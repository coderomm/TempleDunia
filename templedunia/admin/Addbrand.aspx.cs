using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Addbrand : System.Web.UI.Page
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
        DataTable dt = Cnn.FillTable("select * from [brand] where active=1", "Detail");
        ListView1.DataSource = dt;
        ListView1.DataBind();
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
                Bitmap bmpmain = imageHandler.CreateThumbnail(image, false, 120, 70);
                if (bmpmain != null)
                {

                    bmpmain.Save(Server.MapPath("~/img/brand/" + filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                }


                Cnn.ExecuteNonQuery("update [brand] set brandname='" + Txttitle.Text.Replace("'", "''") + "',image='"+filename+"' where brandid='" + LblId.Value + "' ");


            }
            else
            {

                Cnn.ExecuteNonQuery("update [brand] set brandname='" + Txttitle.Text.Replace("'", "''") + "' where brandid='" + LblId.Value + "' ");
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
            int ID = Convert.ToInt32(Cnn.ExecuteScalar("Select  IsNull(Max(brandid)+1,1) From [brand]"));

            if (FileUpload1.HasFile)
            {

                byte[] image = FileUpload1.FileBytes;
                ImageHandler imageHandler = new ImageHandler();
                filename = ID + ".jpg";
                Bitmap bmpmain = imageHandler.CreateThumbnail(image, false, 120, 70);
                if (bmpmain != null)
                {
                    bmpmain.Save(Server.MapPath("~/img/brand/" + filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                }


                Cnn.ExecuteNonQuery("INSERT INTO [brand] (brandid,brandname,image,active) values ('" + ID + "','" + Txttitle.Text.Trim().Replace("'", "''") + "','" + filename + "',1)");

                

            }

            else {

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

                        Cnn.ExecuteNonQuery("update brand set Active=0 where Id='" + LblId.Value + "'");
                    }

                }
            }


        }

        Cnn.Close();

        if (e.CommandName == "delte")
        {
            LblId.Value = ((HiddenField)e.Item.FindControl("HdnID")).Value;

            
         
         
          
            Cnn.Open();
            string img = ((Label)e.Item.FindControl("lblImage")).Text;
          

            File.Delete(Server.MapPath("~/img/brand/" + img + ""));

            Cnn.ExecuteNonQuery("delete from [brand] where brandid='" + LblId.Value + "'");
            
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
            Image1.ImageUrl = "~/img/brand/" + img;
            Image1.Visible = true;

          
            Txttitle.Text = ((Label)e.Item.FindControl("lbltitle")).Text;
            Button1.Text = "Update";


            Cnn.Open();
        }
    }


}