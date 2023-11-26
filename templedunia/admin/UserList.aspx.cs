using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserList : System.Web.UI.Page
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
            DataTable dt = Cnn.FillTable("Select a.*,b.State_Name,c.District_Name as City From  register as a INNER JOIN Loc_State as b On a.State=b.State_Code INNER JOIN Loc_Districtn as c ON a.District=c.District_Code order by userid desc", "Detail");
            lstEnquiryForm.DataSource = dt;
            lstEnquiryForm.DataBind();



            Cnn.Close();
        
    }
  
  
}