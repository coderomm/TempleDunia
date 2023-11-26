using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;


    public class Msg
    {
        #region
        /*--------- start SMS -----------------------------------------------------------------------------------*/
        public static class Gateway
        {
            public static string High = "high";
            public static string Regular = "regular";
        }
        public static string CountryCode(string Mobile)
        {
            if (Mobile != "")
            {
                string MobileNo = "";
                char[] delimeter = new char[] { ',', ' ' };
                string[] mobileList = Mobile.Split(delimeter, StringSplitOptions.RemoveEmptyEntries);
                foreach (string mobile in mobileList)
                {
                    MobileNo = MobileNo + mobile.Substring(mobile.Length - Math.Min(10, mobile.Length)) + ",";
                }
                MobileNo = MobileNo.Remove(MobileNo.LastIndexOf(','));
                return (MobileNo);
            }
            else
            {
                return ("");
            }
        }
        public static string SendSMS(string Mobile, string Message)
        {
            try
            {
                string Gateway = Msg.Gateway.Regular;
              
                //  string gsmSenderId = "TXTSMS";
                Mobile = Msg.CountryCode(Mobile);
                Message = Message.Replace("&", "%26");
                Message = Message.Replace("+", "%2B");
                string baseurl = "https://www.fast2sms.com/dev/bulkV2?authorization=Hn0kbgxQa5q4FlTtfwIGDpme7ZVNYLSoU2RjAiy9zsKWr1CEMJSuli8wEOY9vz6V5yDMbrTte1JjNUFW&route=q&message=" + Message + "&language=english&flash=0&numbers=" + Mobile + "";
              //  string baseurl = "https://www.fast2sms.com/dev/bulkV2?authorization=9BMAcgoSHEnvu57D8xXJPYaWQ04VwIOsCiefp2dUzmtqbljhrRMyxo8v0nRlCpsfgdULiKVQ1huN4etG&route=v3&sender_id=TXTIND&message=" + Message + "&language=english&flash=0&numbers=" + Mobile + "";
                WebClient client = new WebClient();
                Stream data = client.OpenRead(baseurl);
                StreamReader reader = new StreamReader(data);
                string s = reader.ReadToEnd();
                data.Close();
                reader.Close();
                return (s);
            }
            catch (Exception Ex)
            {
                return ("");
            }
        }

        public static string SendSMS12(string Mobile, string Message, string templateid)
        {
            try
            {
                string Gateway = Msg.Gateway.Regular;
                string UserName = "citystotre349836";
                string Password = "18936";
                string gsmSenderId = "CTstor";
                // string gsmSenderId = "TXTSMS";
                Mobile = Msg.CountryCode(Mobile);
                Message = Message.Replace("&", "%26");
                Message = Message.Replace("+", "%2B");
                //string baseurl = "";
              //  string baseurl = "http://kit19.com/ComposeSMS.aspx?username=" + UserName + "&password=" + Password + "&sender=" + gsmSenderId + "&to=" + Mobile + "&message=" + Message + "&priority=1&dnd=1&unicode=0";
                string baseurl = "https://msg2.virtualinfosystems.com/ComposeSMS.aspx?username=" + UserName + "&password=" + Password + "&sender=" + gsmSenderId + "&to=" + Mobile + "&message=" + Message + "&priority=1&dnd=1&unicode=0&dlttemplateid=" + templateid + "";
                WebClient client = new WebClient();
                Stream data = client.OpenRead(baseurl);
                StreamReader reader = new StreamReader(data);
                string s = reader.ReadToEnd();
                data.Close();
                reader.Close();
                return (s);
            }
            catch (Exception Ex)
            {
                return ("");
            }
        }

        public static string SendSMS1(string Mobile, string Message)
        {
            try
            {
                string Gateway = Msg.Gateway.Regular;
                string UserName = "citystotre349836";
                string Password = "18936";
                string gsmSenderId = "CTstor";
                // string gsmSenderId = "TXTSMS";
                Mobile = Msg.CountryCode(Mobile);
                Message = Message.Replace("&", "%26");
                Message = Message.Replace("+", "%2B");
                //string baseurl = "";
                //   string baseurl = "http://kit19.com/ComposeSMS.aspx?username=" + UserName + "&password=" + Password + "&sender=" + gsmSenderId + "&to=" + Mobile + "&message=" + Message + "&priority=1&dnd=1&unicode=0";

                string baseurl = "http://sms.morningstarsolutions.in/vendorsms/pushsms.aspx?user=citystore1&password=citystore&msisdn=91" + Mobile + "&sid=CTSTOR&msg=" + Message + "&fl=0&gwid=2";
                WebClient client = new WebClient();
                Stream data = client.OpenRead(baseurl);
                StreamReader reader = new StreamReader(data);
                string s = reader.ReadToEnd();
                data.Close();
                reader.Close();
                return (s);
            }
            catch (Exception Ex)
            {
                return ("");
            }
        }

        public static string SendSMSdev(string Mobile, string Message)
        {
            try
            {
                //string s = "";
                string Gateway = Msg.Gateway.Regular;
                string UserName = "Dev Education";
                string Password = "11231";
                string gsmSenderId = "DevEdu";
                Mobile = Msg.CountryCode(Mobile);
                Message = Message.Replace("&", "%26");
                Message = Message.Replace("+", "%2B");
                //string baseurl = "";
                string baseurl = "http://kit19.com/ComposeSMS.aspx?username=" + UserName + "&password=" + Password + "&sender=" + gsmSenderId + "&to=" + Mobile + "&message=" + Message + "&priority=1&dnd=1&unicode=1";
                // string baseurl = "http://msg2.virtualinfosystems.com/ComposeSMS.aspx?username=" + UserName + "&password=" + Password + "&sender=" + gsmSenderId + "&to=" + Mobile + "&message=" + Message + "&priority=1&dnd=1&unicode=1";
                WebClient client = new WebClient();
                Stream data = client.OpenRead(baseurl);
                StreamReader reader = new StreamReader(data);
                string s = reader.ReadToEnd();
                data.Close();
                reader.Close();
                return (s);
            }
            catch (Exception Ex)
            {
                return ("");
            }
        }


        public static string HitGetAPI(string UserID, string Password, string SenderID, string PhoneNo, string Msg, string EntityID, string TemplateID)
        {
        //            Username - virtualinfo
        //Pass -         qyft6851QY
        //Url -   https://biz.sms4power.com

            //
        //            Welcome, Ragini Sharma
        //Logged in with PE ID 1201159205147277499 

//https://trueconnect.jio.com/#/dashboard/home
        //user: nalin67@gmail.com
        //password: Ragini@96177

             http://13.126.6.18/vendorsms/pushsms.aspx?user=citystore1&password=citystore&msisdn=919829796177&sid=CTstor&msg=test%20message&fl=0 
            string result = "";
            Msg = HttpUtility.UrlEncode(Msg);
            //For single number
            string testUrl = "http://biz.sms4power.com/api/SmsApi/SendSingleApi?UserID=" + UserID + "&Password=" + Password + "&SenderID=" + SenderID + "&Phno=" + PhoneNo + "&Msg=" + Msg + "&EntityID=" + EntityID + "&TemplateID=" + TemplateID;
            WebRequest reqObj = WebRequest.Create(testUrl);
            reqObj.Method = "POST";
            reqObj.ContentLength = 0;
            HttpWebResponse resObj = null;
            resObj = (HttpWebResponse)reqObj.GetResponse();
            using (Stream st = resObj.GetResponseStream())
            {
                StreamReader str = new StreamReader(st);
                result = str.ReadToEnd();//we can return result
                str.Close();
            }
            return result;
        }
        /*--------- end SMS--------------------------------------------------------------------------------------*/
        #endregion
        #region
        /*--------- start Email -----------------------------------------------------------------------------------*/
        public static void SendEmail(string Receiver_Email, string Subject, string Message)
        {
            try
            {
                //************************************* E-mail system *********************************************************//
                System.Configuration.Configuration configurationFile = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("~/web.config");
                System.Net.Configuration.MailSettingsSectionGroup mailSettings = configurationFile.GetSectionGroup("system.net/mailSettings") as System.Net.Configuration.MailSettingsSectionGroup;
                if (mailSettings != null)
                {
                    int port = mailSettings.Smtp.Network.Port;
                    string host = mailSettings.Smtp.Network.Host;
                    string password = mailSettings.Smtp.Network.Password;
                    string username = mailSettings.Smtp.Network.UserName;
                    System.Net.Mail.MailMessage Msg = new System.Net.Mail.MailMessage();
                    Msg.From = new System.Net.Mail.MailAddress(username,"City Store");
                    Msg.To.Add(Receiver_Email);
                    Msg.Subject = "City Store";
                    Msg.Subject = Subject;
                    Msg.Body = Message;
                    Msg.IsBodyHtml = true;
                    System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient();
                    smtp.Host = host;
                    smtp.Port = port;
                    smtp.Credentials = new System.Net.NetworkCredential(username, password);
                    smtp.Send(Msg);
                    Msg = null;
                }
                //*************************************************************************************************************//
            }
            catch (Exception Ex)
            {

            }
        }
        public static void SendEmailtoAll(string Receiver_Email, string Subject, string Message)
        {
            if (Receiver_Email != "")
            {
                char[] delimeter = new char[] { ',', ' ' };
                string[] emailList = Receiver_Email.Split(delimeter, StringSplitOptions.RemoveEmptyEntries);
                foreach (string email in emailList)
                {
                    SendEmail(email, Subject, Message);
                }
            }
        }
        public static void ABC()
        {

        }
        /*--------- end Email--------------------------------------------------------------------------------------*/
        #endregion
    }
