using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ProductsActive : System.Web.UI.Page
{
    ClsConnection Cnn = new ClsConnection();
    public enum MessageType { Success, Error, Info, Warning };
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Admin_id"] == null)
        {
            Response.Redirect("superlogin.aspx");
        }


        if (!IsPostBack)
        {
            list();
        }
    }


    public void list()
    {
       
            Cnn.Open();
            DataTable dt = Cnn.FillTable("select * from [M_ProductMaster] where ActiveStatus=1", "Detail");
            LstActive.DataSource = dt;
            LstActive.DataBind();

            DataTable Dtt = Cnn.FillTable("select * from [M_ProductMaster] where  ActiveStatus=0", "Detail");
            LstDeactive.DataSource = Dtt;
            LstDeactive.DataBind();

            Cnn.Close();
        
    }
    protected void ShowMessage(string Message, MessageType type)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('" + Message + "','" + type + "');", true);
    }
   
   
    protected void LstActive_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        Cnn.Open();
        if (e.CommandName == "dea")
        {
            if (LstActive.Items.Count > 0)
            {
                for (int i = 0; i < LstActive.Items.Count; i++)
                {
                    if (((CheckBox)LstActive.Items[i].FindControl("ChkBox")).Checked == true)
                    {

                        string id = ((HiddenField)LstActive.Items[i].FindControl("HdnID")).Value;
                        Cnn.ExecuteNonQuery("update M_ProductMaster set ActiveStatus=0 where ProductId='" + id + "'");
                    }

                }
            }


        }
        list();
        ShowMessage("Record updated successfully", MessageType.Success);
        Cnn.Close();
     
      
      
    }
    protected void LstDeactive_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        Cnn.Open();
        if (e.CommandName == "active")
        {
            if (LstDeactive.Items.Count > 0)
            {
                for (int i = 0; i < LstDeactive.Items.Count; i++)
                {
                    if (((CheckBox)LstDeactive.Items[i].FindControl("ChkBox")).Checked == true)
                    {

                        string id = ((HiddenField)LstDeactive.Items[i].FindControl("HdnID")).Value;
                        Cnn.ExecuteNonQuery("update M_ProductMaster set ActiveStatus=1 where ProductId='" + id + "'");
                    }

                }
            }


        }
        list();
        ShowMessage("Record updated successfully", MessageType.Success);
        Cnn.Close();
     
    }
}