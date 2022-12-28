export default [
    {
        label: "照片信息",
        to: "",
        children: [
            {
                label: "照片信息上传",
                to: "/admin/zhaopianxinxiadd",
            },
            {
                label: "照片信息查询",
                to: "/admin/zhaopianxinxi_faburen",
            },
        ],
    },
    {
        label: "个人中心",
        to: "",
        children: [
            {
                label: "修改个人资料",
                to: "/admin/yonghuupdtself",
            },
            {
                label: "修改密码",
                to: "/admin/mod",
            },
            {
                label: "我的收藏",
                to: "/admin/shoucang_username",
            },
            {
                label: "我的评论",
                to: "/admin/pinglun_pinglunren",
            },
        ],
    },
];
