# 作业8_WEB服务与应用

## 1. 创建一个Web服务，该Web服务的功能是：接收请求，对页面输入的多个数值进行排序,支持从大到小、从小到大排序，可以将排序结果回发给请求页面。

使用VS2017实现。

具体的步骤为：

1. 启用IIS服务。
2. 在VS2017中创建AS.NET项目。
3. 添加web服务。
4. 加入以下代码：

```csharp
[WebMethod(Description = "数字从小到大排序。输入示例：3,6,-1,8,100,-7")]
        public string toBigSort(string str)
        {
            string[] strArr = Regex.Split(str, ",", RegexOptions.IgnoreCase);
            string temp="";
            bool sign;
            for(int i = 0; i < strArr.Length - 1; i++)
            {
                for(int j = i + 1; j < strArr.Length; j++)
                {
                    int l = int.Parse(strArr[i]);
                    int r = int.Parse(strArr[j]);
                    if (l > r)
                        sign = true;
                    else
                        sign = false;
                    if (sign)
                    {
                        temp = strArr[i];
                        strArr[i] = strArr[j];
                        strArr[j] = temp;
                    }
                }
            }
            string tmp = "";
            for (int i = 0; i < strArr.Length; i++)
            {
                tmp += strArr[i];
                if(i< strArr.Length - 1)
                {
                    tmp += ",";
                }
            }
            return tmp;
        }
```

上述函数实现了从小到大排序。从大到小排序与之类似，详见文件内。

运行结果如下：

![](images\web服务页面1.png)

![](images\web服务页面2.png)

![](images\web服务页面3.png)

## 2. 创建一个应用程序，在新的网页中调用该Web服务，即向Web服务发送页面输入的多个数值，请求排序，并接收Web服务的应答，在页面上显示排序结果。

实验环境为VS2017

具体步骤为：

1. 发布服务、
2. 添加网站。
3. 新建一个项目，并添加服务引用。
4. 添加如下代码：

   ```csharp
   public static string textbox1 = string.Empty;

   private void sort_Click(object sender, EventArgs e)
   {
   	ServiceReference2.WebServiceTestSoapClient ws1 = new ServiceReference2.WebServiceTestSoapClient();
   	textbox1 = this.textBox1.Text;
   	textBox2.Text = ws1.toBigSort(textbox1);
   }

   private void button1_Click(object sender, EventArgs e)
   {
   	ServiceReference2.WebServiceTestSoapClient ws2 = new ServiceReference2.WebServiceTestSoapClient();
   	textbox1 = this.textBox1.Text;
   	textBox3.Text = ws2.toSmallSort(textbox1);
   }
   ```
   运行应用程序界面如下：

   ![](images\web应用1.png)
