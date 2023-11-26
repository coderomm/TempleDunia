<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="pedit.aspx.cs" Inherits="pedit" %>

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
                <div class="col-md-8">
                    <h1 class="page-head-line">Edit Product Form </h1>
                </div>
                 <div class="col-md-4" style="text-align:right">
                     <br />
                     <a href="EditProductlist.aspx" class="btn btn-danger">Back</a>
                       </div>
            </div>
            <div class="row">

                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Edit Product Form
                        </div>
                          <asp:Label ID="LblEdtProductId" runat="server" Visible="false"></asp:Label>
                        <div class="panel-body">

                            <div class="row">
                                 <div class="col-md-12">
                                    <div class="form-group has-success">
                                        <label class="control-label" for="success">Product Name</label>
                                        <asp:TextBox ID="txtproductname" runat="server" class="form-control" required="required"></asp:TextBox>

                                    </div>
                                </div>

                               
                                
                            </div>

                         
                                
                                <div class="row">
                                     <div class="col-md-3">
                                    <div class="form-group has-success">
                                        <label class="control-label" for="success">Select Category</label>
                                        <asp:DropDownList ID="DDMainCategory" runat="server" class="form-control" DataValueField="MainCategoryId" DataTextField="MainCategoryName"></asp:DropDownList>

                                    </div>
                                </div>
                                    <div class="col-md-3">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">Quantity</label>
                                            <asp:TextBox ID="txtQuantity" runat="server" class="form-control" onkeypress='return ((event.charCode >= 48 && event.charCode <= 57)||event.keyCode == 8||event.keyCode == 9)'></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" Display="Dynamic" ValidationGroup="aaaa" ErrorMessage="Please Enter Quantity" ForeColor="Red" SetFocusOnError="true" Font-Size="XX-Small" ControlToValidate="txtQuantity"></asp:RequiredFieldValidator>

                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">User Price</label>
                                            <asp:TextBox ID="txtuserprice" runat="server" class="form-control" onkeypress='return ((event.charCode >= 48 && event.charCode <= 57)||event.keyCode == 8||event.keyCode == 9)'></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ValidationGroup="aaaa" ErrorMessage="Please Enter Quantity" ForeColor="Red" SetFocusOnError="true" Font-Size="XX-Small" ControlToValidate="txtuserprice"></asp:RequiredFieldValidator>

                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">User Discount</label>
                                            <asp:TextBox ID="txtDiscount" runat="server" class="form-control" onkeypress='return ((event.charCode >= 48 && event.charCode <= 57)||event.keyCode == 8||event.keyCode == 9)'></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ValidationGroup="aaaa" ErrorMessage="Please Enter Quantity" ForeColor="Red" SetFocusOnError="true" Font-Size="XX-Small" ControlToValidate="txtDiscount"></asp:RequiredFieldValidator>

                                        </div>
                                    </div>

                                 
                                </div>
                                <div class="row">
                                    <div class="col-md-2">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">
                                                Image 1(3000*3000)

                                            </label>
                                            <asp:Image runat="server" Visible="false" Width="100" Height="100" ID="ImageColor1"></asp:Image>
                                            <asp:FileUpload ID="FileUpload1" runat="server" />
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">Image 2 (3000*3000)</label>
                                            <asp:Image runat="server" Visible="false" Width="100" Height="100" ID="ImageColor2"></asp:Image>
                                            <asp:FileUpload ID="FileUpload2" runat="server" />

                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">Image 3 (3000*3000)</label>
                                            <asp:Image runat="server" Visible="false" Width="100" Height="100" ID="ImageColor3"></asp:Image>
                                            <asp:FileUpload ID="FileUpload3" runat="server" />

                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">Image 4 (3000*3000)</label>
                                            <asp:Image runat="server" Visible="false" Width="100" Height="100" ID="ImageColor4"></asp:Image>
                                            <asp:FileUpload ID="FileUpload4" runat="server" />

                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">Image 5 (3000*3000)</label>
                                               <asp:Image runat="server" Visible="false" Width="100" Height="100" ID="ImageColor5"></asp:Image>
                                            <asp:FileUpload ID="FileUpload5" runat="server" />

                                        </div>
                                    </div>
                                     <div class="col-md-2">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">Image 6 (3000*3000)</label>
                                               <asp:Image runat="server" Visible="false" Width="100" Height="100" ID="ImageColor6"></asp:Image>
                                            <asp:FileUpload ID="FileUpload6" runat="server" />

                                        </div>
                                    </div>
                                  
                                </div>
                                <asp:Label ID="lblTempId" runat="server" Visible="false"></asp:Label>
                                <asp:Label ID="lblSizeErr" runat="server" ForeColor="Red" Font-Size="Small" Visible="false"></asp:Label><br />
                              
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

                                    <div class="col-md-3">
                                        <div class="form-group has-success">
                                            <label class="control-label" for="success">Unit (gm/kg)</label>
                                         <asp:TextBox ID="txtunit" runat="server" class="form-control" required="required"></asp:TextBox>

                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group has-success">
                                              <label class="control-label" for="success">Weight </label>
                                         <asp:TextBox ID="txtWeight" runat="server" class="form-control" required="required"></asp:TextBox>

                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                      <div class="form-group has-success">
                                              <label class="control-label" for="success">Product Link </label>
                                         <asp:TextBox ID="txtplink" runat="server" class="form-control" required="required" ></asp:TextBox>

                                        </div> 
                                    </div>
                                    <div class="col-md-3">
                                       
                                    </div>
                                </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group has-success">
                                        <label class="control-label" for="success"></label>
                                        <asp:CheckBox ID="CheckBox1" runat="server" Text="Sale" />
                                        &nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:Button ID="btnUpdate" runat="server" Class="btn btn-danger" Text="Update" Style="border-style: none; padding: 5px" OnClick="btnUpdate_Click" />
                                        <asp:Label ID="LblErr" runat="server" ForeColor="Red"></asp:Label><br />
                                    </div>
                                </div>
                            </div>
                            <hr />


                        </div>
                    </div>
                </div>

            </div>
        </div>
    
</asp:Content>

