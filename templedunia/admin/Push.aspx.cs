using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Data;
using System.Net;
using System.Text;
using System.Web.Script.Serialization;


public partial class Push : System.Web.UI.Page
{

    string fileName;
    static string imageURL = "";
    public static string conStr = ConfigurationManager.ConnectionStrings["DigitalMobiz"].ConnectionString;
    ClsConnection Cnn = new ClsConnection();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Admin_id"] == null)
        {
            Response.Redirect("superlogin.aspx");
        }
    }
    private void AndroidPush(String token, string ImagePath)
    {

        //if (FileUpload1.HasFile)
        //{
        //    fileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
        //    FileUpload1.PostedFile.SaveAs(Server.MapPath("~/Images/") + fileName);
        //   //Response.Redirect(Request.Url.AbsoluteUri);
        //}
        try
        {
            Cnn.Open();
         
            string regId = token;
            var applicationID = "AAAAhzH71e4:APA91bF75ue-w_9ezsAL2DK0CsDfAkvMOoENRAJGk2-sBhItWuM39uu7CYbb9xXID3PUcs3D7NQaP5QW_vxW2mIKbtArqT5auseVDf47n0eI8tQDSRifWOIGBKUCY7ngX6WQOkyFh8nd";
            var icon = "http://digitalmobiz.com/img/favicon.jpg";
            var SENDER_ID = "580659172846";
            var value = TextBox1.Text; //message text box
            var title = Text1.Text;
            var subtitle = TxtSubTitle.Text;
            var activitytype = ddtype.SelectedItem.ToString();
            var id = txtproductid.Text;
            var categoryid = ""; var productname ="";
            if (ddtype.SelectedItem.ToString() == "Product")
            {
                categoryid = Cnn.ExecuteScalar("select categoryid from product where productid=" + txtproductid.Text + "").ToString();
                productname = Cnn.ExecuteScalar("select productname from product where productid=" + txtproductid.Text + "").ToString();
            }
                   Cnn.Close();
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
                priority = "high",
                content_available = true,
                data = new
                {
                    title = title,
                    icon = icon,
                    message = value,
                    body = value,
                    subtitle = subtitle,
                    imagepath = ImagePath,
                    activitytype=activitytype,
                    id=id,
                    categoryid = categoryid,
                    productname = productname
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
        ////Text1.Text = "";
        ////TextBox1.Text = "";
        ////TxtSubTitle.Text = "";

    }
    protected void Button1_Click(object sender, EventArgs e)
    {


    }
    protected void Upload(object sender, EventArgs e)
    {
        String token;

        SqlConnection con = new SqlConnection(conStr);
        con.Open();
        if (FileUpload1.HasFile)
        {
            fileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
         FileUpload1.PostedFile.SaveAs(Server.MapPath("~/img/PushImages/") + fileName);

            // TxtActivityType.Text = imageURL;
            //Response.Redirect(Request.Url.AbsoluteUri);
        }
        //for (int j = 0; j < ChkLst.Items.Count; j++)
        //{
        //    if (ChkLst.Items[j].Selected == true)
        //    {
        DataTable Dt = Cnn.FillTable("Select  TokenId From M_TokenMaster", "Detail");
        if (Dt.Rows.Count > 0)
        {
            for (int i = 0; i < Dt.Rows.Count; i++)
            {
                //userDetailsTable.Rows.Add(reader["firstName"], reader["lastName"]);
                token = Dt.Rows[i]["TokenId"].ToString();
                imageURL = "http://digitalmobiz.com/img/PushImages/" + fileName;
                AndroidPush(token, imageURL);
            }
        }
     
        Cnn.Close();

    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        TextBox1.Text = "";
        Text1.Text = "";
        TxtSubTitle.Text = "";
    }
}