<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<head>
 <meta charset="utf-8">
 <meta http-equiv="x-ua-compatible" content="ie=edge">
 <title>Home || Sana Cards || Celebrate like you deserve</title>
 <meta name="description" content="">
 <meta name="viewport" content="width=1440, initial-scale=1">
 
<!-- Google Fonts
============================================ -->		
 <link rel="stylesheet" href="/css/bootstrap.min.css">
 <link rel="stylesheet" type="text/css" href="/css/nivo-slider.css" media="screen" />	
 <link rel="stylesheet" type="text/css" href="/css/preview.css" media="screen" />
 <link rel="stylesheet" href="/css/font-awesome.min.css">
 <link rel="stylesheet" href="/css/owl.carousel.css">
 <link rel="stylesheet" href="/css/jquery-ui.css">
 <link rel="stylesheet" href="/css/meanmenu.min.css">
 <link rel="stylesheet" href="/css/animate.css">
 <link rel="stylesheet" href="/css/style.css">
 <link rel="stylesheet" href="/css/responsive.css">
     
<script src="/js/jquery-1.12.3.min.js"></script>
<script src="/js/modernizr-2.8.3.min.js"></script>
<script src="/js/pagination.min.js"></script>
<script src="/js/customJs.js"></script>
<script src="/js/jquery.scrollUp.min.js"></script>
<script src="/js/loadingView.js"></script>
<link rel="icon" type="image/png" sizes="16x16" href="img/favicon-16x16.png">
<link rel="icon" type="image/png" sizes="32x32" href="img/favicon-32x32.png">
</head>
<%
JSONArray cart = new JSONArray();
float total = 0;
if(request.getAttribute("cart")!=null){
	cart = (JSONArray)request.getAttribute("cart");
}
%>
<style>
* {
  -webkit-transition: none !important;
  -moz-transition: none !important;
  -o-transition: none !important;
  transition: none !important;
}
.container{
	width: 1370px !important;
}
.active {
    color: #F05166 !important;
}
.paginationjs-pages ul li{
	font-size: 14px !important;
}
html, body {  
	min-width:1440px !important; 
}
</style>
<header class="header-area" style="max-height:62px !important;" >
    <div class="header-top-area">
        <div class="container" style="width:1370px !important;">
            <div class="row">
                <div style="width: 400px;float: left;">
                    <div class="header-top-left">
                        <div class="notification-header">
                            <ul>
                                <li style="padding: 20px;">New in Town, But Old in the business.</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div style="float: right;width: 255px;">
                    <div class="header-top-right">
                        <div class="order-cart">
                            <ul>
                                <li class="howto"><a href="/aboutus#howToOrder">How to Order</a></li>
                                <li class="cart" id="shoppingCart"><a href="/cart"><img src="img/icon/cart.png" alt="cart"><p id="cartLength"><%=cart.length()%></p></a>
                                      <%if(cart.length()>0){%>
                                      	<ul class="submenu-mainmenu" style="overflow:scroll;max-height:300px">
                                       <%for(int i=0;i<cart.length();i++){JSONObject obj = cart.getJSONObject(i);total+=Float.parseFloat(obj.get("totalPrice")+"");%>
                                        <li class="single-cart-item clearfix">
                                            <span class="cart-img" style="font-family: auto;font-weight: 400;line-height: 8px;padding: 2px 0px;">
                                                <a href="shop.html"><img style="width: 30%;float: left;" src="<%=obj.get("path")%>" alt=""/></a>
                                                <a href="shop.html"><span style="font-size: 12px; !important">(<span style="font-size: 8px; !important">x</span><%=obj.get("count")%>)</span></a>
                                                <span style="text-transform: capitalize;font-size: 12px; !important">Rs. <%=obj.get("price")%></span>
                                                <a class="trash" style="padding: 0px;" onclick="removeFromCart('<%=obj.get("id")%>','<%=obj.get("name")%>',this);"><i class="fa fa-trash"></i></a>
                                            </span>
                                        </li>
                                        <hr/>
                                        <%}%>
                                        <li class="single-cart-item clearfix">
	                                        <span class="sub-total-cart text-center">
	                                         <div style="margin-top: 20px;">SubTotal</div>
	                                         <div style="text-transform: capitalize;">Rs. <%=Math.round(total*100.0)/100.0%></div>
	                                         <a href="/cart" class="view-cart">Checkout</a>
	                                     	</span> 
                                     	</li>
                                     	</ul>
                                        <%}else{%>
                                        <ul class="submenu-mainmenu">
	                                        <li>
	                                            <span class="sub-total-cart text-center">No items in your cart</span>
	                                        </li>
                                        </ul>
                                    <%}%>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>	   
