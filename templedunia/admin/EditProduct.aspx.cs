using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EditProduct : System.Web.UI.Page
{
    ClsConnection Cnn = new ClsConnection();
    public enum MessageType { Success, Error, Info, Warning };
    // public static int RandomNumber;
    string filename;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["Admin_id"] == null)
        {
            Response.Redirect("superlogin.aspx");
        }
        if (string.IsNullOrEmpty(Request.QueryString["id"] as string))
        {
            Response.Redirect("EditProductlist.aspx");
        }
        else
        {
            if (!IsPostBack)
            {
                Cnn.Open();
                LblEdtProductId.Text = Request.QueryString["id"];
                Random random = new Random();
                int RandomNumber = random.Next(1, 10000);
                Session["Random"] = RandomNumber;
                list();
                DataRow dr = Cnn.FillRow("select * from Product where productid=" + Request.QueryString["id"] + "");
                txtproductname.Text = dr["productname"].ToString();
                txtmetatitle.Text = dr["metatitle"].ToString();
                txtunit.Text = dr["unit"].ToString();
                txtWeight.Text = dr["weight"].ToString();
                if (!string.IsNullOrEmpty(dr["Description"].ToString()))
                {
                    CKEditor1.Value = dr["Description"].ToString();
                }
                if (Convert.ToBoolean(dr["sale"]) == true)
                {
                    CheckBox1.Checked = true;
                }
                else
                {
                    CheckBox1.Checked = true;
                }
                if (!string.IsNullOrEmpty(dr["categoryid"].ToString()))
                {
                    DDMainCategory.DataBind();
                    DDMainCategory.Items.FindByValue(dr["categoryid"].ToString()).Selected = true;
                }
                if (!string.IsNullOrEmpty(dr["brandid"].ToString()))
                {
                    DDbrand.DataBind();
                    DDbrand.Items.FindByValue(dr["brandid"].ToString()).Selected = true;
                }

                int ColorAvailable = Convert.ToInt32(Cnn.ExecuteScalar("select count(*) from ProductSizeQuantity where ProductId=" + dr["productid"].ToString() + ""));
                if (ColorAvailable != 0)
                {
                    DivColor.Visible = true;
                    DataTable DtColor = Cnn.FillTable("select a.*,case when b.ColorId is null then 0 else 1 end as AlreadyPresent from color as a left join ProductSizeQuantity as b on a.ColorId=b.ColorId and b.ProductId='" + dr["productid"].ToString() + "'", "eee");
                    if (DtColor.Rows.Count > 0)
                    {
                        for (int i = 0; i < DtColor.Rows.Count; i++)
                        {
                            if (Convert.ToInt32(DtColor.Rows[i]["AlreadyPresent"]) == 0)
                            {
                                ddlColor.Items.Add(new ListItem(DtColor.Rows[i]["colorname"].ToString(), DtColor.Rows[i]["ColorId"].ToString()));
                            }
                        }
                     //   Imagetitlebind();
                    }

                    if (Convert.ToInt32(Cnn.ExecuteScalar("select count(id) from temp_ProColorSize where Product_id=" + dr["productid"].ToString() + " and random_no=" + RandomNumber + "")) == 0)
                    {
                        Cnn.ExecuteNonQuery("delete from temp_ProColorSize where product_id="+ dr["productid"].ToString() + "");
                        Cnn.ExecuteNonQuery("insert into temp_ProColorSize Select ProductId,Size,quantity,rts,colorid,urate,udiscount,arate,adiscount," + RandomNumber + " from ProductSizeQuantity Where ProductId=" + dr["productid"].ToString() + "");
                        Cnn.ExecuteNonQuery("insert into temp_progallery Select Image_Id,Product_Id,Priority,Active,ImageCode,ColorId,'" + Session["Random"] + "',size From dtl_ProductGallery Where Product_Id=" + dr["productid"].ToString() + "");
                    }
                    DataTable Dt2 = Cnn.FillTable("select a.*,b.ColorName,c.varient from temp_ProColorSize as a join Color as b on a.colorid=b.ColorId join varient as c on a.size=c.id where a.product_id=" + dr["productid"].ToString() + "", "eee");
                    if (Dt2.Rows.Count > 0)
                    {
                        lstTempColorSize.DataSource = Dt2;
                        lstTempColorSize.DataBind();
                        Session["Random"] = Convert.ToInt32(Dt2.Rows[0]["random_no"].ToString());
                    }
                }
                Cnn.Close();
            }
        }
    }

    protected void Imagetitlebind()
    {
        if (ddlColor != null)
        {
            foreach (ListItem li in ddlColor.Items)
            {
                
                li.Attributes["title"] = "../assets/Color/" + li.Value + ".jpg"; // Define the folder of image which is defined in the application.
            }
        }
    }

    public void list()
    {
        DataTable Dtt = Cnn.FillTable("Select 'MainCategoryId'=-1,'MainCategoryName'='Select Main Category' union  select MainCategoryId,MainCategoryName from M_CategoryMaster where  active=1", "Detail");
        DDMainCategory.DataSource = Dtt;
        DDMainCategory.DataBind();

        DataTable Dt1t = Cnn.FillTable("Select 'brandid'=-1,'brandName'='Select Brand' union  select brandid,brandName from brand where  active=1", "Detail");
        DDbrand.DataSource = Dt1t;
        DDbrand.DataBind();
        //DataTable Dtcolor = Cnn.FillTable("select * from  ProductSizeQuantity", "Detail");
        //lstcolorlist.DataSource = Dtcolor;
        //lstcolorlist.DataBind();
        //if (Dtcolor.Rows.Count > 0)
        //{
        //    imglist.Visible = true;
        //}
        //else
        //{
        //    imglist.Visible = false;
        //}
        DataTable Dt11t = Cnn.FillTable("Select 'id'=-1,'varient'='Select varient' union  select id,varient from varient where  active=1", "Detail");
        ddVariant.DataSource = Dt11t;
        ddVariant.DataBind();

        //DataTable Dt = Cnn.FillTable("select * from color", "eee");
        //if (Dt.Rows.Count > 0)
        //{
        //    for (int i = 0; i < Dt.Rows.Count; i++)
        //    {

        //        ddlColor.Items.Add(new ListItem(Dt.Rows[i]["colorname"].ToString(), Dt.Rows[i]["ColorId"].ToString()));

        //    }
        //    Imagetitlebind();
        //}

    }

    protected void lstTempColorSize_ItemEditing(object sender, ListViewEditEventArgs e)
    {

    }

    protected void lstTempColorSize_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "del")
        {
            Cnn.Open();
            int id = Convert.ToInt32(e.CommandArgument.ToString());
            string ClrID = ((Label)e.Item.FindControl("lblColorId")).Text;
            string SizeID = ((Label)e.Item.FindControl("lblSize")).Text;
            Cnn.ExecuteNonQuery("delete from temp_ProColorSize where id=" + id + "");
            int Count = Convert.ToInt32(Cnn.ExecuteScalar("Select Count(*) From temp_progallery Where Product_id=" + LblEdtProductId.Text + " and ColorId=" + ClrID + " and size=" + SizeID + "").ToString());
            if (Count > 0)
            {
                string FileName = Convert.ToString(Cnn.ExecuteScalar("select ImageCode from temp_progallery where Product_id=" + LblEdtProductId.Text + " and ColorId=" + ClrID + " and size=" + SizeID + ""));
                string path = Server.MapPath("~/img/product/");
                //string Npath = path + "/Catalog/";
                //System.IO.File.Delete(Npath + FileName);
                //Npath = path + "/Small/";
                //System.IO.File.Delete(Npath + FileName);
                //Npath = path + "/Big/";
                //System.IO.File.Delete(Npath + FileName);
                //Npath = path + "/Zoom/";
                System.IO.File.Delete(path + FileName);
                Cnn.ExecuteNonQuery("delete from temp_progallery where Product_id=" + LblEdtProductId.Text + " and ColorId=" + ClrID + " and size=" + SizeID + "");
            }
            DataTable dt = Cnn.FillTable("select a.*,b.ColorName,c.varient from temp_ProColorSize as a join Color as b on a.colorid=b.ColorId join varient as c on a.size=c.id where a.product_id=" + LblEdtProductId.Text + " and a.random_no=" + Session["Random"] + "", "lsttemp");
            if (dt.Rows.Count > 0)
            {
                lstTempColorSize.DataSource = dt;
                lstTempColorSize.DataBind();
            }
            else
            {
                lstTempColorSize.DataSource = "";
                lstTempColorSize.DataBind();
            }

            Imagetitlebind();
            Cnn.Close();
        }
        if (e.CommandName == "Edit")
        {
            Cnn.Open();
            int id = Convert.ToInt32(e.CommandArgument.ToString());
            int ColorId = Convert.ToInt32(((Label)e.Item.FindControl("lblColorId")).Text);
            string Size = ((Label)e.Item.FindControl("lblSize")).Text;
            string Qty = ((Label)e.Item.FindControl("lblQty")).Text;
            string ProdId = ((Label)e.Item.FindControl("lblProid")).Text;
            DataRow drColor = Cnn.FillRow("select colorname,Colorimg from Color where colorid=" + ColorId + "");
            DataTable Dt = Cnn.FillTable("select * from Color", "eee");
            if (Dt.Rows.Count > 0)
            {
                for (int i = 0; i < Dt.Rows.Count; i++)
                {
                    //if (Convert.ToInt32(Dt.Rows[i]["AlreadyPresent"]) == 0)
                    //{
                    ddlColor.Items.Add(new ListItem(Dt.Rows[i]["colorname"].ToString(), Dt.Rows[i]["colorimg"].ToString()));
                    //}
                }
                Imagetitlebind();
            }
            ddlColor.ClearSelection();
            ddlColor.DataBind();
            ddlColor.Items.FindByText(drColor["colorname"].ToString()).Selected = true;
            //DataTable Dt1 = Cnn.FillTable("select 'size_number'='<-Select Size->','size_id'=-1 union select size_number,size_id from Store.mst_Size where MainCategoryId=" + DDMainCat.SelectedValue + " and SubCatId=" + DDSUbCat.SelectedValue + "", "eee");
            //if (Dt1.Rows.Count > 0)
            //{
            //    DivSize.Visible = true;
            //    ddSubWiseSize.DataSource = Dt1;
            //    ddSubWiseSize.DataBind();
            //}
            DataTable Dt2 = Cnn.FillTable("Select ImageCode,Image_Id from dtl_ProductGallery Where Product_Id='" + ProdId + "' and colorid=" + ColorId + " and size=" + Size + " Order by Substring((Reverse(Image_Id)),5,1)", "Dt");
            if (Dt2.Rows.Count > 0)
            {
                if (Dt2.Rows.Count == 1)
                {
                    ImageColor1.Visible = true;
                    ImageColor1.AlternateText = Dt2.Rows[0]["Image_Id"].ToString();
                    ImageColor1.ImageUrl = "~/img/product/" + Dt2.Rows[0]["ImageCode"].ToString() + "";

                }
                if (Dt2.Rows.Count == 2)
                {
                    ImageColor1.Visible = true;
                    ImageColor2.Visible = true;
                    ImageColor1.ImageUrl = "~/img/product/" + Dt2.Rows[0]["ImageCode"].ToString() + "";
                    ImageColor2.ImageUrl = "~/img/product/" + Dt2.Rows[1]["ImageCode"].ToString() + "";
                    ImageColor1.AlternateText = Dt2.Rows[0]["Image_Id"].ToString();
                    ImageColor2.AlternateText = Dt2.Rows[1]["Image_Id"].ToString();
                }
                if (Dt2.Rows.Count == 3)
                {
                    ImageColor1.Visible = true;
                    ImageColor2.Visible = true;
                    ImageColor3.Visible = true;
                    ImageColor1.ImageUrl = "~/img/product/" + Dt2.Rows[0]["ImageCode"].ToString() + "";
                    ImageColor2.ImageUrl = "~/img/product/" + Dt2.Rows[1]["ImageCode"].ToString() + "";
                    ImageColor3.ImageUrl = "~/img/product/" + Dt2.Rows[2]["ImageCode"].ToString() + "";
                    ImageColor1.AlternateText = Dt2.Rows[0]["Image_Id"].ToString();
                    ImageColor2.AlternateText = Dt2.Rows[1]["Image_Id"].ToString();
                    ImageColor3.AlternateText = Dt2.Rows[2]["Image_Id"].ToString();
                }
                if (Dt2.Rows.Count == 4)
                {
                    ImageColor1.Visible = true;
                    ImageColor2.Visible = true;
                    ImageColor3.Visible = true;
                    ImageColor4.Visible = true;
                    ImageColor1.ImageUrl = "~/img/product/" + Dt2.Rows[0]["ImageCode"].ToString() + "";
                    ImageColor2.ImageUrl = "~/img/product/" + Dt2.Rows[1]["ImageCode"].ToString() + "";
                    ImageColor3.ImageUrl = "~/img/product/" + Dt2.Rows[2]["ImageCode"].ToString() + "";
                    ImageColor4.ImageUrl = "~/img/product/" + Dt2.Rows[3]["ImageCode"].ToString() + "";
                    ImageColor1.AlternateText = Dt2.Rows[0]["Image_Id"].ToString();
                    ImageColor2.AlternateText = Dt2.Rows[1]["Image_Id"].ToString();
                    ImageColor3.AlternateText = Dt2.Rows[2]["Image_Id"].ToString();
                    ImageColor4.AlternateText = Dt2.Rows[3]["Image_Id"].ToString();
                }
                if (Dt2.Rows.Count == 5)
                {
                    ImageColor1.Visible = true;
                    ImageColor2.Visible = true;
                    ImageColor3.Visible = true;
                    ImageColor4.Visible = true;
                    ImageColor5.Visible = true;
                    ImageColor1.ImageUrl = "~/img/product/" + Dt2.Rows[0]["ImageCode"].ToString() + "";
                    ImageColor2.ImageUrl = "~/img/product/" + Dt2.Rows[1]["ImageCode"].ToString() + "";
                    ImageColor3.ImageUrl = "~/img/product/" + Dt2.Rows[2]["ImageCode"].ToString() + "";
                    ImageColor4.ImageUrl = "~/img/product/" + Dt2.Rows[3]["ImageCode"].ToString() + "";
                    ImageColor5.ImageUrl = "~/img/product/" + Dt2.Rows[4]["ImageCode"].ToString() + "";
                    ImageColor1.AlternateText = Dt2.Rows[0]["Image_Id"].ToString();
                    ImageColor2.AlternateText = Dt2.Rows[1]["Image_Id"].ToString();
                    ImageColor3.AlternateText = Dt2.Rows[2]["Image_Id"].ToString();
                    ImageColor4.AlternateText = Dt2.Rows[3]["Image_Id"].ToString();
                    ImageColor5.AlternateText = Dt2.Rows[4]["Image_Id"].ToString();
                }

            }
            ddVariant.ClearSelection();
            ddVariant.DataBind();
            ddVariant.Items.FindByValue(Size).Selected = true;
            txtQuantity.Text = Qty;
            txtuserprice.Text = ((Label)e.Item.FindControl("lblUsrRate")).Text;
            txtDiscount.Text = ((Label)e.Item.FindControl("lblUsrDiscount")).Text;
            txtagentprice.Text = ((Label)e.Item.FindControl("lblAgentRate")).Text;
            txtadiscount.Text = ((Label)e.Item.FindControl("lblAgentDiscount")).Text;
            lblTempId.Text = Convert.ToString(id);
            lnkAddColor.Text = "Update";
            Cnn.Close();
        }
    }

    protected void lnkAddColor_Click(object sender, EventArgs e)
    {
        Cnn.Open();
        int colorId = 0;
        if (lnkAddColor.Text == "Add")
        {
            colorId = Convert.ToInt32(Cnn.ExecuteScalar("select ColorId from Color where colorname='" + ddlColor.SelectedItem.Text + "'"));
            //if (DivSize.Visible == true)
            //{
            int checksize = Convert.ToInt32(Cnn.ExecuteScalar("select count(id) from temp_ProColorSize where size='" + ddVariant.SelectedItem.Value + "' and colorid=" + colorId + ""));
            if (checksize > 0)
            {
                lblSizeErr.Visible = true;
                lblSizeErr.Text = "Size already exist..!!";
            }
            else
            {
                lblSizeErr.Visible = false;

                Cnn.ExecuteNonQuery("insert into temp_ProColorSize values(" + Request.QueryString["id"] + ",'" + ddVariant.SelectedItem.Value + "','" + txtQuantity.Text + "',getdate()," + colorId + "," + txtuserprice.Text + "," + txtDiscount.Text + "," + txtagentprice.Text + "," + txtadiscount.Text + "," + Session["Random"] + ")");
                DataTable dtClr = Cnn.FillTable("select a.*,b.ColorName,c.varient from temp_ProColorSize as a join Color as b on a.colorid=b.ColorId join varient as c on a.size=c.id where a.Product_id=" + LblEdtProductId.Text + " and a.random_no=" + Session["Random"] + "", "lsttemp");
                if (dtClr.Rows.Count > 0)
                {
                    lstTempColorSize.DataSource = dtClr;
                    lstTempColorSize.DataBind();
                }
            }
            //}
            //else
            //{

            //Cnn.ExecuteNonQuery("insert into temp_ProColorSize values(" + LblEdtProductId.Text + ",'0'," + txtQuantity.Text + ",getdate()," + colorId + "," + Session["Random"] + "," + txtProColorSizeRate.Text + "," + Disc + ")");
            //DataTable dt = Cnn.FillTable("select a.*,b.Color_Name from temp_ProColorSize as a join Store.mst_Color as b on a.colorid=b.Color_Id where a.random_no=" + Session["Random"] + "", "lsttemp");
            //if (dt.Rows.Count > 0)
            //{
            //    lstTempColorSize.DataSource = dt;
            //    lstTempColorSize.DataBind();
            //}

            //}
            Imagetitlebind();
            int Count = Convert.ToInt32(Cnn.ExecuteScalar("Select Count(*) From temp_progallery Where Product_Id=" + Request.QueryString["id"] + " and ColorId=" + colorId + " ans size='" + ddVariant.SelectedValue + "'").ToString());
            //int Count = Convert.ToInt32(Cnn.ExecuteScalar("Select Count(*) From Store.dtl_ProductGallery Where Product_Id=" + LblEdtProductId.Text + " and ColorId=" + colorId + "").ToString());
            if (Count == 0)
            {
                if (FileUpload1.HasFile)
                {
                    int image_id = Convert.ToInt32(Cnn.ExecuteScalar("Select  IsNull(Max(image_id)+1,1) From [dtl_ProductGallery]"));
                    byte[] image = FileUpload1.FileBytes;
                    ImageHandler imageHandler = new ImageHandler();
                    filename = LblEdtProductId.Text + "_" + image_id + ".jpg";
                    Bitmap bmpmain = imageHandler.CreateThumbnail(image, false, 500, 500);
                    if (bmpmain != null)
                    {
                        bmpmain.Save(Server.MapPath("~/img/product/" + filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                    }
                    //int imgCode = Convert.ToInt32(Cnn.ExecuteScalar("select isnull(max(ImageCode),0)+1 from temp_progallery"));
                    Cnn.ExecuteNonQuery("insert into temp_progallery(Image_id,product_id,priority,active,ImageCode,ColorId,random_no,size) values(" + image_id + "," + LblEdtProductId.Text + ",0,1,'" + filename + "'," + colorId + "," + Session["Random"] + ",'" + ddVariant.SelectedValue + "')");

                    //}
                }
                if (FileUpload2.HasFile)
                {
                    int image_id = Convert.ToInt32(Cnn.ExecuteScalar("Select  IsNull(Max(image_id)+1,1) From [dtl_ProductGallery]"));
                    byte[] image = FileUpload1.FileBytes;
                    ImageHandler imageHandler = new ImageHandler();
                    filename = LblEdtProductId.Text + "_" + image_id + ".jpg";
                    Bitmap bmpmain = imageHandler.CreateThumbnail(image, false, 500, 500);
                    if (bmpmain != null)
                    {
                        bmpmain.Save(Server.MapPath("~/img/product/" + filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                    }
                    Cnn.ExecuteNonQuery("insert into temp_progallery(Image_id,product_id,priority,active,ImageCode,ColorId,random_no,size) values(" + image_id + "," + LblEdtProductId.Text + ",0,1,'" + filename + "'," + colorId + "," + Session["Random"] + ",'" + ddVariant.SelectedValue + "')");
                    //}
                }
                if (FileUpload3.HasFile)
                {
                    int image_id = Convert.ToInt32(Cnn.ExecuteScalar("Select  IsNull(Max(image_id)+1,1) From [dtl_ProductGallery]"));
                    byte[] image = FileUpload3.FileBytes;
                    ImageHandler imageHandler = new ImageHandler();
                    filename = LblEdtProductId.Text + "_" + image_id + ".jpg";
                    Bitmap bmpmain = imageHandler.CreateThumbnail(image, false, 500, 500);
                    if (bmpmain != null)
                    {
                        bmpmain.Save(Server.MapPath("~/img/product/" + filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                    }
                    Cnn.ExecuteNonQuery("insert into temp_progallery(Image_id,product_id,priority,active,ImageCode,ColorId,random_no,size) values(" + image_id + "," + LblEdtProductId.Text + ",0,1,'" + filename + "'," + colorId + "," + Session["Random"] + ",'" + ddVariant.SelectedValue + "')");
                    //}
                }
                if (FileUpload4.HasFile)
                {
                    int image_id = Convert.ToInt32(Cnn.ExecuteScalar("Select  IsNull(Max(image_id)+1,1) From [dtl_ProductGallery]"));
                    byte[] image = FileUpload4.FileBytes;
                    ImageHandler imageHandler = new ImageHandler();
                    filename = LblEdtProductId.Text + "_" + image_id + ".jpg";
                    Bitmap bmpmain = imageHandler.CreateThumbnail(image, false, 500, 500);
                    if (bmpmain != null)
                    {
                        bmpmain.Save(Server.MapPath("~/img/product/" + filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                    }
                    Cnn.ExecuteNonQuery("insert into temp_progallery(Image_id,product_id,priority,active,ImageCode,ColorId,random_no,size) values(" + image_id + "," + LblEdtProductId.Text + ",0,1,'" + filename + "'," + colorId + "," + Session["Random"] + ",'" + ddVariant.SelectedValue + "')");
                    //}
                }
                if (FileUpload5.HasFile)
                {
                    int image_id = Convert.ToInt32(Cnn.ExecuteScalar("Select  IsNull(Max(image_id)+1,1) From [dtl_ProductGallery]"));
                    byte[] image = FileUpload5.FileBytes;
                    ImageHandler imageHandler = new ImageHandler();
                    filename = LblEdtProductId.Text + "_" + image_id + ".jpg";
                    Bitmap bmpmain = imageHandler.CreateThumbnail(image, false, 500, 500);
                    if (bmpmain != null)
                    {
                        bmpmain.Save(Server.MapPath("~/img/product/" + filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                    }
                    Cnn.ExecuteNonQuery("insert into temp_progallery(Image_id,product_id,priority,active,ImageCode,ColorId,random_no,size) values(" + image_id + "," + LblEdtProductId.Text + ",0,1,'" + filename + "'," + colorId + "," + Session["Random"] + ",'" + ddVariant.SelectedValue + "')");
                    //}
                }
            }
        }
        else
        {
            colorId = Convert.ToInt32(Cnn.ExecuteScalar("select ColorId from Color where colorname='" + ddlColor.SelectedItem.Text + "'"));

            Cnn.ExecuteNonQuery("update temp_ProColorSize set size='" + ddVariant.SelectedItem.Value + "',quantity=" + txtQuantity.Text.Replace("'", "''") + ",colorid=" + colorId + ",urate=" + txtuserprice.Text + ",udiscount=" + txtDiscount.Text + ",arate=" + txtagentprice.Text + ",adiscount=" + txtadiscount.Text + " where id=" + lblTempId.Text + " and random_no=" + Session["Random"] + "");
            DataTable dt = Cnn.FillTable("select a.*,b.ColorName,c.varient from temp_ProColorSize as a join Color as b on a.colorid=b.ColorId join varient as c on a.size=c.id where a.Product_id=" + LblEdtProductId.Text + " and a.random_no='" + Session["Random"] + "'", "lsttemp");
            if (dt.Rows.Count > 0)
            {
                lstTempColorSize.DataSource = dt;
                lstTempColorSize.DataBind();
            }
            Imagetitlebind();
            if (FileUpload1.HasFile)
            {
                int image_id;
                int Count = Convert.ToInt32(Cnn.ExecuteScalar("Select Count(*) From temp_progallery Where Image_Id='" + ImageColor1.AlternateText + "'").ToString());
                if (Count == 0)
                {
                    image_id = Convert.ToInt32(Cnn.ExecuteScalar("Select  IsNull(Max(image_id)+1,1) From [dtl_ProductGallery]"));
                    //int imgCode = Convert.ToInt32(Cnn.ExecuteScalar("select isnull(max(ImageCode),0)+1 from temp_progallery"));
                    filename = LblEdtProductId.Text + "_" + image_id + ".jpg";
                    Cnn.ExecuteNonQuery("insert into temp_progallery(Image_id,product_id,priority,active,ImageCode,ColorId,random_no,size) values(" + image_id + "," + LblEdtProductId.Text + ",0,1,'" + filename + "'," + colorId + "," + Session["Random"] + ",'" + ddVariant.SelectedValue + "')");
                }
                else
                {
                    image_id = int.Parse(ImageColor1.AlternateText);
                    filename = LblEdtProductId.Text + "_" + image_id + ".jpg";
                }
                byte[] image = FileUpload1.FileBytes;
                ImageHandler imageHandler = new ImageHandler();
                Bitmap bmpmain = imageHandler.CreateThumbnail(image, false, 500, 500);
                if (bmpmain != null)
                {
                    bmpmain.Save(Server.MapPath("~/img/product/" + filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                }
                //}
            }
            if (FileUpload2.HasFile)
            {
                int image_id;
                int Count = Convert.ToInt32(Cnn.ExecuteScalar("Select Count(*) From temp_progallery Where Image_Id='" + ImageColor2.AlternateText + "'").ToString());
                if (Count == 0)
                {
                    image_id = Convert.ToInt32(Cnn.ExecuteScalar("Select  IsNull(Max(image_id)+1,1) From [dtl_ProductGallery]"));
                    //int imgCode = Convert.ToInt32(Cnn.ExecuteScalar("select isnull(max(ImageCode),0)+1 from temp_progallery"));
                    filename = LblEdtProductId.Text + "_" + image_id + ".jpg";
                    Cnn.ExecuteNonQuery("insert into temp_progallery(Image_id,product_id,priority,active,ImageCode,ColorId,random_no,size) values(" + image_id + "," + LblEdtProductId.Text + ",0,1,'" + filename + "'," + colorId + "," + Session["Random"] + ",'" + ddVariant.SelectedValue + "')");
                }
                else
                {
                    image_id = int.Parse(ImageColor2.AlternateText);
                    filename = LblEdtProductId.Text + "_" + image_id + ".jpg";
                }
                byte[] image = FileUpload2.FileBytes;
                ImageHandler imageHandler = new ImageHandler();
                Bitmap bmpmain = imageHandler.CreateThumbnail(image, false, 500, 500);
                if (bmpmain != null)
                {
                    bmpmain.Save(Server.MapPath("~/img/product/" + filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                }
                //}
            }
            if (FileUpload3.HasFile)
            {
                int image_id;
                int Count = Convert.ToInt32(Cnn.ExecuteScalar("Select Count(*) From temp_progallery Where Image_Id='" + ImageColor3.AlternateText + "'").ToString());
                if (Count == 0)
                {
                    image_id = Convert.ToInt32(Cnn.ExecuteScalar("Select  IsNull(Max(image_id)+1,1) From [dtl_ProductGallery]"));
                    //int imgCode = Convert.ToInt32(Cnn.ExecuteScalar("select isnull(max(ImageCode),0)+1 from temp_progallery"));
                    filename = LblEdtProductId.Text + "_" + image_id + ".jpg";
                    Cnn.ExecuteNonQuery("insert into temp_progallery(Image_id,product_id,priority,active,ImageCode,ColorId,random_no,size) values(" + image_id + "," + LblEdtProductId.Text + ",0,1,'" + filename + "'," + colorId + "," + Session["Random"] + ",'" + ddVariant.SelectedValue + "')");
                }
                else
                {
                    image_id = int.Parse(ImageColor3.AlternateText);
                    filename = LblEdtProductId.Text + "_" + image_id + ".jpg";
                }
                byte[] image = FileUpload3.FileBytes;
                ImageHandler imageHandler = new ImageHandler();
                Bitmap bmpmain = imageHandler.CreateThumbnail(image, false, 500, 500);
                if (bmpmain != null)
                {
                    bmpmain.Save(Server.MapPath("~/img/product/" + filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                }
            }
            if (FileUpload4.HasFile)
            {
                int image_id;
                int Count = Convert.ToInt32(Cnn.ExecuteScalar("Select Count(*) From temp_progallery Where Image_Id='" + ImageColor4.AlternateText + "'").ToString());
                if (Count == 0)
                {
                    image_id = Convert.ToInt32(Cnn.ExecuteScalar("Select  IsNull(Max(image_id)+1,1) From [dtl_ProductGallery]"));
                    //int imgCode = Convert.ToInt32(Cnn.ExecuteScalar("select isnull(max(ImageCode),0)+1 from temp_progallery"));
                    filename = LblEdtProductId.Text + "_" + image_id + ".jpg";
                    Cnn.ExecuteNonQuery("insert into temp_progallery(Image_id,product_id,priority,active,ImageCode,ColorId,random_no,size) values(" + image_id + "," + LblEdtProductId.Text + ",0,1,'" + filename + "'," + colorId + "," + Session["Random"] + ",'" + ddVariant.SelectedValue + "')");
                }
                else
                {
                    image_id = int.Parse(ImageColor4.AlternateText);
                    filename = LblEdtProductId.Text + "_" + image_id + ".jpg";
                }
                byte[] image = FileUpload4.FileBytes;
                ImageHandler imageHandler = new ImageHandler();
                Bitmap bmpmain = imageHandler.CreateThumbnail(image, false, 500, 500);
                if (bmpmain != null)
                {
                    bmpmain.Save(Server.MapPath("~/img/product/" + filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                }
            }
            if (FileUpload5.HasFile)
            {
                int image_id;
                int Count = Convert.ToInt32(Cnn.ExecuteScalar("Select Count(*) From temp_progallery Where Image_Id='" + ImageColor5.AlternateText + "'").ToString());
                if (Count == 0)
                {
                    image_id = Convert.ToInt32(Cnn.ExecuteScalar("Select  IsNull(Max(image_id)+1,1) From [dtl_ProductGallery]"));
                    //int imgCode = Convert.ToInt32(Cnn.ExecuteScalar("select isnull(max(ImageCode),0)+1 from temp_progallery"));
                    filename = LblEdtProductId.Text + "_" + image_id + ".jpg";
                    Cnn.ExecuteNonQuery("insert into temp_progallery(Image_id,product_id,priority,active,ImageCode,ColorId,random_no,size) values(" + image_id + "," + LblEdtProductId.Text + ",0,1,'" + filename + "'," + colorId + "," + Session["Random"] + ",'" + ddVariant.SelectedValue + "')");
                }
                else
                {
                    image_id = int.Parse(ImageColor5.AlternateText);
                    filename = LblEdtProductId.Text + "_" + image_id + ".jpg";
                }
                byte[] image = FileUpload5.FileBytes;
                ImageHandler imageHandler = new ImageHandler();
                Bitmap bmpmain = imageHandler.CreateThumbnail(image, false, 500, 500);
                if (bmpmain != null)
                {
                    bmpmain.Save(Server.MapPath("~/img/product/" + filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                }
            }
            lblSizeErr.Text = "Updated Successfully..!!";
        }
        ddlColor.ClearSelection();
        ddlColor.Items.FindByText("Blank").Selected = true;
        ddVariant.ClearSelection();
        ddVariant.Items.FindByValue("-1").Selected = true;
        txtQuantity.Text = "";
        txtuserprice.Text = "";
        txtDiscount.Text = "";
        txtagentprice.Text = "";
        txtadiscount.Text = "";
        ImageColor1.ImageUrl = "";
        ImageColor2.ImageUrl = "";
        ImageColor3.ImageUrl = "";
        ImageColor4.ImageUrl = "";
        ImageColor5.ImageUrl = "";
        ImageColor1.AlternateText = "";
        ImageColor2.AlternateText = "";
        ImageColor3.AlternateText = "";
        ImageColor4.AlternateText = "";
        ImageColor5.AlternateText = "";

        ImageColor1.Visible = false;
        ImageColor2.Visible = false;
        ImageColor3.Visible = false;
        ImageColor4.Visible = false;
        ImageColor5.Visible = false;
        lnkAddColor.Text = "Add";
        Cnn.Close();
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        Cnn.Open();
        string sale = "";
        if (CheckBox1.Checked == true)
        {
            sale = "1";
        }
        else
        {
            sale = "0";
        }
        int Totalquantity = 0;
        //string Sql_Gallery = "";
        string path = Server.MapPath("~/img/product/");
        DataTable dt1 = Cnn.FillTable("select distinct colorid from temp_ProColorSize  where product_id=" + LblEdtProductId.Text + " and random_no=" + Session["Random"] + " group by colorid", "lstPrdct");
        if (dt1.Rows.Count > 0)
        {
            // Cnn.ExecuteNonQuery("delete from Store.dtl_ProductColor where Productid=" + LblEdtProductId.Text + "");
            Cnn.ExecuteNonQuery("delete from ProductSizeQuantity where Productid=" + LblEdtProductId.Text + "");
            Cnn.ExecuteNonQuery("delete from dtl_ProductGallery where Product_id=" + LblEdtProductId.Text + "");
            for (int i = 0; i < dt1.Rows.Count; i++)
            {
                int Qty = Convert.ToInt32(Cnn.ExecuteScalar("select distinct SUM(quantity) from temp_ProColorSize where product_id=" + LblEdtProductId.Text + " and ColorId=" + dt1.Rows[i]["colorid"] + ""));
                //s DataRow Dr = Cnn.FillRow("select colorimg,colorname from Color where colorid=" + dt1.Rows[i]["colorid"] + "");
                // DataRow Dr1 = Cnn.FillRow("select top 1 rate,discount from temp_ProColorSize where product_id=" + LblEdtProductId.Text + " and ColorId=" + dt1.Rows[i]["colorid"] + " order by id asc");
                //int CID = Convert.ToInt32(Cnn.ExecuteScalar("select isnull(max(CID),0)+1 from dtl_ProductColor"));
                //Cnn.ExecuteNonQuery("insert into Store.dtl_ProductColor values(" + CID + "," + LblEdtProductId.Text + ",'" + Dr["color_name"].ToString() + "','" + Dr["color_img"].ToString() + "',1," + Qty + "," + Dr1["rate"] + "," + Dr1["discount"] + ")");
                Totalquantity += Qty;
                DataTable DTLG = Cnn.FillTable("select * from temp_progallery where Product_Id='" + LblEdtProductId.Text + "' and ColorId='" + dt1.Rows[i]["colorid"] + "' and random_no='" + Session["Random"] + "' and size='" + dt1.Rows[i]["size"] + "'", "sqlCon");
                if (DTLG.Rows.Count > 0)
                {
                    for (int j = 0; j < DTLG.Rows.Count; j++)
                    {
                        int imgCode = Convert.ToInt32(Cnn.ExecuteScalar("select isnull(max(Image_Id),0)+1 from dtl_ProductGallery"));
                        Cnn.ExecuteNonQuery("insert into dtl_ProductGallery Select " + imgCode + ",Product_Id,Priority,Active,ImageCode,ColorId,size From temp_progallery Where Product_Id=" + LblEdtProductId.Text + " and ColorId='" + DTLG.Rows[j]["colorid"] + "' and AID=" + DTLG.Rows[j]["AID"] + " and random_no='" + Session["Random"] + "' and size='"+ DTLG.Rows[j]["size"] + "'");
                    }
                }
            }

            DataTable dt2 = Cnn.FillTable("select * from temp_ProColorSize where product_id=" + LblEdtProductId.Text + " and random_no=" + Session["Random"] + "", "lstPrdct");
            if (dt2.Rows.Count > 0)
            {
                for (int i = 0; i < dt2.Rows.Count; i++)
                {
                    if (dt2.Rows[i]["size"].ToString() != "0")
                    {
                        Cnn.ExecuteNonQuery("insert into ProductSizeQuantity Select (Select IsNull(MAX(Id+1),1)  From ProductSizeQuantity), Product_id,Size,quantity,rts,colorid,urate,udiscount,arate,adiscount From temp_ProColorSize Where product_Id=" + LblEdtProductId.Text + " and id='" + dt2.Rows[i]["id"] + "'");
                    }
                }
            }
            string FristImg = Cnn.ExecuteScalar("select top 1 ImageCode from dtl_ProductGallery  where  Product_Id='" + LblEdtProductId.Text + "' ").ToString();
            //DataRow Dr2 = Cnn.FillRow("select top 1 rate,discount from Store.dtl_ProductColor where productid=" + LblEdtProductId.Text + " order by CId asc");
            //if (TxtDealDate.Text != "")
            //{
            //    Cnn.ExecuteNonQuery("Update Store.Product Set ProductName='" + TxtProName.Text.Trim().Replace("'", "") + "',Image='" + FristImg + "',BrandName='" + DDBrand.SelectedItem.ToString() + "',Description='" + FCKeditor1.Value.Trim().Replace("'", "") + "',Unit='" + DDselectQuantity1.SelectedItem.ToString() + "',Quantity=" + Totalquantity + ",Rate=" + Dr2["rate"] + ",Weight='" + TxtWeight1.Text.Trim().Replace("'", "") + "',SubCategoryId='" + DDSUbCat.SelectedValue + "',Discount=" + Dr2["discount"] + ",Type='" + DDType1.SelectedItem.ToString() + "',ProductCode='" + PCode + "',Brand_Id=" + BrandId + ",IsCombo='" + combo.Checked + "',IsDealoftheDay='" + ChkDealoftheDay.Checked + "',DealActive='" + ChkDealoftheDay.Checked + "',ComboActive='" + combo.Checked + "',AdminActive=0,DealDate='" + Dealdate + "',AdditionalCharges='" + TxtAdditionalCharges.Text + "',Cashback='" + Txtcahsbak.Text.Replace("'", "''") + "',StartDate='" + statrdate + "',EndDate='" + enddate + "',ProductWeight='" + TxtProductWeight.Text + "',ProductWeightUnit='" + ddCourierUnit.SelectedItem.Text + "',MiniCategoryId=" + DDMiniCategory.SelectedValue + ",DRate=" + Dealrate + ",del=0  Where ProductId='" + LblEdtProductId.Text + "'");
            //}
            //if (TxtDealDate.Text == "")
            //{
            Cnn.ExecuteNonQuery("Update Product Set ProductName='" + txtproductname.Text.Trim().Replace("'", "") + "',image='" + FristImg + "',categoryid=" + DDMainCategory.SelectedValue + ",Brandid=" + DDbrand.SelectedValue + ",Description='" + CKEditor1.Value.Trim().Replace("'", "") + "',metatitle='" + txtmetatitle.Text.Replace("'", "''") + "',qty=" + Totalquantity + ",sale='" + sale + "' Where ProductId='" + LblEdtProductId.Text + "'");
            //}
            Cnn.ExecuteNonQuery("delete from temp_ProColorSize where product_id=" + LblEdtProductId.Text + " and random_no=" + Session["Random"] + "");
            Cnn.ExecuteNonQuery("delete from temp_progallery where product_id=" + LblEdtProductId.Text + " and random_no=" + Session["Random"] + "");
            lstTempColorSize.DataSource = "";
            lstTempColorSize.DataBind();
        }
        else
        {

            Cnn.ExecuteNonQuery("Update Product Set ProductName='" + txtproductname.Text.Trim().Replace("'", "") + "',categoryid=" + DDMainCategory.SelectedValue + ",Brandid=" + DDbrand.SelectedValue + ",Description='" + CKEditor1.Value.Trim().Replace("'", "") + "',metatitle='" + txtmetatitle.Text.Replace("'", "''") + "',qty=" + Totalquantity + ",sale='" + sale + "' Where ProductId='" + LblEdtProductId.Text + "'");

        }
        Cnn.Close();
        Response.Redirect("Editproductlist.aspx");
    }
}