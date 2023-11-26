<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="AddStock.aspx.cs" Inherits="OrderList" %>


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
                    <h1 class="page-head-line">Add Stock </h1> 

                </div>
            </div>

            <div class="row" >

                <asp:HiddenField ID="HiddenField1" runat="server" />
                <div class="col-md-12">
                    <!--   Kitchen Sink -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Select File to Import
                             <asp:FileUpload ID="FlUpload" runat="server" Style="margin-bottom: 5px" />
                            <asp:Button ID="BtnImport" runat="server" class="btn btn-success" Text="Import" OnClick="BtnImport_Click" />  &nbsp; &nbsp; &nbsp; <asp:Button ID="Button1" runat="server" Style="float: right" Text="Click to Shade Export Data" OnClick="Button1_Click" class="btn btn-danger" />

                        </div>

                        <div class="panel-body">
                            <div class="col-md-12">
                                <table style="border: solid 1px">
                                    <tr>
                                        <th style="width: 250px; background-color: aliceblue; border-right: solid 1px">ITEM</th>
                                        <th style="width: 250px; background-color: aliceblue; border-right: solid 1px">SHADE</th>
                                        <th style="width: 250px; background-color: aliceblue; border-right: solid 1px">PENDING</th>
                                    </tr>
                                </table>

                            </div>
                            <div class="col-md-12" style="max-height: 600px; overflow-y: scroll;">
                                <a href='ExportedFile.xls' style="float: right; margin-top: 5px">Click to Download</a>
                                <asp:Button ID="BtnExport" runat="server" Style="float: right" Text="Click to Export Data" OnClick="BtnExport_Click" class="btn btn-danger" />
                             

                                <asp:GridView ID="gvCustomers" runat="server" AutoGenerateColumns="false" Font-Names="Arial" ShowHeader="false" Font-Size="11pt" AlternatingRowStyle-BackColor="#C2D69B">
                                    <Columns>
                                        <asp:BoundField DataField="ProductName" HeaderText="ITEM" ItemStyle-Width="250px" />
                                        <asp:BoundField DataField="ShadeNo" HeaderText="SHADE" ItemStyle-Width="250px" />
                                        <asp:BoundField DataField="Pending" HeaderText="PENDING" ItemStyle-Width="250px" />
                                    </Columns>
                                </asp:GridView>

                            </div>
                        </div>
                    </div>





                    <!-- End  Kitchen Sink -->
                </div>


            </div>
        </div>

    </div>
    <a id="bottom"></a>

    <br />
    <br />
    <br />

</asp:Content>
