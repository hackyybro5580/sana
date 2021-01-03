<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<head>
 <meta charset="utf-8">
 <meta http-equiv="x-ua-compatible" content="ie=edge">
 <title>Home || Sana Cards || Celebrate like you deserve</title>
 <meta name="description" content="">
 <meta name="viewport" id="viewport" content="width=720, maximum-scale=0, initial-scale=.5, user-scalable=no, shrink-to-fit=no">
 
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
 <link rel="stylesheet" href="/css/sideNavBar.css" />
     
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
#mobilePageContainer	{
 	 min-width: 720px; 
     margin: 0 auto;
}
.active {
    color: #F05166 !important;
}
.loadingImage{
	z-index: 1000;
}
.alert *{
	font-size: 50px !important;
}
.alert {
	width: 1000px !important;
}
.paginationjs-pages ul li{
	font-size: 14px !important;
}
.header-top-area{
	height: 120px;
}
.alignCenter {
    padding-top: 1.7%;
    margin-left: 3%;
    margin-right: 3%;
}
.sub-total-cart > a.view-cart{
	padding: 40px 40px;
}
.cart p {
    background: #cebdb1 none repeat scroll 0 0;
    border-radius: 50%;
    height: 50px;
    line-height: 50px;
    position: absolute;
    right: 13px;
    text-align: center;
    top: -10px;
    width: 50px;
    font-size: 35px;
}
.main-header-area {
	position: fixed;
	top: 0;
	height: 100%;
	z-index: 999;
	width: 800px;
}
.mainmenu ul li{
	display: block;
}
.mainmenu ul li a {
    text-transform: capitalize;
    font-size: 45px;
    font-weight: 400;
    height: auto;
    display: flex;
    letter-spacing: 1px;
}

//Side Nav Bar Starts 

body {
  margin: 0;
  font-family: sans-serif;
}

main {
  height: 100vh;
  display: grid;
  grid-template-areas:
    'aside header'
    'aside contenido';
  grid-template-rows: 100px 1fr;
  grid-template-columns: auto 1fr;
}

main > * {
  display: flex;
  align-items: center;
  justify-content: space-around;
}

header {
  grid-area: header;
  background-color: white;
}

aside {
  grid-area: aside;
  position: fixed;
  top: 0;
  z-index: 999;
  width: 100%;
}

article {
  grid-area: contenido;
  background-color: black;
}

.sidebar-content ul li a, .sidebar-content ul li p, .social-icon li a i{
	font-size: 50px !important;
}
.sidebar-content {
	background-color: white;	
	border: 1px solid #decec2;
}
.sidebar-submenu {
	background-color: #decec2 !important;
}
.sidebar , .sidebar a:not(.dropdown-item):hover, .sidebar-content ul li.active a i {
	color: #decec2;
}
.sidebar a:not(.dropdown-item) {
	color: black;
}
.menu-text , .sidebar-submenu li a{
	margin-left: 40px;
}
.sidebar-content ul li a i {
	background-color: white;
	margin-right: 40px;
}
.sidebar-dropdown	{
	border-bottom: 3px solid #decec2;
	line-height: 2.5;
}
.sidebar-footer	{
	background-color: white;
	border-top: 2px solid #decec2 !important;
}
.fa-shopping-cart:before {
	float: left;
}
.freezeLayer {
	position: fixed;
	top: 0;
	width: 100%;
	height: 100%;
	z-index: 998;
}
.text-center {
	font-size: 50px !important;
	text-transform: capitalize;
	color: black;
	opacity: .5;
}
//Side Nav Bar Ends
</style>
<header class="header-area" >
    <div class="header-top-area">
        <div class="container" style="width: 100%;">
            <div class="row">
                <div>
                    <div>
                        <div class="notification-header" style="text-align: center;">
                            <ul>
                                <li style="padding: 20px;font-size: 50px;">New in Town, But Old in the business.</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>	   
</header>


<div class="container" style="width: 100%;z-index: 990;position: sticky;top :0;background: white;">
    <div class="row">
      	<div class="alignCenter">
			<table style="width: 100%;">
				<tr>
					<td style="text-align: center;padding: 0;width: 100px" onclick="showMenuBar();">
						<a href="javascript:showMenuBar();" style="float: right;margin-top: -96px;"><i class="fa fa-bars" style="font-size: 100px;"></i></a>
					</td>
					<td style="text-align: center;padding: 0;">
						<a href="/homepage"><img id="sanaCard" src="img/sanaLogo.jpg" style="width: 100%;" alt="SANA CARDS"></a>
					</td>
					<td style="text-align: center;padding: 0;width: 100px">
		                <div style="float: right;margin-top: -110px;">
		                    <div>
		                        <div class="notification-header" style="text-align: center;">
				                <div>
				                    <div class="header-top-right">
				                        <div class="order-cart">
				                            <ul>
				                                <li class="cart" id="shoppingCart" style="border: 0;"><a href="javascript:showCartMenu();"><i class="fa fa-shopping-cart" style="font-size: 100px;"></i><p id="cartLength"><%=cart.length()%></p></a>
				                                </li>
				                            </ul>
				                        </div>
				                    </div>
				                </div>
		                        </div>
		                    </div>
		                </div>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>
            
