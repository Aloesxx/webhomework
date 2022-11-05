using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Text.RegularExpressions;

namespace WebServiceTest
{
    /// <summary>
    /// WebServiceTest 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    // [System.Web.Script.Services.ScriptService]
    public class WebServiceTest : System.Web.Services.WebService
    {

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }
        [WebMethod(Description = "数字从小到大排序。输入示例：3,6,-1,8,100,-7")]
        public string Sort(string str)
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
    }
}
