using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class webslider : System.Web.UI.Page
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
        DataTable dt = Cnn.FillTable("select * from [webslider] where active=1", "Detail");
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
                TextBox txtPriority = ((TextBox)myListViewItem.FindControl("txtPriority"));
                TextBox txtlink = ((TextBox)myListViewItem.FindControl("txtlink"));
            //    TextBox txttitle = ((TextBox)myListViewItem.FindControl("txttitle"));
            //    TextBox txtfeature = ((TextBox)myListViewItem.FindControl("txtfeature"));
                FileUpload FileUpload1 = ((FileUpload)myListViewItem.FindControl("FileUpload1"));
                txtlink.Visible = true;
                txtPriority.Visible = true;
                      //     txttitle.Visible = true;
                       //    txtfeature.Visible = true;
                FileUpload1.Visible = true;

            }
            Button1.Text = "Update";
        }
        else
        {
            foreach (ListViewItem myListViewItem in ListView1.Items)
            {
             
                string id = ((HiddenField)myListViewItem.FindControl("HdnID")).Value;
               //     TextBox txttitle = ((TextBox)myListViewItem.FindControl("txttitle"));
                    TextBox txtPriority = ((TextBox)myListViewItem.FindControl("txtPriority"));
                //    TextBox txtfeature = ((TextBox)myListViewItem.FindControl("txtfeature"));
                TextBox txtlink = ((TextBox)myListViewItem.FindControl("txtlink"));
                FileUpload FileUpload1 = ((FileUpload)myListViewItem.FindControl("FileUpload1"));
              // /   txttitle.Visible = true;
              // /   txtfeature.Visible = true;
                txtlink.Visible = true;
                FileUpload1.Visible = true;
                Cnn.Open();
                if (FileUpload1.HasFile)
                {

                    byte[] image = FileUpload1.FileBytes;
                    ImageHandler imageHandler = new ImageHandler();
                    filename = id + ".jpg";
                    Bitmap bmpmain = imageHandler.CreateThumbnail(image, false, 670, 535);
                    if (bmpmain != null)
                    {
                        bmpmain.Save(Server.MapPath("~/img/webSlider/" + filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                    }
                    Cnn.ExecuteNonQuery("update webslider set image='"+filename+"',link='" + txtlink.Text + "',title='',feature='',priority='" + txtPriority.Text + "' where id='" + id + "'");
                }
                else
                { Cnn.ExecuteNonQuery("update webslider set link='" + txtlink.Text + "',title='',feature='',priority='" + txtPriority.Text + "' where id='" + id + "'"); }

                Cnn.Close();
                txtlink.Visible = false;
                FileUpload1.Visible = false;
                //  txttitle.Visible = false;
             txtPriority.Visible = false;
            }
            Button1.Text = "Edit";
             list();

        }
    }
}