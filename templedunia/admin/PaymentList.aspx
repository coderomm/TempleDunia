<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="PaymentList.aspx.cs" Inherits="PaymentList" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
            z-index:1;
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
    <div class="content-wrapper">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h1 class="page-head-line">Payment List  </h1>
                </div>
            </div>
            <div class="row">
                <div class="col-md-7">
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-striped">

                                <tr>
                                  
                                       <%-- <div class="form-group has-success">
                                                 <div class="form-group has-success">
                                            <label class="control-label" for="success">Search By Order No.</label>
                                            <asp:TextBox ID="Txtorder" runat="server" class="form-control MainSearchBar"></asp:TextBox>
                                                         <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" ServicePath="~/sellproduct.asmx"
                                                        ServiceMethod="OrderSearch" CompletionInterval="10" CompletionListItemCssClass="AutoCompliteItem"
                                                        CompletionListCssClass="AutoComplite" CompletionListHighlightedItemCssClass="AutoCompliteSelectedItem"
                                                        FirstRowSelected="true" MinimumPrefixLength="1" TargetControlID="Txtorder">
                                                    </cc1:AutoCompleteExtender>
                                          </div>

                                        </div>--%>
                                  
                                    <td style="width: 40%">
                                    
                                        <div class="form-group has-success">
                                                 <div class="form-group has-success">
                                            <label class="control-label" for="success">Search By Party Name</label>
                                            <asp:TextBox ID="Txtparty" runat="server"   class="form-control MainSearchBar"></asp:TextBox>
                                           <cc1:AutoCompleteExtender ID="AutoCompleteExtProduct" runat="server" ServicePath="~/sellproduct.asmx"
                                                        ServiceMethod="Partname" CompletionInterval="10" CompletionListItemCssClass="AutoCompliteItem"
                                                        CompletionListCssClass="AutoComplite" CompletionListHighlightedItemCssClass="AutoCompliteSelectedItem"
                                                        FirstRowSelected="true" MinimumPrefixLength="1" TargetControlID="Txtparty">
                                                    </cc1:AutoCompleteExtender>
</div>
                                        </div>
                                    </td>

                                      <td style="width: 20%">
                                          <div class="form-group has-success">
                                                 <div class="form-group has-success">
                                   <label class="control-label" for="success">.</label>
                                             <asp:Button ID="Button1" runat="server" Text="Search " class="btn btn-danger form-control" Style="text-align:center !important;border-style:none" OnClick="Button1_Click" />
                                          
</div>
                                        </div>
                                      </td>
                                      
                                </tr>
                            </table>
                        </div>
                    </div>

                </div>
                <div class="col-md-5"></div>
            </div>
            <div class="row">

                <asp:HiddenField ID="HiddenField1" runat="server" />
                <div class="col-md-12">
                    <!--   Kitchen Sink -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Payment  List
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">



                                <table class="table table-striped table-bordered table-hover">
                                    <asp:ListView ID="LstActive" runat="server">
                                        <LayoutTemplate>
                                            <thead>
                                                <tr>
                                                    <th>S.No</th>
                                                    <th>Date</th>
                                                    <th>Payment Mode</th>
                                                      <th>InvoiceNo</th>
                                                    
                                                    <th>Amount</th>
                                                    <th>Again Bill</th>
                                                    <th>Description</th>
                                                    <th>Bank Name</th>
                                                    <th>DD/Cheque No.</th>

                                                    


                                                </tr>
                                            </thead>
                                            <asp:PlaceHolder ID="Itemplaceholder" runat="server"></asp:PlaceHolder>
                                        </LayoutTemplate>

                                        <ItemTemplate>
                                            <tr>
                                               
                                                <td><%# Container.DataItemIndex + 1 %></td>
                                                   <td><%# Eval("Date") %></td>
                                                <td>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# ((Convert.ToInt32(Eval("Mode")) ==0) ? "Bank Mode" : "Cash Mode") %>'></asp:Label></td>
                                                <td><%# Eval("InvoiceNo") %></td>
                                                 <td><%# Eval("Amount") %></td>
                                                 <td><%# Eval("againstbill") %></td>
                                                 <td><%# Eval("Description") %></td>
                                                 <td><%# Eval("BankName") %></td>
                                                <td><%# Eval("DDChequeno") %></td>

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
</asp:Content>