<aside class="sidebarContainer" style="display: none;">
   <nav class="sidebar" style="width: 60%">
      <div class="sidebar-content">
         <ul>
            <li class="header-menu">
               <a href="/homepage"><img id="sanaCard" src="img/sanaLogo.jpg" style="width: 100%;margin-left: -90px;" alt="SANA CARDS"></a>
            </li>
            <li style="text-align: center;">
            	<ul class="social-icon" style="padding-bottom: 80px;">
                     <li><a href="www.facebook.com"><i class="fa fa-facebook"></i></a></li>
                     <li style="padding:0 20px 0px 20px;"><a href="www.twitter.com"><i class="fa fa-twitter"></i></a></li>
                     <li><a href="www.instagram.com"><i class="fa fa-instagram"></i></a></li>
                </ul>
            </li>
            <li class="sidebar-dropdown">
               <a href="#">
               <span class="menu-text">Wedding</span>
               <i class="fa fa-angle-down" style="font-size: 50px;"></i>
               </a>
               <div class="sidebar-submenu">
                  <ul>
                     <li><a onclick="openShopPage(this);" value="wedding#hinduInvitation">Hindu Invitations</a></li>
					 <li><a onclick="openShopPage(this);" value="wedding#muslimInvitation">Muslims Invitations</a></li>
					 <li><a onclick="openShopPage(this);" value="wedding#christianInvitation">Christian Invitations</a></li>
                  </ul>
               </div>
            </li>
            <li class="sidebar-dropdown">
               <a href="#">
               <span class="menu-text">Type</span>
               <i class="fa fa-angle-down" style="font-size: 50px;"></i>
               </a>
               <div class="sidebar-submenu">
                  <ul>
					<li><a onclick="openShopPage(this);" value="type#single">Single sheet Cards</a></li>
					<li><a onclick="openShopPage(this);" value="type#scroll">Scroll Type Cards</a></li>
					<li><a onclick="openShopPage(this);" value="type#book">Book Type Cards</a></li>
					<li><a onclick="openShopPage(this);" value="type#laser">Laser Cut Cards</a></li>
					<li><a onclick="openShopPage(this);" value="type#hand">Hand-made Cards</a></li>
                  </ul>
               </div>
            </li>
            <li class="sidebar-dropdown">
               <a href="#">
               <span class="menu-text">Occasional</span>
               <i class="fa fa-angle-down" style="font-size: 50px;"></i>
               </a>
               <div class="sidebar-submenu">
                  <ul>
					<li><a onclick="openShopPage(this);" value="occassional#engagement">Engagement</a></li>
					<li><a onclick="openShopPage(this);" value="occassional#reception">Reception</a></li>
					<li><a onclick="openShopPage(this);" value="occassional#housewarming">House Warming</a></li>
					<li><a onclick="openShopPage(this);" value="occassional#inauguration">Inauguration</a></li>
					<li><a onclick="openShopPage(this);" value="occassional#earPiercing">Ear Piercing ceremony</a></li>
					<li><a onclick="openShopPage(this);" value="occassional#namingCeremony">Naming ceremony</a></li>
					<li><a onclick="openShopPage(this);" value="occassional#babyShower">Baby shower</a></li> 
                  </ul>
               </div>
            </li>
            <li class="sidebar-dropdown">
               <a href="#">
               <span class="menu-text">Add On's</span>
               <i class="fa fa-angle-down" style="font-size: 50px;"></i>
               </a>
               <div class="sidebar-submenu">
                  <ul>
					<li><a onclick="openShopPage(this);" value="addons#thankyouCards">Thank You Cards</a></li>
                    <li><a onclick="openShopPage(this);" value="addons#thamboolamBags">Thamboolam Bags</a></li>
                    <li><a onclick="openShopPage(this);" value="addons#friendsInvitation">Friends Invitations</a></li> 
                  </ul>
               </div>
            </li>
            <li class="sidebar-dropdown">
               <a href="#">
               <span class="menu-text">Our Story</span>
               <i class="fa fa-angle-down" style="font-size: 50px;"></i>
               </a>
               <div class="sidebar-submenu">
                  <ul>
					<li><a href="/aboutus">About Us</a></li>
                    <li><a href="/contactus">Contact Us</a></li>
                    <li><a href="shop.html">Our Blog</a></li> 
                  </ul>
               </div>
            </li>
            <li style="text-align: center;color: black;margin-top: 150px;">
            	<p>Get in touch with us</p>
            	<p style="display: inline-block;"> <a class="fa fa-phone" href="tel:+91 1122334455"> &nbsp; +91 1122334455</a></p>
            	<p> <a class="fa fa-envelope" href="mailto:hello@sanacards.com" style="display: block;"> &nbsp; hello@sanacards.com</a></p>
            </li>
			<li>
               <a href="/cart" style="width: 100%;padding: 40px 80px;"><i class="fa fa-shopping-cart" style="font-size: 70px;width: 100%;padding-left: 80px;padding: 77px;border: 2px solid #decec2; height: 195px;"><span style="font-size: 50px;padding-left:25px;float: left;">My Cart</span><span style="float:right;margin-top: 5px;font-size: 50px;" id="headerCart"><%=cart.length()%></span></i></a>
            </li>
         </ul>
      </div>
   </nav>
