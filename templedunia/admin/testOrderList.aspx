<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="testOrderList.aspx.cs" Inherits="testOrderList" %>


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
            <div class="row" runat="server" id="canelbox" visible="false">

                <asp:HiddenField ID="HiddenField2" runat="server" />
                <div class="col-md-12">
                    <!--   Kitchen Sink -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Cancel Shade  <span class="pull-right"><b>
                                <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton2_Click">X</asp:LinkButton></b></span>
                        </div>

                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">


                                    <tbody>
                                        <asp:ListView ID="lstcanel" runat="server" OnItemCommand="lstcanel_ItemCommand">
                                            <LayoutTemplate>
                                                <thead>
                                                    <tr>
                                                        <th>S.No</th>
                                                        <td style="width: 50px;" id="firstCol" runat="server">

                                                            <asp:LinkButton ID="LkBtnCancel" Style="text-decoration: none;" runat="server" CommandName="Cen" ForeColor="Black">&nbsp;&nbsp;Cancel&nbsp;&nbsp;</asp:LinkButton>
                                                        </td>





                                                        <th>Particulars</th>
                                                        <th>Qty </th>
                                                        <th>Qty Detail </th>



                                                    </tr>
                                                </thead>
                                                <asp:PlaceHolder ID="Itemplaceholder" runat="server"></asp:PlaceHolder>
                                            </LayoutTemplate>

                                            <ItemTemplate>
                                                <tr>
                                                    <asp:Label ID="lblOrderid" runat="server" Visible="false" Text='<%# Eval("Orderid") %>'></asp:Label>
                                                    <%--<asp:Label ID="lblProductId" runat="server" Visible="false" Text='<%# Eval("ShadeId") %>'></asp:Label>--%>
                                                    <asp:Label ID="lblProductId" runat="server" Visible="false" Text='<%#Eval("ProductId") %>'></asp:Label>
                                                    <asp:HiddenField ID="OrderId" runat="server" Value='<%#Eval("OrderId") %>' />
                                                    <asp:Label ID="ShadeId" runat="server" Visible="false" Text='<%#Eval("Id") %>'></asp:Label>
                                                    <asp:Label ID="lblUserShipId" runat="server" Visible="false" Text='<%#Eval("OrderId") %>'></asp:Label>
                                                    <td><%# Container.DataItemIndex + 1 %></td>
                                                    <td align="center" id="firstCol" runat="server">
                                                        <asp:CheckBox ID="ChkCancel" runat="server" />
                                                    </td>


                                                    <td>Shadeno : <%# Eval("Shadeno") %>
                                                        <asp:Label runat="server" ID="Label1" Text='<%# Eval("ProductName") %>'></asp:Label>

                                                    </td>




                                                    <td>
                                                        <asp:ListView ID="lstqty" runat="server" DataSourceID="lstqtyintl">
                                                            <ItemTemplate>
                                                                <%# Eval("Quantity") %>
                                                            </ItemTemplate>
                                                        </asp:ListView>

                                                        <asp:SqlDataSource ID="lstqtyintl" runat="server" ConnectionString="<%$ ConnectionStrings:ShivShaktiSynthetics%>"
                                                            CancelSelectOnNullParameter="false" SelectCommand="select sum(Quantity) as Quantity from TrnOrderDetail  where OrderID=@lblOrderId and ShadeId=@ShadeId">
                                                            <SelectParameters>
                                                                <asp:ControlParameter Name="lblOrderId" ControlID="lblOrderId" DefaultValue="0" />
                                                                <asp:ControlParameter Name="ShadeId" ControlID="ShadeId" DefaultValue="0" />


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
                                                                    CancelSelectOnNullParameter="false" SelectCommand="select Meter,Quantity from TrnOrderShadeDetail where  ProductId=@lblproductsid and ShadeId=@lblsid and CutType=@lblCutType and OrderID=@lblOrderid">
                                                                    <SelectParameters>
                                                                        <asp:ControlParameter Name="lblCutType" ControlID="lblCutType" DefaultValue="0" />
                                                                        <asp:ControlParameter Name="lblproductsid" ControlID="lblproductsid" DefaultValue="0" />
                                                                        <asp:ControlParameter Name="lblsid" ControlID="lblsid" DefaultValue="0" />
                                                                        <asp:ControlParameter Name="lblOrderid" ControlID="lblOrderid" DefaultValue="0" />
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                            </ItemTemplate>
                                                        </asp:ListView>
                                                        <asp:SqlDataSource ID="Srcluggage" runat="server" ConnectionString="<%$ ConnectionStrings:ShivShaktiSynthetics%>"
                                                            CancelSelectOnNullParameter="false" SelectCommand="select distinct a.ProductId,a.CutType,a.ShadeId,b.Rate from TrnOrderDetail as a inner join M_ProductMaster as b on a.ProductId=b.ProductId where  a.ProductId=@lblProductId and a.ShadeId=@ShadeId and a.OrderID=@lblOrderid">
                                                            <SelectParameters>
                                                                <asp:ControlParameter Name="lblProductId" ControlID="lblProductId" DefaultValue="0" />

                                                                <asp:ControlParameter Name="ShadeId" ControlID="ShadeId" DefaultValue="0" />
                                                                <asp:ControlParameter Name="lblOrderid" ControlID="lblOrderid" DefaultValue="0" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>

                                                    </td>



                                                </tr>
                                            </ItemTemplate>
                                        </asp:ListView>

                                        <%--<asp:SqlDataSource ID="SqlActive" runat="server" ConnectionString="<%$Connectionstrings:topcity %>" SelectCommand="select * from [Restaurant] where CityCode=1 and StateCode=1 and ActiveStatus=1 order by id desc"></asp:SqlDataSource>--%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- End  Kitchen Sink -->
                </div>


            </div>
            <br />
            <div class="row">

                <asp:HiddenField ID="HiddenField1" runat="server" />
                <div class="col-md-12">
                    <!--   Kitchen Sink -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Order  List
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">


                                    <tbody>
                                        <asp:ListView ID="LstActive" runat="server" OnItemCommand="LstActive_ItemCommand">
                                            <LayoutTemplate>
                                                <thead>
                                                    <tr>
                                                        <th>S.No</th>
                                                        <td style="width: 50px;" id="firstCol" runat="server">

                                                            <asp:LinkButton ID="LkBtnCancel" Style="text-decoration: none;" runat="server" CommandName="Cen" ForeColor="Black">&nbsp;&nbsp;Cancel&nbsp;&nbsp;</asp:LinkButton>
                                                        </td>

                                                        <td style="width: 80px;">
                                                            <asp:LinkButton ID="LnkDispatch" Style="text-decoration: none;" runat="server" CommandName="Dispatch" ForeColor="Black">&nbsp;&nbsp;Disptach&nbsp;&nbsp;</asp:LinkButton>
                                                        </td>
                                                        <th>Order No.</th>
                                                        <th>Qty.</th>
                                                        <th>Date</th>

                                                        <th>Firm Name</th>
                                                        <th>City</th>
                                                        <th>State</th>
                                                        <th>Contact</th>
                                                        <th>Delivery Description </th>
                                                        <th></th>
                                                        <th></th>

                                                    </tr>
                                                </thead>
                                                <asp:PlaceHolder ID="Itemplaceholder" runat="server"></asp:PlaceHolder>
                                            </LayoutTemplate>

                                            <ItemTemplate>
                                                <tr>
                                                    <asp:HiddenField ID="OrderId" runat="server" Value='<%#Eval("OrderId") %>' />
                                                    <asp:Label ID="lblUserShipId" runat="server" Visible="false" Text='<%#Eval("OrderId") %>'></asp:Label>
                                                    <td><%# Container.DataItemIndex + 1 %></td>
                                                    <td align="center" id="firstCol" runat="server">
                                                        <asp:CheckBox ID="ChkCancel" runat="server" />
                                                    </td>

                                                    <td align="center">
                                                        <asp:CheckBox ID="ChkDispatch" runat="server" />
                                                    </td>
                                                    <td>
                                                        <%# Eval("InvoiceNo")%>
                                                    </td>
                                                    <td>
                                                        <%# Eval("TotalQuantity")%>
                                                    </td>
                                                    <td>
                                                        <%# Eval("Date")%>
                                                    </td>

                                                    <td>
                                                        <%# Eval("firmname") %>
                                                    </td>

                                                    <td>
                                                        <%# Eval("City")%>
                                                    </td>
                                                    <td>
                                                        <%# Eval("State") %>
                                                    </td>

                                                    <td>
                                                        <%# Eval("MobileNo") %>
                                                    </td>
                                                    <td>
                                                        <%# Eval("OrderThrough") %>
                                                    </td>
                                                    <td>
                                                        <asp:LinkButton ID="LnkShowDetail" CommandName="Show" runat="server">Show Detail</asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        <asp:LinkButton ID="LinkButton1" CommandName="Del" runat="server">Cancel</asp:LinkButton><br />
                                                   <%--     <asp:LinkButton ID="LinkButton3" CommandName="print" runat="server">print</asp:LinkButton>--%>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:ListView>

                                        <%--<asp:SqlDataSource ID="SqlActive" runat="server" ConnectionString="<%$Connectionstrings:topcity %>" SelectCommand="select * from [Restaurant] where CityCode=1 and StateCode=1 and ActiveStatus=1 order by id desc"></asp:SqlDataSource>--%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- End  Kitchen Sink -->
                </div>


            </div>
        </div>

    </div>
    <a id="bottom"></a>
    <asp:Panel ID="pnlOrderInfo" runat="server" Visible="false">
        <asp:UpdatePanel ID="UpdOrder" UpdateMode="Conditional" runat="server">
            <ContentTemplate>
                <div id="divPrint" runat="server" style="padding-top: 20px; padding-bottom: 20px; padding-left: 100px;">
                    <div class="default">

                        <table cellpadding="0" cellspacing="0" class="cart_in" style="border: 0px solid grey; width: 700px">
                            <tr style="border: solid 1px red; width: 700px;background-color:white">
                                <table style=" width: 700px;">
                                <td style="text-align: left; background-color: white; padding: 2px;">GST IN :088BOPPK6550R1ZY</td>
                                <td style="background-color: white; text-align: right;padding: 2px;">Phone :02148-248123,248124 <br />M :94138-84119</td>
                           </table> </tr>

                          
                      
                            <tr style="background-color: white; padding-top: 2px; padding-bottom: 2px;">

                                <td>
                                    <table width="700px" cellpadding="0" cellspacing="0" border="0" style="background-color:white">
                                        <tr>
                                            <td style="width: 700px;" align="center">
                                                <h2><b>Shiv Shakti Synthetics</b> </h2>
                                                <h6>An ISO 9001 : 2015 Certified Co.</h6>
                                                <h6>10-NEW CLOTH MARKET</h6>
                                                <h6>PUR ROAD- Chittorgarh(RAJ.)</h6>

                                            </td>

                                        </tr>

                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style="background-color: white; padding-top: 2px; padding-bottom: 2px; border: 1px solid #ece08b;">
                                    <table width="700px" cellpadding="0" cellspacing="0" border="0" style="background-color:white">
                                        <tr>
                                            <td style="width: 546px;" align="center">

                                                <span style="font-size: 16px; color: #961515; font-weight: bold;text-align:center;margin-left:190px">Order Form</span>
                                            </td>
                                            <td style="width: 180px; text-align: right;" id="tdPrint" runat="server">
                                                <asp:ImageButton ID="ImgBtnPrint" ImageUrl="images/print.png" runat="server" OnClick="ImgBtnPrint_Click" />
                                            </td>
                                        </tr>

                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table class="cart_in" style="border-top: none; padding: 10px; background-color: white">
                            <tr>
                                <td>
                                    <table width="700px" cellpadding="0" cellspacing="0" border="0">
                                        <asp:ListView ID="LstCategory" runat="server">
                                            <LayoutTemplate>
                                                <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <div class="container-fluid">
                                                    <div class="row">
                                                        <div class="col-lg-4" style="border: solid 1px #cccccc">
                                                            <b>Order No</b> :  
                                                            <asp:Label ID="LblOrderNo" runat="server" Text='<%# Eval("InvoiceNo") %>'></asp:Label>
                                                        </div>
                                                        <div class="col-lg-4" style="border: solid 1px #cccccc">
                                                            <b>Order Date</b> : 
                                                            <asp:Label ID="Label6" runat="server" Text='<%# Eval("Date") %>'></asp:Label>
                                                        </div>
                                                        <div class="col-lg-4" style="border: solid 1px #cccccc">
                                                            <b>Order Time.</b> :        
                                                            <asp:Label ID="Label7" runat="server" Text='<%# Eval("Time") %>'></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="container-fluid">
                                                    <div class="row">
                                                        <div class="col-lg-6" style="border: solid 1px #cccccc">
                                                            Frim Name :<%# Eval("FirmName") %><br />
                                                            Agent Name :  <%# Eval("AgentName") %>   <br />
                                                        
                                                           GST IN : <%# Eval("Gst") %> <br/>  Email Id : <%# Eval("EmailId")%><br />
                                                            Address :<%# Eval("Address") %><br />
                                                          Station :  <%# Eval("Station") %> City : <%# Eval("city") %>
                                                        </div>
                                                        <div class="col-lg-6">
                                                            <asp:ListView ID="lstaccount" runat="server" DataSourceID="Srcluggage">
                                                                <ItemTemplate>
                                                                    A/C. : <%# Eval("AccountName") %><br />
                                                                    GSTIN : <%# Eval("GstNo") %>
                                                                    <br />
                                                                    <%# Eval("TransPortName") %>   Station :<%# Eval("Station") %>
                                                                    <br />
                                                                  City :  <%# Eval("City") %>
                                                                    <br />
                                                                 District : <%# Eval("District_Name") %>  State :<%# Eval("State_Name") %>
                                                                </ItemTemplate> 
                                                            </asp:ListView>
                                                            <asp:SqlDataSource ID="Srcluggage" runat="server" ConnectionString="<%$ ConnectionStrings:ShivShaktiSynthetics%>"
                                                                CancelSelectOnNullParameter="false" SelectCommand="Select a.*,b.State_Name,c.District_Name From  UserAccount as a INNER JOIN M_StateMaster as b On a.CityCode=b.State_Code INNER JOIN M_DistrictMaster as c ON a.StateCode=c.District_Code where a.id=@lblid">
                                                                <SelectParameters>
                                                                    <asp:ControlParameter Name="lblid" ControlID="lblid" DefaultValue="0" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                        </div>
                                                    </div>
                                                </div>
                                                <asp:Label ID="lblid" runat="server" Visible="false" Text='<%# Eval("Accountid") %>'></asp:Label>













                                            </ItemTemplate>

                                        </asp:ListView>
                                    </table>
                                </td>
                            </tr>


                            <tr>
                                <td>
                                    <table width="700px" cellpadding="0" cellspacing="0" class="cart_in">
                                        <tr>
                                            <td style="background-color: #fbbe77;">
                                                <asp:ListView ID="LstConferm" runat="server">
                                                    <LayoutTemplate>
                                                        <tr style="height: 35px; background-color: white; color: #000000; border-bottom: solid 0px #c8c5c5; border-top: solid 1px #c8c5c5" align="center">

                                                            <td style="width: 225px; border-right: solid 1px #c8c5c5">
                                                                <b>Particulars</b>
                                                            </td>
                                                            <td style="width: 225px; border-right: solid 1px #c8c5c5">
                                                                <b>Shade No.</b>
                                                            </td>
                                                            <td style="width: 50px; border-right: solid 1px #c8c5c5">
                                                                <b>Cut</b>
                                                            </td>
                                                            <td style="width: 50px; border-right: solid 1px #c8c5c5">
                                                                <b>Meter</b>
                                                            </td>
                                                            <td style="width: 50px; border-right: solid 1px #c8c5c5">
                                                                <b>Quantity</b>
                                                            </td>
                                                            <td style="width: 50px; border-right: solid 1px #c8c5c5">
                                                                <b>Total Meter</b>
                                                            </td>



                                                            <td style="width: 150px; border-right: solid 1px #c8c5c5">
                                                                <b>Rate</b>
                                                            </td>

                                                        </tr>
                                                        <asp:PlaceHolder ID="itemPlaceHolder" runat="server"></asp:PlaceHolder>
                                                    </LayoutTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="ProductId" runat="server" Visible="false" Text='<%#Eval("ProductId") %>'></asp:Label>

                                                        <asp:Label ID="lblShadeid" runat="server" Visible="false" Text='<%#Eval("Shadeid") %>'></asp:Label>
                                                        <asp:Label ID="lblOrderId" runat="server" Visible="false" Text='<%#Eval("OrderId") %>'></asp:Label>
                                                        <tr style="background-color: white; color: #535353; height: 50px; border: solid 1px #c8c5c5; border-top: solid 1px #c8c5c5">

                                                            <td style="width: 300px; text-align: center; border-right: solid 1px #c8c5c5; border-bottom: solid 1px #c8c5c5; padding-left: 3px;">
                                                                <asp:ListView ID="ListView3" runat="server" DataSourceID="Srcluggage">
                                                                    <ItemTemplate>
                                                                        <%# Eval("ProductName") %>
                                                                    </ItemTemplate>
                                                                </asp:ListView>



                                                            </td>
                                                            <td style="width: 275px; text-align: center; border-right: solid 1px #c8c5c5; border-bottom: solid 1px #c8c5c5; padding-left: 3px;">
                                                                <%# Eval("Shadeid") %>
                                                               
                                                            </td>
                                                            <td style="width: 275px; text-align: center; border-right: solid 1px #c8c5c5; border-bottom: solid 1px #c8c5c5; padding-left: 3px;">

                                                                <asp:Label ID="lblCutType" runat="server" Text='<%#Eval("CutType") %>'></asp:Label>
                                                            </td>
                                                            <td style="width: 275px; text-align: center; border-right: solid 1px #c8c5c5; border-bottom: solid 1px #c8c5c5; padding-left: 3px;">
                                                              <%#  String.Format("{0:0.00}", Eval("Meter")) %>      </b>
                                                            </td>
                                                            <td style="width: 275px; text-align: center; border-right: solid 1px #c8c5c5; border-bottom: solid 1px #c8c5c5; padding-left: 3px;">
                                                              <%#  String.Format("{0:0.00}", Eval("Quantity")) %>   
                                                              
                                                            </td>
                                                            <td style="width: 275px; text-align: center; border-right: solid 1px #c8c5c5; border-bottom: solid 1px #c8c5c5; padding-left: 3px;">
                                                                <%#  String.Format("{0:0.00}", Eval("TotalQuantity")) %>
                                                            
                                                            </td>






                                                            <td style="width: 275px; text-align: center; border-right: solid 1px #c8c5c5; border-bottom: solid 1px #c8c5c5; padding-left: 3px;">
                                                                <asp:ListView ID="LstProducts1" runat="server" DataSourceID="Srcluggage">
                                                                    <ItemTemplate>

                                                                        <span id="Span1" visible='<%# ((Eval("CutType").ToString()=="Lump") ? true : false) %>' runat="server"><%# Eval("Lump") %></span>
                                                                        <span id="Span2" visible='<%# ((Eval("CutType").ToString()=="Than") ? true : false) %>' runat="server"><%# Eval("Than") %></span>
                                                                        <span id="Span3" visible='<%# ((Eval("CutType").ToString()=="Piece") ? true : false) %>' runat="server"><%# Eval("Piece") %></span>
                                                                        <span id="Span4" visible='<%# ((Eval("CutType").ToString()=="Multi") ? true : false) %>' runat="server"><%# Eval("Multi") %></span>

                                                                        </b>
                                                                    </ItemTemplate>
                                                                </asp:ListView>
                                                            </td>

                                                            <asp:SqlDataSource ID="Srcluggage" runat="server" ConnectionString="<%$ ConnectionStrings:ShivShaktiSynthetics%>"
                                                                CancelSelectOnNullParameter="false" SelectCommand="select  distinct b.ProductName ,a.CutType,b.Rate,b.Lump,b.Than,b.Piece,b.Multi from TrnOrderDetail as a inner join M_ProductMaster as b on a.ProductId=b.ProductId where  a.ProductId=@ProductId and a.shadeid=@lblShadeid and a.orderid=@lblOrderId and a.CutType=@lblCutType">
                                                                <SelectParameters>
                                                                    <asp:ControlParameter Name="ProductId" ControlID="ProductId" DefaultValue="0" />
                                                                    <asp:ControlParameter Name="lblShadeid" ControlID="lblShadeid" DefaultValue="0" />
                                                                    <asp:ControlParameter Name="lblOrderId" ControlID="lblOrderId" DefaultValue="0" />
                                                                    <asp:ControlParameter Name="lblCutType" ControlID="lblCutType" DefaultValue="0" />

                                                                </SelectParameters>
                                                            </asp:SqlDataSource>



                                                        </tr>
                                                    </ItemTemplate>

                                                </asp:ListView>
                                            </td>
                                        </tr>



                                    </table>

                                    <table style="margin-top: 1px; border: solid 1px #c8c5c5; background-color: white" width="700px">
                                        <tr>
                                            <td>Remark : <%=remark %></td>
                                        </tr>
                                    </table>

                                    <tr style="background-color: white; padding-top: 2px; padding-bottom: 2px;">
                                        <td>
                                            <table width="700px" cellpadding="0" cellspacing="0" border="0">
                                                <tr>
                                                    <td style="width: 700px;" align="center">
                                                        <img src="../img/logo.jpg" style="height: 110px; width: 256px" />

                                                    </td>

                                                </tr>

                                            </table>
                                        </td>
                                    </tr>
                                    <table width="700px" cellpadding="0" cellspacing="0" class="cart_in">
                                        <tr>
                                            <td>
                                                <table width="700px" style="border: solid 1px #e8e5e5; background-color: #f9f8f8; color: #000000; font-size: 10px; padding: 8px 5px 8px 5px;">
                                                    <tr>
                                                        <td valign="top">Supplied by: <b style="color: #961515; font-size: 11px;">Shiv Shakti Synthetics  </b>10, New Cloth Market, Pur Rd, Pratap Nagar, Chittorgarh, Rajasthan India - 311001  Mobile No.: +91-94138 84119 
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top">
                                                            <div style="float: left; position: absolute;">
                                                                E-mail: <a href="mailto:info@ankitsuitings.com "><span style="color: #000000; font-size: 10px;">info@ankitsuitings.com </span></a>
                                                            </div>
                                                            <div style="float: right; font-size: 9px; color: #000000; padding-left: 180px;">
                                                                T&C Apply. Subject to Chittorgarh Jurisdiction
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>


                        </table>
                    </div>

                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </asp:Panel>
    <br />
    <br />


    <br />
    <br />
    <asp:Panel ID="Printpanel" runat="server" Visible="false">

        <div id="div1" runat="server" style="padding-top: 20px; padding-bottom: 20px; padding-left: 100px;">
            <div class="default">
                <table cellpadding="0" cellspacing="0" class="cart_in" style="border: 0px solid grey;">
                    <tr style="background-color: white; padding-top: 2px; padding-bottom: 2px;">
                        <td>
                            <table width="700px" cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td style="width: 700px;" align="center">
                                        <img src="../img/logo.jpg" style="height: 110px; width: 256px" />

                                    </td>

                                </tr>

                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="background-color: white; padding-top: 2px; padding-bottom: 2px; border: 1px solid #ece08b;">
                            <table width="700px" cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td style="width: 546px;" align="center">

                                        <span style="font-size: 16px; color: #961515; font-weight: bold;">Order Form</span>
                                    </td>
                                    <td style="width: 180px; text-align: right;" id="td1" runat="server"></td>
                                </tr>

                            </table>
                        </td>
                    </tr>
                </table>
                <table class="cart_in" style="border-top: none; padding: 10px; background-color: white">
                    <tr>
                        <td>
                            <table width="700px" cellpadding="0" cellspacing="0" border="0">
                                <asp:ListView ID="ListView1" runat="server">
                                    <LayoutTemplate>
                                        <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                                    </LayoutTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblid" runat="server" Visible="false" Text='<%# Eval("Accountid") %>'></asp:Label>

                                        <tr>
                                            <td style="width: 70px; padding: 3px">
                                                <b>Name:</b>
                                            </td>
                                            <td style="width: 200px; padding: 3px" colspan="3">
                                                <asp:Label ID="LblName" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                            </td>



                                            <td style="width: 100px; padding: 3px">
                                                <b>Order No:</b>
                                            </td>
                                            <td style="width: 120px; padding: 3px">
                                                <asp:Label ID="LblOrderNo" runat="server" Text='<%# Eval("InvoiceNo") %>'></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 120px; padding: 3px">
                                                <b>Firm  Name:</b>
                                            </td>
                                            <td style="width: 200px; padding: 3px" colspan="3">
                                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("FirmName") %>'></asp:Label>
                                            </td>



                                            <td style="padding: 3px">
                                                <b>Order Date:</b>
                                            </td>
                                            <td style="padding: 3px">

                                                <asp:Label ID="Label6" runat="server" Text='<%# Eval("Date") %>'></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 120px; padding: 3px">
                                                <b>GSTIN:</b>
                                            </td>
                                            <td style="width: 200px; padding: 3px" colspan="3">
                                                <asp:Label ID="Label4" runat="server" Text='<%# Eval("Gst") %>'></asp:Label>
                                            </td>


                                            <td style="width: 100px; padding: 3px">
                                                <b>Order Time.:</b>
                                            </td>
                                            <td style="width: 120px; padding: 3px">

                                                <asp:Label ID="Label7" runat="server" Text='<%# Eval("Time") %>'></asp:Label>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td style="padding: 3px" valign="top">
                                                <b>Address:</b>
                                            </td>
                                            <td style="padding: 3px" colspan="3" valign="top">

                                                <asp:Label ID="LblAddress" runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                                            </td>
                                            <td style="padding: 3px"></td>
                                            <td style="padding: 3px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 70px; padding: 3px">
                                                <b>Mobile No:</b>
                                            </td>
                                            <td style="width: 200px; padding: 3px" colspan="3">
                                                <%# Eval("MobileNo") %>
                                          
                                            </td>
                                            <td style="width: 100px; padding: 3px"></td>
                                            <td style="width: 120px; padding: 3px"></td>
                                        </tr>

                                        <tr>
                                            <td style="padding: 3px">
                                                <b>Email Id:</b>
                                            </td>
                                            <td style="padding: 3px" colspan="3">
                                                <asp:Label ID="Label5" runat="server" Text='<%# Eval("EmailId")%>'></asp:Label>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td style="width: 70px; padding: 3px">
                                                <b>City:</b>
                                            </td>
                                            <td style="width: 200px; padding: 3px" colspan="3">
                                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("city") %>'></asp:Label>



                                            </td>
                                            <td style="width: 100px; padding: 3px"></td>
                                            <td style="width: 120px; padding: 3px"></td>
                                        </tr>

                                        <table>
                                            <tr>
                                                <td style="width: 60%">
                                                    <asp:ListView ID="lstaccount" runat="server" DataSourceID="Srcluggage">
                                                        <ItemTemplate>
                                                            <table style="margin-left: 10px">
                                                                <tr>
                                                                    <td><b>A/C.</b></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><b><%# Eval("FirmName") %></b></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><b><%# Eval("AccountName") %></b></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><b>GSTIN : <%# Eval("GstNo") %></b></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><b><%# Eval("TransPortName") %></b></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><b><%# Eval("Station") %></b></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><b><%# Eval("City") %></b></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><b><%# Eval("District_Name") %>,<%# Eval("State_Name") %></b></td>
                                                                </tr>

                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:ListView>
                                                    <asp:SqlDataSource ID="Srcluggage" runat="server" ConnectionString="<%$ ConnectionStrings:ShivShaktiSynthetics%>"
                                                        CancelSelectOnNullParameter="false" SelectCommand="Select a.*,b.State_Name,c.District_Name From  UserAccount as a INNER JOIN M_StateMaster as b On a.CityCode=b.State_Code INNER JOIN M_DistrictMaster as c ON a.StateCode=c.District_Code where a.id=@lblid">
                                                        <SelectParameters>
                                                            <asp:ControlParameter Name="lblid" ControlID="lblid" DefaultValue="0" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>

                                                </td>
                                                <td style="width: 40%"></td>
                                            </tr>
                                        </table>
                                        <div style="height: 1px; background-color: #0165a8"></div>


                                    </ItemTemplate>

                                </asp:ListView>
                            </table>
                        </td>
                    </tr>


                    <tr>
                        <td>
                            <table width="700px" cellpadding="0" cellspacing="0" class="cart_in">
                                <tr>
                                    <td style="background-color: #fbbe77;">
                                        <asp:ListView ID="ListView2" runat="server">
                                            <LayoutTemplate>
                                                <tr style="height: 35px; background-color: white; color: #000000; border-bottom: solid 0px #c8c5c5; border-top: solid 1px #c8c5c5" align="center">
                                                    <td style="width: 50px; border-right: solid 1px #c8c5c5; border-left: solid 1px #c8c5c5">
                                                        <b>Image</b>
                                                    </td>
                                                    <td style="width: 225px; border-right: solid 1px #c8c5c5">
                                                        <b>Particulars</b>
                                                    </td>
                                                    <td style="width: 225px; border-right: solid 1px #c8c5c5">
                                                        <b>Shade No.</b>
                                                    </td>

                                                    <td style="width: 50px; border-right: solid 1px #c8c5c5">
                                                        <b>Quantity</b>
                                                    </td>
                                                    <td style="width: 50px; border-right: solid 1px #c8c5c5">
                                                        <b>Cut</b>
                                                    </td>

                                                    <td style="width: 150px; border-right: solid 1px #c8c5c5">
                                                        <b>Mtr.</b>
                                                    </td>
                                                    <td style="width: 150px; border-right: solid 1px #c8c5c5">
                                                        <b>Rate</b>
                                                    </td>
                                                </tr>
                                                <asp:PlaceHolder ID="itemPlaceHolder" runat="server"></asp:PlaceHolder>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="ProductId" runat="server" Visible="false" Text='<%#Eval("ProductId") %>'></asp:Label>
                                                <asp:Label ID="lblOrderId" runat="server" Visible="false" Text='<%#Eval("OrderId") %>'></asp:Label>
                                                <asp:Label ID="ShadeId" runat="server" Visible="false" Text='<%#Eval("Id") %>'></asp:Label>
                                                <%--  <asp:Label ID="lblOrderid" runat="server" Visible="false" Text='<%# Eval("Orderid") %>'></asp:Label>--%>
                                                <%--<asp:Label ID="lblProductId" runat="server" Visible="false" Text='<%# Eval("ShadeId") %>'></asp:Label>--%>
                                                <tr style="background-color: white; color: #535353; height: 50px; border: solid 1px #c8c5c5; border-top: solid 1px #c8c5c5"
                                                    align="center">
                                                    <td style="width: 100px; border-right: solid 1px #c8c5c5; border-left: solid 1px #c8c5c5; border-bottom: solid 1px #c8c5c5;">
                                                        <img src="../img/Shade/<%# ((Convert.ToString(Eval("Image")).Length>0)?Eval("Image"):"noimage.jpg")  %>" width="100px" height="100px" />
                                                    </td>

                                                    <td style="width: 275px; text-align: left; border-right: solid 1px #c8c5c5; border-bottom: solid 1px #c8c5c5; padding-left: 3px;">
                                                        <asp:Label runat="server" ID="Label1" Text='<%# Eval("ProductName") %>'></asp:Label>


                                                    </td>
                                                    <td style="width: 275px; text-align: left; border-right: solid 1px #c8c5c5; border-bottom: solid 1px #c8c5c5; padding-left: 3px;"><%# Eval("Shadeno") %>
                                                               
                                                    </td>

                                                    <td style="width: 275px; text-align: left; border-right: solid 1px #c8c5c5; border-bottom: solid 1px #c8c5c5; padding-left: 3px;">
                                                        <%# Convert.ToInt32(Eval("Meter")) %> </b>
                                                    </td>

                                                    <td style="width: 275px; text-align: left; border-right: solid 1px #c8c5c5; border-bottom: solid 1px #c8c5c5; padding-left: 3px;"><%# Eval("CutType") %>
                                                              
                                                    </td>




                                                    <td style="width: 275px; text-align: left; border-right: solid 1px #c8c5c5; border-bottom: solid 1px #c8c5c5; padding-left: 3px;"><%# Convert.ToInt32(Eval("Quantity")) %>
                                                               
                                                    </td>
                                                    <td style="width: 275px; text-align: left; border-right: solid 1px #c8c5c5; border-bottom: solid 1px #c8c5c5; padding-left: 3px;">
                                                        <span id="Span1" visible='<%# ((Eval("CutType").ToString()=="Lump") ? true : false) %>' runat="server">Rs. <%# Eval("Lump") %></span>
                                                        <span id="Span2" visible='<%# ((Eval("CutType").ToString()=="Than") ? true : false) %>' runat="server">Rs.<%# Eval("Than") %></span>
                                                        <span id="Span3" visible='<%# ((Eval("CutType").ToString()=="Piece") ? true : false) %>' runat="server">Rs.<%# Eval("Piece") %></span>
                                                        <span id="Span4" visible='<%# ((Eval("CutType").ToString()=="Multi") ? true : false) %>' runat="server">Rs.<%# Eval("Multi") %></span>

                                                        </b>
                                                    </td>


                                                </tr>
                                            </ItemTemplate>
                                        </asp:ListView>
                                    </td>
                                </tr>



                            </table>

                            <table style="margin-top: 1px; border: solid 1px #c8c5c5; background-color: white" width="700px">
                                <tr>
                                    <td>Remark : <%# Eval("remark") %></td>
                                </tr>
                            </table>
                            <table width="700px" cellpadding="0" cellspacing="0" class="cart_in">
                                <tr>
                                    <td>
                                        <table width="700px" style="border: solid 1px #e8e5e5; background-color: #f9f8f8; margin-top: 10px; color: #000000; font-size: 10px; padding: 8px 5px 8px 5px;">
                                            <tr>
                                                <td valign="top">Supplied by: <b style="color: #961515; font-size: 11px;">Shiv Shakti Synthetics  </b>10, New Cloth Market, Pur Rd, Pratap Nagar, Chittorgarh, Rajasthan India - 311001  Mobile No.: +91-94138 84119 
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="top">
                                                    <div style="float: left; position: absolute;">
                                                        E-mail: <a href="mailto:info@ankitsuitings.com "><span style="color: #000000; font-size: 10px;">info@ankitsuitings.com </span></a>
                                                    </div>
                                                    <div style="float: right; font-size: 9px; color: #000000; padding-left: 180px;">
                                                        T&C Apply. Subject to Chittorgarh Jurisdiction
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>

                </table>
            </div>

        </div>

    </asp:Panel>
</asp:Content>
