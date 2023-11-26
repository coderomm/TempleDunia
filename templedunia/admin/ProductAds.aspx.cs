using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ProductAds : System.Web.UI.Page
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
        DataTable dt = Cnn.FillTable("select top 2* from [ads] where active=1 and id in(4,5)", "Detail");
        ListView1.DataSource = dt;
        ListView1.DataBind();
    }
   
   
    protected void ShowMessage(string Message, MessageType type)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('" + Message + "','" + type + "');", true);
    }
  


    protected void Button1_Click1(object sender, EventArgs e)
    {

        if (Button1.Text == "Edit")
        {
            foreach (ListViewItem myListViewItem in ListView1.Items)
            {
                string id = ((HiddenField)myListViewItem.FindControl("HdnID")).Value;

                TextBox txtlink = ((TextBox)myListViewItem.FindControl("txtlink"));
                FileUpload FileUpload1 = ((FileUpload)myListViewItem.FindControl("FileUpload1"));
                txtlink.Visible = true;
                FileUpload1.Visible = true;
            }
            Button1.Text = "Update";
        }
        else
        {
            foreach (ListViewItem myListViewItem in ListView1.Items)
            {
             
                string id = ((HiddenField)myListViewItem.FindControl("HdnID")).Value;

                TextBox txtlink = ((TextBox)myListViewItem.FindControl("txtlink"));
                FileUpload FileUpload1 = ((FileUpload)myListViewItem.FindControl("FileUpload1"));

                txtlink.Visible = true;
                FileUpload1.Visible = true;
                Cnn.Open();
                if (FileUpload1.HasFile)
                {

                    byte[] image = FileUpload1.FileBytes;
                    ImageHandler imageHandler = new ImageHandler();
                    filename = id + ".jpg";
                    Bitmap bmpmain = imageHandler.CreateThumbnail(image, false, 470, 250);
                    if (bmpmain != null)
                    {
                        bmpmain.Save(Server.MapPath("~/img/Middleads/" + filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                    }
                    Cnn.ExecuteNonQuery("update ads set link='" + txtlink.Text + "' where id='" + id + "'");
                }
                else
                { Cnn.ExecuteNonQuery("update ads set link='" + txtlink.Text + "' where id='" + id + "'"); }

                Cnn.Close();
                txtlink.Visible = false;
                FileUpload1.Visible = false;
            }
            Button1.Text = "Edit";
             list();

        }
    }
}