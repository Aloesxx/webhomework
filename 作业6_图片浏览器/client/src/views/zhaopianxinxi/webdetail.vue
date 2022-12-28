<template>
    <div class="zhaopianxinxi-detail" v-loading="loading">
        <div>
            <e-container>
                <div class="">
                    <div class="goods-info clearfix">
                        <div class="gallery-list">
                            <e-shangpinban :images="map.zhaopian"></e-shangpinban>
                        </div>
                        <div class="goods-right-content">
                            <h3 class="title" v-text="map.zhaopianmingcheng"></h3>
                            <div class="descount">
                                <div>
                                    <span class="name"> 照片编号： </span>
                                    <span class="val"> {{ map.zhaopianbianhao }} </span>
                                </div>
                                <div>
                                    <span class="name"> 分类： </span>
                                    <span class="val"> <e-select-view module="zhaopianfenlei" :value="map.fenlei" select="id" show="fenleimingcheng"></e-select-view> </span>
                                </div>
                                <div>
                                    <span class="name"> 拍摄时间： </span>
                                    <span class="val"> {{ map.paisheshijian }} </span>
                                </div>
                                <div>
                                    <span class="name"> 拍摄地点： </span>
                                    <span class="val"> {{ map.paishedidian }} </span>
                                </div>
                                <div>
                                    <span class="name"> 照片简介： </span>
                                    <span class="val"> {{ map.zhaopianjianjie }} </span>
                                </div>
                                <div>
                                    <span class="name"> 发布人： </span>
                                    <span class="val"> {{ map.faburen }} </span>
                                </div>
                            </div>
                            <template v-if="$session.cx == '用户'">
                                <el-badge :value="shoucangCount" style="margin-right: 15px">
                                    <el-button type="primary" v-if="!is_shoucang" @click="onShoucangChange" icon="el-icon-star-off"> 收藏 </el-button>
                                    <el-button type="danger" v-else icon="el-icon-star-on" @click="onShoucangChange"> 取消收藏 </el-button>
                                </el-badge>
                                <el-badge :value="dianzanCount" style="margin-right: 15px">
                                    <el-button type="primary" v-if="!is_dianzan" @click="onDianzanChange" icon="fa fa-thumbs-o-up"> 赞 </el-button>
                                    <el-button type="danger" v-else icon="fa fa-thumbs-up" @click="onDianzanChange"> 已点赞 </el-button>
                                </el-badge>
                            </template>

                        </div>
                    </div>

                </div>
            </e-container>
        </div>
        <div>
            <e-container>
                <e-comments module="zhaopianxinxi" :lists="comments" :biaoti="map.zhaopianmingcheng" user="yonghu" headimg="touxiang" :is-reply="false" name="xingming">
                </e-comments>
            </e-container>
        </div>
    </div>
</template>
<style type="text/scss" scoped lang="scss"></style>
<script>
    import api from "@/api";
    import { extend } from "@/utils/extend";
    import jdk from "@/utils/extend";
    export default {
        data() {
            return {
                loading: false, // 加载

                is_shoucang: false,
                shoucangCount: 0,
                is_dianzan: false,
                dianzanCount: 0,

                map: {
                    zhaopianbianhao: "",
                    zhaopianmingcheng: "",
                    fenlei: "",
                    zhaopian: "",
                    paisheshijian: "",
                    paishedidian: "",
                    zhaopianjianjie: "",
                    faburen: "",
                },
                comments: [],
            };
        },
        props: {
            id: {
                type: [String, Number],
                required: true,
            },
        },
        watch: {
            id: {
                handler() {
                    this.loadDetail();
                },
                immediate: true,
            },
        },
        computed: {},
        methods: {
            loadDetail() {
                if (this.loading) return;
                this.loading = true;
                this.$get(api.zhaopianxinxi.webdetail, {
                    id: this.id,
                })
                    .then((res) => {
                        this.loading = false;
                        if (res.code == api.code.OK) {
                            extend(this, res.data);
                        } else {
                            this.$message.error(res.msg);
                        }
                    })
                    .catch((err) => {
                        this.loading = false;
                        this.$message.error(err.message);
                    });
            },
            onShoucangChange() {
                if (this.loading) return;
                this.loading = true;
                var map = this.map;
                this.$post("shoucanginsert.do", {
                    biao: "zhaopianxinxi",
                    xwid: map.id,
                    biaoti: map.zhaopianmingcheng,
                })
                    .then((res) => {
                        if (res.code == 0) {
                            if (this.is_shoucang) {
                                this.$message.success("已取消收藏");
                                this.is_shoucang = false;
                                this.shoucangCount--;
                            } else {
                                this.$message.success("已收藏");
                                this.is_shoucang = true;
                                this.shoucangCount++;
                            }
                        } else {
                            this.$message.error(res.msg);
                        }
                        this.loading = false;
                    })
                    .catch((err) => {
                        this.loading = false;
                        this.$message.error(err.message);
                    });
            },
            onDianzanChange() {
                if (this.loading) return;
                this.loading = true;
                var map = this.map;
                this.$post("dianzaninsert.do", {
                    biao: "zhaopianxinxi",
                    biaoid: map.id,
                    biaoti: map.zhaopianmingcheng,
                })
                    .then((res) => {
                        if (res.code == 0) {
                            if (this.is_dianzan) {
                                this.$message.success("已取消点赞");
                                this.is_dianzan = false;
                                this.dianzanCount--;
                            } else {
                                this.$message.success("已点赞");
                                this.is_dianzan = true;
                                this.dianzanCount++;
                            }
                        } else {
                            this.$message.error(res.msg);
                        }
                        this.loading = false;
                    })
                    .catch((err) => {
                        this.loading = false;
                        this.$message.error(err.message);
                    });
            },
        },
        created() {},
        mounted() {},
        destroyed() {},
    };
</script>
