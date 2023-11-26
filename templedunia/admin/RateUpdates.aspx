<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="RateUpdates.aspx.cs" Inherits="RateUpdates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <style type="text/css">
        .messagealert {
            width: 100%;
           
             top:0px;
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
                        <h1 class="page-head-line">Update Product Rate  </h1>
                    </div>
                </div>
                <div class="row">
                    
                     <asp:HiddenField ID="HiddenField1" runat="server" />
                 <div class="col-md-12">
                  <!--   Kitchen Sink -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                        Product  List
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
 <asp:ListView ID="LstActive" runat="server" OnItemCommand="LstActive_ItemCommand"> 
                                               <LayoutTemplate>
                                                   <thead>
                                        <tr>
                                            <th>S.No</th>
                                            <th>Product Name</th>
                                             <th>Rate <br />  <asp:LinkButton ID="LnkBtnView" runat="server" CommandName="ChkAllRate" Text="Edit" Font-Bold="true" ForeColor="#ff0000"></asp:LinkButton>&nbsp;&nbsp;&nbsp; <asp:LinkButton ID="LinkButton1" runat="server" CommandName="UpdateAllRate" Text="Update" Font-Bold="true" ForeColor="#ff0000"></asp:LinkButton></th>
                                           
                                              
                                        </tr>
                                    </thead>      <asp:PlaceHolder ID="Itemplaceholder" runat="server"></asp:PlaceHolder>
                                                   </LayoutTemplate>

                                             <ItemTemplate>
                                                 <tr>
                                                        <asp:HiddenField ID="HdnID" runat="server"  Value='<%# Eval("ProductId") %>'/>
                                                     <td><%# Container.DataItemIndex + 1 %></td>
                                                     <td><%# Eval("ProductName") %></td>
                                                     <td>
                                                           <asp:Label ID="lblrate" Visible="true" ToolTip="Click to change Rate" TextAlign="Left"
                                                                    Checked="false" Text=' <%# Eval("Rate") %>' runat="server" Width="50px" />
                                                                <asp:TextBox ID="TxtRate" Visible="false" runat="server" style="border:solid 1px green" Height="30px" Width="90px"
                                                                    Text=' <%# Eval("Rate") %>'></asp:TextBox>
                                                         </td>
                                                    
                                                   
                                               
                                        </tr>
                                            </ItemTemplate>
                                        </asp:ListView>
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
