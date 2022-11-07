# 作业7

## 设计与实现一个省市联动显示的下拉列表框。

### 实现效果如下：

![](assets\listbox1.png)

![](assets\listbox2.png)

![](assets\listbox3.png)

#### 注：在页面加载是会出现跨域问题。解决方案为在当前项目文件路径下的命令行中输入anywhere。解决方案文章路径为[(31条消息) from origin ‘null‘ has been blocked by CORS policy: Cross origin requests are only supported for pro_cgsthtm的博客-CSDN博客](https://blog.csdn.net/CGS_______/article/details/120720207)

### html文件代码

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>listbox</title>
    <link rel="stylesheet" href="css/listbox.css" />
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <link
        rel="stylesheet"
        href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css"
    />
  </head>
  <body style="background-color: #ced6e0">
    <div class="container">
        <div class="logo">下拉列表查询省市</div>
        <div id="select_box">
            <div class="row">
                <div class="col-md-2">
                    <select
                    name="Province"
                    id="Province"
                    class="btn btn-primary"
                    ></select>
                </div>
                <div class="col-md-2">
                    <select name="City" id="City" class="btn btn-primary"></select>
                </div>
                <div class="col-md-2">
                    <select name="County" id="County" class="btn btn-primary"></select>
                </div>
            </div>
            <br />
        </div>
    </div>
    <script type="text/javascript" src="js/listbox.js"></script>
    <script
        type="text/javascript"
        src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"
    ></script>
</body>
</html>

```

### css文件代码

```css
.logo {
  width: 100%;
  height: 80px;
  font-size: 50px;
  font-family: "宋体";
  color: #57606f;
  margin-top: 20px;
  margin-left: 100px;
}

#select_box select,
span {
  width: 160px;
}

```

### js文件代码

```javascript
$("#Province").append(
    '<optio   n selected="selected" value="请选择省份">请选择省份</option>'
);
$("#City").append(
    '<option selected="selected" value="请选择城市">请选择城市</option>'
);
$("#County").append(
    '<option selected="selected" value="请选择区县">请选择区县</option>'
);

// 通过如下请求，遍历省份，每一个都加到option里
$.ajax({
    async: false, // 不启用异步请求
    url: "js/city.json",
    dataType: "json",
    type: "GET",
    success: function (jsondoc) {
        for (var index in jsondoc.p) {
            // 响应成功，则找到id="Province"所在标签，在两个标签所包含内容的中间添加 新的内容 <option value="xx省">xx省</option>"  改省源于city.json中的"p"对象
            $("#Province").append(
                '<option value="' + jsondoc.p[index] + '">' + jsondoc.p[index] + "</option>"
            );
        }
    }
});

// 改变了原有或者默认的省份选择，则做如下操作
$("#Province").change(function () {
    // 如果选择了初始状态，则城市和区县也全部回到初始状态
    if ($(this).val() == "请选择省份") {
        $("#City").find("option").remove();
        $("#City").append("<option value='请选择城市'>请选择城市</option>");
        $("#County").find("option").remove();
        $("#County").append("<option value='请选择区县'>请选择区县</option>");
    } else {
        // 如果选了其他城市，则重新找city和country，先给这两个“清空”
        $("#City").find("option").remove();
        $("#City").append("<option value='请选择城市'>请选择城市</option>");
        $("#County").find("option").remove();
        $("#County").append("<option value='请选择区县'>请选择区县</option>");

        var selectvalue_province = $(this).val(); // 记录当前选择的省份
        // 以该省份为key，请求到json的"c"对象中找city，并将这些city加入option
        $.ajax({
        async: false,
        url: "js/city.json",
        type: "GET",
        dataType: "json",
        success: function (jsondoc) {
            for (var key in jsondoc.c) {
            if (key == selectvalue_province) {
                for (var index in jsondoc.c[key]) {
                $("#City").append(
                    '<option value="' +
                    jsondoc.c[key][index] +
                    '">' +
                    jsondoc.c[key][index] +
                    "</option>"
                );
                }
            }
            }
        },
        });
    }
});
// 改变了原有或者默认的城市选择，则做如下操作
$("#City").change(function () {
    // 如果选择了初始状态，则区县也回到初始状态
    if ($(this).val() == "请选择城市") {
        $("#County").find("option").remove();
        $("#County").append("<option value='请选择区县'>请选择区县</option>");
    } else {
        // 如果选择了其他城市，则区县“清空”
        $("#County").find("option").remove();
        $("#County").append("<option value='请选择区县'>请选择区县</option>");
        var selectvalue_province = $("#Province").val();
        var selectvalue_city = $(this).val();
        $.ajax({
        async: false,
        url: "js/city.json",
        type: "GET",
        dataType: "json",
        success: function (jsondoc) {
            for (var key in jsondoc.a) {
            if (key == selectvalue_province + "-" + selectvalue_city) {
                for (var index in jsondoc.a[key]) {
                $("#County").append(
                    '<option value="' +
                    jsondoc.a[key][index] +
                    '">' +
                    jsondoc.a[key][index] +
                    "</option>"
                );
                }
            }
            }
        },
        });
    }
});
```

