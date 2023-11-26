<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="review.aspx.cs" Inherits="review" %>

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
                    <h1 class="page-head-line">Review </h1>
                </div>
            </div>
            <div class="row">

                
                <asp:HiddenField ID="LblId" runat="server" />
                <div class="col-md-12">
                    <!--   Kitchen Sink -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Review List
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>S.No</th>
                                            <th>Product Name</th>
                                            <th>Name</th>
                                            <th>Mobile</th>
                                            <th>Comment</th>
                                            <th></th>
                                            </tr>
                                            </thead>
                                    <tbody>
                                        <asp:ListView ID="ListView1" runat="server" OnItemCommand="ListView1_ItemCommand">
                                            <ItemTemplate>
                                                <tr>
                                                    <asp:HiddenField ID="HdnID" runat="server" Value='<%# Eval("idp") %>' />

                                                 

                                                        <td><%#Container.DataItemIndex+1%></td>
                                                    <td><%# Eval("productname") %></td>
                                                       <td><%# Eval("name") %></td>
                                                       <td><%# Eval("mobile") %></td>
                                                       <td><%# Eval("comment") %></td>
                                                    
                                                 

                                                    
                                                      <td>
                                                        <%--<asp:LinkButton ID="LinkButton2" runat="server" CommandName="delte" Font-Bold="true" ForeColor="#3c8dbc">Delete</asp:LinkButton>--%>
<asp:LinkButton ID="LinkButton3" runat="server" CommandName="del" Font-Bold="true" CssClass="btn-success" Style="padding: 4px 6px; text-decoration: none; background-color: grey; border-radius: 5px; font-family: 'Times New Roman'">Delete <i class="fa fa-ban"></i></asp:LinkButton>&nbsp;<asp:LinkButton ID="LinkButton5" runat="server" CommandName="active" Font-Bold="true" CssClass="btn-success"  Style="padding: 4px 6px; text-decoration: none; background-color: #018636; border-radius: 5px; font-family: 'Times New Roman'">Active <i class="fa fa-ban"></i></asp:LinkButton>
                                                    </td>

                                                </tr>
                                            </ItemTemplate>
                                        </asp:ListView>

                                        <%-- <asp:SqlDataSource ID="Categoray" runat="server" ConnectionString="<%$Connectionstrings:topcity %>" SelectCommand="select * from [Restaurant] where CityCode=1 and StateCode=1 order by id desc"></asp:SqlDataSource>--%>
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
</asp:Content>

