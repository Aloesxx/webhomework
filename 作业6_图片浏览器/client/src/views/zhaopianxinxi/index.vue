<template>
    <div v-loading="loading">
        <div>
            <e-container>
                <div class="floor_goods_wrap clearfix">
                    <div style="margin-bottom: 20px">
                        <div class="form-search">
                            <el-form @submit.prevent.stop :inline="true" size="mini">

                                <el-form-item label="照片名称">
                                    <el-input v-model="search.zhaopianmingcheng"></el-input>
                                </el-form-item>
                                <el-form-item label="分类">
                                    <el-select v-model="search.fenlei"
                                    ><el-option label="请选择" value=""></el-option
                                    ><e-select-option type="option" module="zhaopianfenlei" value="id" label="fenleimingcheng"></e-select-option
                                    ></el-select>
                                </el-form-item>
                                <el-form-item>
                                    <el-button type="primary" @click="searchSubmit" icon="el-icon-search">查询</el-button>
                                </el-form-item>
                            </el-form>
                        </div>
                    </div>
                    <el-row :gutter="20">
                        <el-col :md="6" v-for="r in list">
                            <div class="floor_goods_wrap_li">
                                <div class="floor_goods_wrap_b">
                                    <router-link :to="{path:'/zhaopianxinxidetail',query:{id:r.id}}" class="floor_goods_img">
                                        <e-img-box :src="r.zhaopian" pb="100"></e-img-box>
                                    </router-link>
                                    <router-link :to="{path:'/zhaopianxinxidetail',query:{id:r.id}}" class="floor_goods_tit" v-html="$substr(r.zhaopianmingcheng,20)"></router-link>

                                </div>
                            </div>
                        </el-col>
                    </el-row>
                </div>
            </e-container>
        </div>
    </div>
</template>
<style type="text/scss" scoped lang="scss"></style>
<script>
    import api from "@/api";
    import { extend } from "@/utils/extend";
    import objectDiff from "objectdiff";

    /**
     * 后台列表页面
     */
    export default {
        data() {
            return {
                loading: false,
                list: [],
                search: {
                    zhaopianbianhao: "",

                    zhaopianmingcheng: "",

                    fenlei: "",

                    zhaopian: "",

                    paisheshijian_start: "",
                    paisheshijian_end: "",

                    paishedidian: "",

                    zhaopianjianjie: "",

                    faburen: "",
                },
                page: 1, // 当前页
                pagesize: 12, // 页大小
                totalCount: 0, // 总行数
                total: {},

                mapzhaopianfenlei1: [],
            };
        },
        watch: {},
        computed: {},
        methods: {
            searchSubmit() {
                this.loadList(1);
            },
            loadList(page) {
                // 防止重新点加载列表
                if (this.loading) return;
                this.loading = true;
                this.page = page;
                // 筛选条件
                var filter = extend(true, {}, this.search, { page: page + "", pagesize: this.pagesize + "" });
                var diff = objectDiff.diff(filter, this.$route.query);
                if (diff.changed != "equal") {
                    // 筛选的条件不一致则更新链接
                    this.$router.replace({
                        // 更新query
                        path: this.$route.path,
                        query: filter,
                    });
                }
                this.$post(api.zhaopianxinxi.weblist, filter)
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
            selectRadio(target, name) {
                this.search[target] = name;
                this.searchSubmit(1);
            },
        },
        beforeRouteUpdate(to, form, next) {
            var search = extend(this.search, to.query);
            if (search.page) {
                this.page = Math.floor(to.query.page);
                delete search.page;
            }
            if (search.pagesize) {
                this.pagesize = Math.floor(to.query.pagesize);
                delete search.pagesize;
            }
            this.loadList(1);
            next();
        },
        created() {
            var search = extend(this.search, this.$route.query);
            if (search.page) {
                this.page = Math.floor(this.$route.query.page);
                delete search.page;
            }
            if (search.pagesize) {
                this.pagesize = Math.floor(this.$route.query.pagesize);
                delete search.pagesize;
            }
            this.loadList(this.page);
        },
        mounted() {},
        destroyed() {},
    };
</script>
