<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="OrderProductDetails.aspx.cs" Inherits="OrderProductDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .mycheckbox input[type="checkbox"] {
            margin-right: 9px;
        }

        /*--------------Dynamic Show-----------*/
        .greenRow {
            color: #018636;
        }

        .redRow {
            color: #f00;
        }

        .yellowRow {
            color: #F0770E;
        }
    </style>
    <script>
        function getNextElement(field) {
            var form = field.form;
            for (var e = 0; e < form.elements.length; e++) {
                if (field == form.elements[e]) {
                    break;
                }
            }
            return form.elements[++e % form.elements.length];
        }

        function tabOnEnter(field, evt) {
            if (evt.keyCode === 13) {
                if (evt.preventDefault) {
                    evt.preventDefault();
                } else if (evt.stopPropagation) {
                    evt.stopPropagation();
                } else {
                    evt.returnValue = false;
                }
                getNextElement(field).focus();
                return false;
            } else {
                return true;
            }
        }</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="messagealert" id="alert_container">
    </div>


    <div class="content-wrapper">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h1 class="page-head-line">Order Product Details</h1>
                </div>
            </div>
            <div class="row">

                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Order Product Details
                        </div>
                        <div class="panel-body">
                            <div class="row" runat="server" id="imglist">
                                <div id="DivProducts" runat="server">
                                    <div class="form-group row">
                                        <label class="col-lg-2 col-form-label">Status :</label>
                                        <div class="col-lg-2">
                                            <asp:DropDownList ID="DDStatus" runat="server" class="form-control">
                                                <asp:ListItem Text="ALL" Value="0"></asp:ListItem>
                                                <asp:ListItem Text="Pending" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="Cancelled" Value="2"></asp:ListItem>
                                                <asp:ListItem Text="Returned" Value="3"></asp:ListItem>
                                                <asp:ListItem Text="Delivered" Value="4"></asp:ListItem>
                                                <asp:ListItem Text="Dispatched" Value="5"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>

                                        <div class="col-lg-2">
                                            <asp:Button runat="server" ID="BtnSearch" Text="Search" class="btn btn-success" OnClick="BtnSearch_Click" />
                                            <asp:Button ID="BtnBack" Text="Back" runat="server" OnClick="BtnBack_Click" Class="btn btn-danger" Style="float: right" />

                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-5"></div>
                                        <div class="col-md-3">
                                            <asp:Label ID="LblOrderId" runat="server" Style="color: dimgray; font-size: 20px"></asp:Label>
                                        </div>
                                        <div class="col-md-4"></div>
                                    </div>

                                </div>
                                <br />
                                <div class="table-responsive">
                                    <table class="table table-striped table-bordered table-hover">
                                        <asp:ListView ID="LstOrder" runat="server" OnItemCommand="LstOrder_ItemCommand"
                                            OnItemDataBound="LstOrder_ItemDataBound">
                                            <LayoutTemplate>
                                                <tr>
                                                    <td>
                                                        <b>Invoice No</b>
                                                    </td>
                                                    <td>
                                                        <b>Image</b>
                                                    </td>
                                                    <td>
                                                        <b>Product Name</b>
                                                    </td>

                                                    <td>
                                                        <b>Quantity</b>
                                                    </td>
                                                    <td>
                                                        <b>Net Amount</b>
                                                    </td>
                                                    <td>
                                                        <b>Status</b>
                                                    </td>
                                                    <%--<td></td>--%>
                                                </tr>
                                                <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                                            </LayoutTemplate>
                                            <ItemTemplate>

                                                <asp:Label ID="LblOrderId" runat="server" Visible="false" Text='<%#Eval("OrderId") %>'></asp:Label>
                                                <asp:Label ID="LblAID" runat="server" Visible="false" Text='<%#Eval("AID") %>'></asp:Label>

                                                <tr class="<%#Convert.ToString(setclass(Convert.ToString(Eval("Status")))) %>">

                                                    <td>
                                                        <asp:Label Text='<%# Eval("DisInvoiceNo")%>' runat="server" ID="LblInvoiceNo"></asp:Label>
                                                    </td>
                                                    <td>

                                                        <img src="../img/product/<%# Eval("Image")%>" height="50px" width="50px" />
                                                    </td>
                                                    <td>
                                                        <%# Eval("ProductName")%>
                                                    </td>

                                                    <td>
                                                        <%# Eval("Quantity") %>
                                                    </td>
                                                    <td>
                                                        <%# Eval("NetAmount") %>
                                                    </td>
                                                    <td>
                                                        <%# Eval("Status") %>
                                                    </td>
                                                  <%--  <td>
                                                        <asp:LinkButton ID="LnkDeliver" runat="server" Font-Bold="true" CommandName="EdDeliver">Deliver</asp:LinkButton></td>
                                                    <td>
                                                        <asp:LinkButton ID="LnkDispatch" runat="server" Font-Bold="true" CommandName="EdDispatch">Dispatch</asp:LinkButton></td>
                                                    <td>
                                                        <asp:LinkButton ID="LnkReturn" runat="server" Font-Bold="true" CommandName="EdReturn">Return</asp:LinkButton></td>
                                                    <td>
                                                        <asp:LinkButton ID="LnkCancel" runat="server" Font-Bold="true" CommandName="EdCancel">Cancel</asp:LinkButton></td>--%>
                                                </tr>

                                            </ItemTemplate>

                                        </asp:ListView>

                                    </table>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

