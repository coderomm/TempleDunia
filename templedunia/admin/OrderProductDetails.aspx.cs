using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OrderProductDetails : System.Web.UI.Page
{
    ClsConnection Cnn = new ClsConnection();
    string OrderId;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Admin_id"] == null)
        {
            Response.Redirect("superlogin.aspx");
        }
        if (Request.QueryString["OrderId"] != null)
        {
            OrderId = Request.QueryString["OrderId"].ToString();
            LblOrderId.Text = "Order No: " + OrderId;
        }

        if (!Page.IsPostBack)
        {

            LoadData();
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

    private string WhereCond_()
    {
        string Cond_ = "";
        if (DDStatus.SelectedItem.ToString() != "ALL")
        {
            if (DDStatus.SelectedItem.ToString() == "Pending")
                Cond_ = Cond_ + " AND Delivered=0 AND Cancelled=0 AND Returned=0 AND Dispatched=0";
            else if (DDStatus.SelectedItem.ToString() == "Delivered")
                Cond_ = Cond_ + " AND Delivered=1";
            else if (DDStatus.SelectedItem.ToString() == "Cancelled")
                Cond_ = Cond_ + " AND Cancelled=1";
            else if (DDStatus.SelectedItem.ToString() == "Returned")
                Cond_ = Cond_ + " AND Returned=1";
            else if (DDStatus.SelectedItem.ToString() == "Dispatched")
                Cond_ = Cond_ + " AND Dispatched=1";
        }
        return Cond_;
    }


    private void LoadData(string Cond_ = "")
    {
        Cnn.Open();
        DataTable dtable = Cnn.FillTable("Select AID,OrderId,InvoiceNo,NetAmount,DisInvoiceNo,a.ProductId,a.Quantity,b.ProductName,Case When Image='' then (Select top 1 ImageCode From dtl_ProductGallery where Product_Id=a.ProductId) Else Image End as Image,Case When Delivered=1 Then 'Delivered' When Dispatched=1 Then 'Dispatched' When Returned=1 Then 'Returned' When Cancelled=1 Then 'Cancelled' Else 'Pending' End as Status From TrnOrderDetail as a INNER JOIN Product as b on a.ProductId=b.ProductId Where OrderId='" + OrderId + "'  " + Cond_ + "", "Order");
        LstOrder.DataSource = dtable;
        LstOrder.DataBind();
        //pnlOrderInfo.Visible = false;
        Cnn.Close();
    }

    protected void BtnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("OrderDetails.aspx");
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
            Label LblAID = (Label)e.Item.FindControl("LblAID");
            Cnn.Open();

            Cnn.ExecuteNonQuery("Update TrnOrderDetail Set Delivered=1,Cancelled=0,Returned=0,Dispatched=0  Where AID=" + LblAID.Text + "");

            LoadData(WhereCond_());
        }

        if (e.CommandName == "EdCancel")
        {
            Label LblAID = (Label)e.Item.FindControl("LblAID");
            Label LblOrderId = (Label)e.Item.FindControl("LblOrderId");
            Cnn.Open();
            Cnn.ExecuteNonQuery("Update TrnOrderDetail Set Delivered=0,Cancelled=1,Returned=0,Dispatched=0 Where AID='" + LblAID.Text + "'");
            Cnn.ExecuteNonQuery("Update TrnOrderMain Set Settlement=1,Cancelled=0,Delivered=0,Dispatched=0,Returned=0 Where OrderId=" + LblOrderId.Text + " ");
            LoadData(WhereCond_());
        }
        if (e.CommandName == "EdReturn")
        {
            Label LblAID = (Label)e.Item.FindControl("LblAID");
            Label LblOrderId = (Label)e.Item.FindControl("LblOrderId");
            Cnn.Open();

            Cnn.ExecuteNonQuery("Update TrnOrderDetail Set Delivered=0,Cancelled=0,Returned=1,Dispatched=0 Where AID='" + LblAID.Text + "'");
            Cnn.ExecuteNonQuery("Update TrnOrderMain Set Settlement=1,Cancelled=0,Delivered=0,Dispatched=0,Returned=0 Where OrderId=" + LblOrderId.Text + " ");
            LoadData(WhereCond_());
        }
        if (e.CommandName == "EdDispatch")
        {
            Label LblAID = (Label)e.Item.FindControl("LblAID");
            Cnn.Open();
            Cnn.ExecuteNonQuery("Update TrnOrderDetail Set Delivered=0,Cancelled=0,Returned=0,Dispatched=1 Where AID='" + LblAID.Text + "'");
            LoadData(WhereCond_());
        }

        //if (e.CommandName == "View")
        //{
        //    Divstore.Visible = false;
        //    divPrint.Visible = true;
        //    pnlOrderInfo.Visible = true;

        //    //  DataRow dtrow = Cnn.FillRow("select Storeid,DeliveryFees from Store.stores where Admin_Code='" + Session["AdminCode"] + "'");
        //    //  string storeid = Convert.ToString(dtrow["Storeid"]);
        //    //  string DeliveryFees = Convert.ToString(dtrow["DeliveryFees"]);
        //    string OrderId = ((Label)e.Item.FindControl("lblOrderId")).Text;
        //    //SrcUser.SelectParameters["OrderId"].DefaultValue = Convert.ToString(OrderId);
        //    //SrcCart.SelectParameters["OrderId"].DefaultValue = Convert.ToString(OrderId);
        //    //LblTotalWeight.Text = Convert.ToString(Cnn.ExecuteScalar("Select sum(C.Rate*C.quantity)from Cart C join CartShippingRelation R on C.CartId=R.CartID where R.OrderId='" + Request.QueryString["OrderId"] + "'"));
        //    Cnn.Open();
        //    DataRow dr = Cnn.FillRow("Select DeliveryFees,Amount,OrderAmount From TrnOrderMain where OrderId=" + OrderId + "");
        //    Cnn.Close();
        //    //lblAmount.Text = Convert.ToString(dr["TotalAmount"]);
        //    //LblTotalDiscount.Text = Convert.ToString(dr["DiscountActual"]);
        //    //LblTotalRate.Text = Convert.ToString(dr["Amount"]);
        //    lblAmt.Text = Convert.ToString(dr["Amount"]);
        //    LblDeliveryCharges.Text = Convert.ToString(dr["DeliveryFees"]);
        //    LblNetAmount.Text = Convert.ToString(dr["OrderAmount"]);

        //    Label LblInvoiceNo = e.Item.FindControl("LblInvoiceNo") as Label;
        //    DataTable dt = Cnn.FillTable("Select a.DisInvoiceNo,a.OrderId,a.ProductId,b.BrandName,ISNULL(d.Color_Name,'') as ColorName,b.ProductName,b.Schemeoffer,b.image,a.Unit,a.weight,b.Type,a.Quantity,a.Rate,a.Amount,a.Discount,a.NetAmount,a.Size,a.Color,c.StoreName from TrnOrderDetail as a Inner Join store.Product as b on a.ProductId=b.ProductId INNER JOIN store.stores as c on a.StoreId=c.StoreId  LEFT JOIN  store.mst_color as d ON a.Color=d.Color_id where Orderid='" + OrderId + "'", "Detail");
        //    LstConferm.DataSource = dt;
        //    LstConferm.DataBind();

        //    DataTable dtable = Cnn.FillTable("Select OrderId,'" + LblInvoiceNo.Text + "' as DisInvoiceNo,ShippingName,ShippingAddress,ShippingMobileNo,ShippingEmailId,ShippingCity,ShippingZipcode,ShippingStats,Convert(varchar,RTS,103) as ShippingDate,PayMode,Convert(varchar,DeliveryDate,103) as DeliveredDate From TrnOrderMain where Orderid='" + OrderId + "'", "Detail");
        //    LstCategory.DataSource = dtable;
        //    LstCategory.DataBind();
        //    UpdOrder.Update();
        //    //set page scroll position
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "window.location.href = '#bottom'", true);
        //}
        //if (e.CommandName == "Invoice")
        //{
        //    pnlOrderInfo.Visible = false;

        //    //UpdatePanel1.Visible = false;
        //    Divstore.Visible = true;
        //    divPrint.Visible = false;
        //    seller.Visible = true;
        //    string OrderId = ((Label)e.Item.FindControl("lblOrderId")).Text;

        //    DataTable dtDrop = Cnn.FillTable("select  distinct(StoreId) as Storeid,StoreName from [Store].[Order_cartDetail] where Orderid='" + OrderId + "'", "Drop");
        //    DbStore.DataSource = dtDrop;
        //    DbStore.DataTextField = "StoreName";
        //    DbStore.DataValueField = "Storeid";
        //    DbStore.DataBind();

        //    //select StoreId=-1,StoreName='<---Select Store--->' union All  
        //    DataRow dtStore = Cnn.FillRow("select distinct(a.StoreId) as Storeid,a.StoreName,b.address from [Store].[Order_cartDetail] as a join Store.Stores as b on a.storeid=b.storeid where a.Orderid='" + OrderId + "'");

        //    //  lblstoreName.Text= Convert.ToString(dtStore["StoreName"]);
        //    //  lblstoreaddress.Text = Convert.ToString(dtStore["address"]);



        //    DataTable dt = Cnn.FillTable("select CartId,UserCode,Storeid,StoreName,DeliveryFees,ProductId,ProductName,type,Unit,Quantity,Rate,WeightActual,UnitActual,QuantityActual,Amount,Image,Weight,CategoryName,Discount,DiscountActual,NetAmount,QuantityActual,UnitActual,SchemeOffer,ProductCode,Brandname,ColorName,Size from [Store].[Order_CartDetail] where Orderid='" + OrderId + "' and Storeid='" + DbStore.SelectedValue + "'", "Detail");
        //    LstStoreProductlist.DataSource = dt;
        //    LstStoreProductlist.DataBind();

        //    DataTable dtable = Cnn.FillTable("set dateformat DMY; Select distinct(storeid),a.OrderId,'ShippingDate'=CONVERT(varchar(10),ShippingDate,103),right(convert(varchar(20),ShippingTime,100),7) as ShippingTime,a.UserCode,ShippingName,ShippingAddress,ShippingCountry,ShippingState,ShippingDistrict,ShippingCity,ShippingZipCode,ShippingPhoneNumber,ShippingMobileNumber,ShippingEmailId,ShippingDescription,PayMode from [Store].[Order_OrderDetail] as a join Store.order_CartDetail as b on b.orderid=a.orderid where a.Orderid='" + OrderId + "' and Storeid='" + DbStore.SelectedValue + "'", "Detail");
        //    LstuserDetail.DataSource = dtable;
        //    LstuserDetail.DataBind();

        //    //SrcUser.SelectParameters["OrderId"].DefaultValue = Convert.ToString(OrderId);
        //    // SrcCart.SelectParameters["OrderId"].DefaultValue = Convert.ToString(OrderId);
        //    Cnn.Open();
        //    DataRow dr = Cnn.FillRow("Select Sum(NetAmount) as TotalAmount, SUM(DiscountActual) as DiscountActual, SUM(Amount) as Amount from [Store].[Order_CartDetail] where OrderId='" + OrderId + "'");
        //    DataRow drtime = Cnn.FillRow("set dateformat DMY; Select 'ShippingDate'=CONVERT(varchar(10),ShippingDate,103),right(convert(varchar(20),ShippingTime,100),7) as ShippingTime from [Store].[Order_OrderDetail] where Orderid='" + OrderId + "'");
        //    Cnn.Close();
        //    //   lblInvoicedate.Text = Convert.ToString(drtime["ShippingDate"]);
        //    // lblInvoiceTime.Text = Convert.ToString(drtime["ShippingTime"]);
        //    lblAmount1.Text = Convert.ToString(dr["TotalAmount"]);
        //    LblTotalDiscount1.Text = Convert.ToString(dr["DiscountActual"]);
        //    LblTotalRate1.Text = Convert.ToString(dr["Amount"]);
        //    lblTotalNetAmt1.Text = Convert.ToString(dr["TotalAmount"]);
        //    //DataRow drow = Cnn.FillRow("select * from [Store].[NetAmtDeliveryFees]  where OrderId='" + OrderId + "'");
        //    //lblfees1.Text = Convert.ToString(drow["DeliveryFees"]);

        //    Session.Remove("Order_ID");
        //    //GetInvoiceDetails();

        //    //if (!string.IsNullOrEmpty(OrderId))
        //    //{
        //    //    Session["Order_ID"] = OrderId;
        //    //    ddMessage.Items.Clear();
        //    //    ddMessage.Items.Add(new ListItem("Custom", "1"));
        //    //    ddMessage.Items.Add(new ListItem("OrderNo: " + OrderId, "2"));
        //    //    ddMessage.SelectedValue = "2";
        //    //    FillMessage();
        //    //}

        //    UpdOrder.Update();

        //    //set page scroll position
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "window.location.href = '#bottom'", true);
        //}
    }

    protected void LstOrder_ItemDataBound(object sender, ListViewItemEventArgs e)
    {

    }
}