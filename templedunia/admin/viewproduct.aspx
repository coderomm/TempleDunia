<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="viewproduct.aspx.cs" Inherits="viewproduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <section class="shop-details-area">
        <div class="breadcrumbs">
            <div class="container">
                <div class="container-inner">
                    <ul>
                        <li class="home">
                            <a href="Index.aspx">Home </a>
                            <span>
                                <i class="fa fa-angle-right"></i>
                            </span>
                        </li>

                        <li class="category3">
                            <strong>View Product</strong>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="shop-details">
            <div class="container">
                <div class="row">
                    <div class="col-md-4 col-sm-6">
                        <div class="s_big">
                            <div>
                                <!-- Tab panes -->
                                <div class="tab-content">
                                    <div id="image1" class="tab-pane fade in active">
                                        <div class="simpleLens-big-image-container">
                                            <a class="simpleLens-lens-image" data-lens-image="img/product/<%=img1 %>">
                                                <img alt="" src="img/product/<%=img1 %>" class="simpleLens-big-image">
                                            </a>
                                        </div>
                                    </div>
                                   
                                        <div id="image2" class="tab-pane fade" style="visibility:<%=img2 %>">
                                            <div class="simpleLens-big-image-container">
                                                <a class="simpleLens-lens-image" data-lens-image="img/product/<%=img2 %>">
                                                    <img alt="" src="img/product/<%=img2 %>" class="simpleLens-big-image">
                                                </a>
                                            </div>
                                        </div>
                                   

                                  
                                        <div id="image3" class="tab-pane fade" style="visibility:<%=img3 %>">
                                            <div class="simpleLens-big-image-container">
                                                <a class="simpleLens-lens-image" data-lens-image="img/product/<%=img3 %>">
                                                    <img alt="" src="img/product/<%=img3 %>" class="simpleLens-big-image">
                                                </a>
                                            </div>
                                        </div>
                                  

                                        <div id="image4" class="tab-pane fade" style="visibility:<%=img4 %>">
                                            <div class="simpleLens-big-image-container">
                                                <a class="simpleLens-lens-image" data-lens-image="img/product/<%=img4 %>">
                                                    <img alt="" src="img/product/<%=img4 %>" class="simpleLens-big-image">
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                <div class="thumnail-image fix">
                                    <ul class="tab-menu">
                                        <li class="active"><a data-toggle="tab" href="#image1">
                                            <img alt="" src="img/product/<%=img1 %>"></a></li>
                                        <li style="visibility:<%=img2 %>" ><a data-toggle="tab" href="#image2">
                                            <img alt="" src="img/product/<%=img2 %>"></a></li>
                                        <li style="visibility:<%=img3 %>"><a data-toggle="tab" href="#image3">
                                            <img alt="" src="img/product/<%=img3 %>"></a></li>
                                        <li style="visibility:<%=img4 %>"><a data-toggle="tab" href="#image4">
                                            <img alt="" src="img/product/<%=img4 %>"></a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-5 col-sm-6 col-xs-12">
                        <div class="cras">
                            <div class="product-name">
                                <h1><%=productname %> <%=variant %></h1>
                            </div>
                            <div class="pro-rating">
                                <div class="pro_one">
                                    <img src="img/brand/<%=brand %>" style="border: solid 1px #eaeaea" />
                                </div>

                            </div>
                            <p class="availability in-stock">
                                Availability:
                                   
                                <span>In stock</span>
                            </p>
                            <div class="short-description" onload="myFunction()">
                                <p id="demo"><%=shortDescription %> <%=variant %></p>
                            </div>
                            <div class="pre-box" style="border-top: 1px solid #e5e5e5; margin: 12px 4px; padding: 2px 0 5px;">
                                <span style="font-size: 18px; font-weight: 700">Amount : <%=price %></span> &nbsp; <span style="font-size: 18px; font-weight: 700">Discount  : <%=discount %></span>
                            </div>
                            <div runat="server" id="variantbox" class="pro-rating">
                                <ul style="list-style-type: none">
                                    <asp:ListView ID="lstgallery" runat="server" DataSourceID="sqlvariant">
                                        <ItemTemplate>
                                            <li style="float: left; border: solid 1px #db984f; padding: 4px; margin-left: 3px; color: black">
                                                <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# Eval("id") %>' OnClick="LinkButton1_Click1"><%# Eval("varient") %></asp:LinkButton>
                                            </li>
                                        </ItemTemplate>
                                    </asp:ListView>
                                    <asp:SqlDataSource ID="sqlvariant" runat="server" ConnectionString="<%$ ConnectionStrings:DigitalMobiz%>"
                                        CancelSelectOnNullParameter="false" SelectCommand="select distinct a.varient,a.id from varient as a inner join ProductSizeQuantity as b on a.id=b.size where b.ProductId=@id">
                                        <SelectParameters>
                                            <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </ul>
                            </div>

                            <div runat="server" id="colorbox" style="margin: 12px 4px; padding: 2px 0 5px;">
                                <ul style="list-style-type: none">
                                    <asp:ListView ID="lstcolor" runat="server">
                                        <ItemTemplate>
                                            <asp:Label ID="ProductId" runat="server" Visible="false" Text='<%#Eval("colorid") %>'></asp:Label>
                                            <asp:ListView ID="lstcolor1" runat="server" DataSourceID="SqlDataSource1">
                                                <ItemTemplate>
                                                    <li style="float: left; border: solid 1px #000000; padding: 2px; margin-left: 3px; color: black">
                                                        <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# Eval("colorid") %>' OnClick="LinkButton1_Click"><img src="assets/Color/<%# Eval("colorimg") %>" style="height:25px;width:25px" /></asp:LinkButton>
                                                    </li>
                                                </ItemTemplate>
                                            </asp:ListView>
                                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DigitalMobiz%>"
                                                CancelSelectOnNullParameter="false" SelectCommand="select  colorimg,colorid from  Color  where colorid=@ProductId">
                                                <SelectParameters>
                                                    <asp:ControlParameter Name="ProductId" ControlID="ProductId" DefaultValue="0" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </ItemTemplate>
                                    </asp:ListView>
                                  
                                </ul>

                            </div>


                            <div class="add-to-box1">
                                <div class="add-to-box add-to-box2">
                                    <div class="add-to-cart">
                                        <div class="input-content">
                                            <label for="qty">Quantity:</label>
                                            <asp:DropDownList ID="DDQuantity" class="input-text qty" runat="server" Style="width: 80px"></asp:DropDownList>

                                        </div>

                                        <button
                                            class="button2 btn-cart" runat="server" onserverclick="Unnamed_ServerClick" title="" type="button">
                                            <span>Add to Cart</span>
                                        </button>
                                          <button id="Button1"
                                            class="button2 btn-cart" runat="server"  title="" type="button" onserverclick="Button1_ServerClick">
                                            <span>Add to Wishlist</span>
                                        </button>
                                    </div>
                                    
                                </div>
                            </div>
                            <div class="product-social">
                                <div class="addthis_toolbox">
                                    <div class="pluginButtonLabel">
                                        <ul>
                                            <li class="blue"><a href="#"><i class="fa fa-facebook-official"></i>Like</a></li>
                                            <li class="zero"><a href="#">0</a></li>
                                            <li class="sky"><a href="#"><i class="fa fa-twitter"></i>tweet</a></li>
                                            <li class="puce"><a href="#">G+1</a></li>
                                            <li class="zero"><a href="#">0</a></li>
                                            <li class="orange"><a href="#"><i class="fa fa-plus-square"></i>Share</a>
                                                <ul>
                                                    <li><a href="#"><i class="fa fa-facebook-official"></i>Facebook</a></li>
                                                    <li><a href="#"><i class="fa fa-twitter"></i>tweet</a></li>
                                                    <li><a href="#"><i class="fa fa-envelope-square"></i>Email</a></li>
                                                    <li><a href="#"><i class="fa fa-print"></i>Print</a></li>
                                                    <li><a href="#"><i class="fa fa-envelope-o"></i>Gmail</a></li>
                                                    <li><a href="#"><i class="fa fa-certificate"></i>Favorits</a></li>
                                                    <li><a href="#"><i class="fa fa-plus-square"></i>More...(274)</a></li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-12 col-xs-12">
                        <div class="ma-title">
                            <h2>Related Products </h2>
                        </div>
                        <div class="all">

                            <div class=" content_top content_all indicator-style">
                                <div class="ma-box-content-all">
                                    <asp:ListView ID="ListView2" runat="server">
                                        <ItemTemplate>
                                            <div class="ma-box-content">
                                            <div class="product-img-right">
                                            
                                              
                                                    <a href="viewproduct.aspx?id=<%# Eval("productid") %>">
                                                        <img class="primary-image" alt="" src="img/product/<%# Eval("image") %>">
                                                    </a>
                                            </div>
                                            <div class="product-content">
                                                <h2 class="product-name">
                                                        <a href="viewproduct.aspx?id=<%# Eval("productid") %>"><%# Eval("productname") %></a>
                                                    </h2>
                                                <div class="pro-rating" style="color:white">
                                                    <div class="pro_one" style="color:white">
                                                        <a href="#"  style="color:white">
                                                            <i class="fa fa-star"></i>
                                                        </a>
                                                          <a href="#"  style="color:white">
                                                            <i class="fa fa-star"></i>
                                                        </a>
                                                         <a href="#"  style="color:white">
                                                            <i class="fa fa-star"></i>
                                                        </a>
                                                      <a href="#"  style="color:white">
                                                            <i class="fa fa-star-half-o"></i>
                                                        </a>
                                                    </div>
                                                    <div class="pro_two" >
                                                        <a href="#"  style="color:white">
                                                            <i class="fa fa-star-o"></i>
                                                        </a>
                                                    </div>
                                                </div>
                                                <div class="price-box">
                                                   <span class="special">₹<%# Eval("Price") %></span>
                                                        <span class="old">₹<%# Eval("discount") %></span>
                                                </div>
                                            </div>
                                        </div>
                                           <%-- <div class="ma-box-content" style="border:solid 1px #ddd8d8;margin-top:5px;margin-bottom:5px">
                                                <div class="product-img-right">

                                                    <a href="viewproduct.aspx?id=<%# Eval("productid") %>">
                                                        <img class="primary-image" alt="" src="img/product/<%# Eval("image") %>">
                                                    </a>
                                                </div>
                                                <div class="product-content">
                                                    <h2 class="product-name">
                                                        <a href="viewproduct.aspx?id=<%# Eval("productid") %>"><%# Eval("productname") %></a>
                                                    </h2>

                                                    <div class="price-box">
                                                        <span class="special">₹<%# Eval("Price") %></span>
                                                        <span class="old">₹<%# Eval("discount") %></span>
                                                    </div>
                                                </div>
                                            </div>--%>
                                        </ItemTemplate>
                                    </asp:ListView>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- end main_slider_area
		============================================ -->
    <section class="tab_area">
        <div class="container">
            <div class="row">
                <div class="col-md-12 col-xs-12">
                    <div class="text">
                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs" role="tablist">
                            <li role="presentation" class="active">
                                <a href="#home" aria-controls="home" role="tab" data-toggle="tab">Product Description</a>
                            </li>
                            <%--   <li role="presentation">
                                <a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">Reviews</a>
                            </li>
                            <li role="presentation">
                                <a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">Product Tags</a>
                            </li>--%>
                        </ul>
                        <!-- Tab panes -->
                        <div class="tab-content">
                            <div role="tabpanel" class="tab-pane active" id="home"><%=Description %> </div>
                            <div role="tabpanel" class="tab-pane" id="profile">
                                <div class="row">
                                    <div class="col-md-6 col-xs-12">
                                        <div class="customer-reviews">
                                            <div class="customer-reviews-one">
                                                <p><a href="#">Plazathemes</a> <span>Review by</span> Plazathemes</p>
                                            </div>
                                            <div class="customer-reviews-two">
                                                <p>Quality</p>
                                                <div class="pro-rating">
                                                    <div class="pro_one">
                                                        <a href="#">
                                                            <i class="fa fa-star"></i>
                                                        </a>
                                                        <a href="#">
                                                            <i class="fa fa-star"></i>
                                                        </a>
                                                        <a href="#">
                                                            <i class="fa fa-star"></i>
                                                        </a>
                                                        <a href="#">
                                                            <i class="fa fa-star"></i>
                                                        </a>
                                                        <a href="#">
                                                            <i class="fa fa-star"></i>
                                                        </a>
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="customer-reviews-two">
                                                <p>Price</p>
                                                <div class="pro-rating pro-ra-two">
                                                    <div class="pro_one">
                                                        <a href="#">
                                                            <i class="fa fa-star"></i>
                                                        </a>
                                                        <a href="#">
                                                            <i class="fa fa-star"></i>
                                                        </a>
                                                        <a href="#">
                                                            <i class="fa fa-star"></i>
                                                        </a>
                                                        <a href="#">
                                                            <i class="fa fa-star"></i>
                                                        </a>
                                                    </div>
                                                    <div class="pro_two">
                                                        <a href="#">
                                                            <i class="fa fa-star-o"></i>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="customer-reviews-two">
                                                <p>Value</p>
                                                <div class="pro-rating pro-ra-two">
                                                    <div class="pro_one">
                                                        <a href="#">
                                                            <i class="fa fa-star"></i>
                                                        </a>
                                                        <a href="#">
                                                            <i class="fa fa-star"></i>
                                                        </a>
                                                        <a href="#">
                                                            <i class="fa fa-star"></i>
                                                        </a>
                                                        <a href="#"></a>
                                                    </div>
                                                    <div class="pro_two">
                                                        <a href="#">
                                                            <i class="fa fa-star-o"></i>
                                                            <i class="fa fa-star-o"></i>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="date">
                                                <p>Plazathemes <small>(Posted on 9/11/2014)</small></p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-xs-12">
                                        <div class="form-add table-responsive">
                                            <form action="#">
                                                <div class="form-border">
                                                    <div class="add-text">
                                                        <h3>You're reviewing:
                                                               
                                                            <span>Cras neque metus</span>
                                                        </h3>
                                                        <h4>How do you rate this product?*
                                                        </h4>
                                                    </div>
                                                    <table class="data-table">
                                                        <tr>
                                                            <th></th>
                                                            <th>1 star</th>
                                                            <th>2 stars</th>
                                                            <th>3 stars</th>
                                                            <th>4 stars</th>
                                                            <th>5 stars</th>
                                                        </tr>
                                                        <tr>
                                                            <td class="one two">Quality</td>
                                                            <td>
                                                                <input type="radio" name="ratings" required></td>
                                                            <td>
                                                                <input type="radio" name="ratings" required></td>
                                                            <td>
                                                                <input type="radio" name="ratings" required></td>
                                                            <td>
                                                                <input type="radio" name="ratings" required></td>
                                                            <td>
                                                                <input type="radio" name="ratings" required></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="one">Price</td>
                                                            <td>
                                                                <input type="radio" name="ratings" required></td>
                                                            <td>
                                                                <input type="radio" name="ratings" required></td>
                                                            <td>
                                                                <input type="radio" name="ratings" required></td>
                                                            <td>
                                                                <input type="radio" name="ratings" required></td>
                                                            <td>
                                                                <input type="radio" name="ratings" required></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="one">Value</td>
                                                            <td>
                                                                <input type="radio" name="ratings" required></td>
                                                            <td>
                                                                <input type="radio" name="ratings" required></td>
                                                            <td>
                                                                <input type="radio" name="ratings" required></td>
                                                            <td>
                                                                <input type="radio" name="ratings" required></td>
                                                            <td>
                                                                <input type="radio" name="ratings" required></td>
                                                        </tr>
                                                    </table>
                                                    <div class="input-one form-list">
                                                        <label class="required">Nickname<em>*</em></label>
                                                        <input type="text" class="email" required>
                                                    </div>
                                                    <div class="input-one">
                                                        <label class="required">Summary of Your Review<em>*</em></label>
                                                        <input type="text" class="email" required>
                                                    </div>
                                                    <div class="input-one">
                                                        <label class="required">Review<em>*</em></label>
                                                        <textarea class="email"></textarea>
                                                    </div>
                                                    <button class="button2 btn-cart btn-in" type="button" title="">
                                                        <span>Submit Review</span>
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div role="tabpanel" class="tab-pane" id="messages">
                                <div class="box-collateral">
                                    <h3>Other people marked this product with these tags:</h3>
                                    <p><a href="#">Clothing</a>(3)</p>
                                </div>
                                <div class="input-two">
                                    <label class="required">Add Your Tags:</label>
                                    <input type="text" class="email tags" required>
                                    <button class="button2 btn-cart btn-a" type="button" title="">
                                        <span>Add Tags</span>
                                    </button>
                                </div>
                                <p class="note">Use spaces to separate tags. Use single quotes (') for phrases.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="product_area">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="ma-title">
                        <h2>UpSell Products
                        </h2>
                    </div>
                    <div class="row">
                        <div class="UpSell indicator-style">

                            <asp:ListView ID="lstproduct" runat="server">
                                <ItemTemplate>
                                    <div class=" col-md-3">
                                        <div class="single-product">
                                          <span id="Span1" class="sale-text" runat="server" visible='<%# ((Convert.ToInt32(Eval("sale")) >0))%>'>Sale</span>
                                            <div class="product-img">
                                                <a href="viewproduct.aspx?id=<%# Eval("productid") %>">
                                                    <img class="primary-image" src="img/product/<%# Eval("image") %>" alt="<%# Eval("productname") %>" />
                                                </a>
                                            </div>
                                            <div class="product-content" style="text-align: center">
                                                <div class="price-box">
                                                    <span class="special-price">₹<%# Eval("Price") %></span>
                                                    <span class="old-price">₹<%# Eval("Discount") %> </span>
                                                </div>
                                                <h2 class="product-name"><a href="viewproduct.aspx?id=<%# Eval("productid") %>"><%# Eval("productname") %></a></h2>

                                                <div class="product-icon" style="margin-top: 8px;">
                                                    <a href="viewproduct.aspx?id=<%# Eval("productid") %>"><i class="fa fa-shopping-cart"></i></a>
                                                    <a href="viewproduct.aspx?id=<%# Eval("productid") %>"><i class="fa fa-heart"></i></a>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:ListView>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

