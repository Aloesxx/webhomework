<template>
  <div class="about">
    <h1>照片浏览器</h1>
    <el-button type="primary" round @click="test()">测试按钮</el-button>
    <br><br><br>
    <el-upload class="upload-demo"
        action="#"
        :http-request="httpRequest"
        :on-success="handleAvatarSuccess"
        :on-remove="handleRemove"
        :on-preview="handlePreview"
        :on-change="handleChange"
        :before-remove="beforeRemove"
        multiple>
        <el-button size="small" type="primary">点击上传</el-button>
        <div style="display:none">
            <img :src=img_base64 id="imgid" ref="img">
        </div>
        <div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过500kb</div>
    </el-upload>
  </div>
</template>

<script lang="ts">
import Vue from 'vue'
import api from "../utils/api"
import axios from 'axios'
// npm install exif-js 安装获取图片exif信息的包
// import EXIF from 'exif-js'
import EXIF from "../utils/exif"

export default Vue.extend({
    name: "exif-js",
    data() {
        return{
            img_file: "",
            img_src: "",
            img_base64: "",
            img_date: "",
            img_location: "",
            address: "",
            fileList: "",
            exifdata:""
        }
    },
    methods:{
        handleChange(file, fileList) {
            console.log("handleChange")
            if (fileList.length > 1) {
                fileList.shift()
            }
            this.img_base64 = URL.createObjectURL(file.raw);
            this.uploadImgToBase64(file.raw).then((data) => {
                this.img_base64 = data.result;
            });
        },
        handleAvatarSuccess(res, file) {
            console.log("handleAvatarSuccess")
        },
        handleRemove(){
            console.log("handleRemove")
            this.img_base64 = ''
        },
        uploadImgToBase64(file) {
            // 核心方法，将图片转成base64字符串形式
            return new Promise((resolve, reject) => {
                const reader = new FileReader();
                reader.readAsDataURL(file);
                reader.onload = function () {
                    // 图片转base64完成后返回reader对象
                    resolve(reader);
                };
                reader.onerror = reject;
            });
        },
        httpRequest(data) {
            let _this = this  // 这里要转一下是因为在下面的function里 this的指向发生了变化
            let rd = new FileReader()
            let file = data.file
            rd.readAsDataURL(file)
            rd.onloadend = function(e) {
                // this.result就是得到的base64码
                _this.img_base64 = this.result
            }
            // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            // 注意！不要在这里面输出img_base64码检查 得到的是blob格式 应该在外面直接看 是正确的
            // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        },
        handlePreview(file) {
            console.log("handlePreview")
        },
        beforeRemove(file, fileList) {
            console.log("beforeRemove")
            return this.$confirm(`确定移除 ${ file.name }？`);
        },
        getImgLocation(){
            console.log("getImgLocation")
            let _this = this
            let imgid = document.getElementById("imgid")
            EXIF.getData(this.$refs.img,function(){
                //图片包含的所有信息(例：拍照方向、相机设备型号、拍摄时间、ISO 感光度、GPS 地理位置等数据。)
                console.log("EXIF.getData")
                const imgAllInfo = EXIF.getAllTags(this);
                console.log(imgAllInfo)
                const shootTime = EXIF.getTag(this, 'DateTime')
                const imgLon = EXIF.getTag(this, 'GPSLongitude')
                const imgLat = EXIF.getTag(this, 'GPSLatitude')
                console.log(shootTime)
                console.log(imgLon)
                console.log(imgLat)
                if(imgLon && imgLat){
                    //计算出经纬度并保留6为小数
                    const lon = (imgLon[0] + imgLon[1]/60 + imgLon[2]/60/60).toFixed(6)
                    const lat = (imgLat[0] + imgLat[1]/60 + imgLat[2]/60/60).toFixed(6)
                    //使用高德地图的逆地理编码，key申请类型为Web API服务
                    const mapKey = 'ffe2ec0f997466eb8e28f71a8a6b15ed'
                    //调用高得API
                    axios.get(`https://restapi.amap.com/v3/geocode/regeo?key=${mapKey}&location=${lon},${lat}`).then(res=>{
                        _this.address = res.data.regeocode.formatted_address
                    })
                } else {
                    _this.address = '暂未获得该图片地址'
                }
                console.log(_this.address)
            })
        },
        test(){
            this.getImgLocation()

            // const path = api.prdpath + "/test"
            // this.$api.get(path, null, response=>{
            //     if (response.status >= 200 && response.status < 300) {
            //         let succesmsg = response.data
            //         console.log(succesmsg)
            //         // this.$message.success("请求成功")
            //     } else {
            //         // this.$message.error("请求实验结果列表失败")
            //         console.log("error")
            //     }
            // })
            // console.log(this.img_base64)
        }
    },
    mounted(){
        
    }
})
</script>

<style>

</style>
