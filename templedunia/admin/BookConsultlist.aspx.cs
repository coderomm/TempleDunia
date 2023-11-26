using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BookConsultlist : System.Web.UI.Page
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
            Cnn.Open();
            DataTable dt = Cnn.FillTable("Select a.*,convert(varchar, RTS, 0) as  Date,(select MainCategoryName from doctorlist where MainCategoryid=a.did) as dName from BookConsult as a  order by a.id desc", "Detail");
            lstEnquiryForm.DataSource = dt;
            lstEnquiryForm.DataBind();



            Cnn.Close();
        
    }
  
  
}