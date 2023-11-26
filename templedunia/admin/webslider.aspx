<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="webslider.aspx.cs" Inherits="webslider" %>

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
                    <h1 class="page-head-line">Website Slider Form </h1>
                </div>
            </div>
            <div class="row">


                <asp:HiddenField ID="LblId" runat="server" />
                <div class="col-md-8">
                    <!--   Kitchen Sink -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                           Website Slider  List
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>

                                            <th>S.No</th>
                                            <th>Image (670 *535)</th>
                                            <%-- <th>Product Name</th>
                                            <th>Product Feature (2 Words)</th>--%>
                                             <th>Priority</th>
                                            <th>Link</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:ListView ID="ListView1" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td><%# Eval("id") %>
                                                      
                                                            <td>
                                                                <img src="../img/webSlider/<%# Eval("image") %>" style="height: 80px; width: 150px; border: solid 1px #cccccc" />
                                                              <br />
                                                                <asp:FileUpload ID="FileUpload1" runat="server" Visible="false" />
                                                            </td>
                                                         <%-- <td><%# Eval("title") %>
                                                             <br />
                                                                <asp:TextBox ID="txttitle" runat="server" Visible="false" Text='<%# Eval("title") %>'></asp:TextBox>
                                                            </td>
                                                          <td><%# Eval("feature") %>
                                                             <br />
                                                                <asp:TextBox ID="txtfeature" runat="server" Visible="false" Text='<%# Eval("feature") %>'></asp:TextBox>
                                                            </td>--%>
                                                          <td><%# Eval("Priority") %>
                                                              
                                                             <br />
                                                                <asp:TextBox ID="txtPriority" runat="server" Visible="false" Text='<%# Eval("Priority") %>'></asp:TextBox>
                                                            </td>
                                                            <td><%# Eval("link") %>
                                                             <br />
                                                                <asp:TextBox ID="txtlink" runat="server" Visible="false" Text='<%# Eval("link") %>'></asp:TextBox>
                                                            </td>

                                                            <asp:HiddenField ID="HdnID" runat="server" Value='<%# Eval("id") %>' />
                                                            <asp:Label ID="lblImage" runat="server" Text='<%# Eval("image") %>' Visible="false"></asp:Label>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:ListView>

                                        <%-- <asp:SqlDataSource ID="Categoray" runat="server" ConnectionString="<%$Connectionstrings:topcity %>" SelectCommand="select * from [Restaurant] where CityCode=1 and StateCode=1 order by id desc"></asp:SqlDataSource>--%>
                                    </tbody>
                                </table>
                                <div style="text-align: center">
                                    <asp:Label ID="LblErr" runat="server" ForeColor="red"></asp:Label>
                                    <asp:Button ID="Button1" runat="server" Text="Edit" class="btn btn-danger" OnClick="Button1_Click1" Style="text-align: center !important" />
                                    <asp:Button ID="Button2" runat="server" Text="Cancel" class="btn btn-primary" />

                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End  Kitchen Sink -->
                </div>

                <div class="col-md-4"></div>
            </div>
        </div>
    </div>
</asp:Content>

