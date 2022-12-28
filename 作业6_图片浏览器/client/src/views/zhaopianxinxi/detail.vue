<template>
    <div class="zhaopianxinxi-detail" v-loading="loading" ref="print">
        <el-page-header @back="goBack" content="详情页面"></el-page-header>
        <div class="admin-detail">
            <div class="detail detail-text">
                <div class="detail-title">照片编号：</div>
                <div class="detail-content">{{ map.zhaopianbianhao }}</div>
            </div>
            <div class="detail detail-text">
                <div class="detail-title">拍摄地点：</div>
                <div class="detail-content">{{ map.paishedidian }}</div>
            </div>
            <div class="detail detail-longtext">
                <div class="detail-title">照片名称：</div>
                <div class="detail-content">{{ map.zhaopianmingcheng }}</div>
            </div>
            <div class="detail detail-select">
                <div class="detail-title">分类：</div>
                <div class="detail-content">
                    <e-select-view module="zhaopianfenlei" :value="map.fenlei" select="id" show="fenleimingcheng"></e-select-view>
                </div>
            </div>
            <div class="detail detail-datetime">
                <div class="detail-title">拍摄时间：</div>
                <div class="detail-content">{{ map.paisheshijian }}</div>
            </div>
            <div class="detail detail-textarea">
                <div class="detail-title">照片简介：</div>
                <div class="detail-content">{{ map.zhaopianjianjie }}</div>
            </div>
            <div class="detail detail-textuser">
                <div class="detail-title">发布人：</div>
                <div class="detail-content">{{ map.faburen }}</div>
            </div>
            <div class="detail detail-images">
                <div class="detail-title">照片：</div>
                <div class="detail-content">
                    <e-images :src="map.zhaopian" type="detail"></e-images>
                </div>
            </div>
        </div>
        <div class="mt10">
            <el-button type="default" class="hidePrint" @click="$router.go(-1)"> 返回 </el-button>
            <el-button type="success" class="hidePrint" @click="$print"> 打印本页 </el-button>
        </div>
    </div>
</template>
<style type="text/scss" scoped lang="scss">
    .zhaopianxinxi-detail {
        .admin-detail {
            display: flex;
            flex-wrap: wrap;
            margin-top: 30px;
            .detail {
                width: 50%;
                padding: 5px;
                display: flex;
                margin-bottom: 10px;
                border-bottom: 1px solid #DEDEDE;
                .detail-title {
                    width: 120px;
                    text-align: right;
                    flex-shrink: 0;
                }
                .detail-content {
                    flex-grow: 1;
                }
            }
            .detail.detail-images {
                width: 100%;
                flex-wrap: wrap;
                .detail-title {
                    display: none;
                }

                .detail-content {
                    width: 100%;
                    padding: 10px;
                }
            }
            .detail.detail-editor,
            .detail.detail-dataset {
                width: 100%;
                flex-wrap: wrap;
                .detail-title {
                    width: 100%;
                    padding: 10px;
                    margin-top: 10px;
                    background: #9a0606;
                    color: #ffffff;
                    text-align: left;
                }
                .detail-content {
                    padding: 10px;
                }
            }
        }
    }
</style>
<script>
    import api from "@/api";
    import { extend } from "@/utils/extend";

    export default {
        data() {
            return {
                loading: false,
                map: {},

                is_shoucang: false,
                shoucangCount: 0,
                is_dianzan: false,
                dianzanCount: 0,
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
            goBack() {
                this.$router.go(-1);
            },
            loadDetail() {
                if (this.loading) return;
                this.loading = true;
                this.$get(api.zhaopianxinxi.detail, {
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
                    biaoti: map.biaoti,
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
                    biaoti: map.biaoti,
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
