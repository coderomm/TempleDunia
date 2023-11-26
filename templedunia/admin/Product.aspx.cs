using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Product : System.Web.UI.Page
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
           lis1t();
        }
    }

   
    public void lis1t()
    {
        DataTable Dtt = Cnn.FillTable("Select 'StateCode'=-1,'StateName'='Select State' union  select StateCode,StateName from State where StateName!='Other' and StateName!='all world'", "Detail");
        DDMainCategory.DataSource = Dtt;
        DDMainCategory.DataBind();

          }

  
   
    public void clear()
    {



    }
    protected void ShowMessage(string Message, MessageType type)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('" + Message + "','" + type + "');", true);
    }



    protected void Button2_Click(object sender, EventArgs e)
    {
        Cnn.Open();
        int productid = Convert.ToInt32(Cnn.ExecuteScalar("Select  IsNull(Max(productid)+1,1) From [product]"));
        string fristimg = "",img2="",img3="",img4="",img5="",img6="";
        if (FileUpload1.HasFile)
        {
            fristimg = productid + "_1_.jpg";
            VaryQualityLevel(FileUpload1.PostedFile.InputStream, fristimg);          
        }
        else
        {
            LblErr.Text = "Please Select Image..."; return;
        }

        if (FileUpload2.HasFile)
        {
            img2 = productid + "_2_.jpg";
            VaryQualityLevel(FileUpload2.PostedFile.InputStream, img2);            
        }
        if (FileUpload3.HasFile)
        {
            img3 = productid + "_3_.jpg";
            VaryQualityLevel(FileUpload3.PostedFile.InputStream, img3);
         
        }
        if (FileUpload4.HasFile)
        {
            img4 = productid + "_4_.jpg";
            VaryQualityLevel(FileUpload4.PostedFile.InputStream, img4);
         
        }
      



        //Cnn.ExecuteNonQuery("insert into  product (categoryid,productid,productname,qty,image,Brandid,Description,sale,active,visit,rts,metatitle,unit,Weight,price,discount,img2,img3,img4,img5,img6,plink) values ('" + DDMainCategory.SelectedValue + "','" + productid + "','" + txtproductname.Text.Trim().Replace("'", "''") + "','" + txtQuantity.Text + "','" + fristimg + "','De9','" + CKEditor1.Value.Trim().Replace("'", "''") + "'," + sale + ",1,1,getdate(),'" + txtproductname.Text.Trim().Replace("'", "''") + "','" + txtcourierunit.SelectedItem + "','" + txtWeight.Text + "','" + txtuserprice.Text + "','" + txtDiscount.Text + "','"+img2+"','"+img3+"','"+img4+"','"+img5+"','"+img6+"','"+txtplink.Text+"')");
        Cnn.Close();
        ShowMessage("Record Add successfully", MessageType.Success);
        txtproductname.Text = "";
       
        CKEditor1.Value = "";
       
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
        EncoderParameter myEncoderParameter = new EncoderParameter(myEncoder,30L);
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
    protected void DDMainCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataTable Dtt = Cnn.FillTable("Select 'DistCode'=-1,'DistName'='Select District' union  select DistCode,DistName from District where StateCode="+DDMainCategory.SelectedValue+"", "Detail");
        ddDistrict.DataSource = Dtt;
        ddDistrict.DataBind();
    }
    protected void ddDistrict_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataTable Dtt = Cnn.FillTable("Select 'TehsileCode'=-1,'TehsileName'='Select Tehsile' union  select TehsileCode,TehsileName from Tehsile where DistCode="+ddDistrict.SelectedValue+"", "Detail");
        ddTehsile.DataSource = Dtt;
        ddTehsile.DataBind();
    }
}