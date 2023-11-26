<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="AppSlider.aspx.cs" Inherits="AppSlider" %>

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
                    <h1 class="page-head-line">App Slider  Form </h1>
                </div>
            </div>

            <div class="row">


                <asp:HiddenField ID="LblId" runat="server" />
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            App Slider Forms
                        </div>
                        <div class="panel-body">
                            <form role="form">
                                <div class="form-group has-success">
                                    <label class="control-label" for="success">Type</label>
                                    <asp:DropDownList ID="ddtype" runat="server" class="form-control" OnSelectedIndexChanged="ddtype_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Text="Select Type" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Product" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Category" Value="2"></asp:ListItem>
                                   <%--     <asp:ListItem Text="Brand" Value="3"></asp:ListItem>--%>
                                    </asp:DropDownList>

                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" for="success">Select</label>
                                    <asp:DropDownList ID="DDlink" runat="server" class="form-control" DataTextField="productname" DataValueField="productid"></asp:DropDownList>
                                </div>

                                <div class="form-group has-success">
                                    <label class="control-label" for="success">Priority</label>
                                    <asp:TextBox ID="txtPriority" runat="server" class="form-control" required="required" onkeypress='return ((event.charCode >= 48 && event.charCode <= 57)||event.keyCode == 8||event.keyCode == 9)'></asp:TextBox>
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" for="success">Image (877*600)</label>

                                    <asp:FileUpload ID="FileUpload1" runat="server" />
                                    <asp:Image ID="Image1" runat="server" Style="height: 120px; width: 150px" Visible="false" />
                                </div>



                                <asp:Label ID="Label1" runat="server" ForeColor="Red"></asp:Label><br />
                                <asp:Button ID="Button3" runat="server" Class="btn-danger" Text="Submit" Style="border-style: none; padding: 5px" OnClick="Button3_Click" />

                            </form>
                            <hr />


                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <!--   Kitchen Sink -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            App Slider List
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>

                                            <th>S.No</th>
                                            <th>Image (877*600)</th>
                                            <th>Priority</th>
                                            <th>Link</th>
                                            <th>Type</th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:ListView ID="ListView1" runat="server" OnItemCommand="ListView1_ItemCommand" OnItemEditing="ListView1_ItemEditing" OnItemDeleting="ListView1_ItemDeleting">
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnlink" runat="server" Value='<%# Eval("link") %>' />
                                                <asp:HiddenField ID="hdntype" runat="server" Value='<%# Eval("type") %>' />
                                                <asp:HiddenField ID="HdnID" runat="server" Value='<%# Eval("id") %>' />
                                                <asp:Label ID="lblImage" runat="server" Text='<%# Eval("image") %>' Visible="false"></asp:Label>
                                                <tr>
                                                    <td><%# Container.DataItemIndex + 1 %></td>

                                                    <td>
                                                        <img src="../img/appslider/<%# Eval("image") %>" style="height: 80px; width: 150px; border: solid 1px #cccccc" />
                                                        <br />
                                                        <asp:FileUpload ID="FileUpload1" runat="server" Visible="false" />
                                                    </td>
                                                    <td><%# Eval("Priority") %>

                                                        <br />
                                                        <asp:TextBox ID="txtPriority" runat="server" Visible="false" Text='<%# Eval("Priority") %>' Style="width: 80px"></asp:TextBox>
                                                    </td>


                                                    <td><%# Eval("link") %>

                                                        <br />
                                                        <asp:DropDownList ID="DDlink" runat="server" Visible="false" Style="width: 150px" DataTextField="productname" DataValueField="productid"></asp:DropDownList>
                                                        <%-- <asp:TextBox ID="txtlink" runat="server" Visible="false" Text='<%# Eval("link") %>'></asp:TextBox>--%>
                                                    </td>
                                                    <td>
                                                        <%# Eval("type") %>

                                                        <br />
                                                        <asp:DropDownList ID="ddtype" runat="server" Visible="false" OnSelectedIndexChanged="ddtype_SelectedIndexChanged" AutoPostBack="true" Style="width: 100px">
                                                            <asp:ListItem Text="Product" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="Category" Value="2"></asp:ListItem>
                                                            <asp:ListItem Text="Brand" Value="3"></asp:ListItem>
                                                        </asp:DropDownList>

                                                    </td>
                                                    <td>
                                                        <asp:LinkButton ID="LinkButton1" runat="server" CommandName="edit" Visible="false">Edit</asp:LinkButton>
                                                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="Update1" Visible="false">Update</asp:LinkButton>
                                                          <asp:LinkButton ID="LinkButton3" runat="server" CommandName="Delete" ForeColor="Red" OnClientClick="return confirm('Are you sure you want to delete ?');">Delete</asp:LinkButton>

                                                    </td>





                                                </tr>
                                            </ItemTemplate>
                                        </asp:ListView>

                                        <%-- <asp:SqlDataSource ID="Categoray" runat="server" ConnectionString="<%$Connectionstrings:topcity %>" SelectCommand="select * from [Restaurant] where CityCode=1 and StateCode=1 order by id desc"></asp:SqlDataSource>--%>
                                    </tbody>
                                </table>
                                <div style="text-align: center;">
                                    <asp:Label ID="LblErr" runat="server" ForeColor="red"></asp:Label>
                                    <asp:Button ID="Button1" runat="server" Text="Edit" Visible="false" class="btn btn-danger" OnClick="Button1_Click1" Style="text-align: center !important" />
                                    <asp:Button ID="Button2" runat="server" Text="Cancel" Visible="false" class="btn btn-primary" />

                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End  Kitchen Sink -->
                </div>


            </div>
        </div>
    </div>
</asp:Content>

