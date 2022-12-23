<template>
  <div>
    <img v-if="imgSrc.length > 0" id="fg" :src="imgSrc" style="width:300px;" />
    <br/>

    选择图片读取exif信息:
    <input type="file" ref="hiddenfile" accept="image/*" @change="readExif" class="hiddenInput" />

    <div v-if="isExif == 1">
    <div v-for="(item, index) in tags " :key="index" style="display: flex;text-align: left;">
        <div style="width:200px; ">{{ index }}:</div>
        <div style="width:600px; ">
            {{ item }}
        </div>
    </div>
    </div>

     <div v-if="isExif == 0">
        图片无exif信息可读取
     </div>

  </div>
</template>
<script>
import {ref} from "vue"
import EXIF from "../utils/exif"
export default {
    name: "ExifImg",
    setup() {
        //exif tags
        const tags = ref({});
        //当前图片是否存在exif
        const isExif = ref(-1);
        //图片的src
        const imgSrc = ref("");
        //读取exif
        const readExif = (e) => {
            let file = e.target.files[0];
            let reader = new FileReader();
            reader.readAsDataURL(file);
            reader.onload = () =>{
            imgSrc.value = reader.result;
            var img = new Image();
            img.src = imgSrc.value;
            img.onload = () => {
                // console.log("图片加载成功:");
                EXIF.getData(img, function(){
                let tags1 = EXIF.getAllTags(this);
                tags.value = tags1;
                if (Object.getOwnPropertyNames(tags.value).length >0) {
                    isExif.value = 1;
                } else {
                    isExif.value = 0;
                }
                var pretty = EXIF.pretty(this);
                console.log(pretty);
                });
            }
            }
        }

        return {
            readExif,
            tags,
            isExif,
            imgSrc,
        }
    }
}
</script>

<style scoped>
</style>