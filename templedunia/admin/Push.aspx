<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="Push.aspx.cs" Inherits="Push" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .RadBtnCateCss label {
            margin-left: 4px;
            /*margin-right: 15px;*/
        }

        .RadBtnCateCss td {
            padding-right: 20px;
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
                    <h1 class="page-head-line">Push Notification </h1>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Push Notification
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <asp:Label ID="Label3" runat="server" Text="" Style="color: blue;"></asp:Label>
                                <div class="col-lg-4 col-sm-4 col-md-4"></div>
                                <div class="col-lg-5 col-sm-5 col-md-5" style="text-align: center">
                                    <div class="push" style="border: solid 1px #979797; text-align: center; padding: 5px; height: 490px">
                                        <img src="../img/logo/logo.jpg" style="width: 287px; height: 66px;" />
                                        <br />
                                        <br />
                                        <asp:TextBox ID="Text1" runat="server" placeholder="Enter Title..." Style="height: 30px; width: 90%; margin-bottom: 10px;"></asp:TextBox>
                                        <asp:TextBox ID="TxtSubTitle" runat="server" placeholder="Enter SubTitle..." Style="height: 30px; width: 90%; margin-bottom: 10px;"></asp:TextBox>
                                        <asp:TextBox ID="TextBox1" runat="server" placeholder="Enter Body..." TextMode="MultiLine" Style="width: 90%; margin-bottom: 10px;"></asp:TextBox>

                                        <asp:FileUpload ID="FileUpload1" runat="server" Style="background-color: #224160; color: white; padding: 5px; border-style: none; width: 89%; margin-bottom: 6px; margin-left: 25px" />
                                        <br />
                                        <p>Optional  </p>
                                        <asp:DropDownList ID="ddtype" runat="server" Style="height: 30px; width: 90%; margin-bottom: 10px;">
                                              <asp:ListItem Text="Select" Value="1">Select</asp:ListItem>
                                            <asp:ListItem Text="Product" Value="2">Product</asp:ListItem>
                                            <asp:ListItem Text="Category" Value="3">Category</asp:ListItem>

                                        </asp:DropDownList>
                                        <asp:TextBox ID="txtproductid" runat="server" placeholder="Enter Productid / CategoryId..." Style="height: 30px; width: 90%; margin-bottom: 10px;"></asp:TextBox>

                                        <%--<asp:Button ID="btnUpload" runat="server" Text="Send" OnClick="Upload" Style="background-color:#37a451;color:white;padding:5px;border-style:none;width:30%;margin-bottom:6px;margin-left:15px"  />--%>
                                        <br />
                                        <asp:Button ID="Button1" runat="server" Text="Send" Style="background-color: #224160; color: white; padding: 5px; border-style: none; width: 45%;" OnClick="Upload" />
                                        <asp:Button ID="Button2" runat="server" Text="Cancel" Style="background-color: #224160; color: white; padding: 5px; border-style: none; width: 45%;" OnClick="Button2_Click" />

                                    </div>
                                </div>
                                <div class="col-lg-3 col-sm-3 col-md-3"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

