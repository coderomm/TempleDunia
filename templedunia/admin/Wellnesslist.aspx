<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="Wellnesslist.aspx.cs" Inherits="Wellnesslist" %>

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
        <div class="container-fluid">
              <div class="row">
                    <div class="col-md-12">
                        <h1 class="page-head-line">Ayurveda Wellness Center List </h1>
                    </div>
                </div>
                <div class="row">
                    
                     <asp:HiddenField ID="HiddenField1" runat="server" />
                 <div class="col-md-12">
                  <!--   Kitchen Sink -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                       Ayurveda Wellness Center List
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>S.No</th>
                                            <th>Name</th>   
                                            <th>DOB</th>                                        
                                             <th>PAN Card</th>
                                             <th>Aadhar Card</th>
                                             <th>Shop Area</th>
                                             <th>Invest Amount</th>   
                                            <th>City</th>                                        
                                             <th>State</th>
                                             <th>Pincode</th>
                                             <th>Mobile</th>
                                             <th>Email</th>
                                             <th>Premises </th>
                                             <th>Shop Area  </th>
                                             <th>Area Population  </th>
                                             <th>Location  </th>
                                            <th>Aadhar Front</th>                                        
                                             <th>Aadhar Back</th>
                                             <th>Signature</th>
                                             <th>Profile Photo </th>
                                            <th>Pan Card Image </th>
                                            <th>Shop Image 1</th>
                                            <th>Shop Image 2 </th>
                                            <th>Shop Image 3 </th>
                                            <th>Shop Image 4</th>
                                             <th>Bank Passbook Image </th>
                                           <th>Enquiry Date(MM/DD/YYYY)</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:ListView ID="lstEnquiryForm" runat="server">
                                            <ItemTemplate>
                                                 <tr>
                                                    
                                                     <td><%# Container.DataItemIndex + 1 %></td>
                                                     <td><%# Eval("Name") %></td>
                                                       <td><%# Eval("dateofbirth") %></td>
                                                     <td><%# Eval("pannumber") %></td>
                                                  
                                                     <td><%# Eval("aadharnumber") %></td>
                                                     <td><%# Eval("village") %></td>
                                                   
                                                <td><%# Eval("tehsil") %></td>
                                                     <td><%# Eval("city") %></td>
                                                     <td><%# Eval("states") %></td>
                                                     <td><%# Eval("pincode") %></td>
                                                     <td><%# Eval("mobilenumber") %></td>
                                                     <td><%# Eval("emailid") %></td>
                                                     <td><%# Eval("premises") %></td>
                                                      <td><%# Eval("shoparea") %></td>

                                                      <td><%# Eval("population") %></td>
                                                        
                                                      <td><a href="<%# Eval("location") %>" target="_blank">Location</a></td>
                                                     <td><a href="../wellnessimg/aadharfront/<%# Eval("aadharfront") %>" download><img src="../wellnessimg/dwnlod.png" style="height:40px;width:40px;" /></a></td>
                                                       <td><a href="../wellnessimg/aadharback/<%# Eval("aadharback") %>" download><img src="../wellnessimg/dwnlod.png" style="height:40px;width:40px;" /></a></td>
                                                       <td><a href="../wellnessimg/signature/<%# Eval("signatur") %>" download><img src="../wellnessimg/dwnlod.png" style="height:40px;width:40px;" /></a></td>
                                                        <td><a href="../wellnessimg/profilephoto/<%# Eval("profilephoto") %>" download><img src="../wellnessimg/dwnlod.png" style="height:40px;width:40px;" /></a></td>
                                                     <td><a href="../wellnessimg/pancard/<%# Eval("pancardimg") %>" download><img src="../wellnessimg/dwnlod.png" style="height:40px;width:40px;" /></a></td>
                                                      <td><a href="../wellnessimg/shopimg1/<%# Eval("shopimg1") %>" download><img src="../wellnessimg/dwnlod.png" style="height:40px;width:40px;" /></a></td>
                                                       <td><a href="../wellnessimg/shopimg2/<%# Eval("shopimg2") %>" download><img src="../wellnessimg/dwnlod.png" style="height:40px;width:40px;" /></a></td>
                                                       <td><a href="../wellnessimg/shopimg3/<%# Eval("shopimg3") %>" download><img src="../wellnessimg/dwnlod.png" style="height:40px;width:40px;" /></a></td>
                                                       <td><a href="../wellnessimg/shopimg4/<%# Eval("shopimg4") %>" download><img src="../wellnessimg/dwnlod.png" style="height:40px;width:40px;" /></a></td>
                                                       <td><a href="../wellnessimg/bankpass/<%# Eval("bankimg") %>" download><img src="../wellnessimg/dwnlod.png" style="height:40px;width:40px;" /></a></td>
                                                    
                                                     <td><%# Eval("rts") %></td>
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
                   
                 
                </div>
        </div>
    </div>
</asp:Content>
