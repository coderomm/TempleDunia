using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DisptachOrderList : System.Web.UI.Page
{
    public string DeliverdDate = "";
    public string DeliverdTime = "";
    ClsConnection Cnn = new ClsConnection();
    public string Cancelid;
    public string remark = "";
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
        DataTable Dt = Cnn.FillTable("select e.firmname,a.Orderid,a.InvoiceNo,a.Name,a.City,a.MobileNo,convert(varchar, a.RTS, 0) as  Date,convert(varchar, a.RTS, 107) as  Time,a.OrderThrough,b.State_Name as State,a.TotalQuantity from [TrnOrderMain] as a inner join  M_StateMaster as b on a.StateCode=b.State_Code inner join Registration as e on a.Userid=e.userid where  a.Dispatch=1 And a.Delivered=0 AND a.Canceled=0 order by OrderId Desc", "ttt");
        LstActive.DataSource = Dt;
        LstActive.DataBind();

    }

    protected void LstCategory_ItemCommand(object sender, ListViewCommandEventArgs e)
    {

    }


    protected void ShowMessage(string Message, MessageType type)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('" + Message + "','" + type + "');", true);
    }
    protected void LstActive_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try
        {
            Cnn.Open();

            if (e.CommandName == "Deliverd")
            {
                if (LstActive.Items.Count > 0)
                {
                    for (int i = 0; i < LstActive.Items.Count; i++)
                    {
                        if (((CheckBox)LstActive.Items[i].FindControl("ChkCancel")).Checked == true)
                        {

                            string id = ((HiddenField)LstActive.Items[i].FindControl("OrderId")).Value;
                            Cnn.ExecuteNonQuery("update TrnOrderMain set  Delivered=1 where OrderId='" + id + "'");

                        }
                    }
                }
            }
            //  list();
            if (e.CommandName == "Dispatch")
            {
                if (LstActive.Items.Count > 0)
                {
                    for (int i = 0; i < LstActive.Items.Count; i++)
                    {
                        if (((CheckBox)LstActive.Items[i].FindControl("ChkDispatch")).Checked == true)
                        {

                            string id = ((HiddenField)LstActive.Items[i].FindControl("OrderId")).Value;
                            Cnn.ExecuteNonQuery("update TrnOrderMain set  Dispatch=1 where OrderId='" + id + "'");

                        }
                    }
                }
            }
            if (e.CommandName == "Show")
            {

                string id = ((HiddenField)e.Item.FindControl("OrderId")).Value;
                pnlOrderInfo.Visible = true;

                DataTable Dt = Cnn.FillTable("select b.AgentName,a.Userid,a.Orderid,a.InvoiceNo,a.Name,a.City,a.MobileNo,convert(varchar, a.RTS, 107) as  Date,Right(Convert(varchar(20),a.RTS,100),7) as Time,a.EmailId,a.Address,isnull(a.Accountid,0) as Accountid,b.Gst,b.FirmName,b.Station,a.remark  from [TrnOrderMain] as a inner join Registration as b on a.userid=b.userid where a.OrderId='" + id + "'", "the");
                LstCategory.DataSource = Dt;
                LstCategory.DataBind();
                remark = Dt.Rows[0]["remark"].ToString();
                DataTable Dt1 = Cnn.FillTable("select  OrderID,ProductId,Meter,Quantity,(Meter*Quantity) as TotalQuantity,ShadeId,CutType from TrnOrderShadeDetail where orderid='" + id + "'", "thte");
                LstConferm.DataSource = Dt1;
                LstConferm.DataBind();


                //    string TitAmt = ((Label)e.Item.FindControl("lblTotalNetAmt")).Text.ToString();
                //    lblTotalNetAmt.Text = Cnn.ExecuteScalar("select TotalAmount from TrnOrderMain where OrderId='" + id + "'").ToString();
                Cnn.Close();


                //set page scroll position
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "window.location.href = '#bottom'", true);

            }


            //
            //  PrintHelper
            if (e.CommandName == "print")
            {

                string id = ((HiddenField)e.Item.FindControl("OrderId")).Value;
                pnlOrderInfo.Visible = true;

                DataTable Dt = Cnn.FillTable("select a.remark,a.Userid,a.Orderid,a.InvoiceNo,a.Name,a.City,a.MobileNo,convert(varchar, a.RTS, 107) as  Date,Right(Convert(varchar(20),a.RTS,100),7) as Time,a.EmailId,a.Address,isnull(a.Accountid,0) as Accountid,b.Gst,b.FirmName  from [TrnOrderMain] as a inner join Registration as b on a.userid=b.userid where a.OrderId='" + id + "'", "the");
                ListView1.DataSource = Dt;
                ListView1.DataBind();

                DataTable Dt1 = Cnn.FillTable("select  (d.Meter*d.Quantity) as Quantity ,b.ProductName,a.ProductId,c.id,c.ShadeNo,c.Image,a.OrderID,d.Meter,d.CutType,b.Rate,b.Lump,b.Than,b.Piece,b.Multi from TrnOrderDetail as a inner join M_ProductMaster as b on a.ProductId=b.ProductId  inner join M_ShadeMaster as c on a.ShadeId=c.id inner join TrnOrderShadeDetail as d on a.ShadeId=d.ShadeId  where a.orderid='" + id + "'", "thte");
                ListView2.DataSource = Dt1;
                ListView2.DataBind();


                //    string TitAmt = ((Label)e.Item.FindControl("lblTotalNetAmt")).Text.ToString();
                //    lblTotalNetAmt.Text = Cnn.ExecuteScalar("select TotalAmount from TrnOrderMain where OrderId='" + id + "'").ToString();
                Cnn.Close();

                Printpanel.Visible = true;
                Session["AdminPrint"] = Printpanel;
                Response.Redirect("Print.aspx");
                //set page scroll position
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "window.location.href = '#bottom'", true);

            }


            //
            //Del
            if (e.CommandName == "Del")
            {


                Cancelid = ((HiddenField)e.Item.FindControl("OrderId")).Value;
                canelbox.Visible = true;
                CanelOrderlist();

            }


        }
        catch (Exception ex)
        {
            throw ex;
        }

        list();
    }


    public void CanelOrderlist()
    {
        Cnn.Open();
        DataTable Dt1 = Cnn.FillTable("select distinct b.ProductName,a.ProductId,c.id,c.ShadeNo,c.Image,a.OrderID from TrnOrderDetail as a inner join M_ProductMaster as b on a.ProductId=b.ProductId  inner join M_ShadeMaster as c on a.ShadeId=c.id where a.orderid='" + Cancelid + "' and a.Canceled=0", "thte");
        lstcanel.DataSource = Dt1;
        lstcanel.DataBind();
        Cnn.Close();
    }
    protected void ImgBtnPrint_Click(object sender, ImageClickEventArgs e)
    {
        tdPrint.Visible = false;
        Session["AdminPrint"] = divPrint;
        Response.Redirect("Print.aspx");
    }
    protected void lstcanel_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        Cnn.Open();
        if (e.CommandName == "Cen")
        {
            if (lstcanel.Items.Count > 0)
            {
                for (int i = 0; i < lstcanel.Items.Count; i++)
                {
                    if (((CheckBox)lstcanel.Items[i].FindControl("ChkCancel")).Checked == true)
                    {

                        string id = ((HiddenField)lstcanel.Items[i].FindControl("OrderId")).Value;
                        string Sid = ((Label)lstcanel.Items[i].FindControl("lblProductId")).Text;
                        string Sid1 = ((Label)lstcanel.Items[i].FindControl("ShadeId")).Text;

                        Cnn.ExecuteNonQuery("update TrnOrderDetail set  Canceled=1 where OrderId='" + id + "' and ProductId='" + Sid + "' and ShadeId='" + Sid1 + "'");

                        Int32 Qty = Convert.ToInt32(Cnn.ExecuteScalar("select sum(Quantity) as Quantity from TrnOrderDetail  where OrderID='" + id + "' and ShadeId='" + Sid1 + "' and ProductId='" + Sid + "'"));
                        Cnn.ExecuteNonQuery("update TrnOrderMain set TotalQuantity=TotalQuantity-'" + Qty + "' where OrderId='" + id + "' ");
                        Cnn.ExecuteNonQuery("delete from TrnOrderShadeDetail where OrderId='" + id + "' and  ShadeId='" + Sid1 + "' and ProductId='" + Sid + "'");

                    }
                }
            }
        }

        ShowMessage("Record updated successfully", MessageType.Success);
        canelbox.Visible = false;
        //     CanelOrderlist();
        Cnn.Close();
    }
    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        Response.Redirect("OrderList.aspx");
    }
    protected void LstProducts_DataBound(object sender, EventArgs e)
    {
        // string  tt=((Label)this.LstProducts_DataBound.FindControl("Label")).Text;
    }

}