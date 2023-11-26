using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DispatchOrder : System.Web.UI.Page
{
    ClsConnection Cnn = new ClsConnection();
    int TotalQuantity = 0;
    public enum MessageType { Success, Error, Info, Warning };
    string filename;
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

        DataTable Dtt = Cnn.FillTable("Select 'OrderId'=-1,'InvoiceNo'='Select Invoice No' union  select OrderId,InvoiceNo from TrnOrderMain where  Delivered=0 and Canceled=0 ", "Detail");
        DDorder.DataSource = Dtt;
        DDorder.DataBind();

    }
    protected void Button1_Click(object sender, EventArgs e)
    {


          Cnn.Open();
        for (int i = 0; i < LstActive.Items.Count; i++)
        {
            TextBox TxtQty = LstActive.Items[i].FindControl("Txtbox") as TextBox;
            Label lblstock = LstActive.Items[i].FindControl("lblstock") as Label;
          
            Label lblDispatchQuantity = LstActive.Items[i].FindControl("lblDispatchQuantity") as Label;
            Label lblshadeid = LstActive.Items[i].FindControl("lblshadeid") as Label;  
            

            int id = Convert.ToInt32(Cnn.ExecuteScalar("Select  IsNull(Max(id)+1,1) From [OrderDispatchDetails]"));
            Cnn.ExecuteNonQuery("insert into OrderDispatchDetails (id,OrderId,ShadeId,LrNo,Quantity) values ('" + id + "','"+DDorder.SelectedValue+"','" + lblshadeid.Text + "','" + Txtlrno.Text + "','" + TxtQty.Text + "')");
            Cnn.ExecuteNonQuery("update TrnOrderDetail set DispatchQuantity=DispatchQuantity+" + TxtQty.Text + " where OrderId='" + DDorder.SelectedValue + "' and ShadeId='" + lblshadeid.Text + "'");


            TotalQuantity += Convert.ToInt32(TxtQty.Text);
        }
    
        
               // TotalQuantity



        ////
        Cnn.Open();

        int TotalQuantitys = 0, TotalDiascths = 0, AgainQuantity=0;

        TotalQuantitys = Convert.ToInt32(Cnn.ExecuteScalar("Select   SUM(Quantity) From [TrnOrderDetail] where OrderId='" + DDorder.SelectedValue + "'"));
        TotalDiascths = Convert.ToInt32(Cnn.ExecuteScalar("Select   SUM(DispatchQuantity) From [TrnOrderDetail] where OrderId='" + DDorder.SelectedValue + "'"));
        AgainQuantity = TotalQuantitys - TotalDiascths;

        int ID = Convert.ToInt32(Cnn.ExecuteScalar("Select  IsNull(Max(Id)+1,1) From [OrderDispatch]"));
        int userid = Convert.ToInt32(Cnn.ExecuteScalar("Select UserId  From [TrnOrderMain] where InvoiceNo='" + DDorder.SelectedItem + "'"));
        Cnn.ExecuteNonQuery("INSERT INTO [OrderDispatch] (Id,OrderId,UserId,InvoiceNo,Quantity,Amount,TransPortName,LrNo,AgainQuantity) values ('" + ID + "','" + DDorder.SelectedValue + "','" + userid + "','" + txtinvoice.Text.Trim().Replace("'", "''") + "','" + TotalQuantity + "','" + Txtamt.Text.Trim().Replace("'", "''") + "','" + Txttranport.Text.Trim() + "','" + Txtlrno.Text.Trim().Replace("'", "''") + "','" + AgainQuantity + "')");

        LblErr.Text = "Success !!!";
        Cnn.Close();



        clear();
        list();
        ShowMessage("Record submitted successfully", MessageType.Success);

        listbox.Visible = false;
    }


    public void clear()
    {
    

        Txtamt.Text = "";
        txtinvoice.Text = "";
        Txtlrno.Text = "";
     
        Txttranport.Text = "";
    }
    protected void ShowMessage(string Message, MessageType type)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('" + Message + "','" + type + "');", true);
    }
    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {



    }


    protected void DDorder_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cnn.Open();
        DataTable Dtt = Cnn.FillTable("select distinct Shadeid,DispatchQuantity,OrderId,ProductId from TrnOrderDetail where OrderID='" + DDorder.SelectedValue + "' ", "Detail");
        LstActive.DataSource = Dtt;
        LstActive.DataBind();
        Cnn.Close();
        listbox.Visible = true;

     
    }
    protected void Txtbox_TextChanged(object sender, EventArgs e)
    {
        Cnn.Open();
        for (int i = 0; i < LstActive.Items.Count; i++)
        {
            TextBox TxtQty = LstActive.Items[i].FindControl("Txtbox") as TextBox;
            Label lblstock = LstActive.Items[i].FindControl("lblstock") as Label;
            Label lblmsg = LstActive.Items[i].FindControl("lblMsg") as Label;
            Label lblDispatchQuantity = LstActive.Items[i].FindControl("lblDispatchQuantity") as Label;
            Label lblshadeid = LstActive.Items[i].FindControl("lblshadeid") as Label;

            decimal lblstock1 = 0;
            lblstock1 = Convert.ToDecimal(Cnn.ExecuteScalar("select sum(Quantity) as Quantity from TrnOrderDetail  where OrderID='" + DDorder.SelectedValue + "' and ShadeId='" + lblshadeid.Text + "'"));
            lblmsg.Text = "";
            if (TxtQty.Text != "")
            {
                if (Convert.ToDecimal(TxtQty.Text) > lblstock1)
                {
                    lblmsg.Text = "Maximum Dispatch Quantity exceeded !!! ";
                    lblmsg.Visible = true;


                    //  SetFocus(TxtQty.Text);
                    return;

                    //   ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "alert('Quantity Can't be greater than Available Stock.')", true);
                }
            }



        }
        Cnn.Close();
    }
}