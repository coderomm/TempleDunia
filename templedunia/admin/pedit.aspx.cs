using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class pedit : System.Web.UI.Page
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

                txtunit.Text = dr["unit"].ToString();
                txtWeight.Text = dr["weight"].ToString();

                txtDiscount.Text = dr["discount"].ToString();
                txtQuantity.Text = dr["qty"].ToString();
                txtuserprice.Text = dr["price"].ToString();
                txtplink.Text = dr["plink"].ToString();
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

                string fristimg = dr["image"].ToString(), img2 = dr["img2"].ToString(), img3 = dr["img3"].ToString(), img4 = dr["img4"].ToString(), img5 = dr["img5"].ToString(), img6 = dr["img6"].ToString();


                if (fristimg != "")
                {
                    ImageColor1.Visible = true;
                    ImageColor1.AlternateText = fristimg;
                    ImageColor1.ImageUrl = "~/img/product/" + fristimg + "";
                }
                if (img2 != "")
                {
                    ImageColor2.Visible = true;
                    ImageColor2.AlternateText = img2;
                    ImageColor2.ImageUrl = "~/img/product/" + img2 + "";
                }
                if (img3 != "")
                {
                    ImageColor3.Visible = true;
                    ImageColor3.AlternateText = img3;
                    ImageColor3.ImageUrl = "~/img/product/" + img3 + "";
                }
                if (img4 != "")
                {
                    ImageColor4.Visible = true;
                    ImageColor4.AlternateText = img4;
                    ImageColor4.ImageUrl = "~/img/product/" + img4 + "";
                }

                if (img5 != "")
                {
                    ImageColor5.Visible = true;
                    ImageColor5.AlternateText = img5;
                    ImageColor5.ImageUrl = "~/img/product/" + img5 + "";
                }

                if (img6 != "")
                {
                    ImageColor6.Visible = true;
                    ImageColor6.AlternateText = img6;
                    ImageColor6.ImageUrl = "~/img/product/" + img6 + "";
                }

                Cnn.Close();

            }
        }
    }



    public void list()
    {
        DataTable Dtt = Cnn.FillTable("Select 'MainCategoryId'=-1,'MainCategoryName'='Select Main Category' union  select MainCategoryId,MainCategoryName from M_CategoryMaster ", "Detail");
        DDMainCategory.DataSource = Dtt;
        DDMainCategory.DataBind();


    }





    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        Cnn.Open();
        string fristimg = "", img2 = "", img3 = "", img4 = "", img5 = "", img6 = "";
        int productid = Convert.ToInt32(Request.QueryString["id"]);
        if (FileUpload1.HasFile)
        {
            filename = productid + "_1_.jpg";
            VaryQualityLevel(FileUpload1.PostedFile.InputStream, filename);
            Cnn.ExecuteNonQuery("update Product set image='" + filename + "' Where ProductId='" + LblEdtProductId.Text + "'");
        }
        if (FileUpload2.HasFile)
        {
            img2 = productid + "_2_.jpg";
            VaryQualityLevel(FileUpload2.PostedFile.InputStream, img2);
            Cnn.ExecuteNonQuery("update Product set img2='" + img2 + "' Where ProductId='" + LblEdtProductId.Text + "'");
        }
        if (FileUpload3.HasFile)
        {
            img3 = productid + "_3_.jpg";
            VaryQualityLevel(FileUpload3.PostedFile.InputStream, img3);
            Cnn.ExecuteNonQuery("update Product set img3='" + img3 + "' Where ProductId='" + LblEdtProductId.Text + "'");
        }
        if (FileUpload4.HasFile)
        {
            img4 = productid + "_4_.jpg";
            VaryQualityLevel(FileUpload4.PostedFile.InputStream, img4);
            Cnn.ExecuteNonQuery("update Product set img4='" + img4 + "' Where ProductId='" + LblEdtProductId.Text + "'");
        }
        if (FileUpload5.HasFile)
        {
            img5 = productid + "_5_.jpg";
            VaryQualityLevel(FileUpload5.PostedFile.InputStream, img5);
            Cnn.ExecuteNonQuery("update Product set img5='" + img5 + "' Where ProductId='" + LblEdtProductId.Text + "'");
        }
        if (FileUpload6.HasFile)
        {
            img6 = productid + "_6_.jpg";
            VaryQualityLevel(FileUpload6.PostedFile.InputStream, img6);
            Cnn.ExecuteNonQuery("update Product set img6='" + img6 + "' Where ProductId='" + LblEdtProductId.Text + "'");
        }
       
        

        string sale = "";
        if (CheckBox1.Checked == true)
        {
            sale = "1";
        }
        else
        {
            sale = "0";
        }

        Cnn.ExecuteNonQuery("Update Product Set plink='" + txtplink.Text.Trim().Replace("'", "") + "',ProductName='" + txtproductname.Text.Trim().Replace("'", "") + "',categoryid=" + DDMainCategory.SelectedValue + ",Description='" + CKEditor1.Value.Trim().Replace("'", "") + "',metatitle='" + txtproductname.Text.Replace("'", "''") + "',qty=" + txtQuantity.Text + ",sale='" + sale + "',price='" + txtuserprice.Text + "',discount='" + txtDiscount.Text + "' Where ProductId='" + LblEdtProductId.Text + "'");
        Cnn.Close();
        Response.Redirect("pedit.aspx?id=" + Request.QueryString["id"] + "");
    }

    private void VaryQualityLevel(Stream stream, string fname)
    {



        //  size 
        System.Drawing.Image photo = new Bitmap(stream);
        //Bitmap bmp1 = new Bitmap(photo, 119, 83);

        Bitmap bmp1 = new Bitmap(photo, 3000, 3000);
        // without size
        //  Bitmap bmp1 = new Bitmap(stream);
        ImageCodecInfo jgpEncoder = GetEncoder(ImageFormat.Jpeg);
        System.Drawing.Imaging.Encoder myEncoder = System.Drawing.Imaging.Encoder.Quality;
        EncoderParameters myEncoderParameters = new EncoderParameters(1);
        EncoderParameter myEncoderParameter = new EncoderParameter(myEncoder, 30L);
        myEncoderParameters.Param[0] = myEncoderParameter;
        bmp1.Save(Server.MapPath("~/img/product/" + fname), jgpEncoder, myEncoderParameters);
        bmp1.Dispose();

    }
    private ImageCodecInfo GetEncoder(ImageFormat format)
    {
        ImageCodecInfo[] codecs = ImageCodecInfo.GetImageDecoders();

        foreach (ImageCodecInfo codec in codecs)
        {
            if (codec.FormatID == format.Guid)
            {
                return codec;
            }
        }
        return null;

    }

}