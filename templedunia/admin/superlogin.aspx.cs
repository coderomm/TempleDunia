using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class superlogin : System.Web.UI.Page
{
    ClsConnection Cnn = new ClsConnection();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (Txtusername.Text == "")
        {
            LblErr.Text = "Please enter User Name";
            return;
        }
        if (Txtpassword.Text == "")
        {
            LblErr.Text = "Please enter Password";
            return;
        }
        DataSet ds = new DataSet();
        Cnn.Open();
        Cnn.FillDataSet(ds, "select * from [Admin] where Username = '" + Txtusername.Text.Replace("'", "''") + "'COLLATE SQL_Latin1_General_CP1_CS_AS and Password = '" + Txtpassword.Text.Replace("'", "''") + "'", "Admin_Login");
        Cnn.Close();
        if (ds.Tables[0].Rows.Count == 0)
        {
            LblErr.Text = "Please Enter Correct Username & Password";
        }
        else
        {
            LblErr.Text = "";
            Random random = new Random();
            int RandomNumber = random.Next(1, 10000);
            Session["usersession"] = RandomNumber;
            Session["Admin_id"] = ds.Tables[0].Rows[0]["Id"].ToString();
            Response.Redirect("index.aspx");
        }
    }
}