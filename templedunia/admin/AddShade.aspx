<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="AddShade.aspx.cs" Inherits="AddShade" %>

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
                    <h1 class="page-head-line">Shade  Forms </h1>
                </div>
            </div>
            <div class="row">

                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Shade  Forms
                        </div>
                        <div class="panel-body">
                            <form role="form">
                                <div class="form-group has-success">
                                    <label class="control-label" for="success">Select  Products</label>
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <asp:DropDownList ID="DDProducts" runat="server" class="form-control" DataValueField="ProductId" DataTextField="ProductName" AutoPostBack="true"></asp:DropDownList>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>



                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" for="success">Shade No.</label>
                                    <asp:TextBox ID="Txtshade" runat="server" class="form-control"></asp:TextBox>

                                </div>

                                <div class="form-group has-success">
                                    <label class="control-label" for="success">Quantity</label>
                                    <asp:TextBox ID="TxtQuantity" runat="server" class="form-control"></asp:TextBox>

                                </div>

                                <div class="form-group has-success">
                                    <label class="control-label" for="success">Unit</label>
                                    <asp:TextBox ID="TxtUnit" runat="server" class="form-control"></asp:TextBox>

                                </div>


                                <div class="form-group has-success">
                                    <label class="control-label" for="success">Description</label>
                                    <asp:TextBox ID="Txtdescription" runat="server" class="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>

                                </div>
                                   <div class="form-group has-success">
                                    <label class="control-label" for="success">Extra Charges</label>
                                    <asp:TextBox ID="Txtextra" runat="server" class="form-control"></asp:TextBox>

                                </div>

                                <div class="form-group has-success">
                                    <label class="control-label" for="success">Image</label>
                                    <asp:FileUpload ID="FileUpload1" runat="server" />
                                    <asp:Image ID="Image1" runat="server" Style="height: 120px; width: 150px" Visible="false" />


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
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Shade  List
                        </div>
                     
<div class="row">
                            <div class="col-md-3">
                                
                            </div>
                            <div class="col-md-6">
                                <div class="form-group has-success">
                                    <label class="control-label" for="success"></label>
                                    <asp:DropDownList ID="DDproducts2" runat="server" class="form-control" DataValueField="ProductId" DataTextField="ProductName" AutoPostBack="true" OnSelectedIndexChanged="DDproducts2_SelectedIndexChanged"></asp:DropDownList>

                                </div>
                            </div> 
      <div class="col-md-3">
                                
                            </div>
                        </div>
                 
                        


                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>S.No</th>
                                            <th>Shade No</th>
                                            <th>Image</th>

                                            <th>Edit</th>


                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:ListView ID="lSTProducts" runat="server" OnItemCommand="ListView1_ItemCommand">
                                            <ItemTemplate>
                                                <tr>
                                                    <asp:HiddenField ID="HdnID" runat="server" Value='<%# Eval("Id") %>' />

                                                    <asp:Label ID="lblShadeNo" runat="server" Text='<%# Eval("ShadeNo") %>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblCategoryId" runat="server" Text='<%# Eval("ProductId") %>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblQuantity" runat="server" Text='<%# Eval("Quantity") %>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lnlUnit" runat="server" Text='<%# Eval("Unit") %>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>' Visible="false"></asp:Label>
                                                      <asp:Label ID="lblextra" runat="server" Text='<%# Eval("ExtraCharge") %>' Visible="false"></asp:Label>

                                                    <asp:Label ID="lblImage" runat="server" Text='<%# Eval("Image") %>' Visible="false"></asp:Label>



                                                    <td><%# Container.DataItemIndex + 1 %></td>
                                                    <td><%# Eval("ShadeNo") %></td>
                                                    <td>
                                                        <img src="../img/shade/<%# Eval("image") %>" style="height:130px;width:200px;border:solid 1px #cccccc"  /></td>

                                                    <td>
                                                        <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Edt" Font-Bold="true" ForeColor="#3c8dbc">Edit</asp:LinkButton></td>


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

