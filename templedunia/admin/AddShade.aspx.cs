using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddShade : System.Web.UI.Page
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
        DataTable dt = Cnn.FillTable("select top 6 * from [M_ShadeMaster] where ActiveStatus=1 order by ProductId desc", "Detail");
        lSTProducts.DataSource = dt;
        lSTProducts.DataBind();

        DataTable Dtt = Cnn.FillTable("Select 'ProductId'=-1,'ProductName'='<--Select Main Product-->' union  select ProductId,ProductName from M_ProductMaster where  ActiveStatus=1", "Detail");
        DDProducts.DataSource = Dtt;
        DDProducts.DataBind();
        DDproducts2.DataSource = Dtt;
        DDproducts2.DataBind();


    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        ////update
        if (Button1.Text == "Update")
        {
            Cnn.Open();
            if (FileUpload1.HasFile)
            {

                byte[] image = FileUpload1.FileBytes;
                ImageHandler imageHandler = new ImageHandler();

                filename = "Products-" + LblId.Value + ".jpg";
                Bitmap bmpmain = imageHandler.CreateThumbnail(image, false, 600, 600);
                if (bmpmain != null)
                {

                    bmpmain.Save(Server.MapPath("~/img/shade/" + filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                }


                Cnn.ExecuteNonQuery("update [M_ShadeMaster] set ProductId='" + DDProducts.SelectedValue + "',ShadeNo='" + Txtshade.Text.Replace("'", "''") + "',Quantity='" + TxtQuantity.Text.Replace("'", "''") + "',Unit='" + TxtUnit.Text.Replace("'", "''") + "',Image='" + filename + "',Description='" + Txtdescription.Text + "',ExtraCharge='" + Txtextra.Text + "' where Id='" + LblId.Value + "' ");


            }
            else
            {

                Cnn.ExecuteNonQuery("update [M_ShadeMaster] set ProductId='" + DDProducts.SelectedValue + "',ShadeNo='" + Txtshade.Text.Replace("'", "''") + "',Quantity='" + TxtQuantity.Text.Replace("'", "''") + "',Unit='" + TxtUnit.Text.Replace("'", "''") + "',Description='" + Txtdescription.Text + "',ExtraCharge='" + Txtextra.Text + "' where Id='" + LblId.Value + "' ");
            }





            clear();
            // list();

            ShowMessage("Record updated successfully", MessageType.Success);

            Button1.Text = "Submit";
            Cnn.Close();
        }
        else
        {



            //////////insert
            Cnn.Open();
            int ID = Convert.ToInt32(Cnn.ExecuteScalar("Select  IsNull(Max(Id)+1,1) From [M_ShadeMaster]"));

            if (FileUpload1.HasFile)
            {

                byte[] image = FileUpload1.FileBytes;
                ImageHandler imageHandler = new ImageHandler();

                filename = "Products-" + ID + ".jpg";
                Bitmap bmpmain = imageHandler.CreateThumbnail(image, false, 600, 600);
                if (bmpmain != null)
                {

                    bmpmain.Save(Server.MapPath("~/img/shade/" + filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                }


                Cnn.ExecuteNonQuery("INSERT INTO [M_ShadeMaster] (ProductId,Id,ShadeNo,Quantity,Unit,Image,Description,ExtraCharge) values ('" + DDProducts.SelectedValue + "','" + ID + "','" + Txtshade.Text.Trim().Replace("'", "''") + "','" + TxtQuantity.Text.Trim().Replace("'", "''") + "','" + TxtUnit.Text.Trim().Replace("'", "''") + "','" + filename + "','" + Txtdescription.Text.Trim().Replace("'", "''") + "','" + Txtextra.Text.Trim().Replace("'", "''") + "')");


            }
            else
            {

                ShowMessage("Please Select Image !!!", MessageType.Error);
            }



            LblErr.Text = "Success !!!";
            Cnn.Close();



            clear();
            list();
            ShowMessage("Record submitted successfully", MessageType.Success);


        }
    }

    public void clear()
    {

        Txtdescription.Text = "";

        TxtQuantity.Text = "";
        Txtshade.Text = "";
        TxtUnit.Text = "";
        Txtextra.Text = "";
        Image1.Visible = false;
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

        if (e.CommandName == "Edt")
        {
            LblId.Value = ((HiddenField)e.Item.FindControl("HdnID")).Value;






            Txtshade.Text = ((Label)e.Item.FindControl("lblShadeNo")).Text;
            TxtQuantity.Text = ((Label)e.Item.FindControl("lblQuantity")).Text;
            TxtUnit.Text = ((Label)e.Item.FindControl("lnlUnit")).Text;
            Txtdescription.Text = ((Label)e.Item.FindControl("lblDescription")).Text;
            Txtextra.Text = ((Label)e.Item.FindControl("lblextra")).Text;

            string ProductsID = ((Label)e.Item.FindControl("lblCategoryId")).Text;
            string img = ((Label)e.Item.FindControl("lblImage")).Text;
            Image1.ImageUrl = "~/img/shade/" + img;
            Image1.Visible = true;
            DataTable Dtt = Cnn.FillTable("Select 'ProductId'=-1,'ProductName'='<--Select Main Category-->' union  select ProductId,ProductName from M_ProductMaster where  ActiveStatus=1", "Detail");
            DDProducts.DataSource = Dtt;
            DDProducts.DataBind();
            DDProducts.SelectedValue = ProductsID;

            Button1.Text = "Update";


            Cnn.Open();
        }
    }


    protected void DDproducts2_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cnn.Open();
        DataTable dt = Cnn.FillTable("select * from [M_ShadeMaster] where ActiveStatus=1 and ProductId='" + DDproducts2.SelectedValue + "' order by ProductId desc", "Detail");
        lSTProducts.DataSource = dt;
        lSTProducts.DataBind();
        Cnn.Close();

    }
}