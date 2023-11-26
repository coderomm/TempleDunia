<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="AddProdcuts.aspx.cs" Inherits="AddProdcuts" %>

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
                    <h1 class="page-head-line"> Products  Forms </h1>
                </div>
            </div>
            <div class="row">

                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                         Products  Forms
                        </div>
                        <div class="panel-body">
                            <form role="form">
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                         <ContentTemplate>
                                 <div class="form-group has-success">
                                    <label class="control-label" for="success">Select Main Category</label>
                                     
                                             <asp:DropDownList ID="DDMainCategory" runat="server" class="form-control" DataValueField="MainCategoryId" DataTextField="MainCategoryName" AutoPostBack="true" OnSelectedIndexChanged="DDMainCategory_SelectedIndexChanged"></asp:DropDownList>
                                        
                                    

                                </div> 

                                    <div class="form-group has-success">
                                    <label class="control-label" for="success">Select Sub-Category Name</label>
                                      <asp:DropDownList ID="DDSub" runat="server" class="form-control" DataValueField="id" DataTextField="SubCategoryName" AutoPostBack="true"></asp:DropDownList>

                                </div> 

                                 </ContentTemplate>
                                     </asp:UpdatePanel>
                                     


                                <div class="form-group has-success">
                                    <label class="control-label" for="success">Products Name</label>
                                    <asp:TextBox ID="Txtproducts" runat="server" class="form-control" required="required"></asp:TextBox>

                                </div> 

                              <div class="form-group has-success">
                                    <label class="control-label" for="success">Blend</label>
                                    <asp:TextBox ID="Txtblend" runat="server" class="form-control" TextMode="MultiLine" Rows="2" required="required"></asp:TextBox>

                                </div>
                                
                            <div class="form-group has-success">
                                    <label class="control-label" for="success">Width</label>
                                    <asp:TextBox ID="TxtWidth" runat="server" class="form-control" TextMode="MultiLine" Rows="2" required="required"></asp:TextBox>

                                </div>
                                  <div class="form-group has-success">
                                    <label class="control-label" for="success">Weight</label>
                                    <asp:TextBox ID="TxtWeight" runat="server" class="form-control" TextMode="MultiLine" Rows="2" required="required"></asp:TextBox>

                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" for="success">Rate</label>
                                    <asp:TextBox ID="Txtrate" runat="server" class="form-control"></asp:TextBox>

                                </div>

                                <div class="form-group has-success">
                                    <label class="control-label" for="success">Lump Rate</label>
                                    <asp:TextBox ID="Txtlump" runat="server" class="form-control"></asp:TextBox>

                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" for="success">Than Rate (Lump +)</label>
                                    <asp:TextBox ID="Txtthan" runat="server" class="form-control"></asp:TextBox>

                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" for="success">Piece Rate (Than+)</label>
                                    <asp:TextBox ID="TxtPiece" runat="server" class="form-control"></asp:TextBox>

                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" for="success">Multi Rate (Piece)</label>
                                    <asp:TextBox ID="Txtmulti" runat="server" class="form-control"></asp:TextBox>

                                </div>

                                <div class="form-group has-success">
                                    <label class="control-label" for="success">Description</label>
                                    <asp:TextBox ID="Txtdescription" runat="server" class="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                        <script type="text/javascript">
                                            CKEDITOR.replace('<%=Txtdescription.ClientID%>');
                                    </script>
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
                            Products List
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>S.No</th>
                                            <th>Products Name</th>                          
                                            
                                              
                                            <th>Edit</th>


                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:ListView ID="lSTProducts" runat="server" OnItemCommand="ListView1_ItemCommand">
                                            <ItemTemplate>
                                                <tr>
                                                    <asp:HiddenField ID="HdnID" runat="server" Value='<%# Eval("ProductId") %>' />
                                                  
                                                    <asp:Label ID="lblProductName" runat="server" Text='<%# Eval("ProductName") %>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblCategoryId" runat="server" Text='<%# Eval("CategoryId") %>' Visible="false"></asp:Label>
                                                      <asp:Label ID="lblsubid" runat="server" Text='<%# Eval("SubCategoryId") %>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblBlend" runat="server" Text='<%# Eval("Blend") %>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblWidth" runat="server" Text='<%# Eval("Width") %>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblRate" runat="server" Text='<%# Eval("Rate") %>' Visible="false"></asp:Label>
                                                     <asp:Label ID="lblWeight" runat="server" Text='<%# Eval("Weight") %>' Visible="false"></asp:Label>
                                                    
                                                       <asp:Label ID="lblRemark" runat="server" Text='<%# Eval("Remark") %>' Visible="false"></asp:Label>
                                                     
                                                     <asp:Label ID="lblLump" runat="server" Text='<%# Eval("Lump") %>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblThan" runat="server" Text='<%# Eval("Than") %>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblPiece" runat="server" Text='<%# Eval("Piece") %>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblMulti" runat="server" Text='<%# Eval("Multi") %>' Visible="false"></asp:Label>

                                                     <td><%# Container.DataItemIndex + 1 %></td>
                                                    <td><%# Eval("ProductName") %></td>
                                                     
                                              
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

