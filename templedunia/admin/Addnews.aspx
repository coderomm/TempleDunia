﻿<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="Addnews.aspx.cs" Inherits="Addnews" %>

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
                    <h1 class="page-head-line">News  Forms </h1>
                </div>
            </div>
            <div class="row">

                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                          News  Forms
                        </div>
                        <div class="panel-body">
                            <form role="form">
                                <div class="form-group has-success">
                                    <label class="control-label" for="success">News Title</label>
                                    <asp:TextBox ID="Txttitle" runat="server" class="form-control"></asp:TextBox>

                                </div>
                              

                              
                                   <div class="form-group has-success">
                                    <label class="control-label" for="success">News Description</label>
                                    <asp:TextBox ID="TxtDescription" runat="server" type="text" TextMode="MultiLine" Height="700"></asp:TextBox>
                                    <script type="text/javascript">
                                        CKEDITOR.replace('<%=TxtDescription.ClientID%>');
                                    </script>

                                </div>
                              


                              

                              
                                  <div class="form-group has-success">
                                    <label class="control-label" for="success">priority</label>
                                    <asp:TextBox ID="Txtpriority" runat="server" class="form-control" onkeypress='return ((event.charCode >= 48 && event.charCode <= 57)||event.keyCode == 8||event.keyCode == 9)'></asp:TextBox>

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
                            News List
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>S.No</th>
                                            <th>Title</th>
                                          
                                               <th>priority</th>
                                              <th>Delete</th>
                                            <th>Edit</th>


                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:ListView ID="ListView1" runat="server" OnItemCommand="ListView1_ItemCommand">
                                            <ItemTemplate>
                                                <tr>
                                                    <asp:HiddenField ID="HdnID" runat="server" Value='<%# Eval("Id") %>' />
                                                    
                                                    <asp:Label ID="lbltitle" runat="server" Text='<%# Eval("Name") %>' Visible="false"></asp:Label>
                                                    
                                                      <asp:Label ID="lblpriority" runat="server" Text='<%# Eval("priority") %>' Visible="false"></asp:Label>
                                                     <asp:Label ID="lbldescr" runat="server" Text='<%# Eval("Descr") %>' Visible="false"></asp:Label>


                                                    <td><%# Eval("Id") %></td>
                                                    <td><%# Eval("Name") %></td>
                                                     
                                                <td><%# Eval("priority") %></td>
                                                    <td>
                                                        <asp:LinkButton ID="LnkDelete" runat="server" CommandName="del" Font-Bold="true" ForeColor="#3c8dbc">Delete</asp:LinkButton></td>
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

