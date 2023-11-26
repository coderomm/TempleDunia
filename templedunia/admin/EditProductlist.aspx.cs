using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EditProductlist : System.Web.UI.Page
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
            loaddata("","");
        }
    }

    public void loaddata(string cid="",string bid="")
    {

        Cnn.Open();
        DataTable dt = Cnn.FillTable("select a.* from Product as a  where 1=1 "+cid+" "+bid+" order by a.productid desc", "Detail");
        lstcolorlist.DataSource = dt;
        lstcolorlist.DataBind();
        Cnn.Close();
    
    }
    protected void lstcolorlist_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "DeActive")
        {
            Cnn.Open();
            try
            {
                Cnn.BeginTrans();
                String Sql1 = "", Sql2 = "", Sql3 = "", Sql4 = "";
                if (lstcolorlist.Items.Count > 0)
                {
                    for (int i = 0; i < lstcolorlist.Items.Count; i++)
                    {
                        if (((CheckBox)lstcolorlist.Items[i].FindControl("ChkBoxDA")).Checked == true)
                        {

                            string ProductId = ((Label)lstcolorlist.Items[i].FindControl("LblProductId")).Text;
                            Sql1 = Sql1 + "; Update Product set Active=1 where ProductId='" + ProductId + "';";

                        }
                        else
                        {
                            string ProductId = ((Label)lstcolorlist.Items[i].FindControl("LblProductId")).Text;
                            Sql1 = Sql1 + "; Update Product set Active=0 where ProductId='" + ProductId + "';";
                        }

                    }
                    //Cnn.ExecuteNonQuery("Update [Store].Product set Active=0 where ProductId='" + ProductId + "'");
                    //Cnn.ExecuteNonQuery("Update [Store].dtl_ProductGallery set Active=0 where Product_Id='" + ProductId + "'");
                    //Cnn.ExecuteNonQuery("Update ProductSizeQuantity set Active=0 where ProductId='" + ProductId + "'");
                    //Cnn.ExecuteNonQuery("Update [Store].dtl_Productcolor set Active=0 where ProductId='" + ProductId + "'");
                    if (Sql1 != "")
                    {
                        String Sql = Sql1 + Sql2 + Sql4;
                        Cnn.ExecuteNonQuery(Sql);
                    }
                }
                Cnn.CommitTrans();
            }
            catch (SqlException ex)
            {
                Cnn.CommitTrans();
            }
            Cnn.Close();
            lstcolorlist.DataBind();
        }


        Cnn.Close();

        if (e.CommandName == "delte")
        {
            LblId.Value = ((HiddenField)e.Item.FindControl("HdnID")).Value;

            Cnn.Open();
            //    string img = ((Label)e.Item.FindControl("lblImage")).Text;


            //  File.Delete(Server.MapPath("~/img/product/" + img + ""));

            DataTable Dt2 = Cnn.FillTable("Select ImageCode,Image_Id from dtl_ProductGallery Where Product_Id='" + LblId.Value + "'", "Dt");
            if (Dt2.Rows.Count > 0)
            {
                for (int i = 0; i < Dt2.Rows.Count; i++)
                {
                    File.Delete(Server.MapPath("~/img/product/" + Dt2.Rows[i]["ImageCode"] + ""));
                }
            }
            Cnn.ExecuteNonQuery("delete from Product where ProductID='" + LblId.Value + "'");
            Cnn.ExecuteNonQuery("delete from ProductSizeQuantity where ProductID='" + LblId.Value + "'");
            Cnn.ExecuteNonQuery("delete from dtl_ProductGallery where Product_ID='" + LblId.Value + "'");


            //   ShowMessage("Record Delete successfully", MessageType.Success);

            Cnn.Close();



            lstcolorlist.DataBind();

            //   string id = ((HiddenField)LstDay.Items[j].FindControl("HdnID")).Value;
            //  Cnn.ExecuteNonQuery("update Poster set  Active=0 where Id='" + LblId.Value + "'");
        }

        if (e.CommandName == "deactive")
        {
            LblId.Value = ((HiddenField)e.Item.FindControl("HdnID")).Value;
            Cnn.Open();
            Cnn.ExecuteNonQuery("update [Product] set  active=0 where ProductId=" + LblId.Value + "");
            Cnn.Close();

           
        }
        if (e.CommandName == "active")
        {
            LblId.Value = ((HiddenField)e.Item.FindControl("HdnID")).Value;
            Cnn.Open();
            Cnn.ExecuteNonQuery("update [Product] set active=1 where ProductId=" + LblId.Value + "");
            Cnn.Close();

          
        }
        string cid = "", bid = "";
        if (DDMainCategory.SelectedValue != "-1")
        {
            cid = "and a.categoryid=" + DDMainCategory.SelectedValue + " ";
        }

        loaddata(cid, bid);
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string cid = "", bid = "";
        if (DDMainCategory.SelectedValue != "-1")
        {
            cid = "and a.categoryid="+DDMainCategory.SelectedValue+" ";
        }
      
        loaddata(cid,bid);
    }
}