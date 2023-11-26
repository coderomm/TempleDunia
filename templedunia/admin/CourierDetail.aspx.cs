using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Security;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.IO;

public partial class CourierDetail : System.Web.UI.Page
{
    ClsConnection Cnn = new ClsConnection();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Admin_id"] == null)
        {
            Response.Redirect("superlogin.aspx");
        }
    }
    protected void LstCourierdetails_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        //******************************From Weight**************************************
        if (e.CommandName == "ChkFCWEdit")
        {
            Cnn.Open();
            try
            {
                foreach (ListViewItem myListViewItem in LstCourierdetails.Items)
                {
                    //****************************************************************************
                    Label templbl = myListViewItem.FindControl("lblFW") as Label;
                    templbl.Visible = false;

                    TextBox temptt = myListViewItem.FindControl("txtallFW") as TextBox;
                    temptt.Visible = true;

                    temptt.Text = templbl.Text;
                }
            }
            catch (SqlException ex)
            {
                Response.Write(ex.Message);
            }
            Cnn.Open();
        }
        if (e.CommandName == "ChkFCWUpdate")
        {
            Cnn.Open();
            try
            {
                string Id = "";
                string FCW = "";
                foreach (ListViewItem myListViewItem in LstCourierdetails.Items)
                {
                    Label id = myListViewItem.FindControl("LblId") as Label;
                    TextBox tempFW = myListViewItem.FindControl("txtallFW") as TextBox;
                    Id = id.Text;
                    FCW = tempFW.Text;
                    srcCourierDetails.UpdateCommand = "Update Courier_Detailn set FromWeight='" + FCW.Replace("'", "''") + "' where Id='" + Id + "'";
                    srcCourierDetails.Update();
                    Id = "";
                    FCW = "";
                }
            }
            catch (SqlException ex)
            {
                Response.Write(ex.Message);
            }
            Cnn.Close();
        }
        //******************************TO Weight**************************************
        if (e.CommandName == "ChkFCTEdit")
        {
            Cnn.Open();
            try
            {
                foreach (ListViewItem myListViewItem in LstCourierdetails.Items)
                {
                    //****************************************************************************
                    Label templbl = myListViewItem.FindControl("lblTW") as Label;
                    templbl.Visible = false;

                    TextBox temptt = myListViewItem.FindControl("txtallTW") as TextBox;
                    temptt.Visible = true;

                    temptt.Text = templbl.Text;
                }
            }
            catch (SqlException ex)
            {
                Response.Write(ex.Message);
            }
            Cnn.Open();
        }
        if (e.CommandName == "ChkFCTUpdate")
        {
            Cnn.Open();
            try
            {
                string Id = "";
                string TCW = "";
                foreach (ListViewItem myListViewItem in LstCourierdetails.Items)
                {
                    Label id = myListViewItem.FindControl("LblId") as Label;
                    TextBox tempFW = myListViewItem.FindControl("txtallTW") as TextBox;
                    Id = id.Text;
                    TCW = tempFW.Text;
                    srcCourierDetails.UpdateCommand = "Update Courier_detailn set ToWeight='" + TCW.Replace("'", "''") + "' where Id='" + Id + "'";
                    srcCourierDetails.Update();
                    Id = "";
                    TCW = "";
                }
            }
            catch (SqlException ex)
            {
                Response.Write(ex.Message);
            }
            Cnn.Close();
        }

        //******************************Raj. Courier Fees**************************************
        if (e.CommandName == "ChkRCfedit")
        {
            Cnn.Open();
            try
            {
                foreach (ListViewItem myListViewItem in LstCourierdetails.Items)
                {
                    //****************************************************************************
                    Label templbl = myListViewItem.FindControl("lblAllrajfees") as Label;
                    templbl.Visible = false;

                    TextBox temptt = myListViewItem.FindControl("txtallRajFees") as TextBox;
                    temptt.Visible = true;

                    temptt.Text = templbl.Text;
                }
            }
            catch (SqlException ex)
            {
                Response.Write(ex.Message);
            }
            Cnn.Open();
        }
        if (e.CommandName == "ChkRCfUpdate")
        {
            Cnn.Open();
            try
            {
                string Id = "";
                string RajCF = "";
                foreach (ListViewItem myListViewItem in LstCourierdetails.Items)
                {
                    Label id = myListViewItem.FindControl("LblId") as Label;
                    TextBox tempFW = myListViewItem.FindControl("txtallRajFees") as TextBox;
                    Id = id.Text;
                    RajCF = tempFW.Text;
                    srcCourierDetails.UpdateCommand = "Update Courier_detailn set RajCourier_Fees='" + RajCF.Replace("'", "''") + "' where Id='" + Id + "'";
                    srcCourierDetails.Update();
                    Id = "";
                    RajCF = "";
                }
            }
            catch (SqlException ex)
            {
                Response.Write(ex.Message);
            }
            Cnn.Close();
        }
        //******************************North India Fees**************************************
        if (e.CommandName == "ChkNIFedit")
        {
            Cnn.Open();
            try
            {
                foreach (ListViewItem myListViewItem in LstCourierdetails.Items)
                {
                    //****************************************************************************
                    Label templbl = myListViewItem.FindControl("LblNIf") as Label;
                    templbl.Visible = false;

                    TextBox temptt = myListViewItem.FindControl("txtallNIf") as TextBox;
                    temptt.Visible = true;

                    temptt.Text = templbl.Text;
                }
            }
            catch (SqlException ex)
            {
                Response.Write(ex.Message);
            }
            Cnn.Open();
        }
        if (e.CommandName == "ChkNIFupdate")
        {
            Cnn.Open();
            try
            {
                string Id = "";
                string NICF = "";
                foreach (ListViewItem myListViewItem in LstCourierdetails.Items)
                {
                    Label id = myListViewItem.FindControl("LblId") as Label;
                    TextBox tempFW = myListViewItem.FindControl("txtallNIf") as TextBox;
                    Id = id.Text;
                    NICF = tempFW.Text;
                    srcCourierDetails.UpdateCommand = "Update Courier_detailn set NICourier_Fees='" + NICF.Replace("'", "''") + "' where Id='" + Id + "'";
                    srcCourierDetails.Update();
                    Id = "";
                    NICF = "";
                }
            }
            catch (SqlException ex)
            {
                Response.Write(ex.Message);
            }
            Cnn.Close();
        }
        //******************************Rest Of India Fees**************************************
        if (e.CommandName == "ChkROIFedit")
        {
            Cnn.Open();
            try
            {
                foreach (ListViewItem myListViewItem in LstCourierdetails.Items)
                {
                    //****************************************************************************
                    Label templbl = myListViewItem.FindControl("lblAllRoIF") as Label;
                    templbl.Visible = false;

                    TextBox temptt = myListViewItem.FindControl("txtAllROIf") as TextBox;
                    temptt.Visible = true;

                    temptt.Text = templbl.Text;
                }
            }
            catch (SqlException ex)
            {
                Response.Write(ex.Message);
            }
            Cnn.Open();
        }
        if (e.CommandName == "ChkROIFUpdate")
        {
            Cnn.Open();
            try
            {
                string Id = "";
                string NICF = "";
                foreach (ListViewItem myListViewItem in LstCourierdetails.Items)
                {
                    Label id = myListViewItem.FindControl("LblId") as Label;
                    TextBox tempFW = myListViewItem.FindControl("txtAllROIf") as TextBox;
                    Id = id.Text;
                    NICF = tempFW.Text;
                    srcCourierDetails.UpdateCommand = "Update Courier_detailn set ROICourier_Fees='" + NICF.Replace("'", "''") + "' where Id='" + Id + "'";
                    srcCourierDetails.Update();
                    Id = "";
                    NICF = "";
                }
            }
            catch (SqlException ex)
            {
                Response.Write(ex.Message);
            }
            Cnn.Close();
        }
        //******************************North East Fees**************************************
        if (e.CommandName == "ChkNEFedit")
        {
            Cnn.Open();
            try
            {
                foreach (ListViewItem myListViewItem in LstCourierdetails.Items)
                {
                    //****************************************************************************
                    Label templbl = myListViewItem.FindControl("lblAllNEf") as Label;
                    templbl.Visible = false;

                    TextBox temptt = myListViewItem.FindControl("txtAllNEF") as TextBox;
                    temptt.Visible = true;

                    temptt.Text = templbl.Text;
                }
            }
            catch (SqlException ex)
            {
                Response.Write(ex.Message);
            }
            Cnn.Open();
        }
        if (e.CommandName == "ChkNEFupdate")
        {
            Cnn.Open();
            try
            {
                string Id = "";
                string NICF = "";
                foreach (ListViewItem myListViewItem in LstCourierdetails.Items)
                {
                    Label id = myListViewItem.FindControl("LblId") as Label;
                    TextBox tempFW = myListViewItem.FindControl("txtAllNEF") as TextBox;
                    Id = id.Text;
                    NICF = tempFW.Text;
                    srcCourierDetails.UpdateCommand = "Update Courier_detailn set NECourier_Fees='" + NICF.Replace("'", "''") + "' where Id='" + Id + "'";
                    srcCourierDetails.Update();
                    Id = "";
                    NICF = "";
                }
            }
            catch (SqlException ex)
            {
                Response.Write(ex.Message);
            }
            Cnn.Close();
        }
    }
    protected void LstCourierdetails_ItemEditing(object sender, ListViewEditEventArgs e)
    {

    }
    protected void LstCourierdetails_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {
        try
        {
            Cnn.BeginTrans();
            string ID = ((Label)LstCourierdetails.Items[e.ItemIndex].FindControl("LblId")).Text;
            string FromWeight = ((TextBox)LstCourierdetails.Items[e.ItemIndex].FindControl("txtfromweight")).Text;
            string ToWeight = ((TextBox)LstCourierdetails.Items[e.ItemIndex].FindControl("txttoweight")).Text;
            string RajCfees = ((TextBox)LstCourierdetails.Items[e.ItemIndex].FindControl("txtRajCFees")).Text;
            string NICfees = ((TextBox)LstCourierdetails.Items[e.ItemIndex].FindControl("txtNICFees")).Text;
            string ROIFees = ((TextBox)LstCourierdetails.Items[e.ItemIndex].FindControl("txtROICFees")).Text;
            string NEFees = ((TextBox)LstCourierdetails.Items[e.ItemIndex].FindControl("txtNECName")).Text;

            Cnn.ExecuteNonQuery("Update Courier_detailn set FromWeight='" + FromWeight + "',ToWeight='" + ToWeight + "',RajCourier_Fees='" + RajCfees + "',NICourier_Fees='" + NICfees + "',ROICourier_Fees='" + ROIFees + "',NECourier_Fees='" + NEFees + "' where Id='" + ID + "'");

            Cnn.CommitTrans();
            LstCourierdetails.DataBind();
        }
        catch (SqlException ex)
        {
            Cnn.RollBackTrans();
        }
    }
    protected void LstCourierdetails_ItemDataBound(object sender, ListViewItemEventArgs e)
    {

    }
}