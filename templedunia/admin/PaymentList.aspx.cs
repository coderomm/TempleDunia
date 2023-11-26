
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PaymentList : System.Web.UI.Page
{
    ClsConnection Cnn = new ClsConnection();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            List();
        }
    }


    public void List()
    {
        Cnn.Open();
        DataTable DTT = Cnn.FillTable("select a.Mode,a.BankName,a.DDChequeno,a.Amount,a.againstbill,a.Description,convert(varchar, a.RTS, 0) as  Date,b.InvoiceNo from PaymentList as a inner join  TrnOrderMain as b on a.OrderID=b.OrderID  where ActiveStatus=1 order by id desc", "Cat");
        LstActive.DataSource = DTT;
        LstActive.DataBind();
        Cnn.Close();
    
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
      
        if (Txtparty.Text == null)
        {

            return;
        }
       
        else{
            Cnn.Open();
            string userid = Cnn.ExecuteScalar("select UserID from Registration where FirmName like '" + Txtparty.Text+ "%' ").ToString();
            DataTable DTT = Cnn.FillTable("select top 10 a.Mode,a.BankName,a.DDChequeno,a.Amount,a.againstbill,a.Description,convert(varchar, a.RTS, 0) as  Date,b.InvoiceNo from PaymentList as a inner join  TrnOrderMain as b on a.OrderID=b.OrderID where a.ActiveStatus=1 and a.UserID='" + userid + "'  order by id desc", "Cat");
            LstActive.DataSource = DTT;
            LstActive.DataBind();
            Cnn.Close();
            return;

        }
    }
}