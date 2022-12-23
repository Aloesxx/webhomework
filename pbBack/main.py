import piexif
from PIL import Image
import os

folder_path = "./pic"
all_mat_file = os.walk(folder_path)
print(all_mat_file)
for path, dir_list, file_list in all_mat_file:
    for file_name in file_list:
        print(file_name)
        fname = folder_path + "/" + file_name
        img = Image.open(fname)
        exif_dict = piexif.load(img.info['exif'])
        print(exif_dict)
        longitude = exif_dict['GPS'][piexif.GPSIFD.GPSLongitude]
        latitude = exif_dict['GPS'][piexif.GPSIFD.GPSLatitude]
        altitude = exif_dict['GPS'][piexif.GPSIFD.GPSAltitude]
        print('longitude:', longitude)
        print('latitude:', latitude)
        print('altitude:', altitude)
