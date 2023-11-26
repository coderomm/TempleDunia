<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test.aspx.cs" Inherits="admin_test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>fccccc</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="//cdn.ckeditor.com/4.10.0/standard/ckeditor.js"></script>
    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
     <script language="javascript">
         function PrintMe(DivID) {
             var disp_setting = "EditLuggageBooking.aspx?BookingId=1,toolbar=yes,location=no,";
             disp_setting += "directories=yes,menubar=yes,";
             disp_setting += "scrollbars=yes,width=650, height=600, left=100, top=25";
             var content_vlue = document.getElementById(DivID).innerHTML;
             var docprint = window.open("", "", disp_setting);
             docprint.document.open();
             docprint.document.write('<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"');
             docprint.document.write('"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">');
             docprint.document.write('<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">');
             docprint.document.write('<head><title>My Title</title>');
             docprint.document.write("<link rel=\"stylesheet\" href=\"css/bootstrap.css\" type=\"text/css\" media=\"print\" />");
             docprint.document.write("<link rel=\"stylesheet\" href=\"css/bootstrap.min.css\" type=\"text/css\"  />");
             docprint.document.write('</head><body onLoad="self.print()"><center>');
             docprint.document.write(content_vlue);
             docprint.document.write('</center></body></html>');
             docprint.document.close();
             docprint.focus();
         }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
          <%--  <asp:TextBox ID="Txtdescription" runat="server" class="form-control" TextMode="MultiLine" Rows="7"></asp:TextBox>
            <script type="text/javascript">
                CKEDITOR.replace('<%=Txtdescription.ClientID%>');
            </script>
            <asp:Button ID="Button1" runat="server" Class="btn-danger" Text="Submit" Style="border-style: none; padding: 5px" OnClick="Button1_Click" />
--%>

<%--            <asp:ListView ID="LstActive" runat="server" DataSourceID="Categoray">
                <ItemTemplate>

                    <%# Eval("Descr") %>
                                           
                                           
                                        </tr>
                </ItemTemplate>
            </asp:ListView>
                 <asp:SqlDataSource ID="Categoray" runat="server" ConnectionString="<%$Connectionstrings:ShivShaktiSynthetics %>" SelectCommand="select * from aboutus">

                 </asp:SqlDataSource>--%>

            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <asp:Button ID="Button2" runat="server" Text="Button"  OnClick="Button2_Click"/>

               <input type="button" name="btnprint" value="Print" onclick="PrintMe('div1')" Class="pull-right" style="border:solid 1px red"/>


            <div id="div1">
                 ffffffffffffffffffff
            </div>
        </div>
    </form>
</body>
</html>
