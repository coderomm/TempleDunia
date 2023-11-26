using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    ClsConnection Cnn = new ClsConnection();
    protected void Page_Load(object sender, EventArgs e)
    {
   

        
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Session["Admin_id"] = null;
        //Response.Cookies["Admin_id"].Value = null;
        //Response.Cookies["Admin_id"].Expires.ToString();
        Response.Redirect("superlogin.aspx");
    }
}