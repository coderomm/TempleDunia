<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="ChangePassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <style type="text/css">
        .messagealert
        {
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       <div class="messagealert" id="alert_container">
    </div>

    <div class="content-wrapper">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h1 class="page-head-line">Change Password </h1>
                </div>
            </div>
            <div class="row">

                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                        Change Password 
                        </div>
                        <div class="panel-body">
                            <form role="form">
                               
                              

                              

                              


                              

                              
                                  <div class="form-group has-success">
                                    <label class="control-label" for="success">Old Password</label>
                                    <asp:TextBox ID="Txtold" runat="server" class="form-control"></asp:TextBox>

                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" for="success">New Password</label>
                                    <asp:TextBox ID="Txtnew" runat="server" class="form-control"></asp:TextBox>

                                </div>
                          

                                <asp:Label ID="LblErr" runat="server" ForeColor="Red"></asp:Label><br />
                                <asp:Button ID="Button1" runat="server" Class="btn-danger" Text="Submit" Style="border-style: none; padding: 5px" OnClick="Button1_Click" />

                            </form>
                            <hr />


                        </div>
                    </div>
                </div>
                <asp:HiddenField ID="LblId" runat="server" />
                <div class="col-md-6">
                    <!--   Kitchen Sink -->
                  
                    <!-- End  Kitchen Sink -->
                </div>
            </div>
        </div>
    </div>
</asp:Content>

