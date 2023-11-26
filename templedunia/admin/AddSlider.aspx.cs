using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddSlider : System.Web.UI.Page
{

    ClsConnection Cnn = new ClsConnection();
    public enum MessageType { Success, Error, Info, Warning };
    string filename;
    int itemcount;
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
        DataTable dt = Cnn.FillTable("select * from [Slider] where ActiveStatus=1 order by priority desc", "Detail");
        ListView1.DataSource = dt;
        ListView1.DataBind();
        Cnn.Open();
        itemcount = Convert.ToInt32(Cnn.ExecuteScalar("Select Count(*) From Slider"));
        Cnn.Open();
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

                filename = "Slider" + LblId.Value + ".jpg";
                Bitmap bmpmain = imageHandler.CreateThumbnail(image, false, 1920, 700);
                if (bmpmain != null)
                {

                    bmpmain.Save(Server.MapPath("~/img/slider/" + filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                }

                Cnn.Open();
                Cnn.ExecuteNonQuery("update [Slider] set active='" + Txttitle.Text.Replace("'", "''") + "',image='" + filename + "',priority='" + Txtpriority.Text.Trim().Replace("'", "''") + "' where id='" + LblId.Value + "' ");
                Cnn.Close();



            }

            else
            {
                Cnn.Open();
                Cnn.ExecuteNonQuery("update [Slider] set active='" + Txttitle.Text.Replace("'", "''") + "',priority='" + Txtpriority.Text.Trim().Replace("'", "''") + "' where id='" + LblId.Value + "'");
                Cnn.Close();
            }
            clear();
            list();
            ShowMessage("Record updated successfully", MessageType.Success);
            Button1.Text = "Submit";
          
        }
        else
        {

            if (itemcount >= 6)
            {
                ShowMessage("Record Not submitted above 6 image Sliders  ", MessageType.Error);
                clear();
                return;
            }

            //////////insert
            Cnn.Open();
            int ID = Convert.ToInt32(Cnn.ExecuteScalar("Select  IsNull(Max(ID)+1,1) From [Slider]"));
           

            if (FileUpload1.HasFile)
            {

                byte[] image = FileUpload1.FileBytes;
                ImageHandler imageHandler = new ImageHandler();

                filename = "Slider" + ID + ".jpg";
                Bitmap bmpmain = imageHandler.CreateThumbnail(image, false, 1920, 700);
                if (bmpmain != null)
                {

                    bmpmain.Save(Server.MapPath("~/img/slider/" + filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                }


                Cnn.ExecuteNonQuery("INSERT INTO [Slider] (Id,active,image,priority) values ('" + ID + "','" + Txttitle.Text.Trim().Replace("'", "''") + "','" + filename + "','" + Txtpriority.Text.Trim().Replace("'", "''") + "')");

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
        Txtpriority.Text = "";
        Txttitle.Text = "";

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

                        Cnn.ExecuteNonQuery("update Slider set Active=0 where Id='" + LblId.Value + "'");
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

                Cnn.ExecuteNonQuery("delete from [Slider] where id='" + LblId.Value + "'");
            }
            else
            {
                File.Delete(Server.MapPath("~/img/slider/" + img));
                Cnn.ExecuteNonQuery("delete from [Slider] where id='" + LblId.Value + "'");
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
            Txtpriority.Text = ((Label)e.Item.FindControl("lblpriority")).Text;
            string img = ((Label)e.Item.FindControl("Lblimg")).Text;


            Txttitle.Text = ((Label)e.Item.FindControl("lbltitle")).Text;
            Button1.Text = "Update";


            Cnn.Open();
        }
    }


}