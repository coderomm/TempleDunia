using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class VersionNo : System.Web.UI.Page
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
        if (!IsPostBack)
        {
            load();
        }
    
    }

    public void load()
    {
        Cnn.Open();
        txtFirstuser.Text = Cnn.ExecuteScalar("select versionNo from M_AppVersionMaster").ToString();
 
        Cnn.Close();
    
    }
  
    protected void Button1_Click(object sender, EventArgs e)
    {
      

               Cnn.Open();
               Cnn.ExecuteNonQuery("update [M_AppVersionMaster] set versionNo='" + txtFirstuser.Text.Replace("'", "''") + "'");
               ShowMessage("Record updated successfully", MessageType.Success);
        
          
      
            Cnn.Close();

            load();

       


        
    }

    
    protected void ShowMessage(string Message, MessageType type)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('" + Message + "','" + type + "');", true);
    }
   
    }


