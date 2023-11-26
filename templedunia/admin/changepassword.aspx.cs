using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ChangePassword : System.Web.UI.Page
{
    public enum MessageType { Success, Error, Info, Warning };
    ClsConnection Cnn = new ClsConnection();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Admin_id"] == null)
        {
            Response.Redirect("superlogin.aspx");
        }
        Cnn.Open();
        Txtold.Text = Cnn.ExecuteScalar("select Password from AdminLogin").ToString();
        Cnn.Close();
    }
    protected void ShowMessage(string Message, MessageType type)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('" + Message + "','" + type + "');", true);
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (Txtnew.Text == null)
        {
            LblErr.Text = "Input New Password !!!";
        }
        Cnn.Open();
        Cnn.ExecuteNonQuery("update AdminLogin set password='" + Txtnew.Text.Trim() + "'");
        Txtold.Text = Cnn.ExecuteScalar("select Password from AdminLogin").ToString();
        Cnn.Close();
        Txtnew.Text = "";
        ShowMessage("Password Change successfully", MessageType.Success);
    }
}