<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="addyoutube.aspx.cs" Inherits="addyoutube" %>

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
                    <h1 class="page-head-line">Youtube  Form </h1>
                </div>
            </div>
            <div class="row">

                <div class="col-md-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                          Youtube Forms
                        </div>
                        <div class="panel-body">
                            <form role="form">
                                <div class="form-group has-success">
                                    <label class="control-label" for="success">Title</label>
                                    <asp:TextBox ID="Txttitle" runat="server" class="form-control"></asp:TextBox>

                                </div>

                                  <div class="form-group has-success">
                                    <label class="control-label" for="success">Link</label>
                                    <asp:TextBox ID="txtproductlink" runat="server" class="form-control"></asp:TextBox>

                                </div>
                                <div class="form-group has-success" runat="server" visible="false">
                                    <label class="control-label" for="success">Category Image</label>

                                    <asp:FileUpload ID="FileUpload1" runat="server" />
                                    <asp:Image ID="Image1" runat="server" Style="height: 120px; width: 150px" Visible="false" />
                                </div>
                                   <div class="form-group has-success" runat="server" visible="false">
                                    <label class="control-label" for="success">Banner Image</label>

                                    <asp:FileUpload ID="FileUpload2" runat="server" />
                                    <asp:Image ID="Image2" runat="server" Style="height: 120px; width: 150px" Visible="false" />
                                </div>


                                <asp:Label ID="LblErr" runat="server" ForeColor="Red"></asp:Label><br />
                                <asp:Button ID="Button1" runat="server" Class="btn-danger" Text="Submit" Style="border-style: none; padding: 5px" OnClick="Button1_Click" />

                            </form>
                            <hr />


                        </div>
                    </div>
                </div>
                <asp:HiddenField ID="LblId" runat="server" />
                <div class="col-md-8">
                    <!--   Kitchen Sink -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            List
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>S.No</th>
                                            <th>Name</th>
                                           
                                           
                                            <th>Edit</th>


                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:ListView ID="ListView1" runat="server" OnItemCommand="ListView1_ItemCommand">
                                            <ItemTemplate>
                                                <tr>
                                                    <asp:HiddenField ID="HdnID" runat="server" Value='<%# Eval("MainCategoryid") %>' />

                                                    <asp:Label ID="lbltitle" runat="server" Text='<%# Eval("MainCategoryName") %>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblImage" runat="server" Text='<%# Eval("image") %>' Visible="false"></asp:Label>
                                                     <asp:Label ID="lblpid" runat="server" Text='<%# Eval("pid") %>' Visible="false"></asp:Label>


                                                        <td><%#Container.DataItemIndex+1%></td>
                                                    <td><%# Eval("MainCategoryName") %></td>
                                                    

                                                    <td>
                                                        <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Edt" Font-Bold="true" ForeColor="#3c8dbc">Edit</asp:LinkButton>

                                                    </td>
                                                      <td>
                                                        <%--<asp:LinkButton ID="LinkButton2" runat="server" CommandName="delte" Font-Bold="true" ForeColor="#3c8dbc">Delete</asp:LinkButton>--%>
<asp:LinkButton ID="LinkButton3" runat="server" CommandName="deactive" Font-Bold="true" CssClass="btn-success" Visible='<%# ((Eval("active").ToString()=="1") ? true : false) %>' Style="padding: 4px 6px; text-decoration: none; background-color: grey; border-radius: 5px; font-family: 'Times New Roman'">De-active <i class="fa fa-ban"></i></asp:LinkButton>&nbsp;<asp:LinkButton ID="LinkButton5" runat="server" CommandName="active" Font-Bold="true" CssClass="btn-success" Visible='<%# ((Eval("active").ToString()=="0") ? true : false) %>' Style="padding: 4px 6px; text-decoration: none; background-color: #018636; border-radius: 5px; font-family: 'Times New Roman'">Active <i class="fa fa-ban"></i></asp:LinkButton>
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

