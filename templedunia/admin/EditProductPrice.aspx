<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="EditProductPrice.aspx.cs" Inherits="EditProductPrice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="messagealert" id="alert_container">
    </div>


    <div class="content-wrapper">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h1 class="page-head-line">Edit Product Price Form </h1>
                </div>
            </div>
            <div class="row">

                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Edit Product Price Form
                        </div>
                        <div class="panel-body">

                            <div class="row">


                                <div class="col-md-4">
                                    <div class="form-group has-success">
                                        <label class="control-label" for="success">Select Category</label>
                                        <asp:DropDownList ID="DDMainCategory" DataSourceID="SrcDDMainCategory" runat="server" AutoPostBack="true" class="form-control" DataValueField="MainCategoryId" DataTextField="MainCategoryName"></asp:DropDownList>
                                        <asp:SqlDataSource ID="SrcDDMainCategory" runat="server" ConnectionString="<%$Connectionstrings:DigitalMobiz %>" SelectCommand="Select 'MainCategoryId'=-1,'MainCategoryName'='Select Main Category' union  select MainCategoryId,MainCategoryName from M_CategoryMaster where  active=1"></asp:SqlDataSource>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                </div>

                            </div>


                            <div class="row" runat="server" id="imglist">
                                <div class="table-responsive">
                                    <asp:UpdatePanel ID="updtPnlProdct" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <table class="table table-striped table-bordered table-hover">
                                                <asp:ListView ID="LstProduct" runat="server" DataSourceID="Srclstcolorlist" OnItemCommand="lstcolorlist_ItemCommand">
                                                    <LayoutTemplate>
                                                        <thead>
                                                            <tr>
                                                                <th>
                                                                    <asp:LinkButton ID="LkBtnActive" runat="server" CommandName="DeActive">Activated</asp:LinkButton>
                                                                </th>
                                                                <th>S.No</th>
                                                                <th>ID</th>
                                                                <th>Image</th>
                                                                <th>Product Name</th>
                                                             
                                                             <th>
                                                                    <b>Qty</b>
                                                                </th>
                                                                <th>
                                                                    <b>Price</b>
                                                                </th>
                                                                <th>
                                                                    <b>Discount</b>
                                                                </th>
                                                                <td>
                                                                    <asp:LinkButton ID="LnkUpPrice" Visible="true" runat="server" CommandName="UpPrice">Update</asp:LinkButton>&nbsp;&nbsp;<asp:LinkButton ID="LnkCancelPrice" runat="server" Visible="false" CommandName="CancelPrice">Cancel</asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                        </thead>
                                                        <asp:PlaceHolder ID="itemPlaceHolder" runat="server"></asp:PlaceHolder>
                                                    </LayoutTemplate>

                                                    <ItemTemplate>
                                                        <asp:Label ID="LblProductId" runat="server" Visible="false" Text='<%#Eval("ProductId") %>'></asp:Label>
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

                                                                

                                                                  <td>
                                                                                        <asp:Label ID="lblQty" runat="server" Visible="false" Text='<%#Eval("qty") %>'></asp:Label>
                                                                                        <asp:TextBox ID="txtQty" runat="server" class="form-control" Width="50px" Visible="true" Text='<%# Eval("qty")%>'></asp:TextBox>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:Label ID="LblPrice" runat="server" Visible="false" Text='<%#Eval("price") %>'></asp:Label>
                                                                                        <asp:TextBox ID="TxtPrice" runat="server" class="form-control" Width="65px" Visible="true" Text='<%# Eval("price")%>'></asp:TextBox>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:Label ID="lblDis" runat="server" Visible="false" Text='<%#Eval("discount") %>'></asp:Label>
                                                                                        <asp:Label ID="lblNewDiscount" runat="server" Visible="false"></asp:Label>
                                                                                        <asp:TextBox ID="txtDisSize" runat="server" class="form-control" Width="65px" Text='<%# Eval("discount")%>' Visible="true"></asp:TextBox>
                                                                                    </td>

                                                            </tr>
                                                        </tbody>
                                                    </ItemTemplate>
                                                </asp:ListView>
                                            </table>
                                            <asp:SqlDataSource ID="Srclstcolorlist" runat="server" ConnectionString="<%$Connectionstrings:DigitalMobiz %>" SelectCommand="select a.* from Product as a where a.categoryid=@CateId and a.active=1 order by a.productid desc">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="DDMainCategory" Name="CateId" Type="Int32" />

                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
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

