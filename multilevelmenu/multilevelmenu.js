var json1 = {
    menu1: "1级菜单1",
    // menu2: "1级菜单2",
};
var json1_1 = {
    menu1_1: "2级菜单1.1",
    menu1_2: "2级菜单1.2",
    menu1_3: "2级菜单1.3",
    menu1_4: "2级菜单1.4",
};

var json1_1_1 = {
    menu1_1_1: "3级菜单1.1.1",
    menu1_1_2: "3级菜单1.1.2",
    menu1_1_3: "3级菜单1.1.3",
};
// 整个下拉菜单区的父节点
var level_1_parent = document.getElementById("level_1_parent");

// 将一级菜单基础架构完成到ul标签
var i = 1;
for (let key_1 in json1) {
    // 对于每个1级菜单，先创建一个div
    let div_level_1 = document.createElement("div");
    div_level_1.setAttribute("class", "dropdown col-md-2");
    div_level_1.setAttribute("id", "div_level_one_" + i);
    level_1_parent.appendChild(div_level_1);

    // 给这个div之下加东西
    // 先拿到当前div
    let div_level_one_i = document.getElementById("div_level_one_" + i);
    // 加一个a
    div_level_one_i.innerHTML =
        '<a role="button" data-toggle="dropdown" class="btn btn-primary" href="#" >' +
        json1[key_1] +
        '<span class="caret"></span> </a>';

    // 加一个2级ul
    let ul_1 = document.createElement("ul");
    ul_1.setAttribute("id", "ul_level_two_" + i);
    ul_1.setAttribute("class", "dropdown-menu multi-level");
    ul_1.setAttribute("role", "menu");
    ul_1.setAttribute("aria-labelledby", "dropdownMenu");
    div_level_one_i.appendChild(ul_1);
    i = i + 1;
}

// 开始构建2级标签，找ul_level_two_i，只考虑给1级菜单1添加的ul添加li
var ul_level_two_1 = document.getElementById("ul_level_two_1");
i = 1;
for (let key_2 in json1_1) {
    let li_level_two_i = document.createElement("li");
    li_level_two_i.setAttribute("id", "li_level_two_" + i);
    li_level_two_i.setAttribute("class", "dropdown-submenu");
    li_level_two_i.innerHTML = '<a href="#">' + json1_1[key_2] + "</a>";
    ul_level_two_1.appendChild(li_level_two_i);
    i += 1;
}

// 开始构建3级标签，找li_level_two_i，只考虑给2级菜单1.2 li添加ul、li
var li_level_two_4 = document.getElementById("li_level_two_2");
// 先添加ul
var ul_level_three_i = document.createElement("ul");
ul_level_three_i.setAttribute("id", "ul_level_three_1");
ul_level_three_i.setAttribute("class", "dropdown-menu");
li_level_two_4.appendChild(ul_level_three_i);

// 给这个ul添加li
var ul_level_three_1 = document.getElementById("ul_level_three_1");
i = 1;
for (let key_3 in json1_1_1) {
    let li_level_three_i = document.createElement("li");
    li_level_three_i.innerHTML = '<a href="#">' + json1_1_1[key_3] + "</a>";
    ul_level_three_1.appendChild(li_level_three_i);
    i += 1;
}

