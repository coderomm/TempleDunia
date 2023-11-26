using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_test : System.Web.UI.Page
{
    ClsConnection Cnn = new ClsConnection();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Cnn.Open();
            TextBox1.Text = Cnn.ExecuteScalar("select VersionNo  from M_AppVersionMaster").ToString();
            Cnn.Close();
        }

    }
    //protected void Button1_Click(object sender, EventArgs e)
    //{
    //    Cnn.Open();
    //    Cnn.ExecuteNonQuery("update AboutUs set Descr='"+Txtdescription.Text+"' where id=1");
    //    Cnn.Close();
    //}
    protected void Button2_Click(object sender, EventArgs e)
    {
        Cnn.Open();
        Cnn.ExecuteNonQuery("update M_AppVersionMaster set VersionNo='" + TextBox1.Text + "'");
        Cnn.Close();
    }
}