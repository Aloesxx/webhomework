<template>
    <div class="panelo-main">
        <div :style="styles" class="clearfix panelwrap">
            <div class="submenu">
                <ul class="sidenav">
                    <li class="nav-item" :class="{now:k==active}" v-for="(m,k) in menus">
                        <a href="javascript:;" @click="active = active==k ? -1 : active=k">{{ m.label }}</a>
                        <ul class="erji">
                            <li class="now_li" v-for="c in m.children">
                                <router-link :to="c.to" active-class="active">{{ c.label }}</router-link>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
            <div class="right-arrow"></div>
        </div>
        <div class="paper-header">
            <div class="paper-header-main">
                <div class="title">{{ setting.title }}</div>
                <div class="">
                    <ul class="header-nav">
                        <li>  <el-button @click="$goto('/')" class="item" type="primary" round size="mini">前台首页</el-button></li>
                    </ul>
                </div>
                <div class="">
                    <ul class="header-nav">
                        <li>
                            <a href="javascript:;">{{ $session.username }}</a>
                        </li>
                        <li>
                            <a href="javascript:;" @click="logout">退出登录</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="content">
            <div class="content-router">
                <router-view></router-view>
            </div>
        </div>
    </div>
</template>
<style type="type/scss" lang="scss">
    $sideWidth: 240px;
    $headerHeight: 50px;
    $backgroundColor: #212120;

    .panelo-main {
        width: 100%;
        height: 100%;
        font-size: 14px;
        padding-top: 0;

        .panelwrap {
            position: fixed;
            left: 0;
            width: $sideWidth;
            top: $headerHeight;
            bottom: 0;
            background-color: $backgroundColor;
            color: #fff;
            overflow: auto;
            .submenu {
            }
            a {
                color: #fff;
            }
            a:hover {
                color: #fff;
                text-underline: none;
                text-decoration: none;
            }
            a.active {
                background: #F2F2F2;
                color: $backgroundColor;
            }
            .sidenav {
                > .nav-item {
                    > a {
                        display: block;
                        padding: 10px 20px;
                    }
                    > .erji {
                        max-height: 0;
                        visibility: hidden;
                        transition: all 100ms linear;
                        background: #080808;

                        .now_li a {
                            display: block;
                            padding: 8px 20px;
                            padding-left: 30px;
                        }
                    }
                }
                .now {
                    background: #080808;
                    > .erji {
                        max-height: 500px;
                        visibility: inherit;
                    }
                }
            }
        }
        .paper-header {
            a:hover {
                text-decoration: none;
            }
            position: fixed;
            top: 0;
            height: $headerHeight;
            left: 0;
            right: 0;
            background-color: $backgroundColor;
            .paper-header-main {
                display: flex;
                justify-content: space-between;
                padding: 0 20px;
                color: #ffffff;

                a {
                    color: #ffffff;
                }
                height: $headerHeight;
                line-height: $headerHeight;
                overflow: hidden;
                .title {
                    font-size: 18px;
                }
            }
        }
        .content {
            position: fixed;
            left: $sideWidth;
            top: $headerHeight;
            right: 0px;
            bottom: 0;
            .content-router {
                position: absolute;
                top: 10px;
                left: 10px;
                right: 10px;
                bottom: 10px;
                > div {
                    height: 100%;
                    overflow: hidden;
                    overflow-y: auto;
                }
            }
            $inputHeight: 40px;
            .el-input__inner {
                width: 100%;
                height: $inputHeight;
                line-height: $inputHeight;
                padding: 0 20px;
                padding-right: 30px;
                border-radius: 8px;
                border: 1px solid #DEDEDE;
                background: #FFFCF5;
                transition: all 100ms linear;
            }
            .el-input--mini .el-input__inner {
                height: $inputHeight / 1.2;
                line-height: $inputHeight / 1.2;
            }
            .el-input__inner::placeholder {
                color: #DEDEDE;
            }
            .el-input__inner:focus,
            .el-input__inner:hover {
                outline: none;
                border: 1px solid #0f6cb2;
            }
            .el-input__inner:focus {
                background: #ffffff;
            }
            .el-input__inner:focus::placeholder {
                color: #626262;
            }

            .el-card.box-card {
                height: 100%;
                .el-card__header {
                    background: #080808;
                    color: #ffffff;
                }
                .el-card__body {
                    height: calc(100% - 57px);
                    overflow: hidden;
                    overflow-y: auto;
                }
            }
            .el-pagination__sizes {
                display: none;
            }
            .el-pagination {
                text-align: right;
            }
            .el-pagination__editor.el-input .el-input__inner {
                height: 28px;
                line-height: 28px;
            }
            .el-table__body {
                > tbody > tr:nth-child(even) {
                    background: #FFFCF5;
                }
            }
        }
        .header-nav {
            display: flex;
            li {
                margin-right: 20px;
                a {
                    display: block;
                    padding: 0 15px;
                    background: #171616;
                }
                a:hover,
                a:active {
                    background: #000000;
                }
            }
            li:last-child {
                margin-right: 0;
            }
        }
    }
</style>
<script>
    import menu from "@/views/admin/sidebar";
    import api from "@/api";
    import setting from "@/setting";

    export default {
        name: "panelo-main",
        data() {
            return {
                setting,
                active: 0,
                widths: ["980px", "1200px", "80%", "90%", "98%"],
                width: "1200px",
            };
        },
        watch: {},
        computed: {
            menus() {
                var cx = this.$session.cx;
                return menu[cx];
            },
            styles() {
                return {};
            },
        },
        methods: {
            changeWidth(w) {
                this.width = w;
                localStorage.setItem("paneloWidth", w);
            },
            logout() {
                this.$confirm("确定退出登录？", "确认信息").then(() => {
                    // 退出登录
                    this.$store
                        .dispatch("user/logout")
                        .then((res) => {
                            if (res.code == api.code.OK) {
                                this.$message.success("退出登录成功");
                                this.$router.replace("/index");
                            } else {
                                this.$message.error(res.msg);
                            }
                        })
                        .catch((err) => {
                            this.$message.error(err.message);
                        });
                });
            },
        },
        created() {
            this.width = localStorage.getItem("paneloWidth") || "1200px";
        },
        mounted() {
            var menus = this.menus;
            var active = -1;
            var path = this.$route.path;

            for (var i in menus) {
                var ci = menus[i];
                for (var j in ci.children) {
                    var v = ci.children[j];
                    if (v.to == path) {
                        active = i;
                        break;
                    }
                }
                if (active != -1) break;
            }
            if (active != -1) {
                this.active = active;
            }
        },
        destroyed() {},
    };
</script>
