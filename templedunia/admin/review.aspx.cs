using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class review : System.Web.UI.Page
{

    ClsConnection Cnn = new ClsConnection();
    public enum MessageType { Success, Error, Info, Warning };
    string filename;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Admin_id"] == null)
        {
            Response.Redirect("superlogin.aspx");
        }

        list();
    }

    public void list()
    {
        DataTable dt = Cnn.FillTable("select a.*,(select productname from product where productid=a.pid) as productname  from [review] as a  where a.active=0 order by a.idp asc", "Detail");
        ListView1.DataSource = dt;
        ListView1.DataBind();
    }
  
    public void clear()
    {
        
    }
    protected void ShowMessage(string Message, MessageType type)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('" + Message + "','" + type + "');", true);
    }
    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        Cnn.Open();
        if (e.CommandName == "dea")
        {
            if (ListView1.Items.Count > 0)
            {
                for (int i = 0; i < ListView1.Items.Count; i++)
                {
                    if (((CheckBox)ListView1.Items[i].FindControl("ChkBox")).Checked == true)
                    {
                        LblId.Value = ((HiddenField)e.Item.FindControl("HdnID")).Value;

                        Cnn.ExecuteNonQuery("update M_CategoryMaster set Active=0 where Id='" + LblId.Value + "'");
                    }

                }
            }


        }

        Cnn.Close();

        if (e.CommandName == "del")
        {
            LblId.Value = ((HiddenField)e.Item.FindControl("HdnID")).Value;

            
         
         
          
            Cnn.Open();



            Cnn.ExecuteNonQuery("delete from [review] where idp='" + LblId.Value + "'");
            
            list();
            ShowMessage("Record Delete successfully", MessageType.Success);

            Cnn.Close();





            //   string id = ((HiddenField)LstDay.Items[j].FindControl("HdnID")).Value;
            //  Cnn.ExecuteNonQuery("update Poster set  Active=0 where Id='" + LblId.Value + "'");
        }

       
        if (e.CommandName == "deactive")
        {
            LblId.Value = ((HiddenField)e.Item.FindControl("HdnID")).Value;
            Cnn.Open();
            Cnn.ExecuteNonQuery("update [M_CategoryMaster] set  active=0 where MainCategoryid=" + LblId.Value + "");
            Cnn.Close();

            list();
        }
        if (e.CommandName == "active")
        {
            LblId.Value = ((HiddenField)e.Item.FindControl("HdnID")).Value;
            Cnn.Open();
            Cnn.ExecuteNonQuery("update [review] set active=1 where idp=" + LblId.Value + "");
            Cnn.Close();

            list();
        }
    }


}