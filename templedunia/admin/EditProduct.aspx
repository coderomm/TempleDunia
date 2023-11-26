<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="EditProduct.aspx.cs" Inherits="EditProduct" %>

<%@ Register Assembly="FredCK.FCKeditorV2" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../assets/msdropdown/dd.css" rel="stylesheet" />
    <script src="../assets/msdropdown/js/jquery.dd.js"></script>

      <script type="text/javascript">

          $(document).ready(function () {

              $("#<%=ddVariant.ClientID%>").select2({

                placeholder: "Select Item",

                allowClear: true

            });

        });

    </script>
        <script type="text/javascript">

            $(document).ready(function () {

                $("#<%=ddlColor.ClientID%>").select2({

                  placeholder: "Select Item",

                  allowClear: true

              });

          });

    </script>
   <%-- <script type="text/javascript">
        $(document).ready(function (e) {
            try {
                $(".ddColor").msDropDown();
            } catch (e) {
                alert(e.message);
            }
        });
    </script>--%>

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
                    <h1 class="page-head-line">Edit Product Form </h1>
                </div>
            </div>
            <div class="row">

                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Edit Product Form
                        </div>
                          <asp:Label ID="LblEdtProductId" runat="server" Visible="false"></asp:Label>
                        <div class="panel-body">

                            <div class="row">


                                <div class="col-md-4">
                                    <div class="form-group has-success">
                                        <label class="control-label" for="success">Select Category</label>
                                        <asp:DropDownList ID="DDMainCategory" runat="server" class="form-control" DataValueField="MainCategoryId" DataTextField="MainCategoryName"></asp:DropDownList>

                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group has-success">
                                        <label class="control-label" for="success">Select Brand</label>
                                        <asp:DropDownList ID="DDbrand" runat="server" class="form-control" DataValueField="brandid" DataTextField="brandname"></asp:DropDownList>

                                    </div>
                                </div>
                            </div>

                            <div id="DivColor" runat="server" visible="false">
                                <div class="row">


                                    <div class="col-md-4">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">Select Color</label><br />
                                            <asp:DropDownList ID="ddlColor" ClientIDMode="Static" DataTextField="colorname" DataValueField="ColorId" CssClass="ddColor form-control" runat="server" Width="180">
                                            </asp:DropDownList>

                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">Select Variant </label>
                                            <asp:DropDownList ID="ddVariant" runat="server" class="form-control" DataValueField="id" DataTextField="varient"></asp:DropDownList>

                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">Quantity</label>
                                            <asp:TextBox ID="txtQuantity" runat="server" class="form-control" onkeypress='return ((event.charCode >= 48 && event.charCode <= 57)||event.keyCode == 8||event.keyCode == 9)'></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" Display="Dynamic" ValidationGroup="aaaa" ErrorMessage="Please Enter Quantity" ForeColor="Red" SetFocusOnError="true" Font-Size="XX-Small" ControlToValidate="txtQuantity"></asp:RequiredFieldValidator>

                                        </div>
                                    </div>

                                </div>
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">User Price</label>
                                            <asp:TextBox ID="txtuserprice" runat="server" class="form-control" onkeypress='return ((event.charCode >= 48 && event.charCode <= 57)||event.keyCode == 8||event.keyCode == 9)'></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ValidationGroup="aaaa" ErrorMessage="Please Enter Quantity" ForeColor="Red" SetFocusOnError="true" Font-Size="XX-Small" ControlToValidate="txtuserprice"></asp:RequiredFieldValidator>

                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">User Discount</label>
                                            <asp:TextBox ID="txtDiscount" runat="server" class="form-control" onkeypress='return ((event.charCode >= 48 && event.charCode <= 57)||event.keyCode == 8||event.keyCode == 9)'></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ValidationGroup="aaaa" ErrorMessage="Please Enter Quantity" ForeColor="Red" SetFocusOnError="true" Font-Size="XX-Small" ControlToValidate="txtDiscount"></asp:RequiredFieldValidator>

                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">Agent Price</label>
                                            <asp:TextBox ID="txtagentprice" runat="server" class="form-control" onkeypress='return ((event.charCode >= 48 && event.charCode <= 57)||event.keyCode == 8||event.keyCode == 9)'></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ValidationGroup="aaaa" ErrorMessage="Please Enter Agent Price" ForeColor="Red" SetFocusOnError="true" Font-Size="XX-Small" ControlToValidate="txtDiscount"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">Agent Discount</label>
                                            <asp:TextBox ID="txtadiscount" runat="server" class="form-control" onkeypress='return ((event.charCode >= 48 && event.charCode <= 57)||event.keyCode == 8||event.keyCode == 9)'></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic" ValidationGroup="aaaa" ErrorMessage="Please Enter Agent Discount" ForeColor="Red" SetFocusOnError="true" Font-Size="XX-Small" ControlToValidate="txtDiscount"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">
                                                Image (500*500)

                                            </label>
                                            <asp:Image runat="server" Visible="false" Width="100" Height="100" ID="ImageColor1"></asp:Image>
                                            <asp:FileUpload ID="FileUpload1" runat="server" />
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">Image 2 (500*500)</label>
                                            <asp:Image runat="server" Visible="false" Width="100" Height="100" ID="ImageColor2"></asp:Image>
                                            <asp:FileUpload ID="FileUpload2" runat="server" />

                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">Image 3 (500*500)</label>
                                            <asp:Image runat="server" Visible="false" Width="100" Height="100" ID="ImageColor3"></asp:Image>
                                            <asp:FileUpload ID="FileUpload3" runat="server" />

                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">Image 4 (500*500)</label>
                                            <asp:Image runat="server" Visible="false" Width="100" Height="100" ID="ImageColor4"></asp:Image>
                                            <asp:FileUpload ID="FileUpload4" runat="server" />

                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">Image 5 (500*500)</label>
                                            <asp:Image runat="server" Visible="false" Width="100" Height="100" ID="ImageColor5"></asp:Image>
                                            <asp:FileUpload ID="FileUpload5" runat="server" />

                                        </div>
                                    </div>
                                </div>
                                <asp:Label ID="lblTempId" runat="server" Visible="false"></asp:Label>
                                <asp:Label ID="lblSizeErr" runat="server" ForeColor="Red" Font-Size="Small" Visible="false"></asp:Label><br />
                                <asp:LinkButton ID="lnkAddColor" runat="server" class="btn-danger" Style="border-style: none; padding: 5px" OnClick="lnkAddColor_Click" Font-Size="12px" Font-Bold="true" ValidationGroup="aaaa" Text="Add"></asp:LinkButton>
                            </div>
                            <div class="row" runat="server" id="imglist">
                                <div class="table-responsive">
                                    <table class="table table-striped table-bordered table-hover">
                                        <asp:ListView ID="lstTempColorSize" runat="server" OnItemEditing="lstTempColorSize_ItemEditing" OnItemCommand="lstTempColorSize_ItemCommand">
                                            <LayoutTemplate>
                                                <tr>
                                                    <th style="width: 80px !important;">Id</th>
                                                    <th style="width: 170px !important;">Product Id</th>
                                                    <th style="width: 169px !important;">Size</th>
                                                    <th style="width: 169px !important;">Quantity</th>
                                                    <th style="width: 170px !important;">Color</th>
                                                    <th style="width: 170px !important;">User Rate</th>
                                                    <th style="width: 170px !important;">User Discount</th>
                                                    <th style="width: 170px !important;">Agent Rate</th>
                                                    <th style="width: 170px !important;">Agent Discount</th>
                                                    <th style="width: 169px !important;"></th>
                                                    <th style="width: 169px !important;"></th>
                                                </tr>
                                                <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblColorId" runat="server" Visible="false" Text='<%#Eval("ColorId") %>'></asp:Label>
                                                <asp:Label ID="lblSize" runat="server" Visible="false" Text='<%#Eval("Size") %>'></asp:Label>
                                                <asp:Label ID="lblQty" runat="server" Visible="false" Text='<%#Eval("quantity") %>'></asp:Label>
                                                <tr>
                                                    <td><%#Container.DataItemIndex+1 %></td>
                                                    <td>
                                                        <asp:Label ID="lblProid" runat="server" Text='<%#Eval("product_id") %>'></asp:Label></td>
                                                    <td><%#Eval("varient") %></td>
                                                    <td><%#Eval("quantity") %></td>
                                                    <td><%#Eval("colorname") %></td>
                                                    <td>
                                                        <asp:Label ID="lblUsrRate" runat="server" Text='<%#Eval("urate") %>'></asp:Label></td>
                                                    <td>
                                                        <asp:Label ID="lblUsrDiscount" runat="server" Text='<%#Eval("udiscount") %>'></asp:Label></td>
                                                    <td>
                                                        <asp:Label ID="lblAgentRate" runat="server" Text='<%#Eval("arate") %>'></asp:Label></td>
                                                    <td>
                                                        <asp:Label ID="lblAgentDiscount" runat="server" Text='<%#Eval("adiscount") %>'></asp:Label></td>
                                                    <td>
                                                        <asp:LinkButton ID="lnkbtnEdtColorQty" runat="server" CommandName="Edit" CommandArgument='<%#Eval("id") %>' Font-Size="12px" Font-Bold="true" Text="Edit"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        <asp:LinkButton ID="lnkDelColorQuantity" runat="server" CommandName="del" CommandArgument='<%#Eval("id") %>' Font-Size="12px" Font-Bold="true" Text="Delete"></asp:LinkButton></td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:ListView>
                                        <%--<asp:ListView ID="lstcolorlist" runat="server" OnItemCommand="lSTProducts_ItemCommand">
                                            <LayoutTemplate>
                                                <thead>
                                                    <tr>
                                                        <th>S.No</th>
                                                        <th>Color</th>
                                                        <th>Varient</th>
                                                        <th>Quantity</th>
                                                        <th>User Price</th>
                                                        <th>User Discount</th>
                                                        <th>Agent Price</th>
                                                        <th>Agent Discount</th>
                                                    </tr>
                                                </thead>
                                                <asp:PlaceHolder ID="itemPlaceHolder" runat="server"></asp:PlaceHolder>
                                            </LayoutTemplate>

                                            <ItemTemplate>
                                                <tbody>
                                                    <tr>
                                                        <asp:HiddenField ID="ProductSizeQuantityid" runat="server" Value='<%# Eval("id") %>' />

                                                        <asp:Label ID="lblvarient" runat="server" Text='<%# Eval("Size") %>' Visible="false"></asp:Label>
                                                        <asp:Label ID="lblcolor" runat="server" Text='<%# Eval("colorid") %>' Visible="false"></asp:Label>
                                                        <asp:Label ID="lblProductID" runat="server" Text='<%# Eval("ProductID") %>' Visible="false"></asp:Label>
                                                        <td><%# Container.DataItemIndex + 1 %></td>
                                                        <td>
                                                            <asp:ListView ID="lstcolor" runat="server" DataSourceID="srccolor">
                                                                <ItemTemplate>

                                                                    <img src="../assets/Color/<%# Eval("colorimg") %>" style="height: 25px; width: 25px" />
                                                                </ItemTemplate>
                                                            </asp:ListView>
                                                            <asp:SqlDataSource ID="srccolor" runat="server" ConnectionString="<%$ ConnectionStrings:DigitalMobiz%>"
                                                                CancelSelectOnNullParameter="false" SelectCommand="select * from color where colorid=@lblcolor">
                                                                <SelectParameters>
                                                                    <asp:ControlParameter Name="lblcolor" ControlID="lblcolor" DefaultValue="0" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                        </td>
                                                        <td>
                                                            <asp:ListView ID="ListView1" runat="server" DataSourceID="srclblvarient">
                                                                <ItemTemplate>
                                                                    <%# Eval("varient") %>
                                                                </ItemTemplate>
                                                            </asp:ListView>
                                                            <asp:SqlDataSource ID="srclblvarient" runat="server" ConnectionString="<%$ ConnectionStrings:DigitalMobiz%>"
                                                                CancelSelectOnNullParameter="false" SelectCommand="select * from varient where id=@lblvarient">
                                                                <SelectParameters>
                                                                    <asp:ControlParameter Name="lblvarient" ControlID="lblvarient"
                                                                        DefaultValue="0" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>

                                                        </td>
                                                        <td><%# Eval("Quantity") %></td>
                                                        <td><%# Eval("urate") %></td>
                                                        <td><%# Eval("udiscount") %></td>
                                                        <td><%# Eval("arate") %></td>
                                                        <td><%# Eval("adiscount") %></td>
                                                        <td>
                                                            <asp:ListView ID="lstimage" runat="server" DataSourceID="SqlDataSource1">
                                                                <ItemTemplate>
                                                                    <img src="../img/product/<%# Eval("ImageCode") %>" style="height: 65px; width: 65px" />
                                                                </ItemTemplate>
                                                            </asp:ListView>
                                                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DigitalMobiz%>"
                                                                CancelSelectOnNullParameter="false" SelectCommand="select * from dtl_ProductGallery where Product_Id=@lblProductID and ColorId=@lblcolor">
                                                                <SelectParameters>
                                                                    <asp:ControlParameter Name="lblProductID" ControlID="lblProductID" DefaultValue="0" />
                                                                    <asp:ControlParameter Name="lblcolor" ControlID="lblcolor" DefaultValue="0" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                        </td>

                                                        <td>
                                                            <asp:LinkButton ID="LinkButton1" runat="server" CommandName="del" Font-Bold="true" ForeColor="#3c8dbc">Delete</asp:LinkButton>

                                                        </td>


                                                    </tr>
                                                </tbody>
                                            </ItemTemplate>
                                        </asp:ListView>--%>
                                    </table>

                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group has-success">
                                        <label class="control-label" for="success">Product Name</label>
                                        <asp:TextBox ID="txtproductname" runat="server" class="form-control" required="required"></asp:TextBox>

                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group has-success">
                                        <label class="control-label" for="success">Product Meta Title</label>
                                        <asp:TextBox ID="txtmetatitle" runat="server" class="form-control" required="required"></asp:TextBox>

                                    </div>
                                </div>

                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group has-success">
                                        <label class="control-label" for="success">Description</label>
                                        <FCKeditorV2:FCKeditor ID="CKEditor1" BasePath="~/fckeditor/" runat="server" Height="400"></FCKeditorV2:FCKeditor>
                                    </div>
                                </div>
                            </div>
                              <div class="row">

                                    <div class="col-md-3">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">Unit (gm/kg)</label>
                                         <asp:TextBox ID="txtunit" runat="server" class="form-control" required="required"></asp:TextBox>

                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group has-success">
                                              <label class="control-label" for="success">Weight </label>
                                         <asp:TextBox ID="txtWeight" runat="server" class="form-control" required="required"></asp:TextBox>

                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                       
                                    </div>
                                    <div class="col-md-3">
                                       
                                    </div>
                                </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group has-success">
                                        <label class="control-label" for="success"></label>
                                        <asp:CheckBox ID="CheckBox1" runat="server" Text="Sale" />
                                        &nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:Button ID="btnUpdate" runat="server" Class="btn btn-danger" Text="Update" Style="border-style: none; padding: 5px" OnClick="btnUpdate_Click" />
                                        <asp:Label ID="LblErr" runat="server" ForeColor="Red"></asp:Label><br />
                                    </div>
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

