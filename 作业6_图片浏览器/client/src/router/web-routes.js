export default [
    {
        path: "yonghuadd",
        name: "IndexyonghuAdd",
        component: () => import("@/views/yonghu/webadd"),
        meta: { title: "用户添加" },
    },
    {
        path: "zhaopianxinxi",
        name: "IndexzhaopianxinxiList",
        component: () => import("@/views/zhaopianxinxi/index"),
        meta: { title: "照片信息列表" },
    },
    {
        path: "zhaopianxinxidetail",
        name: "IndexzhaopianxinxiDetail",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/zhaopianxinxi/webdetail"),
        meta: { title: "照片信息详情" },
    },
    {
        path: "pinglunadd",
        name: "IndexpinglunAdd",
        component: () => import("@/views/pinglun/webadd"),
        meta: { title: "评论添加", authLogin: true, msg: true },
    },
    {
        path: "shoucangadd",
        name: "IndexshoucangAdd",
        component: () => import("@/views/shoucang/webadd"),
        meta: { title: "收藏添加", authLogin: true, msg: true },
    },
    {
        path: "dianzanadd",
        name: "IndexdianzanAdd",
        component: () => import("@/views/dianzan/webadd"),
        meta: { title: "点赞添加", authLogin: true, msg: true },
    },
];
