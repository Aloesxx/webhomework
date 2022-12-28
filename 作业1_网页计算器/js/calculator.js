var dot_num;// 记录小数点的个数
var oprt_num;// 记录运算符的个数
var oprt_continue;// 记录连续操作
var oprt_dup;// 记录重复操作
var eql_continue;// 记录连续等
var eql_num;// 记录数字相等
var eql_tozero;
var sign_before;// 记录之前操作的符号
var result;// 记录结果
var value_before;// 记录操作之前的数字
var dot_num = 0;//记录小数点是否使用
var oprt_num = 0;
var oprt_continue = 0;
var eql_num = 0;
var result = '';
var sign_before = '';
var eql_continue = '';//连续等
var oprt_dup = 0;
var eql_tozero = 0;//按下等号下次按数字清零


// 使用科学计数法
function scientific(){
    let temp = Number(form.disp.value);
    if(form.disp.value.length > 8){
        temp = temp.toExponential(8);
        form.disp.value = temp;
    }
}
// 添加正负号
function reverse(){
    if(form.disp.value != '0'){
        if(form.disp.value.substring(0,1) != '-'){
            form.disp.value = '-'+form.disp.value;
        }
        else{
            form.disp.value = form.disp.value.substr(1);
        }
    }
}
// 百分之的函数
function percentage(){
    if(form.disp.value != '0'){
        form.disp.value /= 100;
    }
}
// exp函数
function expFunc(){
    form.disp.value = Math.exp(form.disp.value);
    scientific();
}
// log函数
function logFunc(){
    form.disp.value = Math.log(form.disp.value);
    scientific();
}
// sin函数
function sinFunc(){
    form.disp.value = Math.sin(form.disp.value);
    scientific();
}
// cos函数
function cosFunc(){
    form.disp.value = Math.cos(form.disp.value);
    scientific();
}
// tan函数
function tanFunc(){
    form.disp.value = Math.tan(form.disp.value);
    scientific();
}
// 开方函数
function sqrtFunc(){
    form.disp.value = Math.sqrt(form.disp.value);
    scientific();
}
// 平方函数
function squareFunc(){
    form.disp.value = Math.pow(form.disp.value,2);
    scientific();
}
// e
function eFunc(){
    form.disp.value = Math.E;
    scientific();
}
// pi
function piFunc(){
    form.disp.value = Math.PI;
    scientific();
}
// 暂存器
function saveFunc(){
    form.temptext.value = form.disp.value;
}
// 清除一位的函数
function clearone(){
    let len = form.disp.value.length;
    if(len == 1){
        form.disp.value = '0';
        form.temptext.value = '0';
        dot_num = 0;
        oprt_num = 0;
        oprt_continue = 0;
        sign = '';
        eql_num = 0;
        result = '';
        sign_before = '';
        eql_continue = '';
        oprt_dup = 0;
    }
    else{
        if(form.disp.value.substr(len - 1, 1)=='.'){
            dot_num = 0;
        }
        form.disp.value = form.disp.value.substr(0, len-1);
    }
}
// 计算功能的实现
function val(s){
    if(eql_tozero != 0){
        eql_tozero = 0;
        form.disp.value = '0';
        dot_num = 0;
        oprt_dup = 0;
    }
    if(oprt_num != 0){
        oprt_num = 0;
        form.disp.value = '0';
        dot_num = 0;
        oprt_dup = 0;
    }
    if(s == "ac"){
        form.disp.value = '0';
        dot_num = 0;
        oprt_num = 0;
        oprt_continue = 0;
        sign = '';
        eql_num = 0;
        result = '';
        sign_before = '';
        eql_continue = '';
        oprt_dup = 0;
    }
    else if(s =='.'){
        if(dot_num == 0){
            form.disp.value += s;
        }
        dot_num++;
    }
    else if(form.disp.value == '0'){
        form.disp.value = s;
    }
    else {
        form.disp.value += s;
    }
    
    if(s != '.' && dot_num == 0){
        eql_continue = sign_before + form.disp.value;
        eql_num = 0;
    }
}
// 使用运算符
function oprt(sign){
    // alert(oprt_dup);
    if(oprt_dup != 1){
        if(oprt_continue == 1){
            result = equal();  
        }
        
        oprt_num = 1;
        oprt_continue = 1;
        eql_num = 0;
        oprt_dup = 1;
    }
    result = form.disp.value + sign;
    sign_before = sign;
    eql_continue = sign_before + form.disp.value;
}
// 计算结果
function equal(){
    let sign = '';
    let temp_result;
    let temp_value;
    if(eql_num == 1){
        sign = sign_before;
        result = form.disp.value + sign;
        temp_value = Number(eql_continue.substr(1));
    }
    else{
        sign = result.substr(result.length-1,  1);
        temp_value = Number(form.disp.value);
    }
    temp_result = Number(result.substr(0, result.length-1));
    if(sign == '+'){
        form.disp.value = temp_result.add(temp_value);
    }
    else if(sign == '-'){
        form.disp.value = temp_result.sub(temp_value);
    }
    else if(sign == '*'){
        form.disp.value = temp_result.mul(temp_value);
    }
    else if(sign == '/'){
        form.disp.value = temp_result.divi(temp_value);
    }
    let ttt = Number(form.disp.value);
    if(form.disp.value.length > 8){
        ttt = ttt.toExponential(8);
        form.disp.value = ttt;
    }
    oprt_num = 0;
    eql_num = 1;
    oprt_continue = 0;
    eql_tozero = 1;
}
// 以下的函数是为了解决JavaScript运算小数时的精确度问题而实现的运算方法
var floatCalc = function (a, b) {
    a = a + '', b = b + '';
    let aNum = a.indexOf('.'),
        bNum = b.indexOf('.'),
        aSum,
        bSum,
        resultNum,
        inta,
        intb;
    aSum = aNum < 0 ? 0 : a.split('.')[1].length;
    bSum = bNum < 0 ? 0 : b.split('.')[1].length;
    resultNum = aSum > bSum ? aSum : bSum;
    inta = aNum < 0 ? Number(a + (Math.pow(10, resultNum) + '').replace('1', '')) : (function () {
        a = a.replace('.', '');
        a = resultNum == aSum ? a : a + (Math.pow(10, resultNum - aSum) + '').replace('1', '');
        return Number(a);
    }())
    intb = bNum < 0 ? Number(b + (Math.pow(10, resultNum) + '').replace('1', '')) : (function () {
        b = b.replace('.', '');
        b = resultNum == bSum ? b : b + (Math.pow(10, resultNum - bSum) + '').replace('1', '');
        return Number(b);
    }())
    return {
        a: inta,
        b: intb,
        num: resultNum
    };
}
//加法
Number.prototype.add = function (n) {
    var o = floatCalc(this, n);
    return (o.a + o.b) / Math.pow(10, o.num);
}
// 减法
Number.prototype.sub = function (n) {
    var o = floatCalc(this, n);
    return (o.a - o.b) / Math.pow(10, o.num);
}
// 乘法
Number.prototype.mul = function (n) {
    var o = floatCalc(this, n);
    return (o.a * o.b) / Math.pow(10, o.num * 2);
}
// 除法
Number.prototype.divi = function (n) {
    var o = floatCalc(this, n);
    return (o.a / o.b);
}