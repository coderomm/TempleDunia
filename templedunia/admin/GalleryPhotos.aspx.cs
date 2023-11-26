using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GalleryPhotos : System.Web.UI.Page
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
        DataTable dt = Cnn.FillTable("select * from [Gallery] where ActiveStatus=1", "Detail");
        ListView1.DataSource = dt;
        ListView1.DataBind();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        ////update
        if (Button1.Text == "Update")
        {

            if (FileUpload1.HasFile)
            {

                byte[] image = FileUpload1.FileBytes;
                ImageHandler imageHandler = new ImageHandler();

                filename = "Textile" + LblId.Value + ".jpg";
                Bitmap bmpmain = imageHandler.CreateThumbnail(image, false, 811, 447);
                if (bmpmain != null)
                {

                    bmpmain.Save(Server.MapPath("~/img/gallery/" + filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                }

                Cnn.Open();
                Cnn.ExecuteNonQuery("update [Gallery] set image='" + filename + "' where id='" + LblId.Value + "' ");
                Cnn.Close();



            }

           
            clear();
            list();
            ShowMessage("Record updated successfully", MessageType.Success);
            Button1.Text = "Submit";
          
        }
        else
        {



            //////////insert
            Cnn.Open();
            int ID = Convert.ToInt32(Cnn.ExecuteScalar("Select  IsNull(Max(ID)+1,1) From [Gallery]"));
           

            if (FileUpload1.HasFile)
            {

                byte[] image = FileUpload1.FileBytes;
                ImageHandler imageHandler = new ImageHandler();

                filename = "Textile" + ID + ".jpg";
                Bitmap bmpmain = imageHandler.CreateThumbnail(image, false, 811, 447);
                if (bmpmain != null)
                {

                    bmpmain.Save(Server.MapPath("~/img/gallery/" + filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                }


                Cnn.ExecuteNonQuery("INSERT INTO [Gallery] (Id,image,ActiveStatus) values ('" + ID + "','" + filename + "',1)");

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
        Image1.Visible = false;

    }
    protected void ShowMessage(string Message, MessageType type)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('" + Message + "','" + type + "');", true);
    }
    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        Cnn.Open();
        if (e.CommandName == "dea")
        {
            if (ListView1.Items.Count > 0)
            {
                for (int i = 0; i < ListView1.Items.Count; i++)
                {
                    if (((CheckBox)ListView1.Items[i].FindControl("ChkBox")).Checked == true)
                    {
                        LblId.Value = ((HiddenField)e.Item.FindControl("HdnID")).Value;

                        Cnn.ExecuteNonQuery("update Gallery set ActiveStatus=0 where Id='" + LblId.Value + "'");
                    }

                }
            }


        }

        Cnn.Close();

        if (e.CommandName == "del")
        {
            LblId.Value = ((HiddenField)e.Item.FindControl("HdnID")).Value;

            
           
            string img = ((Label)e.Item.FindControl("Lblimg")).Text;


         
            Cnn.Open();

            if (img == "")
            {

                Cnn.ExecuteNonQuery("delete from [Gallery] where id='" + LblId.Value + "'");
            }
            else
            {
                File.Delete(Server.MapPath("~/img/gallery/" + img));
                Cnn.ExecuteNonQuery("delete from [Gallery] where id='" + LblId.Value + "'");
            }
            list();
            ShowMessage("Record Delete successfully", MessageType.Success);

            Cnn.Close();



            //   string id = ((HiddenField)LstDay.Items[j].FindControl("HdnID")).Value;
            //  Cnn.ExecuteNonQuery("update Poster set  Active=0 where Id='" + LblId.Value + "'");
        }

        if (e.CommandName == "Edt")
        {
            LblId.Value = ((HiddenField)e.Item.FindControl("HdnID")).Value;
      
            string img = ((Label)e.Item.FindControl("Lblimg")).Text;



            Image1.ImageUrl = "~/img/gallery/" + img;
            Image1.Visible = true;
            Button1.Text = "Update";


            Cnn.Open();
        }
    }


}