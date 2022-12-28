<template>
    <div class="zhaopianxinxi-add" v-loading="loading">
        <el-card class="box-card">
            <div slot="header" class="clearfix">
                <span class="title"> 添加照片信息</span>
            </div>
            <div class="form-database-form">
                <el-form :model="form" ref="formModel" label-width="130px" status-icon validate-on-rule-change>
                    <el-form-item label="照片编号" prop="zhaopianbianhao" :rules="[{required:true, message:'请填写照片编号'}]">
                        <el-input type="text" placeholder="输入照片编号" style="width: 250px" v-model="form.zhaopianbianhao" />
                    </el-form-item>

                    <el-form-item label="照片名称" prop="zhaopianmingcheng" required :rules="[{required:true, message:'请填写照片名称'}]">
                        <el-input type="text" placeholder="输入照片名称" style="width: 450px" v-model="form.zhaopianmingcheng" />
                    </el-form-item>

                    <el-form-item label="分类" prop="fenlei" required :rules="[{required:true, message:'请填写分类'}]">
                        <el-select v-model="form.fenlei"><e-select-option type="option" module="zhaopianfenlei" value="id" label="fenleimingcheng"></e-select-option></el-select>
                    </el-form-item>

                    <el-form-item label="照片" prop="zhaopian" required :rules="[{required:true, message:'请填写照片'}]">
                        <e-upload-images v-model="form.zhaopian"></e-upload-images>
                    </el-form-item>

                    <el-form-item label="拍摄时间" prop="paisheshijian" required :rules="[{required:true, message:'请填写拍摄时间'}]">
                        <el-date-picker v-model="form.paisheshijian" type="datetime" :editable="false" value-format="yyyy-MM-dd HH:mm:ss" placeholder="选择日期"> </el-date-picker>
                    </el-form-item>

                    <el-form-item label="拍摄地点" prop="paishedidian" required :rules="[{required:true, message:'请填写拍摄地点'}]">
                        <el-input type="text" placeholder="输入拍摄地点" style="width: 250px" v-model="form.paishedidian" />
                    </el-form-item>

                    <el-form-item label="照片简介" prop="zhaopianjianjie" required :rules="[{required:true, message:'请填写照片简介'}]">
                        <el-input type="textarea" v-model="form.zhaopianjianjie"></el-input>
                    </el-form-item>

                    <el-form-item label="发布人" prop="faburen"> <el-input v-model="form.faburen" readonly style="width: 250px"></el-input> </el-form-item>

                    <el-form-item v-if="btnText">
                        <el-button type="primary" @click="submit">{{ btnText }}</el-button>
                    </el-form-item>
                </el-form>
            </div>
        </el-card>
    </div>
</template>
<style type="text/scss" scoped lang="scss">
    .zhaopianxinxi-add {
    }
</style>
<script>
    import api from "@/api";
    import rule from "@/utils/rule";
    import { extend } from "@/utils/extend";

    export default {
        name: "zhaopianxinxi-add",
        data() {
            return {
                rule,
                loading: false,
                form: {
                    zhaopianbianhao: rule.getID(),
                    zhaopianmingcheng: "",
                    fenlei: "",
                    zhaopian: "",
                    paisheshijian: "",
                    paishedidian: "",
                    zhaopianjianjie: "",
                    faburen: this.$store.state.user.session.username,
                },
            };
        },
        watch: {},
        props: {
            isRead: {
                type: Boolean,
                default: true,
            },
            btnText: {
                type: String,
                default: "提交",
            },
        },

        computed: {},
        methods: {
            submit() {
                this.$refs.formModel
                    .validate()
                    .then((res) => {
                        if (this.loading) return;
                        this.loading = true;
                        var form = this.form;

                        this.$post(api.zhaopianxinxi.insert, form)
                            .then((res) => {
                                this.loading = false;
                                if (res.code == api.code.OK) {
                                    this.$message.success("添加成功");
                                    this.$emit("success", res.data);
                                    this.$refs.formModel.resetFields();
                                    this.loadInfo();
                                } else {
                                    this.$message.error(res.msg);
                                }
                            })
                            .catch((err) => {
                                this.loading = false;
                                this.$message.error(err.message);
                            });
                    })
                    .catch((err) => {
                        console.log(err.message);
                    });
            },
            loadInfo() {
                var form = this.form;
                // 获取模块得数据
                this.loading = true;
                this.$post(api.zhaopianxinxi.create, {
                    id: this.$route.query.id,
                })
                    .then((res) => {
                        this.loading = false;
                        if (res.code == api.code.OK) {
                            extend(this, res.data);
                        } else {
                            this.$message.error(res.msg);
                            this.$router.go(-1);
                        }
                    })
                    .catch((err) => {
                        this.$message.error(err.message);
                        this.$router.go(-1);
                    });
            },
        },
        created() {
            this.loadInfo();
        },
        mounted() {},
        destroyed() {},
    };
</script>
