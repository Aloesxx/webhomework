import http from "@/utils/ajax/http";
import { extend } from "@/utils/extend";

const api = {
    code: {
        OK: 0,
    },
    user: {
        login: "authLogin.do?ac=login",
        tokenLogin: "tokenLogin.do",
        logout: "logout.do",
    },
    checkUpdate: "sh.do",
    editorPassword: "editPassword",
    checkField: "checkno.do",
    dbQuery: "/db/query",
    dbSelect: "/db/select",

    captch() {
        var url = "captcha.do?rd=" + Math.floor(Math.random() * 100000);
        return new Promise((resolve, reject) => {
            http.get(url).then((res) => {
                var url = res.data;
                resolve(url);
            }, reject);
        });
    },
    search: {
        select: "selectUpdateSearch.do",
        table: "tableAjax.do?a=table",
        selectView: "selectView.do",
        all: "selectAll.do",
    },
    attachment: {
        uploadUrl: "upload_re.do",
        upload(file) {
            return new Promise((resolve, reject) => {
                var formdata = new FormData();
                formdata.append("fujian", file, file.name || "tmp.png");
                http.post(api.attachment.uploadUrl, formdata)
                    .then((res) => {
                        if (res.code == api.code.OK) {
                            resolve(res.data);
                        } else {
                            reject(res.msg);
                        }
                    })
                    .catch((err) => {
                        reject(err.message);
                    });
            });
        },
    },
    admins: {
        list: "admins_list.do",
        insert: "adminsinsert.do",
        update: "adminsupdate.do",
        delete: "admins_delete.do",
        detail: "admins_detail.do",
        create: "admins_add.do",
        edit: "admins_updt.do",
    },
    yonghu: {
        list: "yonghu_list.do",
        insert: "yonghuinsert.do",
        update: "yonghuupdate.do",
        delete: "yonghu_delete.do",
        detail: "yonghu_detail.do",
        create: "yonghu_add.do",
        edit: "yonghu_updt.do",
    },
    lunbotu: {
        list: "lunbotu_list.do",
        insert: "lunbotuinsert.do",
        update: "lunbotuupdate.do",
        delete: "lunbotu_delete.do",
        detail: "lunbotu_detail.do",
        create: "lunbotu_add.do",
        edit: "lunbotu_updt.do",
    },
    zhaopianfenlei: {
        list: "zhaopianfenlei_list.do",
        insert: "zhaopianfenleiinsert.do",
        update: "zhaopianfenleiupdate.do",
        delete: "zhaopianfenlei_delete.do",
        detail: "zhaopianfenlei_detail.do",
        create: "zhaopianfenlei_add.do",
        edit: "zhaopianfenlei_updt.do",
    },
    zhaopianxinxi: {
        list: "zhaopianxinxi_list.do",
        insert: "zhaopianxinxiinsert.do",
        update: "zhaopianxinxiupdate.do",
        delete: "zhaopianxinxi_delete.do",
        detail: "zhaopianxinxi_detail.do",
        create: "zhaopianxinxi_add.do",
        edit: "zhaopianxinxi_updt.do",
        listfaburen: "zhaopianxinxi_list_faburen.do",
        weblist: "zhaopianxinxilist.do",
        webdetail: "zhaopianxinxidetail.do",
    },
    pinglun: {
        list: "pinglun_list.do",
        insert: "pingluninsert.do",
        update: "pinglunupdate.do",
        delete: "pinglun_delete.do",
        detail: "pinglun_detail.do",
        create: "pinglun_add.do",
        edit: "pinglun_updt.do",
        listpinglunren: "pinglun_list_pinglunren.do",
    },
    shoucang: {
        list: "shoucang_list.do",
        insert: "shoucanginsert.do",
        update: "shoucangupdate.do",
        delete: "shoucang_delete.do",
        detail: "shoucang_detail.do",
        create: "shoucang_add.do",
        edit: "shoucang_updt.do",
        listusername: "shoucang_list_username.do",
        batch: "shoucang_batch.do",
    },
    dianzan: {
        list: "dianzan_list.do",
        insert: "dianzaninsert.do",
        update: "dianzanupdate.do",
        delete: "dianzan_delete.do",
        detail: "dianzan_detail.do",
        create: "dianzan_add.do",
        edit: "dianzan_updt.do",
        listusername: "dianzan_list_username.do",
        batch: "dianzan_batch.do",
    },
};

export default api;
