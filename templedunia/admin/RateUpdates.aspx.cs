using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RateUpdates : System.Web.UI.Page
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
        DataTable DTT = Cnn.FillTable("select * from M_ProductMaster where ActiveStatus=1", "Cat");
        LstActive.DataSource = DTT;
        LstActive.DataBind();
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
              


                foreach (ListViewItem myListViewItem in LstActive.Items)
                {
                    HiddenField tempProdcode = myListViewItem.FindControl("HdnID") as HiddenField;
                    TextBox price = myListViewItem.FindControl("TxtRate") as TextBox;
                  
                    ProductId = tempProdcode.Value;
                    UserPrice = price.Text;

                    Cnn.ExecuteNonQuery("update M_ProductMaster set Rate='" + UserPrice + "' where ProductID='" + ProductId + "'");


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
}