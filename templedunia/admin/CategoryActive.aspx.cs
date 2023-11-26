using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CategoryActive : System.Web.UI.Page
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
            DataTable dt = Cnn.FillTable("select * from [M_CategoryMaster] where ActiveStatus=1", "Detail");
            LstActive.DataSource = dt;
            LstActive.DataBind();

            DataTable Dtt = Cnn.FillTable("select * from [M_CategoryMaster] where  ActiveStatus=0", "Detail");
            LstDeactive.DataSource = Dtt;
            LstDeactive.DataBind();

            Cnn.Close();
        
    }
    protected void ShowMessage(string Message, MessageType type)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('" + Message + "','" + type + "');", true);
    }
    protected void ListView2_ItemCommand(object sender, ListViewCommandEventArgs e)
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
                        HiddenField1.Value = ((HiddenField)e.Item.FindControl("HdnID")).Value;

                        Cnn.ExecuteNonQuery("update M_CategoryMaster set ActiveStatus=0 where MainCategoryId='" + HiddenField1.Value + "'");
                    }

                }
            }


        }  Cnn.Close();
        list();
        ShowMessage("Record updated successfully", MessageType.Success);
      

    }
    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
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
                        LblId.Value = ((HiddenField)e.Item.FindControl("HdnID")).Value;

                        Cnn.ExecuteNonQuery("update M_CategoryMaster set ActiveStatus=1 where MainCategoryId='" + LblId.Value + "'");
                    }

                }
            }


        }
        list();
        ShowMessage("Record updated successfully", MessageType.Success);
        Cnn.Close();
    }
}