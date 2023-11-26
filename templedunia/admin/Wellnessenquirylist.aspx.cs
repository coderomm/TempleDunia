using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Wellnessenquirylist : System.Web.UI.Page
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
           
            DataTable dt = Cnn.FillTable("Select * from wellnessenquiry order by id desc", "Detail");
            lstEnquiryForm.DataSource = dt;
            lstEnquiryForm.DataBind();



            Cnn.Close();
        
    }
  
  
}