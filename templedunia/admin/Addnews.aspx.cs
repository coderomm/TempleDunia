using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Addnews : System.Web.UI.Page
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
        DataTable dt = Cnn.FillTable("select * from [News]   order by priority desc", "Detail");
        ListView1.DataSource = dt;
        ListView1.DataBind();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        ////update
        if (Button1.Text == "Update")
        {
                 Cnn.Open();
                Cnn.ExecuteNonQuery("update [News] set Name='" + Txttitle.Text.Replace("'", "''") + "',Descr='" + TxtDescription.Text + "',priority='" + Txtpriority.Text.Trim().Replace("'", "''") + "' where id='" + LblId.Value + "' ");
                Cnn.Close();
               clear();
            list();
            ShowMessage("Record updated successfully", MessageType.Success);
            Button1.Text = "Submit";
          
        }
        else
        {



            //////////insert
            Cnn.Open();
            int ID = Convert.ToInt32(Cnn.ExecuteScalar("Select  IsNull(Max(ID)+1,1) From [news]"));
           

          
                Cnn.ExecuteNonQuery("INSERT INTO [news] (Id,Name,Descr,priority) values ('" + ID + "','" + Txttitle.Text.Trim().Replace("'", "''") + "','"+TxtDescription.Text+"','" + Txtpriority.Text.Trim().Replace("'", "''") + "')");

            
           
          


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
        TxtDescription.Text = "";

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

                        Cnn.ExecuteNonQuery("update news set Active=0 where Id='" + LblId.Value + "'");
                    }

                }
            }


        }

        Cnn.Close();

        if (e.CommandName == "del")
        {
            LblId.Value = ((HiddenField)e.Item.FindControl("HdnID")).Value;         
            Cnn.Open();



            Cnn.ExecuteNonQuery("delete from [news] where id='" + LblId.Value + "'");            
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
            

            TxtDescription.Text = ((Label)e.Item.FindControl("lbldescr")).Text;
            Txttitle.Text = ((Label)e.Item.FindControl("lbltitle")).Text;
            Button1.Text = "Update";


            Cnn.Open();
        }
    }


}