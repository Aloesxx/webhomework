// 以下变量是为了得到时分秒，年月日，星期几的标签元素
const hr = document.querySelector("#hr");
const min = document.querySelector("#min");
const sec = document.querySelector("#sec");
const hrsmg = document.querySelector("#hrmsg");
const minmsg = document.querySelector("#minmsg");
const secmsg = document.querySelector("#secmsg");
const yearmsg = document.querySelector("#yearmsg");
const monthmsg = document.querySelector("#monthmsg");
const datemsg = document.querySelector("#datemsg");
const weekmsg = document.querySelector("#weekmsg");

// 起连接字符串作用
var weekstring;
// 使用setInterval函数，使以下函数每一秒钟运行一次，来达到时钟按秒运行的效果
setInterval(()=>{
    // 声明Date变量，得到需要的时间信息
    let day = new Date();
    let hh = day.getHours();
    let mm = day.getMinutes();
    let ss = day.getSeconds();
    let ww = day.getDay();
    let year = day.getFullYear();
    let month = day.getMonth();
    let date =day.getDate();
    switch(ww){
        case 0:weekstring="星期日";break;
        case 1:weekstring="星期一";break;
        case 2:weekstring="星期二";break;
        case 3:weekstring="星期三";break;
        case 4:weekstring="星期四";break;
        case 5:weekstring="星期五";break;
        case 6:weekstring="星期六";break;
        default:break;
    }
    // 根据得到的时分秒对时针，分钟和秒针进行旋转
    hr.style.transform = `rotateZ(${hh*30+(mm/2)}deg)`;
    min.style.transform = `rotateZ(${mm*6}deg)`;
    sec.style.transform = `rotateZ(${ss*6}deg)`;
    if(hh<10){hh = "0"+hh};
    if(mm<10){mm = "0"+mm};
    if(ss<10){ss = "0"+ss};
    // 连接字符串显示年月日
    hrsmg.innerHTML = hh + ":";
    minmsg.innerHTML = mm + ":";
    secmsg.innerHTML = ss;
    yearmsg.innerHTML = year + "&nbsp年";
    monthmsg.innerHTML = '&nbsp' + (month + 1) + "&nbsp月";
    datemsg.innerHTML = '&nbsp'+ date + "&nbsp日";
    weekmsg.innerHTML = weekstring;
})
// 显示刻度
// 先获取表盘ul1
var dul = document.getElementById('dial');
// 因为是60个刻度，我们就创建60个li，并设置它们的旋转角度
for (let i=0;i<60;i++){
   let dli = document.createElement('li');
   // 因为i是从0~60，而每个刻度的旋转角度360°÷60=6°，所以每个刻度的旋转角度就是i*6°
   dli.style.webkitTransform = 'rotate('+ i*6 +'deg)';
   dul.appendChild(dli);
}
// 设置表盘时点数
var numul = document.getElementById('num');
for (let i=1;i<13;i++){
    let numli = document.createElement('li');
    numli.style.webkitTransform = 'rotate('+ i*30.1 +'deg)';
    // numli.style.backgroundColor = rgba(255, 255, 255, 0.5);
    // numli.style.opacity = 0.3
    numli.style.color = "#ffffff";
    numli.style.width = "0px";
    numli.style.height = "50px";
    numli.textContent = i;
    numul.appendChild(numli);
 }