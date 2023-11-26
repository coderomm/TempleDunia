using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class adddoctors : System.Web.UI.Page
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
        DataTable dt = Cnn.FillTable("select * from [doctorlist] order by MainCategoryid asc", "Detail");
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
                Bitmap bmpmain = imageHandler.CreateThumbnail(image, false, 230, 290);
                if (bmpmain != null)
                {

                    bmpmain.Save(Server.MapPath("~/img/doctorlist/" + filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                }


                Cnn.ExecuteNonQuery("update [doctorlist] set active=1,MainCategoryName='" + Txttitle.Text.Replace("'", "''") + "',post='" + txtpost.Text.Replace("'", "''") + "',info='" + txtinfo.Text.Replace("'", "''") + "',image='" + filename + "' where MainCategoryid='" + LblId.Value + "' ");


            }
            else
            {

                Cnn.ExecuteNonQuery("update [doctorlist] set active=1,MainCategoryName='" + Txttitle.Text.Replace("'", "''") + "',post='" + txtpost.Text.Replace("'", "''") + "',info='" + txtinfo.Text.Replace("'", "''") + "' where MainCategoryid='" + LblId.Value + "' ");
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
            int ID = Convert.ToInt32(Cnn.ExecuteScalar("Select  IsNull(Max(MainCategoryid)+1,1) From [doctorlist]"));

            if (FileUpload1.HasFile)
            {

                byte[] image = FileUpload1.FileBytes;
                ImageHandler imageHandler = new ImageHandler();
                filename = ID + ".jpg";
                Bitmap bmpmain = imageHandler.CreateThumbnail(image, false, 230, 290);
                if (bmpmain != null)
                {
                    bmpmain.Save(Server.MapPath("~/img/doctorlist/" + filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                }


                Cnn.ExecuteNonQuery("INSERT INTO [doctorlist] (MainCategoryid,MainCategoryName,image,active,post,info) values ('" + ID + "','" + Txttitle.Text.Trim().Replace("'", "''") + "','" + filename + "',1,'"+txtpost.Text+"','"+txtinfo.Text+"')");

                

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
        txtinfo.Text = "";
        txtpost.Text = "";
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

                        Cnn.ExecuteNonQuery("update doctorlist set Active=0 where Id='" + LblId.Value + "'");
                    }

                }
            }


        }

        Cnn.Close();

        if (e.CommandName == "delte")
        {
            LblId.Value = ((HiddenField)e.Item.FindControl("HdnID")).Value;

            string img = ((Label)e.Item.FindControl("lblImage")).Text;
         
         
          
            Cnn.Open();

            File.Delete(Server.MapPath("~/img/doctorlist/" + img + ""));

            Cnn.ExecuteNonQuery("delete from [doctorlist] where MainCategoryid='" + LblId.Value + "'");
            
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
            Image1.ImageUrl = "~/img/doctorlist/" + img;
            Image1.Visible = true;

          
            Txttitle.Text = ((Label)e.Item.FindControl("lbltitle")).Text;

            txtpost.Text = ((Label)e.Item.FindControl("lblpost")).Text;
            txtinfo.Text = ((Label)e.Item.FindControl("lblinfo")).Text;
            Button1.Text = "Update";


            Cnn.Open();
        }

        if (e.CommandName == "deactive")
        {
            LblId.Value = ((HiddenField)e.Item.FindControl("HdnID")).Value;
            Cnn.Open();
            Cnn.ExecuteNonQuery("update [doctorlist] set  active=0 where MainCategoryid=" + LblId.Value + "");
            Cnn.Close();

            list();
        }
        if (e.CommandName == "active")
        {
            LblId.Value = ((HiddenField)e.Item.FindControl("HdnID")).Value;
            Cnn.Open();
            Cnn.ExecuteNonQuery("update [doctorlist] set active=1 where MainCategoryid=" + LblId.Value + "");
            Cnn.Close();

            list();
        }
    }


}