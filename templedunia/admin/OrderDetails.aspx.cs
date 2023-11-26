using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OrderDetails : System.Web.UI.Page
{
    ClsConnection Cnn = new ClsConnection();
    protected void Page_Load(object sender, EventArgs e)
    {
        TxtFromDate.Focus();
        if (Session["Admin_id"] == null)
        {
            Response.Redirect("superlogin.aspx");
        }

        if (!Page.IsPostBack)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["status"] as string))
            {
                DDStatus.Items.FindByText(Request.QueryString["status"].ToString()).Selected = true;
            }
            LoadData(WhereCond_());
        }
    }

    protected void BtnSearch_Click(object sender, EventArgs e)
    {
        LoadData(WhereCond_());
    }

    protected void LstOrder_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "EdDeliver")
        {
            Label LblOrderId = (Label)e.Item.FindControl("LblOrderId");
            Cnn.Open();
            Cnn.ExecuteNonQuery("Update TrnOrderMain Set Delivered=1,Cancelled=0,Returned=0,Dispatched=0  Where OrderId='" + LblOrderId.Text + "'");
            Cnn.ExecuteNonQuery("Update TrnOrderDetail Set Delivered=1,Cancelled=0,Returned=0,Dispatched=0  Where OrderId='" + LblOrderId.Text + "'");

            LoadData(WhereCond_());
        }

        if (e.CommandName == "EdCancel")
        {
            Label LblOrderId = (Label)e.Item.FindControl("LblOrderId");
            Cnn.Open();
            Cnn.ExecuteNonQuery("Update TrnOrderMain  Set Delivered=0,Cancelled=1,Returned=0,Dispatched=0 Where OrderId='" + LblOrderId.Text + "'");
            Cnn.ExecuteNonQuery("Update TrnOrderDetail Set Delivered=0,Cancelled=1,Returned=0,Dispatched=0 Where OrderId='" + LblOrderId.Text + "'");
            LoadData(WhereCond_());
        }
        if (e.CommandName == "EdReturn")
        {
            Label LblOrderId = (Label)e.Item.FindControl("LblOrderId");
            Cnn.Open();
            Cnn.ExecuteNonQuery("Update TrnOrderMain Set Delivered=0,Cancelled=0,Returned=1,Dispatched=0 Where OrderId='" + LblOrderId.Text + "'");
            Cnn.ExecuteNonQuery("Update TrnOrderDetail Set Delivered=0,Cancelled=0,Returned=1,Dispatched=0 Where OrderId='" + LblOrderId.Text + "'");
            LoadData(WhereCond_());
        }
        if (e.CommandName == "EdDispatch")
        {
            Label LblOrderId = (Label)e.Item.FindControl("LblOrderId");
            Cnn.Open();
            Cnn.ExecuteNonQuery("Update TrnOrderMain Set Delivered=0,Cancelled=0,Returned=0,Dispatched=1 Where OrderId='" + LblOrderId.Text + "'");
            Cnn.ExecuteNonQuery("Update TrnOrderDetail Set Delivered=0,Cancelled=0,Returned=0,Dispatched=1 Where OrderId='" + LblOrderId.Text + "'");
            LoadData(WhereCond_());
        }

        if (e.CommandName == "View")
        {

            divPrint.Visible = true;
            pnlOrderInfo.Visible = true;
            //DivProducts.Visible = false;

            //  DataRow dtrow = Cnn.FillRow("select Storeid,DeliveryFees from Store.stores where Admin_Code='" + Session["AdminCode"] + "'");
            //  string storeid = Convert.ToString(dtrow["Storeid"]);
            //  string DeliveryFees = Convert.ToString(dtrow["DeliveryFees"]);
            string OrderId = ((Label)e.Item.FindControl("lblOrderId")).Text;
            //SrcUser.SelectParameters["OrderId"].DefaultValue = Convert.ToString(OrderId);
            //SrcCart.SelectParameters["OrderId"].DefaultValue = Convert.ToString(OrderId);
            //LblTotalWeight.Text = Convert.ToString(Cnn.ExecuteScalar("Select sum(C.Rate*C.quantity)from Cart C join CartShippingRelation R on C.CartId=R.CartID where R.OrderId='" + Request.QueryString["OrderId"] + "'"));
            Cnn.Open();
            DataRow dr = Cnn.FillRow("Select DeliveryFees,Amount,OrderAmount From TrnOrderMain where OrderId=" + OrderId + "");
            Cnn.Close();
            //lblAmount.Text = Convert.ToString(dr["TotalAmount"]);
            //LblTotalDiscount.Text = Convert.ToString(dr["DiscountActual"]);
            //LblTotalRate.Text = Convert.ToString(dr["Amount"]);
            lblAmt.Text = Convert.ToString(dr["Amount"]);
            LblDeliveryCharges.Text = Convert.ToString(dr["DeliveryFees"]);
            LblNetAmount.Text = Convert.ToString(dr["OrderAmount"]);

            Label LblInvoiceNo = e.Item.FindControl("LblInvoiceNo") as Label;
            DataTable dt = Cnn.FillTable("Select a.DisInvoiceNo,a.OrderId,a.ProductId,b.ProductName,b.Image,a.Unit,a.weight,a.Quantity,a.Rate,a.Amount,a.Discount,a.NetAmount from TrnOrderDetail as a Inner Join Product as b on a.ProductId=b.ProductId  where Orderid='" + OrderId + "'", "Detail");
            LstConferm.DataSource = dt;
            LstConferm.DataBind();

            DataTable dtable = Cnn.FillTable("Select OrderId,'" + LblInvoiceNo.Text + "' as DisInvoiceNo,ShippingName,ShippingAddress,ShippingMobileNo,ShippingEmailId,ShippingCity,ShippingZipcode,ShippingStats,Convert(varchar,RTS,103) as ShippingDate,PayMode,Convert(varchar,DeliveryDate,103) as DeliveredDate From TrnOrderMain where Orderid='" + OrderId + "'", "Detail");
            LstCategory.DataSource = dtable;
            LstCategory.DataBind();
            UpdOrder.Update();
            //set page scroll position
            Page.ClientScript.RegisterStartupScript(this.GetType(), "hash", "location.hash = '#View';", true);
        }
    }

    private string WhereCond_()
    {
        string Cond_ = "";

        if (TxtFromDate.Text != "" && TxtToDate.Text != "")
        {
            Cond_ = " AND RTS >= Convert(DateTime,'" + TxtFromDate.Text + "',103) AND RTS <= Convert(DateTime,'" + TxtToDate.Text + "',103)+1";
        }
        if (DDStatus.SelectedItem.ToString() != "ALL")
        {
            if (DDStatus.SelectedItem.ToString() == "Pending")
                Cond_ = Cond_ + " AND Delivered=0 AND Cancelled=0 AND Returned=0 AND Dispatched=0 AND Settlement=0";
            else if (DDStatus.SelectedItem.ToString() == "Delivered")
                Cond_ = Cond_ + " AND Delivered=1";
            else if (DDStatus.SelectedItem.ToString() == "Cancelled")
                Cond_ = Cond_ + " AND Cancelled=1";
            else if (DDStatus.SelectedItem.ToString() == "Returned")
                Cond_ = Cond_ + " AND Returned=1";
            else if (DDStatus.SelectedItem.ToString() == "Dispatch")
                Cond_ = Cond_ + " AND Dispatched=1";
            else if (DDStatus.SelectedItem.ToString() == "Settlement")
                Cond_ = Cond_ + " AND Settlement=1";
        }
        return Cond_;
    }


    private void LoadData(string Cond_ = "")
    {
        Cnn.Open();
        DataTable dtable = Cnn.FillTable("Select OrderId,OrderAmount,Convert(Varchar,RTS,103) as OrderDate,DeliveryFees,ShippingName as Name,ShippingMobileNo as MobileNumber,Case When Delivered=1 Then 'Delivered' When Dispatched=1 Then 'Dispatched' When Returned=1 Then 'Returned' When Cancelled=1 Then 'Cancelled' When Settlement=1 Then 'Settlement' Else 'Pending' End as Status From TrnOrderMain Where 1=1 " + Cond_ + " Order by OrderId desc", "Order");
        LstOrder.DataSource = dtable;
        LstOrder.DataBind();

        //pnlOrderInfo.Visible = false;
        Cnn.Close();
    }

    protected void LstOrder_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        DataPager1.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        LoadData(WhereCond_());
    }

    protected void LstOrder_ItemDataBound(object sender, ListViewItemEventArgs e)
    {

        string Stats = ((Label)e.Item.FindControl("lblStatus")).Text;
        if (Stats == "Pending")
        {
            ((LinkButton)e.Item.FindControl("LnkDeliver")).Enabled = true;
            ((LinkButton)e.Item.FindControl("LnkDispatch")).Enabled = true;
            ((LinkButton)e.Item.FindControl("LnkCancel")).Enabled = true;
            ((LinkButton)e.Item.FindControl("LnkReturn")).Enabled = false;
        }
        if (Stats == "Dispatched")
        {
            ((LinkButton)e.Item.FindControl("LnkDeliver")).Enabled = true;
            ((LinkButton)e.Item.FindControl("LnkDispatch")).Enabled = false;
            ((LinkButton)e.Item.FindControl("LnkCancel")).Enabled = true;
            ((LinkButton)e.Item.FindControl("LnkReturn")).Enabled = false;
        }
        if (Stats == "Cancelled")
        {
            ((LinkButton)e.Item.FindControl("LnkDeliver")).Enabled = false;
            ((LinkButton)e.Item.FindControl("LnkDispatch")).Enabled = false;
            ((LinkButton)e.Item.FindControl("LnkCancel")).Enabled = false;
            ((LinkButton)e.Item.FindControl("LnkReturn")).Enabled = false;
        }
        if (Stats == "Delivered")
        {
            ((LinkButton)e.Item.FindControl("LnkDeliver")).Enabled = false;
            ((LinkButton)e.Item.FindControl("LnkDispatch")).Enabled = false;
            ((LinkButton)e.Item.FindControl("LnkCancel")).Enabled = false;
            ((LinkButton)e.Item.FindControl("LnkReturn")).Enabled = true;
        }
        if (Stats == "Returned")
        {
            ((LinkButton)e.Item.FindControl("LnkDeliver")).Enabled = false;
            ((LinkButton)e.Item.FindControl("LnkDispatch")).Enabled = false;
            ((LinkButton)e.Item.FindControl("LnkCancel")).Enabled = false;
            ((LinkButton)e.Item.FindControl("LnkReturn")).Enabled = false;
        }
    }

    protected string setclass(string active)
    {
        string classToApply = string.Empty;
        if (active == "Pending")
        {
            classToApply = "yellowRow";
        }
        else if (active == "Delivered")
        {
            classToApply = "greenRow";
        }
        else if (active == "Canceled")
        {
            classToApply = "redRow";
        }
        return classToApply;

    }

    protected void Imgbtn_Click(object sender, ImageClickEventArgs e)
    {
        // tdstoreprint.Visible = false;
        Imgbtn.Visible = false;
        Session["AdminPrint"] = divPrint;
        Response.Redirect("print.aspx");
    }
    protected void LstCategory_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {

    }
    protected void LstCategory_ItemCommand(object sender, ListViewCommandEventArgs e)
    {

    }
    protected void Imgbtnstore_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void LstuserDetail_ItemCommand(object sender, ListViewCommandEventArgs e)
    {

    }

    protected void BtnClose_Click(object sender, EventArgs e)
    {
        //DivProducts.Visible = true;
        pnlOrderInfo.Visible = false;
    }
}