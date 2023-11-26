using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddSubCategory : System.Web.UI.Page
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
            list();
        }
    }

    public void list()
    {
        DataTable dt = Cnn.FillTable("select * from [SubCategory] where ActiveStatus=1 order by id desc", "Detail");
        lSTProducts.DataSource = dt;
        lSTProducts.DataBind();

        DataTable Dtt = Cnn.FillTable("Select 'MainCategoryId'=-1,'MainCategoryName'='<--Select Main Category-->' union  select MainCategoryId,MainCategoryName from M_CategoryMaster where  ActiveStatus=1", "Detail");
        DDMainCategory.DataSource = Dtt;
        DDMainCategory.DataBind();

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        ////update
        if (Button1.Text == "Update")
        {

            Cnn.Open();
            Cnn.ExecuteNonQuery("update [SubCategory] set SubCategoryName='" + Txtname.Text.Replace("'", "''") + "',MainCategoryId='" + DDMainCategory.SelectedValue + "' where id='" + LblId.Value + "' ");
            Cnn.Close();



            clear();
            list();
            ShowMessage("Record updated successfully", MessageType.Success);
            Button1.Text = "Submit";

        }
        else
        {



            //////////insert
            Cnn.Open();
            int ID = Convert.ToInt32(Cnn.ExecuteScalar("Select  IsNull(Max(id)+1,1) From [SubCategory]"));



            Cnn.ExecuteNonQuery("INSERT INTO [SubCategory] (id,MainCategoryId,SubCategoryName) values ('"+ID+"','" + DDMainCategory.SelectedValue + "','" + Txtname.Text.Trim().Replace("'", "''") + "')");






            LblErr.Text = "Success !!!";
            Cnn.Close();



            clear();
            list();
            ShowMessage("Record submitted successfully", MessageType.Success);


        }
    }

    public void clear()
    {
        Txtname.Text = "";

    
    }
    protected void ShowMessage(string Message, MessageType type)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('" + Message + "','" + type + "');", true);
    }
    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {


        if (e.CommandName == "del")
        {
            LblId.Value = ((HiddenField)e.Item.FindControl("HdnID")).Value;





            Cnn.Open();



            Cnn.ExecuteNonQuery("delete from [M_CategoryMaster] where id='" + LblId.Value + "'");

            list();
            ShowMessage("Record Delete successfully", MessageType.Success);

            Cnn.Close();





            //   string id = ((HiddenField)LstDay.Items[j].FindControl("HdnID")).Value;
            //  Cnn.ExecuteNonQuery("update Poster set  Active=0 where Id='" + LblId.Value + "'");
        }

      
    }


    protected void lSTProducts_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "Edt11")
        {
            LblId.Value = ((HiddenField)e.Item.FindControl("HdnID")).Value;






            Txtname.Text = ((Label)e.Item.FindControl("lblsub")).Text;

            string MainCategoryId = ((Label)e.Item.FindControl("lblCategoryId")).Text;
            DataTable Dtt = Cnn.FillTable("Select 'MainCategoryId'=-1,'MainCategoryName'='<--Select Main Category-->' union  select MainCategoryId,MainCategoryName from M_CategoryMaster where  ActiveStatus=1", "Detail");
            DDMainCategory.DataSource = Dtt;
            DDMainCategory.DataBind();
            DDMainCategory.SelectedValue = MainCategoryId;
            Button1.Text = "Update";


            Cnn.Open();
        }
    }
}