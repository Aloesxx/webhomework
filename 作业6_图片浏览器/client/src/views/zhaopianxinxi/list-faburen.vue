<template>
    <div class="v-list" v-loading="loading" element-loading-text="加载中">
        <el-card class="box-card">
            <div slot="header" class="clearfix">
                <span class="title"> 照片信息列表 </span>
            </div>
            <!-- 搜索 -->
            <div class="form-search">
                <el-form @submit.prevent.stop :inline="true" size="mini">
                    <el-form-item label="照片编号">
                        <el-input v-model="search.zhaopianbianhao"></el-input>
                    </el-form-item>
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

            <el-table border :data="list" @sort-change="sortChange" style="width: 100%" highlight-current-row>
                <el-table-column type="index" label="#"></el-table-column>
                <!-- 序号 -->

                <el-table-column prop="zhaopianbianhao" label="照片编号" width="130">
                    <template slot-scope="{row}"> {{ row.zhaopianbianhao }} </template>
                </el-table-column>
                <el-table-column prop="zhaopianmingcheng" label="照片名称">
                    <template slot-scope="{row}"> {{ row.zhaopianmingcheng }} </template>
                </el-table-column>
                <el-table-column prop="fenlei" label="分类" width="80">
                    <template slot-scope="{row}"> <e-select-view module="zhaopianfenlei" :value="row.fenlei" select="id" show="fenleimingcheng"></e-select-view> </template>
                </el-table-column>
                <el-table-column prop="zhaopian" label="照片" width="100">
                    <template slot-scope="{row}"> <e-img :src="row.zhaopian" type="list" style="max-width: 120px"></e-img> </template>
                </el-table-column>
                <el-table-column sortable="custom" prop="paisheshijian" label="拍摄时间" width="120">
                    <template slot-scope="{row}"> {{ row.paisheshijian }} </template>
                </el-table-column>
                <el-table-column prop="paishedidian" label="拍摄地点" width="130">
                    <template slot-scope="{row}"> {{ row.paishedidian }} </template>
                </el-table-column>
                <el-table-column prop="zhaopianjianjie" label="照片简介">
                    <template slot-scope="{row}"> {{ row.zhaopianjianjie }} </template>
                </el-table-column>
                <el-table-column prop="faburen" label="发布人" width="80">
                    <template slot-scope="{row}"> {{ row.faburen }} </template>
                </el-table-column>

                <el-table-column label="操作">
                    <template slot-scope="{row}">
                        <el-button-group>
                            <el-tooltip content="详情" placement="top">
                                <el-button @click="$goto({path:'/admin/zhaopianxinxidetail',query:{id:row.id } })" icon="el-icon-info" type="info" size="mini"></el-button>
                            </el-tooltip>
                            <el-tooltip content="编辑" placement="top">
                                <el-button icon="el-icon-edit" @click="$goto({path:'/admin/zhaopianxinxiupdt',query:{id:row.id } })" type="warning" size="mini"></el-button>
                            </el-tooltip>
                            <el-tooltip content="删除" placement="top">
                                <el-button icon="el-icon-delete" type="danger" size="mini" @click="deleteItem(row)"> </el-button>
                            </el-tooltip>
                        </el-button-group>
                    </template>
                </el-table-column>
            </el-table>

            <div class="e-pages" style="margin-top: 10px; text-align: center">
                <el-pagination
                    @current-change="loadList"
                    :current-page="page"
                    :page-size="pagesize"
                    @size-change="sizeChange"
                    layout="total, sizes, prev, pager, next, jumper"
                    :total="totalCount"
                >
                </el-pagination>
            </div>
        </el-card>
    </div>
</template>
<style type="text/scss" scoped lang="scss"></style>
<script>
    import api from "@/api";
    import { remove } from "@/utils/utils";
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

                    order: "id",
                    sort: "desc",
                },
                total: {},
                page: 1, // 当前页
                pagesize: 10, // 页大小
                totalCount: 0, // 总行数
            };
        },
        watch: {},
        computed: {},
        methods: {
            searchSubmit() {
                this.loadList(1);
            },
            sortChange(e) {
                console.log(e);
                if (e.order == null) {
                    this.search.order = "id";
                    this.search.sort = "desc";
                } else {
                    this.search.order = e.prop;
                    this.search.sort = e.order == "ascending" ? "asc" : "desc";
                }
                this.loadList(1);
            },

            sizeChange(e) {
                this.pagesize = e;
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
                    this.$router.push({
                        // 更新query
                        path: this.$route.path,
                        query: filter,
                    });
                }

                this.$post(api.zhaopianxinxi.listfaburen, filter)
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
            // 删除某行方法
            deleteItem(row) {
                this.$confirm("确定删除数据？", "提示", {
                    // 弹出 确认框提示是否要删除
                    type: "warning",
                })
                    .then(() => {
                        // 确定操作

                        this.loading = true; // 滚动条
                        this.$post(api.zhaopianxinxi.delete, {
                            // 提交后台
                            id: row.id,
                        })
                            .then((res) => {
                                this.loading = false;
                                if (res.code != api.code.OK) {
                                    this.$message.error(res.msg);
                                } else {
                                    remove(this.list, row);
                                }
                            })
                            .catch((err) => {
                                // 访问网络错误
                                this.loading = false;
                                this.$message.error(err.message);
                            });
                    })
                    .catch(() => {
                        // 取消操作
                    });
            },
        },
        beforeRouteUpdate(to, form, next) {
            extend(this.search, to.query);
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

            this.loadList(1);
        },
        mounted() {},
        destroyed() {},
    };
</script>
