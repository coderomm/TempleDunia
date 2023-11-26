<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="AcitveSlider.aspx.cs" Inherits="AcitveSlider" %>

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
                        <h1 class="page-head-line">Active /Deactive  Slider </h1>
                    </div>
                </div>
                <div class="row">
                    
                     <asp:HiddenField ID="HiddenField1" runat="server" />
                 <div class="col-md-6">
                  <!--   Kitchen Sink -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                         Active    Slider List
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>S.No</th>
                                            <th>image</th>
                                          
                                             <th>Deactive</th>
                                        
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:ListView ID="LstActive" runat="server" OnItemCommand="ListView2_ItemCommand">
                                            <ItemTemplate>
                                                 <tr>
                                                     <asp:HiddenField ID="HdnID" runat="server"  Value='<%# Eval("Id") %>'/>
                                                     <asp:Label ID="Lblimg" runat="server" Text='<%# Eval("image") %>' Visible="false"></asp:Label>
                                                       
                                                       

                                            <td><%# Eval("Id") %></td>
                                             <td>    <img src="../img/slider/<%# Eval("image") %>" style="height:100px;width:200px;border:solid 1px #cccccc" /></td>
                                           <td>   <asp:CheckBox ID="ChkBox" runat="server" /><br /><asp:LinkButton ID="LinkButton2" runat="server" CommandName="dea" Font-Bold="true" ForeColor="#3c8dbc">Deactive</asp:LinkButton></td>
                                           
                                        </tr>
                                            </ItemTemplate>
                                        </asp:ListView>

                                         <%--<asp:SqlDataSource ID="SqlActive" runat="server" ConnectionString="<%$Connectionstrings:topcity %>" SelectCommand="select * from [Restaurant] where CityCode=1 and StateCode=1 and ActiveStatus=1 order by id desc"></asp:SqlDataSource>--%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                     <!-- End  Kitchen Sink -->
                </div> 
                    <asp:HiddenField ID="LblId" runat="server" />
                 <div class="col-md-6">
                  <!--   Kitchen Sink -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                      Deactive   Slider List
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>S.No</th>
                                            <th>image</th>
                                          
                                             <th>Active</th>
                                        
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:ListView ID="LstDeactive" runat="server" OnItemCommand="ListView1_ItemCommand">
                                            <ItemTemplate>
                                                 <tr>
                                                     <asp:HiddenField ID="HdnID" runat="server"  Value='<%# Eval("Id") %>'/>
                                                     <asp:Label ID="Lblimg" runat="server" Text='<%# Eval("image") %>' Visible="false"></asp:Label>
                                                     
                                                       

                                            <td><%# Eval("Id") %></td>
                                              <td>    <img src="../img/slider/<%# Eval("image") %>" style="height:100px;width:200px;border:solid 1px #cccccc" /></td>
                                           <td>   <asp:CheckBox ID="ChkBox" runat="server" /><br /><asp:LinkButton ID="LinkButton2" runat="server" CommandName="active" Font-Bold="true" ForeColor="#3c8dbc">Active</asp:LinkButton></td>
                                           
                                        </tr>
                                            </ItemTemplate>
                                        </asp:ListView>

                                         <%--<asp:SqlDataSource ID="Categoray" runat="server" ConnectionString="<%$Connectionstrings:topcity %>" SelectCommand="select * from [Restaurant] where CityCode=1 and StateCode=1 and ActiveStatus=0 order by id desc"></asp:SqlDataSource>--%>
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
