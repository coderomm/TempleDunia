<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="OrderDetails.aspx.cs" Inherits="OrderDetails" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <style type="text/css">
        .messagealert
        {
            width: 100%;
            top: 0px;
            z-index: 100000;
            padding: 0;
            font-size: 15px;
        }
    </style>
    <style>
        .mycheckbox input[type="checkbox"]
        {
            margin-right: 9px;
        }

        /*--------------Dynamic Show-----------*/
        .greenRow
        {
            color: #018636;
        }

        .redRow
        {
            color: #f00;
        }

        .yellowRow
        {
            color: #F0770E;
        }

        .btn-btn-success
        {
            display: inline-block;
            width: 40px;
            height: 40px;
            line-height: 40px;
            text-align: center;
            background-color: darkgray;
            color: white;
            border: 1px solid #E4E7ED;
            -webkit-transition: 0.2s all;
            transition: 0.2s all;
        }

        .btn-btn-success11
        {
            display: inline-block;
            width: 40px;
            height: 40px;
            line-height: 40px;
            text-align: center;
            background-color: #E4E7ED;
            color: red;
            border: 1px solid #E4E7ED;
            -webkit-transition: 0.2s all;
            transition: 0.2s all;
        }

        .btn-btn-success:hover
        {
            -webkit-transition: 0.2s all;
            transition: 0.2s all;
            background-color: #E4E7ED;
            color: #D10024;
        }

        .btn-btn-success .active
        {
            background-color: #D10024;
            border-color: #000;
            color: #F0770E;
            font-weight: 500;
            cursor: default;
        }

        .btn-btn-success a
        {
            display: block;
        }

        .ajax__calendar_container
        {
            z-index: 1000;
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
    <script type="text/javascript">
        function ShowMessage(message, messagetype) {
            var cssclass;
            switch (messagetype) {
                case 'Success':
                    cssclass = 'alert-success'
                    break;
                case 'Error':
                    cssclass = 'alert-danger'
                    break;
                case 'Warning':
                    cssclass = 'alert-warning'
                    break;
                default:
                    cssclass = 'alert-info'
            }
            $('#alert_container').append('<div id="alert_div" style="margin: 0 0.5%; -webkit-box-shadow: 3px 4px 6px #999;" class="alert fade in ' + cssclass + '"><a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a><strong>' + messagetype + '!</strong> <span>' + message + '</span></div>');
        }
    </script>
    <script type="text/javascript">
        window.setTimeout(function () {
            $("#alert_container").fadeTo(500, 0).slideUp(500, function () {
                $(this).remove();
            });
        }, 4000);
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="messagealert" id="alert_container">
    </div>


    <div class="content-wrapper">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h1 class="page-head-line">Order List </h1>
                </div>
            </div>
            <div class="row">

                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Order List
                        </div>
                        <div class="panel-body">

                            <div class="row">


                                <div class="col-md-3">
                                    <div class="form-group has-success">
                                        <label class="control-label" for="success">From Date</label>
                                        <asp:TextBox ID="TxtFromDate" runat="server" class="form-control"></asp:TextBox>
                                        <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="TxtFromDate" Format="dd/MM/yyyy"></cc1:CalendarExtender>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group has-success">
                                        <label class="control-label" for="success">To Date</label>
                                        <asp:TextBox ID="TxtToDate" runat="server" class="form-control"></asp:TextBox>
                                        <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="TxtToDate" Format="dd/MM/yyyy"></cc1:CalendarExtender>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group has-success">
                                        <label class="control-label" for="success">Status</label>
                                        <asp:DropDownList ID="DDStatus" runat="server" class="form-control">
                                            <asp:ListItem Text="ALL" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Pending" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Cancelled" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Returned" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="Delivered" Value="4"></asp:ListItem>
                                            <asp:ListItem Text="Dispatch" Value="5"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group has-success">
                                        <br />
                                        <asp:Button runat="server" ID="BtnSearch" Text="Search" class="btn btn-success" OnClick="BtnSearch_Click" />
                                    </div>
                                </div>
                            </div>
                        
                            <div class="row" runat="server" id="imglist">
                                <div class="table-responsive">
                                    <table class="table table-striped table-bordered table-hover">
                                        <asp:ListView ID="LstOrder" runat="server" OnItemCommand="LstOrder_ItemCommand" OnPagePropertiesChanging="LstOrder_PagePropertiesChanging"
                                            OnItemDataBound="LstOrder_ItemDataBound">
                                            <LayoutTemplate>
                                                <thead>
                                                    <tr>
                                                        <td>
                                                            <b>Order No</b>
                                                        </td>
                                                        <td>
                                                            <b>Order Date</b>
                                                        </td>
                                                        <td>
                                                            <b>Order Amount</b>
                                                        </td>
                                                        <td>
                                                            <b>Delivery Charges</b>
                                                        </td>
                                                        <td>
                                                            <b>Name</b>
                                                        </td>
                                                        <td>
                                                            <b>Mobile No</b>
                                                        </td>
                                                        <td>
                                                            <b>Status</b>
                                                        </td>

                                                    </tr>
                                                </thead>
                                                <asp:PlaceHolder ID="itemPlaceHolder" runat="server"></asp:PlaceHolder>
                                            </LayoutTemplate>

                                            <ItemTemplate>
                                                <tbody>
                                                      <asp:Label ID="lblStatus" runat="server" Visible="false" Text='<%#Eval("status") %>'></asp:Label>
                                                    <asp:Label ID="LblOrderId" runat="server" Visible="false" Text='<%#Eval("OrderId") %>'></asp:Label>
                                                    <tr class="<%#Convert.ToString(setclass(Convert.ToString(Eval("Status")))) %>">

                                                        <td>
                                                            <asp:Label Text='<%# Eval("OrderId")%>' runat="server" ID="LblInvoiceNo"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <%# Eval("OrderDate")%>
                                                        </td>
                                                        <td>
                                                            <%# Eval("OrderAmount")%>
                                                        </td>
                                                        <td>
                                                            <%# Eval("DeliveryFees")%>
                                                        </td>
                                                        <td>
                                                            <%# Eval("Name") %>
                                                        </td>
                                                        <td>
                                                            <%# Eval("MobileNumber") %>
                                                        </td>
                                                        <td>
                                                            <%# Eval("Status") %>
                                                        </td>
                                                        <td>
                                                            <asp:LinkButton ID="LnkDeliver" runat="server" Font-Bold="true" CommandName="EdDeliver">Deliver</asp:LinkButton></td>
                                                        <td>
                                                            <asp:LinkButton ID="LnkDispatch" runat="server" Font-Bold="true" CommandName="EdDispatch">Dispatch</asp:LinkButton></td>
                                                        <td>
                                                            <asp:LinkButton ID="LnkReturn" runat="server" Font-Bold="true" CommandName="EdReturn">Return</asp:LinkButton></td>
                                                        <td>
                                                            <asp:LinkButton ID="LnkCancel" runat="server" Font-Bold="true" CommandName="EdCancel">Cancel</asp:LinkButton></td>

                                                        <td><a href="OrderProductDetails.aspx?OrderId=<%# Eval("OrderId") %>">View</a>
                                                        </td>
                                                        <td>
                                                            <asp:LinkButton ID="LnkViews" runat="server" Font-Bold="true" CommandName="View">Order Detail</asp:LinkButton></td>
                                                    </tr>
                                                </tbody>
                                            </ItemTemplate>
                                        </asp:ListView>
                                        <tr>
                                            <td colspan="12">
                                                <asp:DataPager ID="DataPager1" runat="server" PagedControlID="LstOrder" PageSize="10">
                                                    <Fields>
                                                        <asp:NumericPagerField NumericButtonCssClass="btn-btn-success" ButtonType="Button"
                                                            CurrentPageLabelCssClass="btn-btn-success11" NextPreviousButtonCssClass="btn-btn-success"
                                                            ButtonCount="10" NextPageText="Next &raquo;" PreviousPageText="&laquo; Previous" />
                                                        <%--<asp:NextPreviousPagerField ButtonType="Link" ShowNextPageButton="true" ShowLastPageButton="false" ShowPreviousPageButton="false" />--%>
                                                    </Fields>
                                                </asp:DataPager>
                                            </td>
                                        </tr>
                                    </table>

                                </div>
                            </div>
                            <hr />
                        </div>
                    </div>
                </div>

            </div>
            <a name="View" style="text-decoration:none" />
            <asp:Panel ID="pnlOrderInfo" runat="server" Visible="false">
                <asp:Button ID="BtnClose" Text="Close" runat="server" OnClick="BtnClose_Click" Style="float: right" class="btn btn-danger" />
                <asp:UpdatePanel ID="UpdOrder" UpdateMode="Conditional" runat="server">
                    <ContentTemplate>
                        <div style="width: 840px; padding-top: 20px; padding-bottom: 20px;">
                            <div id="divPrint" runat="server">
                                <div style="width: 100%; padding-bottom: 10px; background-color: #f1f0f0; padding: 20px 0px; border: 1px solid #d6d6d6;">
                                    <div style="width: 850px; text-align: center;">
                                        <b style="color: #000; font-family: Tahoma; font-size: 18px; font-weight: normal; letter-spacing: 1px">Order Information</b>
                                    </div>
                                    <div id="tdPrint" runat="server" style="width: 180px; text-align: right; margin-left: 600px; margin-top: -35px;">
                                        <asp:ImageButton ID="Imgbtn" ImageUrl="~/Images/print.png" AlternateText="Print" runat="server" OnClick="Imgbtn_Click" />
                                    </div>
                                </div>
                                <div style="width: 100%; padding-bottom: 10px; border-bottom: 1px solid #d6d6d6; border-left: 1px solid #d6d6d6; border-right: 1px solid #d6d6d6;">
                                    <table cellpadding="0" cellspacing="0" style="width: 100%; padding-top: 20px;">
                                        <tr>
                                            <td colspan="2" align="left" style="padding-bottom: 8px; border-bottom: 1px solid #e8e5e5; background-color: #f1f0f0;">
                                                <span style="font-size: 16px; color: #961515; font-weight: bold; padding-left: 5px;">Order Form</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 500px; padding-top: 0px; background-color: #ffffff; border: 1px solid #e8e5e5; border-bottom: none; border-top: 1px solid #e8e5e5;" valign="top">

                                                <asp:ListView ID="LstCategory" runat="server" OnItemUpdating="LstCategory_ItemUpdating" OnItemCommand="LstCategory_ItemCommand">
                                                    <LayoutTemplate>
                                                        <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                                                    </LayoutTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="LblUserCode" runat="server" Visible="false" Text='<%#Eval("OrderId") %>'></asp:Label>
                                                        <tr>
                                                            <td style="width: 300px; padding-top: 0px; background-color: #ffffff; border: 1px solid #e8e5e5; border-bottom: none; border-top: 1px solid #e8e5e5;" valign="top">
                                                                <table width="300px" cellpadding="0" cellspacing="0" border="0">
                                                                    <tr>
                                                                        <td style="width: 70px; padding: 3px">
                                                                            <b>Name:</b>
                                                                        </td>
                                                                        <td style="width: 200px; padding: 3px" colspan="2">
                                                                            <asp:Label ID="LblName" runat="server" Text='<%# Eval("ShippingName") %>'></asp:Label>
                                                                        </td>

                                                                    </tr>
                                                                    <tr>
                                                                        <td style="padding: 3px" valign="top">
                                                                            <b>Address:</b>
                                                                        </td>
                                                                        <td style="padding: 3px" colspan="2" valign="top">
                                                                            <asp:Label ID="LblAddress" runat="server" Text='<%# Eval("ShippingAddress") %>'></asp:Label>
                                                                        </td>

                                                                    </tr>
                                                                    <tr>
                                                                        <td style="width: 70px; padding: 3px" valign="top">
                                                                            <b>City:</b>
                                                                        </td>
                                                                        <td style="width: 200px; padding: 3px" colspan="2">
                                                                            <asp:Label ID="Lblcity" runat="server" Text='<%# Eval("ShippingCity") %>'></asp:Label>
                                                                            <asp:Label ID="Label5" runat="server" Text='<%# "-" + Eval("ShippingZipCode") %>'></asp:Label>
                                                                            <asp:Label ID="Label4" runat="server" Text='<%# "(" + Eval("ShippingStats") + ")" %>'></asp:Label>
                                                                        </td>

                                                                    </tr>
                                                                    <tr>
                                                                        <td style="padding: 3px">
                                                                            <b>Contact No:</b>
                                                                        </td>
                                                                        <td style="padding: 3px" colspan="2">
                                                                            <asp:Label ID="Label12" runat="server" Text='<%# Eval("ShippingMobileNo") %>'></asp:Label>

                                                                        </td>

                                                                    </tr>
                                                                    <tr>
                                                                        <td valign="top" style="padding: 3px">
                                                                            <b>Email Id:</b>
                                                                        </td>
                                                                        <td valign="top" style="padding: 3px" colspan="2">
                                                                            <asp:Label ID="Label10" Font-Size="12px" runat="server" Text='<%# Eval("ShippingEmailId")%>'></asp:Label>
                                                                        </td>
                                                                    </tr>

                                                                    <tr>
                                                                        <td valign="top" style="padding: 3px"></td>
                                                                        <td valign="top" style="padding: 3px" colspan="2"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="left" colspan="6" style="padding: 3px; height: 60px;" valign="top"></td>
                                                                    </tr>
                                                                </table>
                                                                <table width="200px" cellpadding="0" cellspacing="0" border="0" style="margin-left: 576px; margin-top: -194px; padding-top: 9px;">
                                                                    <tr>
                                                                        <td style="width: 100px; padding: 3px; text-align: right;" valign="top"></td>
                                                                        <td style="width: 120px; padding: 3px" valign="top"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="padding: 3px; text-align: right;"></td>
                                                                        <td style="padding: 3px;"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="width: 100px; padding: 3px; text-align: right;" valign="top">
                                                                            <b>Order No:</b>
                                                                        </td>
                                                                        <td style="width: 120px; padding: 3px" valign="top">
                                                                            <asp:Label ID="LblOrderNo" runat="server" Text='<%# Eval("DisInvoiceNo") %>'></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="padding: 3px; text-align: right;">
                                                                            <b>Order Date:</b>
                                                                        </td>
                                                                        <td style="padding: 3px">
                                                                            <asp:Label ID="LblOrderDate" runat="server" Text='<%# Eval("ShippingDate") %>'></asp:Label>
                                                                        </td>
                                                                    </tr>

                                                                    <tr>
                                                                        <td style="width: 100px; padding: 3px; text-align: right;" valign="top">
                                                                            <b>PayMode:</b>
                                                                        </td>
                                                                        <td style="width: 120px; padding: 3px" valign="top">
                                                                            <asp:Label ID="Label16" runat="server" Text='<%# Eval("Paymode") %>'></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="padding-left: 110px;" colspan="2" rowspan="8">
                                                                            <span style="color: Gray; font-family: Arial; font-size: 12px; font-weight: normal; padding-bottom: 5px;">Enjoy Online Shopping on...</span><br />
                                                                            <a style="text-decoration: none" href="http://de9store.com/" target="_blank">
                                                                                <img src="../img/nlogo.png" width="130" height="120" />
                                                                            </a>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:ListView>
                                            </td>
                                        </tr>
                                        <tr style="margin-top:25px">
                                            <td style="width: 850px; padding-top: 0px;" valign="top">
                                                <table cellpadding="0" cellspacing="0" width="100%" border="0" style="border: 1px solid #e2e2e2; border-collapse: collapse;">
                                                    <asp:ListView ID="LstConferm" runat="server">
                                                        <LayoutTemplate>
                                                            <tr style="height: 35px; background-color: #DFDFDF; color: #000000;" align="center">
                                                                <td style="text-align: center; width: 10px;">&nbsp;<b>SNo.</b>
                                                                </td>
                                                                <td align="center" style="width: 40px;"></td>
                                                                <td style="text-align: left; width: 150px; padding-left: 5px; font-weight: bolder; font-family: sans-serif;">
                                                                    <b>Particulars</b>
                                                                </td>
                                                                <td></td>
                                                                <td style="width: 85px; font-weight: bolder; font-family: sans-serif; text-align: right;">
                                                                    <b>Amount</b>
                                                                </td>
                                                                <td style="width: 85px; font-weight: bolder; font-family: sans-serif; text-align: right;">
                                                                    <b>Discount</b>
                                                                </td>
                                                                <td style="width: 105px; font-weight: bolder; font-family: sans-serif; text-align: right;">
                                                                    <b>NetAmount</b>
                                                                </td>
                                                            </tr>
                                                            <asp:PlaceHolder ID="itemPlaceHolder" runat="server"></asp:PlaceHolder>
                                                        </LayoutTemplate>
                                                        <ItemTemplate>
                                                            <asp:HiddenField ID="HdnAmount" runat="server" Value='<%# Eval("Rate") %>' />
                                                            <asp:HiddenField ID="HdnDiscount" runat="server" Value='<%# Eval("Discount") %>' />
                                                            <asp:HiddenField ID="HdnQuantity" runat="server" Value='<%# Eval("Quantity") %>' />
                                                            <asp:HiddenField ID="Hdnweight" runat="server" Value='<%# Eval("Weight") %>' />
                                                            <%-- <asp:HiddenField ID="HdnType" runat="server" Value='<%# Eval("Type") %>' />--%>
                                                            <asp:Label ID="LblUnit" runat="server" Visible="false" Text='<%# Eval("Unit") %>'></asp:Label>
                                                            <asp:Label ID="LblProductId" runat="server" Visible="false" Text=' <%# Eval("ProductId")%>'></asp:Label>
                                                          


                                                            <tr style="background-color: white; color: #535353; border-bottom: 1px solid #e2e2e2;" align="center" valign="top" class="spaceUnder">

                                                                <td class="LstMyCart_td">
                                                                    <%#Container.DataItemIndex+1 %>
                                                                </td>
                                                                <td class="LstMyCart_td">
                                                                    <img width="75" height="110" src="../img/product/<%# ((Convert.ToString(Eval("Image")).Length>0)?Eval("Image"):"noimage.jpg")  %>" width="27px" height="40px" />
                                                                </td>
                                                                <td style="text-align: left;" valign="top" class="LstMyCart_td">
                                                                    <asp:Label ID="Label4" runat="server" CssClass="pdCode1" ForeColor="#000" Text="Product Name:"></asp:Label>
                                                                    <asp:Label runat="server" ID="Label1" Font-Size="11px" Text='<%# Eval("ProductName") %>'></asp:Label>
                                                                    <br />
                                                                    <asp:Label ID="Label5" runat="server" CssClass="pdCode1" ForeColor="#000" Text="Brand Name:"></asp:Label>
                                                                   
                                                                    <br />


                                                                    <br />


                                                                    <div class="pdCode" style="font-size: 11px; padding-left: 10px;">
                                                                        Price: 
                                                                          &nbsp;<asp:Label ID="LblRate" runat="server" Text='<%# Eval("Rate") %>'></asp:Label>
                                                                    </div>

                                                                </td>
                                                                <td width="180px">
                                                                    <table cellpadding="0" cellspacing="0" class="rounded-corners" style="padding-top: -7px;">

                                                                        <tr>
                                                                            <td>
                                                                                <table style="width: 180px;">
                                                                                    <tr>
                                                                                        <td style="text-align: left; padding-top: 2px; width: 150px;">
                                                                                            <span style="color: #004A79; font-size: 12px;">Actual Unit: </span>

                                                                                            <asp:Label ID="lblUnitActual" runat="server" Text='<%# Eval("Unit") %>'></asp:Label>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>

                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <table style="width: 180px;">
                                                                                    <tr>
                                                                                        <td style="text-align: left; padding-top: 2px; width: 150px;">
                                                                                            <span style="color: #004A79; font-size: 12px;">Weight: </span>
                                                                                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("Weight") %>'></asp:Label>

                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>

                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <table>
                                                                                    <tr>
                                                                                        <td style="text-align: left; padding-top: 2px; width: 150px;">
                                                                                            <span style="color: #004A79; font-size: 12px;">Quantity: </span>
                                                                                            &nbsp;<asp:Label ID="Label10" runat="server" Text='<%# Eval("Quantity") %>'></asp:Label>
                                                                                        </td>

                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                       
                                                                       
                                                                    </table>
                                                                </td>

                                                                <td class="LstMyCart_td" style="text-align: right; padding-right: 20px;">
                                                                    <asp:Label runat="server" ID="LblAmount" Text='<%# Eval("Amount") %>'></asp:Label>
                                                                </td>
                                                                <td class="LstMyCart_td" style="text-align: right; padding-right: 20px;">
                                                                    <asp:Label runat="server" ID="lblDiscount" Text='<%# Eval("Discount") %>'></asp:Label>
                                                                </td>
                                                                <td class="LstMyCart_td" style="text-align: right; padding-right: 20px;">
                                                                    <asp:Label runat="server" ID="lblNetAmount" Text='<%# Eval("NetAmount") %>'></asp:Label>
                                                                </td>
                                                                <td id="Td1" visible="false" runat="server">
                                                                    <asp:LinkButton ID="LkBtnEdit" runat="server" CommandName="Edit">Edit</asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                        </ItemTemplate>
                                                    </asp:ListView>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="12" align="right" style="border: solid 1px #c8c5c5; border-top: none; background-color: #eeeded;">
                                                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                                    <tr style="height: 30px;">
                                                        <td style="width: 514px; border-right: 1px solid #c8c5c5; text-align: right;">
                                                            <b>Total Amount (in Rs.)</b>&nbsp;
                                                        </td>
                                                        <td style="width: 58.5px; text-align: right; padding: 4px 16px 4px 8px;">
                                                            <asp:Label ID="lblAmt" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="12" align="right" style="border: solid 1px #c8c5c5; border-top: none; background-color: #eeeded;">
                                                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                                    <tr style="height: 30px;">
                                                        <td style="width: 514px; border-right: 1px solid #c8c5c5; text-align: right;">
                                                            <b>Delivery Charges (in Rs.)</b>&nbsp;
                                                        </td>
                                                        <td style="width: 58.5px; text-align: right; padding: 4px 16px 4px 8px;">
                                                            <asp:Label ID="LblDeliveryCharges" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="12" align="right" style="border: solid 1px #c8c5c5; border-top: none; background-color: #eeeded;">
                                                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                                    <tr style="height: 30px;">
                                                        <td style="width: 514px; border-right: 1px solid #c8c5c5; text-align: right;">
                                                            <b>Net Amount (in Rs.)</b>&nbsp;
                                                        </td>
                                                        <td style="width: 58.5px; text-align: right; padding: 4px 16px 4px 8px;">
                                                            <asp:Label ID="LblNetAmount" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <%--  <asp:SqlDataSource ID="SrcCart" runat="server" ConnectionString="<%$ ConnectionStrings:ConString%>"
                SelectCommand="set dateformat DMY;select CartId,UserCode,ProductId,ProductName,type,Unit,Quantity,Rate,Amount,Image,Weight,CategoryName,Discount,DiscountActual,NetAmount,QuantityActual,UnitActual,SchemeOffer from [Store].[Order_CartDetail] where OrderId=@OrderId"
                UpdateCommand=" ">
                <SelectParameters>
                    <asp:QueryStringParameter Name="OrderId" QueryStringField="OrderId" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource> 
                            <asp:SqlDataSource ID="SrcUser" runat="server" ConnectionString="<%$ ConnectionStrings:ConString%>"
                                SelectCommand="set dateformat DMY; Select OrderId,'ShippingDate'=CONVERT(varchar(10),ShippingDate,103),right(convert(char(20),ShippingTime,0),7) as ShippingTime,'DeliveredDate'=CONVERT(varchar(10),DeliveredDate,103),right(convert(char(20),DeliveredTime,0),7) as DeliveredTime,UserCode,ShippingName,ShippingAddress,ShippingCountry,ShippingState,ShippingDistrict,ShippingCity,ShippingZipCode,ShippingPhoneNumber,ShippingMobileNumber,ShippingEmailId,ShippingDescription from [Store].[Order_OrderDetail] where OrderId=@OrderId" UpdateCommand=" ">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="OrderId" QueryStringField="OrderId" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource> --%>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>

            </asp:Panel>
        </div>
    </div>
</asp:Content>

