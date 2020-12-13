<%@page import="org.json.JSONArray"%>
<style>
.productDescriptionArea *{
	font-size: 50px !important;
}
.productDescriptionArea {
	min-height: 2000px;
}
#productDescription {
	padding: 200px;
    padding-top: 80px;
}
.image{
	height: 800px;
    width: 700px;
}
.active {
    color: #F05166 !important;
}
.imageZoom{
	position:absolute;
	box-shadow: 0 10px 16px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19) !important;
}
.p-details-slider li{
	max-width: 45px !important;
}

.img-zoom-lens {
  position: absolute;
  border: 1px solid #d4d4d4;
  width: 200px;
  height: 200px;
}

.img-zoom-result {
	top: -100px;
  	border: 1px solid #d4d4d4;
	width: 670px;
	height: 580px;
	z-index: 99;
}
.product-desc {
	line-height: 60px;
}
</style>
<%
JSONArray images = (JSONArray)request.getAttribute("images");
%>
<div class="productDescriptionArea">
<div class="breadcrumb-area">
    <div class="container">
        <div class="row">
            <div class="col-md-12 text-left">
                <ul class="breadcrumb">
                    <li><a href="/home">Home</a><span> - </span></li>
                    <li><a href="/shop">Shop</a><span> - </span></li>
                    <li class="active">Product Details</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div class="product-details-area fullwidth" style="min-height: 500px;">
    <div class="container">   
        <div class="row">
            <div>
               <div class="zoomWrapper clearfix">
                    <div style="text-align: center;position: relative;">
                    	<img class="image" id="myimage" src="<%=request.getAttribute("path")%>" alt="big-1">
                    </div>
                </div>
            </div>
        </div>    
    </div>
</div>
<div id="productDescription" style="position:relative;">
    <div class="product-detail shop-product-text">
        <h4><a href="#"><%=request.getAttribute("name")%></a></h4>
        <div class="price-rating-container">    
            <div class="price-box"><span>Rs. <%=request.getAttribute("price")%></span></div>
        </div>
        <div class="availability">AVAILABILITY : <span> In stock</span></div>
        <h5 class="overview">Overview :</h5>
        <p class="product-desc">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor indunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
        </p>
        
        
        <div class="shop-buttons">
            <a href="javascript:addToCart('<%=request.getAttribute("id")%>','<%=request.getAttribute("name")%>');" class="cart-btn"><span>Add to Bag</span></a>
        </div>
        <div class="share">
           <h5 class="share">share this on :</h5>
           <ul>
               <li><a href="www.facebook.com"><i class="fa fa-facebook"></i></a></li>
               <li><a href="www.twitter.com"><i class="fa fa-twitter"></i></a></li>
               <li><a href="www.instagram.com"><i class="fa fa-instagram"></i></a></li>
               <li><a href="www.pinterest.com"><i class="fa fa-pinterest"></i></a></li>
           </ul>
        </div>
    </div>
</div> 
</div>