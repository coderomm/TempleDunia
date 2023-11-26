using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Data;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Collections.Generic;
using System.Web.Script.Serialization;

public partial class Push_default : System.Web.UI.Page
{

    string fileName;
    static string imageURL = "";
    public static string conStr = ConfigurationManager.ConnectionStrings["ShivShaktiSynthetics"].ConnectionString;
    ClsConnection Cnn = new ClsConnection();
    protected void Page_Load(object sender, EventArgs e)
    {


     
    }
    private void AndroidPush(String token,string ImagePath)
    {

        //if (FileUpload1.HasFile)
        //{
        //    fileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
        //    FileUpload1.PostedFile.SaveAs(Server.MapPath("~/Images/") + fileName);
        //   //Response.Redirect(Request.Url.AbsoluteUri);
        //}
        try
        {
            string regId = token;
            var applicationID = "AAAAemreUKI:APA91bGo0AbEGqg8JE3MkcTBPXTOf0n6r5KiepFIlvA2itFhBTGhX_Ytabpo5KCuBH718ODXVWqUFzomkKxRKb12RCN_Yn4nsMbJeavlDaYvnYTQiIqAtLnQHhYlXO82rR_aknulSK4M";
            var SENDER_ID = "525778964642";
            var value = TextBox1.Text; //message text box
            var title = Text1.Text;
            var subtitle = TxtSubTitle.Text;
          
           

            WebRequest tRequest;
            //String imageURL = "http://store.ankurfurniture.com/Images/bullet.png";
            // tRequest = WebRequest.Create("https://fcm.googleapis.com/fcm/send");
            tRequest = (HttpWebRequest)WebRequest.Create("https://fcm.googleapis.com/fcm/send");
            tRequest.Method = "post";

            tRequest.ContentType = " application/json";

            //Data post to server                                                                                                                                         
            //string postData =
            //     "collapse_key=score_update&time_to_live=108&delay_while_idle=1&data.title=" + title + "&data.message="
            //      + value + "&data.time=" + System.DateTime.Now.ToString() + "&registration_id=" +
            //         regId + "&data.image=" + imageURL;

            var data = new
            {
                to = regId,
                data = new
                {
                    title = title,
                    message = value,
                    subtitle = subtitle,
                    imagepath = ImagePath
                   
                }
            };

            var serializer = new JavaScriptSerializer();
            var json = serializer.Serialize(data);
            Byte[] byteArray = Encoding.UTF8.GetBytes(json);
            tRequest.Headers.Add(string.Format("Authorization: key={0}", applicationID));

            tRequest.Headers.Add(string.Format("Sender: id={0}", SENDER_ID));
            tRequest.ContentLength = byteArray.Length;


            using (Stream dataStream = tRequest.GetRequestStream())
            {
                dataStream.Write(byteArray, 0, byteArray.Length);
                using (WebResponse tResponse = tRequest.GetResponse())
                {
                    using (Stream dataStreamResponse = tResponse.GetResponseStream())
                    {
                        using (StreamReader tReader = new StreamReader(dataStreamResponse))
                        {
                            String sResponseFromServer = tReader.ReadToEnd();
                            string str = sResponseFromServer;
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            string str = ex.Message;
        }
        Label3.Text = "Message Sent Successfully";

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
     

    }
    protected void Upload(object sender, EventArgs e)
    {
        String token;

        SqlConnection con = new SqlConnection(conStr);
        con.Open();
        DataTable Dt = Cnn.FillTable("Select Token From Token_list", "Detail");


        if (FileUpload1.HasFile)
        {
            fileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
            FileUpload1.PostedFile.SaveAs(Server.MapPath("~/img/PushImages/") + fileName);
            
           // TxtActivityType.Text = imageURL;
            //Response.Redirect(Request.Url.AbsoluteUri);
        }
        if (Dt.Rows.Count > 0)
        {
            for (int i = 0; i < Dt.Rows.Count; i++)
            {
                //userDetailsTable.Rows.Add(reader["firstName"], reader["lastName"]);
                token = Dt.Rows[i]["Token"].ToString();
                imageURL = "http://ankitsuitings.com/img/PushImages/" + fileName;
                AndroidPush(token, imageURL);

            }
        }


    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        TextBox1.Text = "";
        Text1.Text = "";

    }
}