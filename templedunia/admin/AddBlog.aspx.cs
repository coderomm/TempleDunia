using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddBlog : System.Web.UI.Page
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

        list();
    }

    public void list()
    {
        Cnn.Open();
        DataTable dt = Cnn.FillTable("select * from blog_detail where active=1", "Detail");
        ListView1.DataSource = dt;
        ListView1.DataBind();
        Cnn.Close();
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

                filename = LblId.Value + ".jpg";
                Bitmap bmpmain = imageHandler.CreateThumbnail(image, false, 800, 478);
                if (bmpmain != null)
                {

                    bmpmain.Save(Server.MapPath("~/img/blog/" + filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                }

                Cnn.ExecuteNonQuery("update blog_detail set title='" + Txttitle.Text.Replace("'", "''") + "',image='" + filename + "',description='" + CKEditor1.Value.Replace("'", "''") + "' where id='" + LblId.Value + "' ");
                
            }
            else
            {

                Cnn.ExecuteNonQuery("update blog_detail set title='" + Txttitle.Text.Replace("'", "''") + "',description='" + CKEditor1.Value.Replace("'", "''") + "' where id='" + LblId.Value + "' ");
            }
            
            clear();
            list();
            ShowMessage("Record updated successfully", MessageType.Success);
            Button1.Text = "Submit";
            Cnn.Open();
        }
        else
        {



            //////////insert
            Cnn.Open();
            int ID = Convert.ToInt32(Cnn.ExecuteScalar("Select  IsNull(Max(id)+1,1) From [blog_detail]"));

            if (FileUpload1.HasFile)
            {

                byte[] image = FileUpload1.FileBytes;
                ImageHandler imageHandler = new ImageHandler();
                filename = ID + ".jpg";
                Bitmap bmpmain = imageHandler.CreateThumbnail(image, false, 800, 478);
                if (bmpmain != null)
                {
                    bmpmain.Save(Server.MapPath("~/img/blog/" + filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                }


                Cnn.ExecuteNonQuery("INSERT INTO blog_detail (id,active,title,image,description,entrydate) values ('" + ID + "',1,'" + Txttitle.Text.Trim().Replace("'", "''") + "','" + filename + "','" + CKEditor1.Value + "',getdate())");



            }

            else
            {

                ShowMessage("Select Image !!!", MessageType.Info);
                return;

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
        Txttitle.Text = "";
        Image1.Visible = false;
        CKEditor1.Value = "";

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

                        Cnn.ExecuteNonQuery("update M_CategoryMaster set Active=0 where Id='" + LblId.Value + "'");
                    }

                }
            }


        }

        Cnn.Close();

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

            string img = ((Label)e.Item.FindControl("lblImage")).Text;
            string desc = ((Label)e.Item.FindControl("lblDesc")).Text;
            Image1.ImageUrl = "~/img/blog/" + img;
            Image1.Visible = true;


            Txttitle.Text = ((Label)e.Item.FindControl("lbltitle")).Text;
            CKEditor1.Value = desc;
            Button1.Text = "Update";


            Cnn.Open();
        }
    }


}