</aside>


<div class="freezeLayer" style="display :none;">
</div>
<div style="float:right;width: 60%;">
<aside class="cartContainer" style="display :none;">
   <nav class="sidebar" style="width: 60%">
      <div class="sidebar-content">
         <ul>
            <li class="header-menu" style="padding: 35px;border-bottom: 3px solid #decec2;color: black;">
               <p>My Cart</p>
            </li>
            <li style="padding-top:70px;padding: 60px;">
            	<%if(cart.length()>0){%>
                 	<ul class="submenu-mainmenu">
                  <%for(int i=0;i<cart.length();i++){JSONObject obj = cart.getJSONObject(i);total+=Float.parseFloat(obj.get("totalPrice")+"");%>
                   <li class="single-cart-item clearfix" style="position: relative;color: black;">
                       <span class="cart-img" style="font-family: auto;font-weight: 400;line-height: 8px;padding: 2px 0px;width:30%">
                           <a href="shop.html"><img style="width: 100%;float: left;" src="<%=obj.get("path")%>" alt=""/></a>
                       </span>
                       <p style="margin-top: 25px;"><span style="text-transform: capitalize;font-size: 50px;">Rs. <%=obj.get("price")%></span></p>
                       <p><span style="text-transform: capitalize;font-size: 50px;"><%=obj.get("name")%></span></p>
                       <i onclick="removeFromCart('<%=obj.get("id")%>','<%=obj.get("name")%>',this);" class="fa fa-trash" style="font-size: 50px;position: absolute;top: 30px;right: 0"></i>
                       <span style="font-size: 50px;position: absolute;bottom: 0;">(x<%=obj.get("count")%>)</span>
                   </li>
                   <hr/>
                   <%}%>
                   <li class="single-cart-item clearfix">
                    <span class="sub-total-cart text-center">
                     <div style="margin-top: 20px;padding: 100px;font-size:60px;opacity:0.7;">
                     	<span style="float:left;">Subtotal</span>
                     	<span style="float:right;"><i class="fa fa-rupee" style="font-size:65px;padding-right:20px;"></i> <%=Math.round(total*100.0)/100.0%></span>
                     </div>
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
   </nav>
</aside>
</div>

<script>
scale = .5;
$(function () {
  let sidebar = $('.sidebar'),
    allDropdown = $('.sidebar-dropdown'),
    width = sidebar.width();

  function hideSidebar() {
    if (!sidebar.hasClass('hidden')) {
      sidebar.one('transitionend', function () {
        sidebar.addClass('hidden');
      });
      sidebar.width(0);
    }
  }
  function showSidebar() {
    sidebar.removeClass('hidden');
    sidebar.width(width);
  }
  function dropdown() {
    let parent = $(this).parent('.sidebar-dropdown');
    if (parent.hasClass('active')) {
      parent.removeClass('active');
    } else {
      allDropdown.removeClass('active');
      parent.addClass('active');
    }
  }

  $('#btn-hide, .btn-sidebar-close').on('click', hideSidebar);
  $('#btn-show, .btn-sidebar-show').on('click', showSidebar);
  $('.sidebar-dropdown a').on('click', dropdown);
  apply_viewport();
});

$(document).click(function(e) {
    var container = $(".sidebar");
    if (!container.is(e.target) && container.has(e.target).length === 0) 
    {
    	$(".sidebarContainer, .cartContainer, .freezeLayer").hide();
    }
});
function showMenuBar(){
	$(".sidebarContainer").show();
}
function showCartMenu(){
	$(".freezeLayer, .cartContainer").show();
}
pageWidth = $(window).width();
$(window).on('resize', function() {
  if ( pageWidth !== width ) {
	  pageWidth = $(window).width();
	  $('#viewport').attr('content','width='+pageWidth+', maximum-scale=0, initial-scale='+scale+', user-scalable=no, shrink-to-fit=no');
  }
});

//mobile viewport hack
function apply_viewport(){
    if( /iPhone|iPod/i.test(navigator.userAgent)   ) {
    	scale = 0.2;
    	$('#viewport').attr('content','width='+pageWidth+', maximum-scale=0, initial-scale='+scale+', user-scalable=no, shrink-to-fit=no');
    }
}
</script>