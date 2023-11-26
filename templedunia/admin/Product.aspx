<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="Product.aspx.cs" Inherits="Product" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<%@ Register Assembly="FredCK.FCKeditorV2" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../assets/msdropdown/dd.css" rel="stylesheet" />
    <script src="../assets/msdropdown/js/jquery.dd.js"></script>
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
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <h1 class="page-head-line">Temple Form </h1>
                </div>
            </div>
            <div class="row">

                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Temple Form
                        </div>
                        <div class="panel-body">
                            <form role="form">
                               
                                

                                <div class="row">


                                    <div class="col-md-2">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">Select State</label>
                                            <asp:DropDownList ID="DDMainCategory" runat="server" class="form-control" AutoPostBack="true" OnSelectedIndexChanged="DDMainCategory_SelectedIndexChanged" DataValueField="StateCode" DataTextField="StateName"></asp:DropDownList>

                                        </div>
                                    </div>
                                    
                                    
                                    
                                    <div class="col-md-2">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">Select District</label>
                                            <asp:DropDownList ID="ddDistrict" runat="server" class="form-control" DataValueField="DistCode" DataTextField="DistName" AutoPostBack="true" OnSelectedIndexChanged="ddDistrict_SelectedIndexChanged"></asp:DropDownList>

                                        </div>
                                    </div>

                                    <div class="col-md-2">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">Select State</label>
                                            <asp:DropDownList ID="ddTehsile" runat="server" class="form-control" DataValueField="TehsileCode" DataTextField="TehsileName"></asp:DropDownList>

                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">Temple Name</label>
                                            <asp:TextBox ID="txtproductname" runat="server" class="form-control" required="required"></asp:TextBox>

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
                                    <div class="col-md-2">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">
                                                Image 1(3000*3000)

                                            </label>
                                            <asp:FileUpload ID="FileUpload1" runat="server" />
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">Image 2 (3000*3000)</label><asp:FileUpload ID="FileUpload2" runat="server" />

                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">Image 3 (3000*3000)</label><asp:FileUpload ID="FileUpload3" runat="server" />

                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">Image 4 (3000*3000)</label><asp:FileUpload ID="FileUpload4" runat="server" />

                                        </div>
                                    </div>
                                      <div class="col-md-4">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">Seo Title</label>
                                            <asp:TextBox ID="txtseptitle" runat="server" class="form-control" required="required"></asp:TextBox>

                                        </div>
                                    </div>
                                  <div class="col-md-6">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">Seo Keyword</label>
                                            <asp:TextBox ID="txtseokeyword" runat="server" class="form-control" required="required"></asp:TextBox>

                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">Seo Description</label>
                                            <asp:TextBox ID="seoDescription" runat="server" class="form-control" required="required"></asp:TextBox>

                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success"></label>
                                         
                                    <asp:Button ID="Button2" runat="server" Class="btn btn-danger" Text="Submit" Style="border-style: none; padding: 5px" OnClick="Button2_Click" />
                                            <asp:Label ID="LblErr" runat="server" ForeColor="Red"></asp:Label><br />
                                        </div>
                                    </div>
                                </div>

                            </form>
                            <hr />


                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
                                      
</asp:Content>

