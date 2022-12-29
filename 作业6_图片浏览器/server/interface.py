import base64
import urllib.request
import cpca
import mne
import scipy.io as scio
import numpy as np
from datetime import datetime
import requests
import csv
import json
import piexif
import exifread
from PIL import Image
import time
from flask import Flask, request
from flask_cors import CORS
import os

os.environ['KMP_DUPLICATE_LIB_OK'] = 'TRUE'

app = Flask(__name__)
CORS(app, supports_credentials=True)


def getLatOrLng(refKey, tudeKey, tags):
    """
    获取经度或纬度
    """
    if refKey not in tags:
        return None
    LatOrLng = tags[tudeKey].printable[1:-1].replace(" ", "").replace("/", ",").split(",")
    LatOrLng = float(LatOrLng[0]) + float(LatOrLng[1]) / 60 + float(LatOrLng[2]) / float(LatOrLng[3]) / 3600
    if refKey == 'GPS GPSLatitudeRef' and tags[refKey].printable != "N":
        LatOrLng = LatOrLng * (-1)
    if refKey == 'GPS GPSLongitudeRef' and tags[refKey].printable != "E":
        LatOrLng = LatOrLng * (-1)
    return LatOrLng


def getlocation(lat, lng):
    """
    exif里面的经纬度是度分秒形式传入的，需要转换为小数形式，然后根据传入的经纬度,调用百度接口去查询详细地址
    """
    url = "http://api.map.baidu.com/reverse_geocoding/v3/?ak=Mu91myb8BrzmRnGOgGRjl1FoAPlFAdFG&output=json&coordtype=wgs84ll&language_auto=1&extensions_town=true&location=" + lat + "," + lng
    req = urllib.request.urlopen(url)
    res = req.read().decode("utf-8")
    str1 = json.loads(res)
    jsonResult = str1.get('result')
    formatted_address = jsonResult.get('formatted_address')
    return formatted_address


@app.route('/updateImgData', methods=['POST'])
def updateImgData():
    picDir = "pic/"
    for i in range(len(request.json)):
        img64_arg = request.json[i]["img_base64"].split(",")
        # 获得图片文件类型
        imgtype = img64_arg[0].split(";")[0]
        imgtype = imgtype.split("/")[-1]
        # 获得图片的base64
        img64 = img64_arg[1]
        # 根据当前的系统时间对图片进行命名
        timestr = time.strftime("%Y%m%d-%H%M%S")
        imgname = timestr + "-" + str(i)
        # 保存图片
        imgname = picDir + imgname
        imgfile = open(imgname + "." + imgtype, 'wb')
        imgfile.write(base64.b64decode(img64))
        imgfile.close()
        # 保存完整base64
        imgtxt = open(imgname + '.txt', 'wt')
        imgtxt.write(request.json[i]["img_base64"])
        imgtxt.close()
        # 读取图片的exif信息
        f = open(imgname + "." + imgtype, 'rb')
        tags = exifread.process_file(f)
        imgtime = tags['EXIF DateTimeOriginal']
        imgtime = str(imgtime)
        lat = getLatOrLng('GPS GPSLatitudeRef', 'GPS GPSLatitude', tags)  # 纬度
        lng = getLatOrLng('GPS GPSLongitudeRef', 'GPS GPSLongitude', tags)  # 经度
        location = getlocation(str(lat), str(lng))
        print('位置：{0}'.format(location))
        df = cpca.transform([str(location)])
        print("省份：" + df.iat[0, 0])
        print("城市：" + df.iat[0, 1])
        print("区域：" + df.iat[0, 2])
        print("详细：" + df.iat[0, 3])
        # 保存图片exif信息 imgMsg文件为保存上传图片的拍摄时间、地点、名称的信息
        imgMsgTxt = open('pic/imgMsg.txt', 'a')
        imgDir = imgname + "." + imgtype
        imgMsgTemp = imgDir+"&"+imgtime+"&"+df.iat[0, 0]+"&"+df.iat[0, 1]+"&"+df.iat[0, 2]+"&"+df.iat[0, 3]+"\n"
        imgMsgTxt.write(imgMsgTemp)
        imgMsgTxt.close()
    return "上传图片成功"


@app.route('/getAllImg', methods=['GET'])
def getAllImg():
    imgMsgTxt = open('pic/imgMsg.txt', 'r')
    allLines = imgMsgTxt.readlines()
    imgMsgTxt.close()
    img_Msg = {}
    skipProvince = []
    skipCity = []
    skipRegion = []
    provinceList = []
    timeList = []
    timeTempItem = ""
    timeTemp = []
    for line in allLines:
        img_temp = line.split("&")
        # 生成照片的级联选择器所需要的数据格式
        timeTempItem = img_temp[1].split(" ")[0]
        # timeTempItem = timeTempItem.replace(":", "-")
        timeTemp.append(timeTempItem)
        # 生成照片位置的级联选择器需要的数据格式
        regionList = []
        cityList = []
        if img_temp[2] not in skipProvince:
            skipProvince.append(img_temp[2])
            skipCity.append(img_temp[3])
            skipRegion.append(img_temp[4])
            regionList.append({
                "value": img_temp[4],
                "label": img_temp[4]
            })
            cityList.append({
                "value": img_temp[3],
                "label": img_temp[3],
                "children": regionList
            })
            provinceList.append({
                "value": img_temp[2],
                "label": img_temp[2],
                "children": cityList
            })
        else:
            if img_temp[3] not in skipCity:
                skipCity.append(img_temp[3])
                skipRegion.append(img_temp[4])
                regionList.append({
                    "value": img_temp[4],
                    "label": img_temp[4]
                })
                cityDict = {
                    "value": img_temp[3],
                    "label": img_temp[3],
                    "children": regionList
                }
                for i in range(len(provinceList)):
                    if provinceList[i]["value"] == img_temp[2]:
                        provinceList[i]["children"].append(cityDict)
            else:
                if img_temp[4] not in skipRegion:
                    skipRegion.append(img_temp[4])
                    regionDict = {
                        "value": img_temp[4],
                        "label": img_temp[4]
                    }
                    for i in range(len(provinceList)):
                        if provinceList[i]["value"] == img_temp[2]:
                            tempList = provinceList[i]["children"]
                            for j in range(len(tempList)):
                                if tempList[j]["value"] == img_temp[3]:
                                    tempList[j]["children"].append(regionDict)
    img_Msg["location"] = provinceList
    print(provinceList)
    timeTemp = set(timeTemp)
    timeTemp = sorted(timeTemp, key=lambda x: datetime.strptime(x, "%Y:%m:%d"))
    for i in range(len(timeTemp)):
        timeDict = {
            "value": timeTemp[i],
            "label": timeTemp[i]
        }
        timeList.append(timeDict)
    img_Msg["time"] = timeList
    print(timeList)
    return img_Msg


@app.route('/lgrtest', methods=['POST'])
def lgrtest():
    print(request.json)
    return "halo"


if __name__ == '__main__':
    # 这里host是你的后端地址，这里写0.0.0.0， 表示的是这个接口在任何服务器上都可以被访问的到，只需要前端访问该服务器地址就可以的，
    # 当然你也可以写死，如222.222.222.222， 那么前端只能访问222.222.222.222, port是该接口的端口号,
    # debug = True ,表示的是，调试模式，每次修改代码后不用重新启动服务
    app.run(host='0.0.0.0', port=5000, debug=True)
