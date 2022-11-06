using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WSTEST1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

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
    }
}