</header>
	<div class="logo-center">
		<div class="logo" style="background: white;">
			<a href="/homepage"><img id="sanaCard" src="img/sanaLogo.jpg" style="width: 30%;" alt="SANA CARDS"></a>
		</div>
	</div>
   <div class="main-header-area" id="myHeader">
    <div class="container" style="width:1370px !important;">
    	<div class="logoImg" style="width: 70px;position: absolute;display:none;">
    		<a href="/homepage"><img src="img/logo.png" alt="SANA CARDS"></a>
    	</div>
        <div class="row">
            <div>
                <div class="mainmenu" style="display:block;">
                    <nav>
                        <ul>
                            <li><a href="/homepage">Home</a></li>
                            <li><a style="pointer-events:none;">Wedding</a>
                                <div class="mega-menu">
                                    <span>
                                        <a class="title" style="pointer-events:none;">By Religion</a>
                                        <a onclick="openShopPage(this);" value="wedding#hinduInvitation">Hindu Invitations</a>
                                        <a onclick="openShopPage(this);" value="wedding#muslimInvitation">Muslims Invitations</a>
                                        <a onclick="openShopPage(this);" value="wedding#christianInvitation">Christian Invitations</a>
                                    </span>
                                    <span>
                                        <a class="title" style="pointer-events:none;">By Type</a>
										<a onclick="openShopPage(this);" value="type#single">Single sheet Cards</a>
										<a onclick="openShopPage(this);" value="type#scroll">Scroll Type Cards</a>
										<a onclick="openShopPage(this);" value="type#book">Book Type Cards</a>
										<a onclick="openShopPage(this);" value="type#laser">Laser Cut Cards</a>
										<a onclick="openShopPage(this);" value="type#hand">Hand-made Cards</a>                                        
                                    </span>
                                    <span class="menu-image">
                                        <img src="img/menu/laser-cut-menu.png" alt="">
                                    </span>
                                </div>
                            </li>
                            
                            <li><a style="pointer-events:none;">Occasional</a>
                                <ul class="submenu-mainmenu">
									<li><a onclick="openShopPage(this);" value="occassional#engagement">Engagement</a></li>
									<li><a onclick="openShopPage(this);" value="occassional#reception">Reception</a></li>
									<li><a onclick="openShopPage(this);" value="occassional#housewarming">House Warming</a></li>
									<li><a onclick="openShopPage(this);" value="occassional#inauguration">Inauguration</a></li>
									<li><a onclick="openShopPage(this);" value="occassional#earPiercing">Ear Piercing ceremony</a></li>
									<li><a onclick="openShopPage(this);" value="occassional#namingCeremony">Naming ceremony</a></li>
									<li><a onclick="openShopPage(this);" value="occassional#babyShower">Baby shower</a></li>                                    
                                </ul>    
                            </li>
                            <li><a style="pointer-events:none;">Add On's</a>
                                <ul class="submenu-mainmenu">
                                    <li><a onclick="openShopPage(this);" value="addons#thankyouCards">Thank You Cards</a></li>
                                    <li><a onclick="openShopPage(this);" value="addons#thamboolamBags">Thamboolam Bags</a></li>
                                    <li><a onclick="openShopPage(this);" value="addons#friendsInvitation">Friends Invitations</a></li>
                                    </ul>    
                            </li>
                            <li><a style="pointer-events:none;">Our Story</a>
                                <ul class="submenu-mainmenu">
                                    <li><a href="/aboutus">About Us</a></li>
                                    <li style="display:none"><a href="/contactus">Contact Us</a></li>
                                    <li style="display:none"><a href="shop.html">Our Blog</a></li>
                                </ul>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
            
        </div> 
    </div>
</div>
<script>
var header = $('#myHeader');
var sticky = header.offset().top;
$('#scrollUp').click(function(){
	   header.classList.remove("sticky");
});
$(window).load(function(){
        if (window.pageYOffset <= sticky) {
        	header.removeClass("sticky");
        }else{
        	header.addClass("sticky");
        }
    });
$(window).bind('mousewheel', function(event) {
	    if (event.originalEvent.wheelDelta >= 0) {
	        if (window.pageYOffset <= sticky) {
	        	header.removeClass("sticky");
	        	$('.logoImg').fadeOut();
	        }
	    }
	    else {
	    	 if (window.pageYOffset > sticky) {
	    		 header.addClass("sticky");
	    		 $('.logoImg').fadeIn();
	        }
	    }
	});
</script>