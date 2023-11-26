using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AppSlider : System.Web.UI.Page
{

    ClsConnection Cnn = new ClsConnection();
    public enum MessageType { Success, Error, Info, Warning };
    string filename;
    int count = 0;
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
        DataTable dt = Cnn.FillTable("select * from [appslider] where active=1 order by id asc", "Detail");
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
                string type = ((HiddenField)myListViewItem.FindControl("hdntype")).Value;
                string link = ((HiddenField)myListViewItem.FindControl("hdnlink")).Value;
                
                string id = ((HiddenField)myListViewItem.FindControl("HdnID")).Value;
                TextBox txtPriority = ((TextBox)myListViewItem.FindControl("txtPriority"));
             //   TextBox txtlink = ((TextBox)myListViewItem.FindControl("txtlink"));
                FileUpload FileUpload1 = ((FileUpload)myListViewItem.FindControl("FileUpload1"));
                DropDownList ddtype = ((DropDownList)myListViewItem.FindControl("ddtype"));
              

                DropDownList ddlink = ((DropDownList)myListViewItem.FindControl("DDlink"));
                string query = "";
                if (type == "Product")
                {
                    query = "select productid,productname  from product order by productid desc";
                }
                else if (type == "Category")
                {
                    query = "select MainCategoryid as productid,MainCategoryName as productname  from M_CategoryMaster order by MainCategoryid desc";
                }

                else if (type == "Brand")
                {
                    query = "select brandid as productid,brandName as productname  from brand order by brandid desc";
                }


                ddlink.Items.Clear();
               
                DataTable dt = Cnn.FillTable(query, "Detail");
                ddlink.DataSource = dt;
                ddlink.DataBind(); ddlink.Visible = true;
               

                if (type == "Product")
                {
                    ddlink.Items.FindByText(link).Selected = true;
                }
                else if (type == "Category")
                {
                    ddlink.Items.FindByValue(link).Selected = true;
                }

                else if (type == "Brand")
                {
                    ddlink.Items.FindByValue(link).Selected = true;
                }

                //ddtype.DataBind();
                ddtype.ClearSelection();
                ddtype.DataBind();
                ddtype.Items.FindByText(type).Selected = true;
             
             //   txtlink.Visible = true;
                FileUpload1.Visible = true;
                txtPriority.Visible = true;
                ddtype.Visible = true;
               
            }
            Button1.Text = "Update";
        }
        else
        {
            foreach (ListViewItem myListViewItem in ListView1.Items)
            {
             
                string id = ((HiddenField)myListViewItem.FindControl("HdnID")).Value;

             //   TextBox txtlink = ((TextBox)myListViewItem.FindControl("txtlink"));
                TextBox txtPriority = ((TextBox)myListViewItem.FindControl("txtPriority"));
                FileUpload FileUpload1 = ((FileUpload)myListViewItem.FindControl("FileUpload1"));
                DropDownList ddtype = ((DropDownList)myListViewItem.FindControl("ddtype"));
                DropDownList ddlink = ((DropDownList)myListViewItem.FindControl("DDlink"));
                string type = ((HiddenField)myListViewItem.FindControl("hdntype")).Value;
            //    txtlink.Visible = true;
                txtPriority.Visible = true; ddtype.Visible = true;
                FileUpload1.Visible = true; ddlink.Visible = true;
                Cnn.Open();
                string query = "",productid="",categoryid="",linkm="";
                if (ddlink.SelectedValue.ToString() != "-1")
                {
                    if (type == "Product")
                    {
                        query = "link='" + ddlink.SelectedItem + "',";
                        productid = ddlink.SelectedValue.ToString();
                        categoryid = Cnn.ExecuteScalar("select categoryid from product where productid='" + ddlink.SelectedValue + "'").ToString();
                        string tt = productid + "," + categoryid;
                        linkm = ",lnikn='" + tt + "'";

                    }

                    else if (type == "Category")
                    {
                        query = "link='" + ddlink.SelectedValue + "',";
                    }

                    else if (type == "Brand")
                    {
                        query = "link='" + ddlink.SelectedValue + "',";
                    }
                }

                if (FileUpload1.HasFile)
                {

                    byte[] image = FileUpload1.FileBytes;
                    ImageHandler imageHandler = new ImageHandler();
                    filename = id + ".jpg";
                    Bitmap bmpmain = imageHandler.CreateThumbnail(image, false, 877, 600);
                    if (bmpmain != null)
                    {
                        bmpmain.Save(Server.MapPath("~/img/appslider/" + filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                    }
                    Cnn.ExecuteNonQuery("update appslider set " + query + "priority='" + txtPriority.Text + "',type='" + ddtype.SelectedItem + "' " + linkm + " where id='" + id + "'");
                }
                else
                { Cnn.ExecuteNonQuery("update appslider set " + query + " priority='" + txtPriority.Text + "',type='" + ddtype.SelectedItem + "' " + linkm + " where id='" + id + "'"); }

                Cnn.Close();
              //  txtlink.Visible = false;
                FileUpload1.Visible = false;
                txtPriority.Visible = false;
                ddtype.Visible = false;
            }
            Button1.Text = "Edit";
             list();
             ShowMessage("Record updated successfully", MessageType.Success);

        }
    }

    protected void ddtype_SelectedIndexChanged(object sender, EventArgs e)
    {
             Cnn.Open();
       

                string query = "",type="";
             type=ddtype.SelectedItem.ToString();
                if (type == "Product")
                {
                    query = "Select 'productid'=-1,'productname'='Select product Name' union  select productid,productname from product";
                }
                else if (type == "Category")
                {
                    query = "select 'productid'=-1,'productname'='Select MainCategory Name' union select MainCategoryid as productid,MainCategoryName as productname  from M_CategoryMaster";
                }

                else if (type == "Brand")
                {
                    query = "select  'productid'=-1,'productname'='Select brand Name' union select  brandid as productid,brandName as productname  from brand";
                }


              
                DataTable dt = Cnn.FillTable(query, "Detail");
                DDlink.DataSource = dt;
                DDlink.DataBind(); DDlink.Visible = true;

               
                FileUpload1.Visible = true;
                txtPriority.Visible = true;
                ddtype.Visible = true;
            
        

        Cnn.Close();
    }
    //protected void ddtype_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    Cnn.Open();
    //    foreach (ListViewItem myListViewItem in ListView1.Items)
    //    {
    //        TextBox txtPriority = ((TextBox)myListViewItem.FindControl("txtPriority"));

    //        if (txtPriority.Visible == true)
    //        {

    //            string link = ((DropDownList)myListViewItem.FindControl("ddtype")).SelectedItem.ToString();

    //            string id = ((HiddenField)myListViewItem.FindControl("HdnID")).Value;

    //            //   TextBox txtlink = ((TextBox)myListViewItem.FindControl("txtlink"));
    //            FileUpload FileUpload1 = ((FileUpload)myListViewItem.FindControl("FileUpload1"));
    //            DropDownList ddtype = ((DropDownList)myListViewItem.FindControl("ddtype"));
    //            string type = ((DropDownList)myListViewItem.FindControl("ddtype")).SelectedItem.ToString();

    //            string linktext = ((DropDownList)myListViewItem.FindControl("DDlink")).SelectedItem.ToString();
    //            string linkvalue = ((DropDownList)myListViewItem.FindControl("DDlink")).SelectedValue.ToString();
    //            DropDownList ddlink = ((DropDownList)myListViewItem.FindControl("DDlink"));
    //            string query = "";
    //            if (type == "Product")
    //            {
    //                query = "Select 'productid'=-1,'productname'='Select product Name' union  select productid,productname from product";
    //            }
    //            else if (type == "Category")
    //            {
    //                query = "select 'productid'=-1,'productname'='Select MainCategory Name' union select MainCategoryid as productid,MainCategoryName as productname  from M_CategoryMaster";
    //            }

    //            else if (type == "Brand")
    //            {
    //                query = "select  'productid'=-1,'productname'='Select brand Name' union select  brandid as productid,brandName as productname  from brand";
    //            }


    //            ddlink.Items.Clear();
    //            DataTable dt = Cnn.FillTable(query, "Detail");
    //            ddlink.DataSource = dt;
    //            ddlink.DataBind(); ddlink.Visible = true;

    //            if (type == "Product")
    //            {
    //                //int count = Convert.ToInt32(Cnn.ExecuteScalar("select count(*)  from product where productname='" + ddlink.SelectedItem + "'"));
    //                //if (count > 0)
    //                //{
    //                //    ddlink.ClearSelection();
    //                //    ddlink.Items.FindByText(linktext).Selected = true;
    //                //}

    //            }
    //            else if (type == "Category")
    //            {
    //                //int count = Convert.ToInt32(Cnn.ExecuteScalar("select count(*)  from M_CategoryMaster where MainCategoryname='" + ddlink.SelectedItem + "'"));
    //                // if (count > 0)
    //                // {
    //                //     ddlink.ClearSelection();
    //                //     ddlink.Items.FindByValue(linkvalue).Selected = true;
    //                // }
    //            }

    //            else if (type == "Brand")
    //            {
    //                //int count = Convert.ToInt32(Cnn.ExecuteScalar("select count(*)  from brand where brandname='" + ddlink.SelectedItem + "'"));
    //                // if (count > 0)
    //                // {
    //                //     ddlink.ClearSelection();
    //                //     ddlink.Items.FindByValue(linkvalue).Selected = true;
    //                // }
    //            }
    //            //    ddtype.Items.FindByText(type).Selected = true;

    //            //   txtlink.Visible = true;
    //            FileUpload1.Visible = true;
    //            txtPriority.Visible = true;
    //            ddtype.Visible = true;
    //        }
    //    }

    //    Cnn.Close();
    //}
    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
         Cnn.Open();
         if (e.CommandName == "Delete")
         {

             string id = ((HiddenField)e.Item.FindControl("HdnID")).Value;
             string img = ((Label)e.Item.FindControl("lblImage")).Text;
             Cnn.ExecuteNonQuery("delete from appslider where id="+id+"");
             File.Delete(Server.MapPath("~/img/appslider/" + img));

         }
         if (e.CommandName == "edit")
         {
             LinkButton lnkedit = ((LinkButton)e.Item.FindControl("LinkButton1"));
             LinkButton lnkupdate = ((LinkButton)e.Item.FindControl("LinkButton2"));
             string type = ((HiddenField)e.Item.FindControl("hdntype")).Value;
             string link = ((HiddenField)e.Item.FindControl("hdnlink")).Value;

             string id = ((HiddenField)e.Item.FindControl("HdnID")).Value;
             TextBox txtPriority = ((TextBox)e.Item.FindControl("txtPriority"));
             //   TextBox txtlink = ((TextBox)myListViewItem.FindControl("txtlink"));
             FileUpload FileUpload1 = ((FileUpload)e.Item.FindControl("FileUpload1"));
             DropDownList ddtype = ((DropDownList)e.Item.FindControl("ddtype"));


             DropDownList ddlink = ((DropDownList)e.Item.FindControl("DDlink"));
             string query = "";
             if (type == "Product")
             {
                 query = "select productid,productname  from product order by productid desc";
             }
             else if (type == "Category")
             {
                 query = "select MainCategoryid as productid,MainCategoryName as productname  from M_CategoryMaster order by MainCategoryid desc";
             }

             else if (type == "Brand")
             {
                 query = "select brandid as productid,brandName as productname  from brand order by brandid desc";
             }


             ddlink.Items.Clear();

             DataTable dt = Cnn.FillTable(query, "Detail");
             ddlink.DataSource = dt;
             ddlink.DataBind(); ddlink.Visible = true;


             if (type == "Product")
             {
                 ddlink.Items.FindByText(link).Selected = true;
             }
             else if (type == "Category")
             {
                 ddlink.Items.FindByValue(link).Selected = true;
             }

             else if (type == "Brand")
             {
                 ddlink.Items.FindByValue(link).Selected = true;
             }

             //ddtype.DataBind();
             ddtype.ClearSelection();
             ddtype.DataBind();
             ddtype.Items.FindByText(type).Selected = true;

             //   txtlink.Visible = true;
             FileUpload1.Visible = true;
             txtPriority.Visible = true;
             ddtype.Visible = true;
             lnkedit.Visible = false;
             lnkupdate.Visible = true;
         }


         if (e.CommandName == "Update1")
         {

             string type = ((HiddenField)e.Item.FindControl("hdntype")).Value;
             string link = ((HiddenField)e.Item.FindControl("hdnlink")).Value;
             LinkButton lnkedit = ((LinkButton)e.Item.FindControl("LinkButton1"));
             LinkButton lnkupdate = ((LinkButton)e.Item.FindControl("LinkButton2"));
             string id = ((HiddenField)e.Item.FindControl("HdnID")).Value;
             TextBox txtPriority = ((TextBox)e.Item.FindControl("txtPriority"));
             //   TextBox txtlink = ((TextBox)myListViewItem.FindControl("txtlink"));
             FileUpload FileUpload1 = ((FileUpload)e.Item.FindControl("FileUpload1"));
             DropDownList ddtype = ((DropDownList)e.Item.FindControl("ddtype"));


             DropDownList ddlink = ((DropDownList)e.Item.FindControl("DDlink"));
                     
           

             string query1 = "", productid = "", categoryid = "", linkm = "";
             string ddtypenew = ddtype.SelectedItem.ToString();
             if (ddlink.SelectedValue.ToString() != "-1")
             {
                 if (ddtypenew == "Product")
                 {
                     query1 = "link='" + ddlink.SelectedItem + "',";
                     productid = ddlink.SelectedValue.ToString();
                     categoryid = Cnn.ExecuteScalar("select categoryid from product where productid='" + ddlink.SelectedValue + "'").ToString();
                     string tt = productid + "," + categoryid;
                     linkm = ",lnikn='" + tt + "'";

                 }

                 else if (ddtypenew == "Category")
                 {
                     query1 = "link='" + ddlink.SelectedValue + "',";
                 }

                 else if (ddtypenew == "Brand")
                 {
                     query1 = "link='" + ddlink.SelectedValue + "',";
                 }
             }
             Cnn.Open();
            


             if (FileUpload1.HasFile)
             {

                 byte[] image = FileUpload1.FileBytes;
                 ImageHandler imageHandler = new ImageHandler();
                 filename = id + ".jpg";
                 Bitmap bmpmain = imageHandler.CreateThumbnail(image, false, 877, 600);
                 if (bmpmain != null)
                 {
                     bmpmain.Save(Server.MapPath("~/img/appslider/" + filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                 }
                 Cnn.ExecuteNonQuery("update appslider set " + query1 + "priority='" + txtPriority.Text + "',type='" + ddtype.SelectedItem + "' " + linkm + " where id='" + id + "'");
             }
             else
             { Cnn.ExecuteNonQuery("update appslider set " + query1 + " priority='" + txtPriority.Text + "',type='" + ddtype.SelectedItem + "' " + linkm + " where id='" + id + "'"); }

             Cnn.Close();


             //   txtlink.Visible = true;
             FileUpload1.Visible = false;
             txtPriority.Visible = false;
             ddlink.Visible = false;
             ddtype.Visible = false;


             lnkedit.Visible = true;
             lnkupdate.Visible = false;
             list();
         }
    }
    protected void ListView1_ItemEditing(object sender, ListViewEditEventArgs e)
    {

    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        Cnn.Open();
        count = Convert.ToInt32(Cnn.ExecuteScalar("Select  count(*) From [appslider]"));
        int ID = Convert.ToInt32(Cnn.ExecuteScalar("Select  IsNull(Max(id)+1,1) From [appslider]"));
        if (8 == count)
        {

            Label1.Text = "8 Slider Add Only.... ";
            return;
        }
        else
        {





            string query1 = "", productid = "", categoryid = "", linkm = "";
            string ddtypenew = ddtype.SelectedItem.ToString();
            if (DDlink.SelectedValue.ToString() != "-1")
            {
                if (ddtypenew == "Product")
                {
                    query1 = DDlink.SelectedItem.ToString();
                    productid = DDlink.SelectedValue.ToString();
                    categoryid = Cnn.ExecuteScalar("select categoryid from product where productid='" + DDlink.SelectedValue + "'").ToString();
                    string tt = productid + "," + categoryid;
                    linkm = tt;

                }

                else if (ddtypenew == "Category")
                {
                    query1 = DDlink.SelectedValue;
                }

                else if (ddtypenew == "Brand")
                {
                    query1 = DDlink.SelectedValue;
                }
            }




            if (FileUpload1.HasFile)
            {

                byte[] image = FileUpload1.FileBytes;
                ImageHandler imageHandler = new ImageHandler();
                filename = ID + ".jpg";
                Bitmap bmpmain = imageHandler.CreateThumbnail(image, false, 877, 600);
                if (bmpmain != null)
                {
                    bmpmain.Save(Server.MapPath("~/img/appslider/" + filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                }
                Cnn.ExecuteNonQuery("insert into appslider (id,image,link,priority,active,type,lnikn) values ('" + ID + "','" + filename + "','" + query1 + "','" + txtPriority.Text + "',1,'" + ddtype.SelectedItem + "','" + linkm + "')");

            }
            else
            {
                Label1.Text = "Select Image ...";
                return;

            }
            list();
            Cnn.Close();
        }
    }
    protected void ListView1_ItemDeleting(object sender, ListViewDeleteEventArgs e)
    {

    }
}