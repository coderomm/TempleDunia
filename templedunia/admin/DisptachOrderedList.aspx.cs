
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DisptachOrderedList : System.Web.UI.Page
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
        DataTable DTT = Cnn.FillTable("select top 100 InvoiceNo,Quantity,TransPortName,LrNo,AgainQuantity,convert(varchar, RTS, 0) as  Date,Amount from OrderDispatch where ActiveStatus=1 order by id desc", "Cat");
        LstActive.DataSource = DTT;
        LstActive.DataBind();
        Cnn.Close();
    
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
      
        if (Txtorder.Text == null)
        {

            return;
        }
       
        else{
            Cnn.Open();
            string OrderId = Cnn.ExecuteScalar("select UserId from Registration where FirmName  like '" + Txtorder.Text.Trim() + "%' ").ToString();
            DataTable DTT = Cnn.FillTable("select top 100 InvoiceNo,Quantity,TransPortName,LrNo,AgainQuantity,convert(varchar, RTS, 0) as  Date,Amount from OrderDispatch where ActiveStatus=1 and Userid='" + OrderId + "'  order by id desc", "Cat");
            LstActive.DataSource = DTT;
            LstActive.DataBind();
            Cnn.Close();
            return;

        }
    }
}