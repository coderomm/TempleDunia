<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="EditProductlist.aspx.cs" Inherits="EditProductlist" %>

<%@ Register Assembly="FredCK.FCKeditorV2" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>
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
                    <h1 class="page-head-line">Edit Product Form </h1>
                </div>
            </div>
            <div class="row">

                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Edit Product Form
                        </div>
                        <div class="panel-body">

                            <div class="row">


                                <div class="col-md-4">
                                    <div class="form-group has-success">
                                        <label class="control-label" for="success">Select Category</label>
                                        <asp:DropDownList ID="DDMainCategory" DataSourceID="SrcDDMainCategory" runat="server"  class="form-control" DataValueField="MainCategoryId" DataTextField="MainCategoryName"></asp:DropDownList>
                                        <asp:SqlDataSource ID="SrcDDMainCategory" runat="server" ConnectionString="<%$Connectionstrings:DigitalMobiz %>" SelectCommand="Select 'MainCategoryId'=-1,'MainCategoryName'='Select Main Category' union  select MainCategoryId,MainCategoryName from M_CategoryMaster where  active=1"></asp:SqlDataSource>
                                    </div>
                                </div>
                               
                                  <div class="col-md-4">
                                    <div class="form-group has-success">
                                       <br />
                                        
                                        <asp:Button ID="Button1" runat="server" Text="Submit" Class="btn-danger"  OnClick="Button1_Click"/>
                                        </div>
                                      </div> <div class="col-md-4">
                                   
                                </div>
                            </div>
                                <asp:HiddenField ID="LblId" runat="server" />

                            <div class="row" runat="server" id="imglist">
                                <div class="table-responsive">
                                    <table class="table table-striped table-bordered table-hover">
                                        <asp:ListView ID="lstcolorlist" runat="server"  OnItemCommand="lstcolorlist_ItemCommand">
                                            <LayoutTemplate>
                                                <thead>
                                                    <tr>
                                                        <th>
                                                            <asp:LinkButton ID="LkBtnActive" runat="server" CommandName="DeActive">Activated</asp:LinkButton>
                                                        </th>
                                                        <th>S.No</th>
                                                        <th>Product ID</th>
                                                        <th>Image</th>
                                                        <th>Product Name</th>
                                                     
                                                        <th>Price</th>
                                                          <th>Discount</th>
                                                    </tr>
                                                </thead>
                                                <asp:PlaceHolder ID="itemPlaceHolder" runat="server"></asp:PlaceHolder>
                                            </LayoutTemplate>

                                            <ItemTemplate>
                                                <asp:Label ID="LblProductId" runat="server" Text='<%#Eval("ProductID") %>' Visible="false"></asp:Label>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <asp:CheckBox ID="ChkBoxDA" runat="server" Checked='<%#Convert.ToInt32( Eval("Active")) ==1 ? true : false %>' />
                                                        </td>
                                                        <td><%# Container.DataItemIndex + 1 %></td>
                                                        <td>
                                                            <%#Eval("ProductID") %>
                                                        </td>
                                                        <td>
                                                            <img src="../img/product/<%#Eval("image") %>" width="50" height="50" />
                                                        </td>
                                                        <td><%# Eval("productname") %></td>
                                                      
                                                        <td><%# Eval("price") %></td>
                                                          <td><%# Eval("discount") %></td>

                                                        <td>
                                                            <a href='pedit.aspx?id=<%#Eval("productid") %>' style="color: #3c8dbc; font-weight: 400">Edit</a>


                                                        </td>
                                                          <td> <asp:HiddenField ID="HdnID" runat="server" Value='<%# Eval("ProductID") %>' />
                                                        <%--<asp:LinkButton ID="LinkButton2" runat="server" CommandName="delte" Font-Bold="true" ForeColor="#3c8dbc" OnClientClick="return confirm('Are you sure you want to delete ?');">Delete</asp:LinkButton>--%>

                                                    </td>
                                                        <td>
                                                            <asp:LinkButton ID="LinkButton3" runat="server" CommandName="deactive" Font-Bold="true" CssClass="btn-success" Visible='<%# ((Eval("active").ToString()=="True") ? true : false) %>' Style="padding: 4px 6px; text-decoration: none; background-color: grey; border-radius: 5px; font-family: 'Times New Roman'">De-active <i class="fa fa-ban"></i></asp:LinkButton>&nbsp;<asp:LinkButton ID="LinkButton5" runat="server" CommandName="active" Font-Bold="true" CssClass="btn-success" Visible='<%# ((Eval("active").ToString()=="False") ? true : false) %>' Style="padding: 4px 6px; text-decoration: none; background-color: #018636; border-radius: 5px; font-family: 'Times New Roman'">Active <i class="fa fa-ban"></i></asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </ItemTemplate>
                                        </asp:ListView>
                                    </table>
                                    <asp:SqlDataSource ID="Srclstcolorlist" runat="server" ConnectionString="<%$Connectionstrings:DigitalMobiz %>" SelectCommand="select a.*,b.brandname from Product as a left join brand as b on a.brandid=b.brandid where a.categoryid=@CateId and a.brandid=@BrandId order by a.productid desc">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="DDMainCategory" Name="CateId" Type="Int32" />
                                           
                                        </SelectParameters>
                                    </asp:SqlDataSource>
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

