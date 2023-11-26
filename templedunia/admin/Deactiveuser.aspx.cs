using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Net.Mail;

public partial class Deactiveuser : System.Web.UI.Page
{
    ClsConnection Cnn = new ClsConnection();
    public enum MessageType { Success, Error, Info, Warning };
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
       
            Cnn.Open();
            DataTable dt = Cnn.FillTable("Select a.*,b.State_Name as State,c.District_Name as City From  Registration as a INNER JOIN M_StateMaster as b On a.StateCode=b.State_Code INNER JOIN M_DistrictMaster as c ON a.CityCode=c.District_Code where ActiveStatus=1", "Detail");
            LstActive.DataSource = dt;
            LstActive.DataBind();


            Cnn.Close();
        
    }
    protected void ShowMessage(string Message, MessageType type)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('" + Message + "','" + type + "');", true);
    }

    protected void LstActive_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        Cnn.Open();
        if (e.CommandName == "active")
        {
            if (LstActive.Items.Count > 0)
            {
                for (int i = 0; i < LstActive.Items.Count; i++)
                {
                    if (((CheckBox)LstActive.Items[i].FindControl("ChkBox")).Checked == true)
                    {
                        

                        string id = ((HiddenField)LstActive.Items[i].FindControl("HdnID")).Value;
                        string Mail = Cnn.ExecuteScalar("select EmailId from Registration where UserId='" + id + "'").ToString();
                        Cnn.ExecuteNonQuery("update Registration set ActiveStatus=0,UserStatus=1 where UserId='" + id + "'");
                    }

                }
            }


        }
        list();
        ShowMessage("Record updated successfully", MessageType.Success);
        Cnn.Close();
    }

}


//try
//                        {

//                            MailMessage newmail = new MailMessage();
//                            MailAddress toadd = new MailAddress(Mail);
//                            MailAddress fromadd = new MailAddress("info@ankitsuitings.com");
//                            newmail.Subject = "Account Activated";
//                            string msg = "<div>";
//                            msg = DateTime.Now + "<br/>";
//                            msg += "<html><head><body><div style='border-style: double; border-width: 10px; border-color:#cccccc; padding:20px; Font-size:11px; color:black;'><br />";
//                            msg += "<b>Hello </b>,<br/><br>Your Account: Is Activated in website Shiv Shakti Synthetics Thank. <br />visit <a href='http://ankitsuitings.com/'>ankitsuitings.com</a><br />";

//                            msg += "</div></body></head></html>";
//                            newmail.Body = msg;
//                            newmail.To.Add(toadd);
//                            newmail.From = fromadd;
//                            newmail.IsBodyHtml = true;
//                            SmtpClient sserver = new SmtpClient();
//                            sserver.Host = "mail.ankitsuitings.com";
//                            sserver.Credentials = new NetworkCredential("info@ankitsuitings.com", "Ankit@Info77");
//                            sserver.DeliveryMethod = SmtpDeliveryMethod.Network;
//                            sserver.Port = 25;
//                            sserver.Send(newmail);
                           
                          
                        


//                        }
//                        catch (Exception ex)
//                        {
                          
//                        }