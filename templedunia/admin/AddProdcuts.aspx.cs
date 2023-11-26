using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddProdcuts : System.Web.UI.Page
{

    ClsConnection Cnn = new ClsConnection();
    public enum MessageType { Success, Error, Info, Warning};
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
        DataTable dt = Cnn.FillTable("select * from [M_ProductMaster] where ActiveStatus=1 order by ProductId desc", "Detail");
        lSTProducts.DataSource = dt;
        lSTProducts.DataBind();

        DataTable Dtt = Cnn.FillTable("Select 'MainCategoryId'=-1,'MainCategoryName'='<--Select Main Category-->' union  select MainCategoryId,MainCategoryName from M_CategoryMaster where  ActiveStatus=1", "Detail");
        DDMainCategory.DataSource = Dtt;
        DDMainCategory.DataBind();

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        ////update
        if (Button1.Text == "Update")
        {

            Cnn.Open();
            Cnn.ExecuteNonQuery("update [M_ProductMaster] set ProductName='" + Txtproducts.Text.Replace("'", "''") + "',Blend='" + Txtblend.Text.Replace("'", "''") + "',Width='" + TxtWidth.Text.Replace("'", "''") + "',Rate='" + Txtrate.Text.Replace("'", "''") + "',Remark='" + Txtdescription.Text.Replace("'", "''") + "',Weight='" + TxtWeight.Text + "',CategoryId='" + DDMainCategory.SelectedValue + "',SubCategoryId='" + DDSub.SelectedValue + "',Lump='" + Txtlump.Text.Trim() + "',Than='" + Txtthan.Text.Trim() + "',Piece='" + TxtPiece.Text.Trim() + "',Multi='" + Txtmulti.Text.Trim() + "' where ProductId='" + LblId.Value + "' ");
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
            int ID = Convert.ToInt32(Cnn.ExecuteScalar("Select  IsNull(Max(ProductId)+1,1) From [M_ProductMaster]"));
            Cnn.ExecuteNonQuery("INSERT INTO [M_ProductMaster] (CategoryId,SubCategoryId,ProductId,ProductName,Blend,Width,Weight,Remark,Rate,Lump,Than,Piece,Multi) values ('" + DDMainCategory.SelectedValue + "','" + DDSub.SelectedValue + "','" + ID + "','" + Txtproducts.Text.Trim().Replace("'", "''") + "','" + Txtblend.Text.Trim().Replace("'", "''") + "','" + TxtWidth.Text.Trim().Replace("'", "''") + "','" + TxtWeight.Text.Trim() + "','" + Txtdescription.Text.Trim().Replace("'", "''") + "','" + Txtrate.Text.Trim().Replace("'", "''") + "','" + Txtlump.Text.Trim().Replace("'", "''") + "','" + Txtthan.Text.Trim().Replace("'", "''") + "','" + TxtPiece.Text.Trim().Replace("'", "''") + "','" + Txtmulti.Text.Trim().Replace("'", "''") + "',)");
            LblErr.Text = "Success !!!";
            Cnn.Close();
            clear();
            list();
            ShowMessage("Record submitted successfully", MessageType.Success);
        }
    }

    public void clear()
    {
        Txtproducts.Text = "";
        Txtblend.Text = "";
        TxtWidth.Text = "";
        Txtrate.Text = "";
        Txtdescription.Text = "";
        TxtWeight.Text = "";
        DDMainCategory.SelectedIndex = 0;
        DDSub.SelectedIndex = 0;
    }
    protected void ShowMessage(string Message, MessageType type)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('" + Message + "','" + type + "');", true);
    }
    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "del")
        {
            LblId.Value = ((HiddenField)e.Item.FindControl("HdnID")).Value;
            Cnn.Open();
            Cnn.ExecuteNonQuery("delete from [M_CategoryMaster] where id='" + LblId.Value + "'");
            list();
            ShowMessage("Record Delete successfully", MessageType.Success);
            Cnn.Close();
            //   string id = ((HiddenField)LstDay.Items[j].FindControl("HdnID")).Value;
            //  Cnn.ExecuteNonQuery("update Poster set  Active=0 where Id='" + LblId.Value + "'");
        }
        if (e.CommandName == "Edt")
        {
            LblId.Value = ((HiddenField)e.Item.FindControl("HdnID")).Value;
            Txtblend.Text = ((Label)e.Item.FindControl("lblBlend")).Text;
            TxtWidth.Text = ((Label)e.Item.FindControl("lblWidth")).Text;
            Txtrate.Text = ((Label)e.Item.FindControl("lblRate")).Text;
            Txtdescription.Text = ((Label)e.Item.FindControl("lblRemark")).Text;
            TxtWeight.Text = ((Label)e.Item.FindControl("lblWeight")).Text;
            Txtlump.Text = ((Label)e.Item.FindControl("lblLump")).Text;
            Txtthan.Text = ((Label)e.Item.FindControl("lblThan")).Text;
            TxtPiece.Text = ((Label)e.Item.FindControl("lblPiece")).Text;
            Txtmulti.Text = ((Label)e.Item.FindControl("lblMulti")).Text;
            Txtproducts.Text = ((Label)e.Item.FindControl("lblProductName")).Text;
            string MainCategoryId = ((Label)e.Item.FindControl("lblCategoryId")).Text;
            string SubCategoryId = ((Label)e.Item.FindControl("lblsubid")).Text;
            DataTable Dtt = Cnn.FillTable("Select 'MainCategoryId'=-1,'MainCategoryName'='<--Select Main Category-->' union  select MainCategoryId,MainCategoryName from M_CategoryMaster where  ActiveStatus=1", "Detail");
            DDMainCategory.DataSource = Dtt;
            DDMainCategory.DataBind();
            DDMainCategory.SelectedValue = MainCategoryId;
            DataTable DTTT = Cnn.FillTable("Select 'Id'=-1,'SubCategoryName'='Select Sub-Category' union  select id,SubCategoryName from SubCategory where  ActiveStatus=1 and MainCategoryId='" + MainCategoryId + "'", "Detail");
            DDSub.DataSource = DTTT;
            DDSub.DataBind();
            DDSub.SelectedValue = SubCategoryId;
            Button1.Text = "Update";


            Cnn.Open();
        }
    }


    protected void DDMainCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataTable Dtt = Cnn.FillTable("Select 'Id'=-1,'SubCategoryName'='Select Sub-Category' union  select id,SubCategoryName from SubCategory where  ActiveStatus=1 and MainCategoryId='" + DDMainCategory.SelectedValue + "'", "Detail");
        DDSub.DataSource = Dtt;
        DDSub.DataBind();
    }
}