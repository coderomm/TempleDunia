<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ttt.aspx.cs" Inherits="admin_ttt" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <script type="text/javascript">
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
      <input type="button" name="btnprint" value="Print" onclick="PrintMe('divid')" Class="pull-right" style="border:solid 1px red"/>


            <div id="divid">
                 ffffffffffffffffffff
            </div>
    </div>
    </form>
</body>
</html>
