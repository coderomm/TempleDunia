<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Push_default.aspx.cs" Inherits="Push_default" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid" style="margin-top: 17vh">
            <asp:Label ID="Label3" runat="server" Text="" Style="color: blue;"></asp:Label>
            <div class="row">
                <div class="col-lg-4 col-sm-4 col-md-4"></div>
                <div class="col-lg-4 col-sm-4 col-md-4" style="text-align: center">

                    <div class="push" style="border: solid 1px #979797; text-align: center; padding: 5px; height: 490px">
                        <img src="../img/logo.jpg" style="height:130px" />  
                        <br />
                        <br />
                      
                        <asp:TextBox ID="Text1" runat="server" placeholder="Enter Title..."  Style="height: 30px; width: 90%;margin-bottom:10px;"></asp:TextBox>
                        <asp:TextBox ID="TxtSubTitle" runat="server" placeholder="Enter SubTitle..."  Style="height: 30px; width: 90%;margin-bottom:10px;"></asp:TextBox>
                        <asp:TextBox ID="TextBox1" runat="server" placeholder="Enter Body..." TextMode="MultiLine" Style=" width: 90%;margin-bottom:10px;"></asp:TextBox>
                        <asp:FileUpload ID="FileUpload1" runat="server" Style="background-color: #224160; color: white; padding: 5px; border-style: none; width: 89%; margin-bottom:6px; margin-left: 25px" />
                        <%--<asp:Button ID="btnUpload" runat="server" Text="Send" OnClick="Upload" Style="background-color:#37a451;color:white;padding:5px;border-style:none;width:30%;margin-bottom:6px;margin-left:15px"  />--%>
                        <br />
                        <asp:Button ID="Button1" runat="server" Text="Send" Style="background-color: #224160; color: white; padding: 5px; border-style: none; width: 45%;" OnClick="Upload" />
                        <asp:Button ID="Button2" runat="server" Text="Cancel" Style="background-color: #224160; color: white; padding: 5px; border-style: none; width: 45%;" OnClick="Button2_Click" />

                    </div>

                </div>
                <div class="col-lg-4 col-sm-4 col-md-4"></div>
            </div>

        </div>
        <div>
        </div>
    </form>
</body>
</html>

