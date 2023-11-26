using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Shadequantity : System.Web.UI.Page
{
    ClsConnection Cnn=new ClsConnection();
    public enum MessageType { Success, Error, Info, Warning };
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Admin_id"] == null)
        {
            Response.Redirect("superlogin.aspx");
        }

        if (!IsPostBack)
        {
            List();
          
        }

    }

    public void List()
    {
        Cnn.Open();
        DataTable DTT = Cnn.FillTable("select top 5 * from M_ShadeMaster where ActiveStatus=1 order by ProductId desc", "Cat");
        LstActive.DataSource = DTT;
        LstActive.DataBind();

        DataTable Dttt = Cnn.FillTable("Select 'ProductId'=-1,'ProductName'='<--Select Main Product-->' union  select ProductId,ProductName from M_ProductMaster where  ActiveStatus=1", "Detail");
        DDproducts2.DataSource = Dttt;
        DDproducts2.DataBind();
        Cnn.Close();

    }
    protected void ShowMessage(string Message, MessageType type)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('" + Message + "','" + type + "');", true);
    }
    protected void LstActive_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "ChkAllRate")
        {
            Cnn.Open();
            try
            {
                foreach (ListViewItem myListViewItem in LstActive.Items)
                {
                    //****************************************************************************
                    Label templbl = myListViewItem.FindControl("lblrate") as Label;
                    templbl.Visible = false;

                    TextBox temptt = myListViewItem.FindControl("TxtRate") as TextBox;
                    temptt.Visible = true;

                    temptt.Text = templbl.Text;

                  

                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
            Cnn.Close();
        }

        if (e.CommandName == "UpdateAllRate")
        {
            Cnn.Open();
            try
            {
                string ProductId = "";
                string UserPrice = "";
                string Shadid = "";
                foreach (ListViewItem myListViewItem in LstActive.Items)
                {
                    HiddenField tempProdcode = myListViewItem.FindControl("HdnID") as HiddenField;
                    Label Sid = myListViewItem.FindControl("sid") as Label;
                    TextBox price = myListViewItem.FindControl("TxtRate") as TextBox;                  
                    ProductId = tempProdcode.Value;
                    UserPrice = price.Text;
                    Shadid = Sid.Text;
                    Cnn.ExecuteNonQuery("update M_ShadeMaster set Quantity='" + UserPrice + "' where ProductID='" + ProductId + "' and id='"+Shadid+"'");
                    ProductId = "";
                    UserPrice = "";                  
                }
                ShowMessage("Record updated successfully", MessageType.Success);
                List();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
            Cnn.Close();
        }
    }
    protected void DDproducts2_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cnn.Open();
        DataTable dt = Cnn.FillTable("select * from [M_ShadeMaster] where ActiveStatus=1 and ProductId='" + DDproducts2.SelectedValue + "'", "Detail");
        LstActive.DataSource = dt;
        LstActive.DataBind();
        Cnn.Close();
    }
}