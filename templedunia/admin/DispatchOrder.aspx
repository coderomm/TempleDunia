<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="DispatchOrder.aspx.cs" Inherits="DispatchOrder" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <style type="text/css">
        .messagealert {
            width: 100%;
            top: 0px;
            z-index: 100000;
            padding: 0;
            font-size: 15px;
        }
    </style>
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
    <style>
        .MainSearchBar {
            color: #333333;
            padding: 3px;
            margin-right: 4px;
            margin-bottom: 8px;
            font-family: tahoma, arial, sans-serif;
            background-image: url(images/SearchImg.jpg);
            background-repeat: repeat-x;
            border: 1px solid #d2d2ce;
        }

        .AutoComplite {
            width: 326px;
            background-color: white;
            margin: 0;
            padding: 0;
            color: #A4A4A4;
            z-index: 1;
        }

        .AutoCompliteItem {
            font-size: 12px;
            height: 25px;
            background-color: white;
            width: 320px;
            overflow: hidden;
            color: Black;
            border-top-style: dotted;
            border-right-style: groove;
            border-bottom-style: dotted;
            border-left-style: solid;
            border-color: #d2d2d2;
            border-width: 1px;
        }

        .AutoCompliteSelectedItem {
            font-size: 12px;
            height: 25px;
            color: #E80732;
            font-weight: bold;
            background-color: #eaeaea;
            width: 320px;
            overflow: hidden;
            padding-top: 5px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="messagealert" id="alert_container">
    </div>

    <div class="content-wrapper">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h1 class="page-head-line">Dispatch  Forms </h1>
                </div>
            </div>
            <div class="row">

                <div class="col-md-12" runat="server" id="listbox" visible="false">
                    <!--   Kitchen Sink -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Order  List
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">

                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>

                                        <table class="table table-striped table-bordered table-hover">
                                            <asp:ListView ID="LstActive" runat="server">
                                                <LayoutTemplate>
                                                    <thead>
                                                        <tr>
                                                            <th>S.No</th>

                                                            <th>Shade Id</th>
                                                            <th>Order Quantity</th>
                                                            <th>Qty. Detail</th>
                                                            <th>Dispatch Quantity</th>
                                                            <th>Dispatched Quantity</th>







                                                        </tr>
                                                    </thead>
                                                    <asp:PlaceHolder ID="Itemplaceholder" runat="server"></asp:PlaceHolder>
                                                </LayoutTemplate>

                                                <ItemTemplate>
                                                    <tr>
                                                        <asp:Label ID="lblshadeid" runat="server" Text='<%#Eval("ShadeId")%>' Visible="false"></asp:Label>
                                                        <asp:Label ID="lblstock" runat="server" Text='<%#Eval("ShadeId")%>' Visible="false"></asp:Label>
                                                        <asp:Label ID="lblOrderId" runat="server" Text='<%#Eval("OrderId")%>' Visible="false"></asp:Label>
                                                        <asp:Label ID="ProductId" runat="server" Text='<%#Eval("ProductId")%>' Visible="false"></asp:Label>


                                                        <asp:Label ID="lblDispatchQuantity" runat="server" Text='<%#Eval("DispatchQuantity")%>' Visible="false"></asp:Label>
                                                        <td><%# Container.DataItemIndex + 1 %></td>
                                                       <td>
                                                            <asp:ListView ID="lstshade" runat="server" DataSourceID="sqlshade">
                                                                <ItemTemplate>
                                                                    <%# Eval("ShadeNo") %>
                                                                </ItemTemplate>
                                                            </asp:ListView>

                                                            <asp:SqlDataSource ID="sqlshade" runat="server" ConnectionString="<%$ ConnectionStrings:ShivShaktiSynthetics%>"
                                                                CancelSelectOnNullParameter="false" SelectCommand="select ShadeNo from M_ShadeMaster  where Id=@lblshadeid">
                                                                <SelectParameters>
                                                                  
                                                                    <asp:ControlParameter Name="lblshadeid" ControlID="lblshadeid" DefaultValue="0" />


                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                        </td>
                                                        <td>
                                                            <asp:ListView ID="lstqty" runat="server" DataSourceID="lstqtyintl">
                                                                <ItemTemplate>
                                                                    <%# Eval("Quantity1") %> 
                                                                </ItemTemplate>
                                                            </asp:ListView>

                                                            <asp:SqlDataSource ID="lstqtyintl" runat="server" ConnectionString="<%$ ConnectionStrings:ShivShaktiSynthetics%>"
                                                                CancelSelectOnNullParameter="false" SelectCommand="select sum(Quantity) as Quantity1 from TrnOrderDetail  where OrderID=@lblOrderId and ShadeId=@lblshadeid">
                                                                <SelectParameters>
                                                                    <asp:ControlParameter Name="lblOrderId" ControlID="lblOrderId" DefaultValue="0" />
                                                                    <asp:ControlParameter Name="lblshadeid" ControlID="lblshadeid" DefaultValue="0" />


                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                        </td>

                                                        <td style="width: 145px; border-right: solid 1px #c8c5c5; border-bottom: solid 1px #c8c5c5;">
                                                            <asp:ListView ID="LstProducts" runat="server" DataSourceID="Srcluggage">
                                                                <ItemTemplate>
                                                                    <span class="product-name"><strong></strong>&nbsp;&nbsp;&nbsp;</span>
                                                                    <b class="pull-left"><%# Eval("CutType") %></b>
                                                                    <asp:Label ID="lblCutType" runat="server" Visible="false" Text='<%#Eval("CutType") %>'></asp:Label>
                                                                    <asp:Label ID="lblsid" runat="server" Visible="false" Text='<%#Eval("ShadeId") %>'></asp:Label>
                                                                    <asp:Label ID="lblproductsid" runat="server" Visible="false" Text='<%#Eval("ProductId") %>'></asp:Label>
                                                                    <asp:ListView ID="LstProducts" runat="server" DataSourceID="Listmeter">
                                                                        <ItemTemplate>
                                                                            <table>
                                                                                <tr>
                                                                                    <td style="border-bottom: solid 1px #cccccc"><%# Eval("Meter") %>&nbsp;M.&nbsp;<span id="Span1" visible='<%# ((Eval("Quantity").ToString()=="0.00") ? false : true) %>' runat="server"><%# Eval("Quantity") %>&nbsp;Qty.</span> </b></td>
                                                                                </tr>


                                                                            </table>
                                                                        </ItemTemplate>
                                                                    </asp:ListView>
                                                                    <asp:SqlDataSource ID="Listmeter" runat="server" ConnectionString="<%$ ConnectionStrings:ShivShaktiSynthetics%>"
                                                                        CancelSelectOnNullParameter="false" SelectCommand="select Meter,Quantity from TrnOrderShadeDetail where  ProductId=@lblproductsid and ShadeId=@lblsid and CutType=@lblCutType and OrderID=@lblOrderId">
                                                                        <SelectParameters>
                                                                            <asp:ControlParameter Name="lblCutType" ControlID="lblCutType" DefaultValue="0" />
                                                                            <asp:ControlParameter Name="lblproductsid" ControlID="lblproductsid" DefaultValue="0" />
                                                                            <asp:ControlParameter Name="lblsid" ControlID="lblsid" DefaultValue="0" />
                                                                            <asp:ControlParameter Name="lblOrderId" ControlID="lblOrderId" DefaultValue="0" />

                                                                        </SelectParameters>
                                                                    </asp:SqlDataSource>
                                                                </ItemTemplate>
                                                            </asp:ListView>
                                                            <asp:SqlDataSource ID="Srcluggage" runat="server" ConnectionString="<%$ ConnectionStrings:ShivShaktiSynthetics%>"
                                                                CancelSelectOnNullParameter="false" SelectCommand="select distinct a.ProductId,a.CutType,a.ShadeId,b.Rate from TrnOrderDetail as a inner join M_ProductMaster as b on a.ProductId=b.ProductId where  a.ProductId=@ProductId and a.ShadeId=@lblshadeid">
                                                                <SelectParameters>
                                                                    <asp:ControlParameter Name="ProductId" ControlID="ProductId" DefaultValue="0" />

                                                                    <asp:ControlParameter Name="lblshadeid" ControlID="lblshadeid" DefaultValue="0" />

                                                                </SelectParameters>
                                                            </asp:SqlDataSource>

                                                        </td>
                                                        <td><%# Eval("DispatchQuantity") %></td>

                                                        <td>
                                                            <asp:TextBox ID="Txtbox" runat="server" Style="width: 50%;" OnTextChanged="Txtbox_TextChanged" onkeypress='return ((event.charCode >= 48 && event.charCode <= 57)||event.keyCode == 8||event.keyCode == 9)' AutoPostBack="true"></asp:TextBox>
                                                            <br />
                                                            <asp:Label ID="lblMsg" runat="server" Visible="false" ForeColor="red" Font-Size="10px"></asp:Label>
                                                        </td>

                                                    </tr>
                                                </ItemTemplate>
                                            </asp:ListView>



                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>

                </div>


                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Dispatch  Forms
                        </div>
                        <div class="panel-body">
                            <form role="form">
                                <div class="col-md-3">
                                    <div class="form-group has-success">
                                        <label class="control-label" for="success">Select Order No.</label>

                                        <asp:DropDownList ID="DDorder" runat="server" class="form-control" DataValueField="OrderId" DataTextField="InvoiceNo" AutoPostBack="true" OnSelectedIndexChanged="DDorder_SelectedIndexChanged"></asp:DropDownList>



                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group has-success">
                                        <label class="control-label" for="success">Transport Name</label>
                                        <asp:TextBox ID="Txttranport" runat="server" class="form-control" required="required"></asp:TextBox>

                                    </div>


                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" ServicePath="~/sellproduct.asmx"
                                        ServiceMethod="Transportname" CompletionInterval="10" CompletionListItemCssClass="AutoCompliteItem"
                                        CompletionListCssClass="AutoComplite" CompletionListHighlightedItemCssClass="AutoCompliteSelectedItem"
                                        FirstRowSelected="true" MinimumPrefixLength="1" TargetControlID="Txttranport">
                                    </cc1:AutoCompleteExtender>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group has-success">
                                        <label class="control-label" for="success">Lr. No</label>
                                        <asp:TextBox ID="Txtlrno" runat="server" class="form-control" required="required"></asp:TextBox>

                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group has-success">
                                        <label class="control-label" for="success">Invoice No</label>
                                        <asp:TextBox ID="txtinvoice" runat="server" class="form-control" required="required"></asp:TextBox>

                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group has-success">
                                        <label class="control-label" for="success">Amount</label>
                                        <asp:TextBox ID="Txtamt" runat="server" class="form-control" required="required" onkeypress='return ((event.charCode >= 48 && event.charCode <= 57)||event.keyCode == 8||event.keyCode == 9)'></asp:TextBox>

                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group has-success">
                                        <label class="control-label" for="success"></label>
                                        <asp:Button ID="Button1" runat="server" Class="form-control btn-danger" Text="Dispatch" Style="border-style: none; padding: 5px" OnClick="Button1_Click" />
                                    </div>
                                </div>
                                <div class="col-md-3">
                                </div>

                                <div class="col-md-3">
                                </div>
                                <asp:Label ID="LblErr" runat="server" ForeColor="Red"></asp:Label><br />
                            </form>
                            <hr />


                        </div>
                    </div>
                </div>
                <asp:HiddenField ID="LblId" runat="server" />

            </div>
        </div>
    </div>
</asp:Content>


