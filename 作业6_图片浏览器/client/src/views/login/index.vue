<template>
    <div class="paper-login">
        <div class="loginpanelwrap">
            <div class="loginheader">
                <div class="logintitle"><router-link to="/index">{{ setting.title }}</router-link></div>
            </div>
            <form action="javascript:;" :autocomplete="false">
                <div class="loginform clearfix">
                    <div class="loginform_row">
                        <label for="username">账号:</label>
                        <input type="text" id="username" :autocomplete="false" class="loginform_input" v-model="form.username" placeholder="输入账号" name="username" />
                    </div>
                    <div class="loginform_row">
                        <label for="password">密码:</label>
                        <input type="password" id="password" :autocomplete="false" class="loginform_input" v-model="form.pwd" placeholder="输入密码" name="password" />
                    </div>
                    <div class="loginform_row random">
                        <label>验证码:</label>
                        <input type="text" class="loginform_input" v-model="form.pagerandom" placeholder="输入验证码" name="" />
                        <e-img alt="刷新验证码" title="点击刷新验证码" class="ramdom-img" @click="loadCaptch" :src="captchUrl" style=""></e-img>
                    </div>
                    <div class="loginform_row role">
                        <label>角色:</label>
                        <div class="loginform_input">
                            <el-radio-group v-model="form.cx" size="mini">
                                <el-radio-button v-for="r in rules" :key="r" :label="r" size="mini"></el-radio-button>
                            </el-radio-group>
                        </div>
                    </div>
                    <div class="loginform_row" style="text-align: right">
                        <input type="submit" class="loginform_submit" @click="login" value="登录" />
                    </div>
                    <div class="clear"></div>
                </div>
            </form>
        </div>
    </div>
</template>
<style type="type/scss" lang="scss">
    $inputHeight: 40px;
    .paper-login {
        height: 100%;
        width: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        background: url("./bg.png") no-repeat center center;
        background-size: cover;
        .loginpanelwrap {
            width: 540px;
            border-radius: 30px;
            border: 1px solid #DEDEDE;
            padding: 40px;
            background: rgba(255, 255, 255, 0.5);
        }
        .loginheader {
            text-align: center;
            font-size: 24px;
            margin-bottom: 30px;
            border-bottom: 2px solid #DEDEDE;
            padding-bottom: 30px;
        }
        .loginform {
            .loginform_row {
                position: relative;
                margin-bottom: 20px;

                > label {
                    position: absolute;
                    left: 0;
                    top: 0;
                    font-size: 13px;
                    height: $inputHeight;
                    line-height: $inputHeight;
                    color: #0b0b0b;
                    width: 75px;
                    text-align: right;
                }
                .loginform_input {
                    width: 100%;
                    height: $inputHeight;
                    line-height: $inputHeight;
                    padding-left: 85px;
                    border-radius: 8px;
                    border: 1px solid #DEDEDE;
                    background: #FFFCF5;
                    transition: all 100ms linear;
                }

                .loginform_input::placeholder {
                    color: #DEDEDE;
                }
                .loginform_input:focus,
                .loginform_input:hover {
                    outline: none;
                    border: 1px solid #0f6cb2;
                }
                .loginform_input:focus {
                    background: #ffffff;
                }
                .loginform_input:focus::placeholder {
                    color: #626262;
                }
            }
        }
        .random {
            .ramdom-img {
                position: absolute;
                right: 10px;
                top: 4px;
                width: 100px;
                height: 30px;
            }
        }
        .loginform_submit {
            user-select: none;
            border: 1px solid transparent;
            border: none;
            display: inline-block;
            font-weight: 400;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            border-radius: 30px;
            box-sizing: border-box;
            border-width: 2px;
            font-size: 12px;
            font-weight: 600;
            padding: 10px 28px;
            line-height: 1.75;
            cursor: pointer;
            text-transform: uppercase;
            color: #fff;
            opacity: 1;
            filter: alpha(opacity=100);
            -webkit-transition: all 0.15s linear;
            -moz-transition: all 0.15s linear;
            -o-transition: all 0.15s linear;
            transition: all 0.15s linear;

            background-color: #68b3c8;
            border-color: #68b3c8;
        }

        .loginform_submit:focus,
        .loginform_submit:hover {
            background-color: #3091b2;
            color: #fff;
            border-color: #3091b2;
        }
    }
</style>
<script>
    import setting from "@/setting";
    import api from "@/api";

    export default {
        name: "panelo-login",
        data() {
            return {
                setting,
                captchUrl: "",
                loading: false,
                nowId1: new Date().getTime() + "" + Math.floor(Math.random() * 1000),
                nowId2: new Date().getTime() + "" + Math.floor(Math.random() * 1000),
                nowId3: new Date().getTime() + "" + Math.floor(Math.random() * 1000),
                form: {
                    username: "",
                    pwd: "",
                    cx: "管理员",

                    /* 验证码段 */
                    pagerandom: "",
                    a: "a",
                    /* 验证码段 */
                },
                rules: ["管理员", "用户"],
            };
        },
        watch: {},
        computed: {},
        methods: {
            login() {
                this.loading = true;
                this.$store
                    .dispatch("user/login", this.form)
                    .then((res) => {
                        this.loading = false;
                        if (res.code == api.code.OK) {
                            this.$message.success("登录成功");
                            var redirect = this.$route.query.redirect;
                            if (redirect) {
                                this.$router.replace(redirect);
                            } else {
                                this.$router.replace("/admin/sy");
                            }
                        } else {
                            this.$message.error(res.msg);
                        }
                        if (res.code == 20) {
                            this.loadCaptch();
                        }
                    })
                    .catch((err) => {
                        this.loading = false;
                        this.$message.error(err.message);
                    });
            },
            loadCaptch() {
                api.captch().then((res) => {
                    console.log(res);
                    this.form.captchToken = res.token;
                    this.captchUrl = res.url;
                });
            },
        },
        created() {
            this.loadCaptch();
            this.form.cx = this.rules[0];
        },
        mounted() {},
        destroyed() {},
    };
</script>
