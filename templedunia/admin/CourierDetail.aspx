<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="CourierDetail.aspx.cs" Inherits="CourierDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="messagealert" id="alert_container">
    </div>


    <div class="content-wrapper">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h1 class="page-head-line">Courier Details</h1>
                </div>
            </div>
            <div class="row">

                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Courier Details
                        </div>
                        <div class="panel-body">


                            <div class="row" runat="server" id="imglist">
                                <div class="table-responsive">
                                    <asp:Panel ID="PnlProduct" runat="server">
                                       <%-- <div style="padding-left: 15px; padding-bottom: 5px;">
                                            <strong><span style="font-size: 14pt; color: Purple">Courier Details</span></strong>
                                        </div>--%>
                                        <table class="cart_in" width="100%" border="1">
                                            <asp:ListView ID="LstCourierdetails" runat="server" DataSourceID="srcCourierDetails" OnItemCommand="LstCourierdetails_ItemCommand" OnItemEditing="LstCourierdetails_ItemEditing"
                                                OnItemUpdating="LstCourierdetails_ItemUpdating" OnItemDataBound="LstCourierdetails_ItemDataBound">
                                                <LayoutTemplate>
                                                    <tr style="height: 35px; font-weight: bold;"
                                                        align="center">
                                                        <td style="width: 30px;">Sno
                                                        </td>
                                                        <td style="width: 80px;">FromWeight
                                        <br />
                                                            <hr />
                                                            <asp:LinkButton ID="lnkFCEdit" runat="server" CommandName="ChkFCWEdit" Text="Edit" Font-Bold="true" ForeColor="#ff0000"></asp:LinkButton>
                                                            <asp:LinkButton ID="lnlFCUpdate" runat="server" CommandName="ChkFCWUpdate" Text="Update" Font-Bold="true" ForeColor="#ff0000"></asp:LinkButton>
                                                        </td>
                                                        <td style="width: 80px;">ToWeight
                                        <br />
                                                            <hr />
                                                            <asp:LinkButton ID="lnkTWEdit" runat="server" CommandName="ChkFCTEdit" Text="Edit" Font-Bold="true" ForeColor="#ff0000"></asp:LinkButton>
                                                            <asp:LinkButton ID="lnkTWUpdate" runat="server" CommandName="ChkFCTUpdate" Text="Update" Font-Bold="true" ForeColor="#ff0000"></asp:LinkButton>
                                                        </td>
                                                        <td style="width: 60px;">Unit
                                                        </td>
                                                        <td style="width: 85px;">Raj. Courier Fees
                                         <br />
                                                            <hr />
                                                            <asp:LinkButton ID="lnkRCfedit" runat="server" CommandName="ChkRCfedit" Text="Edit" Font-Bold="true" ForeColor="#ff0000"></asp:LinkButton>
                                                            <asp:LinkButton ID="lnkRCfUpdate" runat="server" CommandName="ChkRCfUpdate" Text="Update" Font-Bold="true" ForeColor="#ff0000"></asp:LinkButton>
                                                        </td>
                                                        <td style="width: 70px;">with in Rajasthan
                                                        </td>
                                                        <td style="width: 80px;">North India Fees
                                        <br />
                                                            <hr />
                                                            <asp:LinkButton ID="lnkNIFedit" runat="server" CommandName="ChkNIFedit" Text="Edit" Font-Bold="true" ForeColor="#ff0000"></asp:LinkButton>
                                                            <asp:LinkButton ID="lnkNIFUpdate" runat="server" CommandName="ChkNIFupdate" Text="Update" Font-Bold="true" ForeColor="#ff0000"></asp:LinkButton>
                                                        </td>
                                                        <td style="width: 80px;">North India
                                                        </td>
                                                        <td style="width: 80px;">Rest of India Fees
                                        <br />
                                                            <hr />
                                                            <asp:LinkButton ID="lnkROIFedit" runat="server" CommandName="ChkROIFedit" Text="Edit" Font-Bold="true" ForeColor="#ff0000"></asp:LinkButton>
                                                            <asp:LinkButton ID="lnkROIFupdate" runat="server" CommandName="ChkROIFUpdate" Text="Update" Font-Bold="true" ForeColor="#ff0000"></asp:LinkButton>
                                                        </td>
                                                        <td style="width: 80px;">Rest of India
                                                        </td>
                                                        <td style="width: 80px;">North East Fees
                                        <br />
                                                            <hr />
                                                            <asp:LinkButton ID="lnkNEFedit" runat="server" CommandName="ChkNEFedit" Text="Edit" Font-Bold="true" ForeColor="#ff0000"></asp:LinkButton>
                                                            <asp:LinkButton ID="lnkNEFUpdate" runat="server" CommandName="ChkNEFupdate" Text="Update" Font-Bold="true" ForeColor="#ff0000"></asp:LinkButton>
                                                        </td>
                                                        <td style="width: 80px;">North East
                                                        </td>
                                                        <td style="width: 50px;"></td>
                                                    </tr>
                                                    <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                                                </LayoutTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="LblId" runat="server" Visible="false" Text='<%#Eval("Id") %>'></asp:Label>
                                                    <tr style="height: 30px;" align="center">
                                                        <td align="center">
                                                            <%#Container.DataItemIndex+1 %>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblFW" runat="server" Text='<%#Eval("FromWeight") %>' Visible="true" ToolTip="Click to change From Weight"></asp:Label>
                                                            <asp:TextBox ID="txtallFW" runat="server" Visible="false" Width="50px" Text=' <%# Eval("FromWeight") %>' BorderStyle="Solid" BackColor="#FFFFD9"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblTW" runat="server" Text='<%#Eval("ToWeight") %>' Visible="true" ToolTip="Click to change To Weight"></asp:Label>
                                                            <asp:TextBox ID="txtallTW" runat="server" Visible="false" Width="50px" Text=' <%# Eval("ToWeight") %>' BorderStyle="Solid" BackColor="#FFFFD9"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label5" runat="server" Text='<%#Eval("Unit") %>'></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblAllrajfees" runat="server" Text='<%#Eval("RajCourier_Fees") %>' Visible="true" ToolTip="Click to change Rajasthan Courier Fees"></asp:Label>
                                                            <asp:TextBox ID="txtallRajFees" runat="server" Visible="false" Width="50px" Text=' <%# Eval("RajCourier_Fees") %>' BorderStyle="Solid" BackColor="#FFFFD9"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label7" runat="server" Text='<%#Eval("RajCourier_Name") %>'></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="LblNIf" runat="server" Text='<%#Eval("NICourier_Fees") %>' Visible="true" ToolTip="Click to change North Courier Fees"></asp:Label>
                                                            <asp:TextBox ID="txtallNIf" runat="server" Visible="false" Width="50px" Text=' <%# Eval("NICourier_Fees") %>' BorderStyle="Solid" BackColor="#FFFFD9"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label1" runat="server" Text='<%#Eval("NICourier_Name") %>'></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblAllRoIF" runat="server" Text='<%#Eval("ROICourier_Fees") %>' Visible="true" ToolTip="Click to change Rest of India Courier Fees"></asp:Label>
                                                            <asp:TextBox ID="txtAllROIf" runat="server" Width="50px" Visible="false" Text=' <%# Eval("NICourier_Fees") %>' BorderStyle="Solid" BackColor="#FFFFD9"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label10" runat="server" Text='<%#Eval("ROICourier_Name") %>'></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblAllNEf" runat="server" Text='<%#Eval("NECourier_Fees") %>' Visible="true" ToolTip="Click to change North East Courier Fees"></asp:Label>
                                                            <asp:TextBox ID="txtAllNEF" runat="server" Visible="false" Width="50px" Text=' <%# Eval("NICourier_Fees") %>' BorderStyle="Solid" BackColor="#FFFFD9"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label12" runat="server" Text='<%#Eval("NECourier_Name") %>'></asp:Label>
                                                        </td>
                                                        <td style="padding: 10px 0px; text-align: center; font-weight: bold;">
                                                            <asp:LinkButton ID="LnkBtnEdit" runat="server" CommandName="Edit" Font-Bold="true" ForeColor="Red">Edit</asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:Label ID="LblId" runat="server" Visible="false" Text='<%#Eval("Id") %>'></asp:Label>
                                                    <tr style="height: 30px; background-color: #fffdfd; color: #000000;" align="center">
                                                        <td align="center">
                                                            <%#Container.DataItemIndex+1 %>
                                                        </td>
                                                        <td style="width: 60px;">
                                                            <asp:TextBox ID="txtfromweight" runat="server" Width="50px" Text=' <%# Eval("FromWeight") %>' BorderStyle="Solid" BackColor="#FFFFD9"></asp:TextBox>
                                                        </td>
                                                        <td style="width: 60px;">
                                                            <asp:TextBox ID="txttoweight" runat="server" Width="50px" Text=' <%# Eval("ToWeight") %>' BorderStyle="Solid" BackColor="#FFFFD9"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label5" runat="server" Text='<%#Eval("Unit") %>'></asp:Label>
                                                        </td>
                                                        <td style="width: 60px;">
                                                            <asp:TextBox ID="txtRajCFees" runat="server" Width="50px" Text=' <%# Eval("RajCourier_Fees") %>' BorderStyle="Solid" BackColor="#FFFFD9"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblRajCname" runat="server" Text='<%#Eval("RajCourier_Name") %>'></asp:Label>
                                                        </td>
                                                        <td style="width: 60px;">
                                                            <asp:TextBox ID="txtNICFees" runat="server" Width="50px" Text=' <%# Eval("NICourier_Fees") %>' BorderStyle="Solid" BackColor="#FFFFD9"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblNICname" runat="server" Text='<%#Eval("NICourier_Name") %>'></asp:Label>
                                                        </td>
                                                        <td style="width: 60px;">
                                                            <asp:TextBox ID="txtROICFees" runat="server" Width="50px" Text=' <%# Eval("ROICourier_Fees") %>' BorderStyle="Solid" BackColor="#FFFFD9"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblROIName" runat="server" Text='<%#Eval("ROICourier_Name") %>'></asp:Label>
                                                        </td>
                                                        <td style="width: 60px;">
                                                            <asp:TextBox ID="txtNECName" runat="server" Width="50px" Text=' <%# Eval("NECourier_Fees") %>' BorderStyle="Solid" BackColor="#FFFFD9"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblNECName" runat="server" Text='<%#Eval("NECourier_Name") %>'></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:LinkButton ID="LnkBtnEdit" runat="server" CommandName="Update" Font-Bold="true" ForeColor="red">Update</asp:LinkButton>
                                                            <asp:LinkButton ID="LnkBtnListUpdate" runat="server" CommandName="Cancel" Font-Bold="true" ForeColor="red">Cancel</asp:LinkButton><br />
                                                        </td>

                                                    </tr>
                                                </EditItemTemplate>
                                            </asp:ListView>
                                            <asp:SqlDataSource ID="srcCourierDetails" runat="server" ConnectionString="<%$ ConnectionStrings:DigitalMobiz%>"
                                                CancelSelectOnNullParameter="false" SelectCommand="select * from Courier_Detailn------;" UpdateCommand=" "></asp:SqlDataSource>
                                        </table>
                                    </asp:Panel>
                                </div>
                            </div>
                            <hr />
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>

