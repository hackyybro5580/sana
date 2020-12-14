<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%
	String prop = request.getAttribute("requestObj")+"";
	JSONObject requestObj = new JSONObject(prop);
	JSONArray sliderContent = new JSONArray(requestObj.get("sliderContent")+"");
	JSONArray showCaseHindu = new JSONArray(requestObj.get("showCaseHindu")+"");
	JSONArray showCaseMuslim = new JSONArray(requestObj.get("showCaseMuslim")+"");
	JSONArray showCaseChristian = new JSONArray(requestObj.get("showCaseChristian")+"");
	JSONArray friendsInvitation = new JSONArray(requestObj.get("friendsInvitation")+"");
	JSONArray thamboolamBags = new JSONArray(requestObj.get("thamboolamBags")+"");
	JSONArray engagementInvitations = new JSONArray(requestObj.get("engagementInvitations")+"");
	JSONArray latestNews = new JSONArray(requestObj.get("latestNews")+"");
	JSONArray instaFeed = new JSONArray(requestObj.get("instaFeed")+"");
%>
<style>
.text-center{
	font-size: 15px;
    font-family: "FontAwesome";
    line-height: 1.6em;
}
.owl-wrapper, .tabpanel{
	width: 100% !important;
	margin-left: 7%;
	margin-right: 9.2%;
}
.latest-blog-slider .owl-wrapper-outer .owl-wrapper .owl-item {
	width: 50% !important;
}
.latest-blog-slider .owl-wrapper-outer .owl-wrapper {
	 width: 100% !important;
}
.section-heading {
	padding-bottom: 15px;
	padding-top: 5%;
	margin-left: 7%;
	margin-right: 9.2%;
}
.center-align {
    padding-top: 1.7%;
	margin-left: 7%;
	margin-right: 9.2%;
}
.section-heading h3 {
    width: auto;
    height: auto;
    position: absolute;
    padding: 10px 30px 10px 30px;
	background: #dbc7b6;
    color: #ffffff !important;
    display: inline-block;
    margin: 0;
}

.section-heading h3:before {
    content: "";
    position: absolute;
    left: 0;
    bottom: 0;
    width: 0;
    height: 0;
    border-left: 13px solid #ffffff;
    border-top: 21px solid transparent;
    border-bottom: 21px solid transparent;
}

.section-heading h3:after {
    content: "";
    position: absolute;
    right: 0;
    bottom: 0;
    width: 0;
    height: 0;
    border-right: 13px solid #ffffff;
    border-top: 21px solid transparent;
    border-bottom: 21px solid transparent;
}
.section-tab-menu, .tendy-tab-menu {
    border-bottom: 0px;
}
.section-heading h3:after{
    left: auto;
}
.section-heading:after {
    content: "";
    width: 100%;
    display: inline-block;
    z-index: -2;
    margin-top: 17px;
    border-top: 4px;
    border-top-color: #e8d5c5;
    border-top-style: solid;
}
.owl-buttons{
	display: none;
}
.section-heading h3:hover {
    background: #848484;
    cursor: pointer;
}
.showcase{
	width: 100%;
}
.single-product-item{
	max-width: 95%;
}
.owl-item{
	width: 12% !important;
}
.row {
	margin-right: 0px;
    margin-left: 0px;
}
.owl-item::after{
	padding-right: 10px;
}
.wish-icon-hover, .product-content{
	bottom: 5%;
	top: unset;
}
.single-client{
	max-height: 281px;
	max-width: 281px;
}
.client-owl .owl-wrapper-outer .owl-wrapper .owl-item{
	width: 304px !important;
}
.client-owl .owl-wrapper-outer .owl-wrapper{
	margin-left: 5%;
}
td{
	padding: 0 2% 2% 0;
}
td:last-child{
	padding: 0 0 2% 0;
}
.TwoInARow{
	width: 719px;
    height: 719px;
}
a img{
	z-index: 51;
}
.showCaseItems a img:hover{
	z-index: 50;
	opacity: 0.2;
	transition: all 0.5s ease 0s;
	box-shadow: 0 10px 16px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19) !important;
}
td div{
	position: relative;
	text-align: center;
}
.bottom50{
	bottom: 50px;
}
.showOnHover{
	z-index: -1;
	pointer-events:none;
}
.blog-content{
	text-align: left;
}
.blogContent:hover{
	transition: all 0.5s ease 0s;
	box-shadow: 0 10px 16px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19) !important;
}
.welcomePage{
	position: fixed;
    top: 0;
    z-index: 999;
}
.nivo_text{
	margin-top: 700px !important;
	z-index: 999;
}
.preview-2 .nivoSlider{
	height: 1300px !important;
}
.nivo-caption{
	background: white !important;
}
.nivo-main-image{
	z-index: 100;
}
.title{
	color: black !important;
}
h2.title{
	font-size: 100px !important;
	padding-bottom: 50px !important;
}
h3.ti7{
	font-size: 50px !important;
	padding-bottom: 90px !important;
}
.nivo-prevNav {
	right: 12% !important;
}
.nivo-prevNav , .nivo-nextNav{
	color: #DDCFC1 !important;
	font-size: 30px !important;
}
.nivo-directionNav{
	display: none !important;
}
.slider-button {
	font-size: 50px !important;
	text-transform: capitalize;
    border-bottom: none;
    color: #fff;
    padding: 60px 90px;
    display: block;
    background: #DDCFC1;
    letter-spacing: 4px;
    font-weight: 500;
    color: black;
}
.section-title h2{
	font-size: 90px;
}
.section-heading h3{
	font-size: 60px;
	padding: 10px 80px 12px 80px !important;
}
.section-heading h3:after{
	border-right: 28px solid #ffffff;
}
.section-heading h3:before{
	border-left: 28px solid #ffffff;
}
.section-heading h3:after, .section-heading h3:before{
	border-top: 44px solid transparent;
    border-bottom: 44px solid transparent;
}
.center-align {
    padding-top: 5%;
}
.section-heading:after{
	margin-top: 36px;
    border-top: 16px;
    border-top-color: #e8d5c5;
    border-top-style: solid;
}
.showCaseItems{
	padding: 2% !important;
}
.date-comment h4, .blog-content h4 a, .blog-content p, .date-comment h5, .fa-share-alt, .fa-heart-o{
	font-size: 50px;
}
.blog-content h4, .blog-content p{
	padding-bottom: 24px;
}
#scrollUp	{
	display : none !important;
}
.single-cart-item	{
	border-bottom: 1px solid #dbc7b6;
}
</style>
 <body>
      <!-- slider start -->
     <div class="slider-wrap">
         <div class="preview-2">
             <div id="nivoslider" class="slides">
             	<%for(int i=0;i<sliderContent.length();i++){JSONObject obj = sliderContent.getJSONObject(i);%>
             		<img src="<%=obj.get("path")%>"  alt="" title="#slider-direction-<%=i+1%>"/>
             	<%}%> 
             </div>
             <%for(int i=0;i<sliderContent.length();i++){JSONObject obj = sliderContent.getJSONObject(i);%>
             	<div id="slider-direction-<%=i+1%>" class="t-cn slider-direction">
                 <div class="nivo_text">    
                     
                     <div class="slider-content slider-text-2">
                         <div class="wow fadeInDown" data-wow-delay=".2s">
                            <h2 class="title"><%=obj.get("title1")%></h2>
                         </div>
                     </div>
                     <div class="slider-content slider-text-4">
                         <div class="wow fadeInDown" data-wow-delay=".3s">
                            <h3 class="title ti7"><%=obj.get("title2")%></h3>
                         </div>
                     </div>
                     <div class="slider-content slider-text-3">
                         <div class="wow fadeInDown" data-wow-delay=".4s">
                             <a href='/shop' class='slider-button'>Shop Now</a>
                         </div>
                     </div>
                 </div>    
             	</div>
             <%}%>
         </div>
     </div>
     <!-- slider end -->
     
     
     
     <!-- featured start -->
	<div class="featured-area clearfix">
		<div class="container">
			<div class="row">
				<div class="col-xs-12">
					<div class="section-title">
						<h2>Featured Products</h2>
					</div>
				</div>
			</div>
		</div>
	</div>
		<div class="row">
			<div class="col-xs-12">
				<div class="section-tab">
					<div class="section-tab-menu text-left section-heading">
						<h3>Hindu Invitations</h3>
					</div>
					<div class="center-align">
						<table style="width: 100%;">
							<tr>
								<%for(int i=0;i<2;i++){JSONObject obj = showCaseHindu.getJSONObject(i);%>
								<td class="showCaseItems">
									<a onclick="openProductDetails('<%=obj.get("id")%>');"><img src="<%=obj.get("path")%>" alt="" class="TwoInARow"></a>
								</td>
								<%}%>
							</tr>
							<tr>
								<%for(int i=2;i<4;i++){JSONObject obj = showCaseHindu.getJSONObject(i);%>
								<td class="showCaseItems">
									<a onclick="openProductDetails('<%=obj.get("id")%>');"><img src="<%=obj.get("path")%>" alt="" class="TwoInARow"></a>
								</td>
								<%}%>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
			
		<div class="row">
			<div class="col-xs-12">
				<div class="section-tab">
					<div class="section-tab-menu text-left section-heading">
						<h3>Muslim Invitations</h3>
					</div>
					<div class="center-align">
						<table style="width: 100%;">
							<tr>
								<%for(int i=0;i<2;i++){JSONObject obj = showCaseMuslim.getJSONObject(i);%>
								<td class="showCaseItems">
									<a onclick="openProductDetails('<%=obj.get("id")%>');"><img src="<%=obj.get("path")%>" alt="" class="TwoInARow"></a>
								</td>
								<%}%>
							</tr>
							<tr>
								<%for(int i=2;i<4;i++){JSONObject obj = showCaseMuslim.getJSONObject(i);%>
								<td class="showCaseItems">
									<a onclick="openProductDetails('<%=obj.get("id")%>');"><img src="<%=obj.get("path")%>" alt="" class="TwoInARow"></a>
								</td>
								<%}%>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
			
		<div class="row">
			<div class="col-xs-12">
				<div class="section-tab">
					<div class="section-tab-menu text-left section-heading">
						<h3>Christian Invitations</h3>
					</div>
					<div class="center-align">
						<table style="width: 100%;">
							<tr>
								<%for(int i=0;i<2;i++){JSONObject obj = showCaseChristian.getJSONObject(i);%>
								<td class="showCaseItems">
									<a onclick="openProductDetails('<%=obj.get("id")%>');"><img src="<%=obj.get("path")%>" alt="" class="TwoInARow"></a>
								</td>
								<%}%>
							</tr>
							<tr>
								<%for(int i=2;i<4;i++){JSONObject obj = showCaseChristian.getJSONObject(i);%>
								<td class="showCaseItems">
									<a onclick="openProductDetails('<%=obj.get("id")%>');"><img src="<%=obj.get("path")%>" alt="" class="TwoInARow"></a>
								</td>
								<%}%>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
     <!-- featured end -->
     

     
     
     <!-- testimonials start -->
		<div class="row">
			<div class="col-xs-12">
				<div class="section-tab">
					<div class="section-tab-menu text-left section-heading">
						<h3>Testimonials</h3>
					</div> 
		             <div class="center-align">
						<table style="width: 100%;">
							<tr>
								<%for(int i=0;i<2;i++){JSONObject obj = instaFeed.getJSONObject(i);%>
								<td class="showCaseItems">
									<a onclick="openProductDetails('<%=obj.get("id")%>');"><img src="<%=obj.get("path")%>" alt="" class="TwoInARow"></a>
								</td>
								<%}%>
							</tr>
							<tr>
								<%for(int i=2;i<4;i++){JSONObject obj = instaFeed.getJSONObject(i);%>
								<td class="showCaseItems">
									<a onclick="openProductDetails('<%=obj.get("id")%>');"><img src="<%=obj.get("path")%>" alt="" class="TwoInARow"></a>
								</td>
								<%}%>
							</tr>
						</table>
					</div>
		         </div>
		     </div>
		</div>
     <!-- testimonials end -->	
     
     
     <!-- client start -->
 		<div class="row">
			<div class="col-xs-12">
				<div class="section-tab">
					<div class="section-tab-menu text-left section-heading">
						<h3>Instagram Feed</h3>
					</div> 
		             <div class="center-align">
						<table style="width: 100%;">
							<tr>
								<%for(int i=0;i<2;i++){JSONObject obj = instaFeed.getJSONObject(i);%>
								<td class="showCaseItems">
									<a onclick="openProductDetails('<%=obj.get("id")%>');"><img src="<%=obj.get("path")%>" alt="" class="TwoInARow"></a>
								</td>
								<%}%>
							</tr>
							<tr>
								<%for(int i=2;i<4;i++){JSONObject obj = instaFeed.getJSONObject(i);%>
								<td class="showCaseItems">
									<a onclick="openProductDetails('<%=obj.get("id")%>');"><img src="<%=obj.get("path")%>" alt="" class="TwoInARow"></a>
								</td>
								<%}%>
							</tr>
						</table>
					</div>
		         </div>
		     </div>
		</div>
     <!-- client end -->	
     
     <!-- latest blog start -->
	  <div class="row">
		<div class="col-xs-12">
			<div class="section-tab">
				<div class="section-tab-menu text-left section-heading">
					<h3>Blogs</h3>
				</div> 
	             <div class="center-align">
                 <table style="width: 100%;">
					<tr>
						<%JSONObject obj = latestNews.getJSONObject(0);%>
						<td>
							<div style="border: 1px solid #dddddd;">
		                         <div class="blogContent">
		                             <div class="single-latest-blog-img">
		                                 <a href="blog-details.html">
		                                     <img class="dim" src="<%=obj.get("path")%>" alt="">
		                                 </a>
		                             </div>
		                             <div class="single-latest-blog-text">
		                                 <div class="date-comment clearfix">
		                                     <h4><%=obj.get("title1")%></h4>
		                                     <h5><%=obj.get("date")%></h5>   
		                                 </div>
		                                 <div class="blog-content">
		                                     <h4><a href="<%=obj.get("postURL")%>"><%=obj.get("title2")%></a></h4>
		                                     <p><%=obj.get("title3")%></p>   
		                                 </div>
		                                 <div class="continue-reading">
		                                     <div class="blog-icon">
		                                         <ul>
		                                             <li><a href="<%=obj.get("postURL")%>"><i class="fa fa-share-alt"></i></a></li>
		                                             <li><a href="<%=obj.get("likeURL")%>"><i class="fa fa-heart-o"></i></a></li>
		                                         </ul>
		                                     </div> 
		                                 </div>
		                             </div>
		                         </div>
		                     </div>
						</td>
					</tr>
					<tr>
						<%obj = latestNews.getJSONObject(1);%>
						<td>
							<div style="border: 1px solid #dddddd;">
		                         <div class="blogContent">
		                             <div class="single-latest-blog-img">
		                                 <a href="blog-details.html">
		                                     <img class="dim" src="<%=obj.get("path")%>" alt="">
		                                 </a>
		                             </div>
		                             <div class="single-latest-blog-text">
		                                 <div class="date-comment clearfix">
		                                     <h4><%=obj.get("title1")%></h4>
		                                     <h5><%=obj.get("date")%></h5>   
		                                 </div>
		                                 <div class="blog-content">
		                                     <h4><a href="<%=obj.get("postURL")%>"><%=obj.get("title2")%></a></h4>
		                                     <p><%=obj.get("title3")%></p>   
		                                 </div>
		                                 <div class="continue-reading">
		                                     <div class="blog-icon">
		                                         <ul>
		                                             <li><a href="<%=obj.get("postURL")%>"><i class="fa fa-share-alt"></i></a></li>
		                                             <li><a href="<%=obj.get("likeURL")%>"><i class="fa fa-heart-o"></i></a></li>
		                                         </ul>
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
     </div>
     <!-- blog end -->	
     <script src="js/jquery.meanmenu.js"></script>
     <script src="js/wow.min.js"></script>
     <script src="js/owl.carousel.min.js"></script>
     <script src="js/jquery.countdown.min.js"></script>
     <script src="js/jquery-price-slider.js"></script>
     <script src="js/jquery.elevatezoom.js"></script> 
     <script src="js/jquery.scrollUp.min.js"></script>
     <script src="js/plugins.js"></script>
	 <script type="text/javascript" src="js/jquery.nivo.slider.js"></script>
     <script type="text/javascript" src="js/home.js"></script> 
     <script src="js/main.js"></script>
     <script src="js/parallax.min.js"></script> 
 </body>
 <script>
// var header = $('#myHeader');
// var sticky = header.offset().top;
// $('#scrollUp').click(function(){
// 	   header.classList.remove("sticky");
// });
// $(window).load(function(){
//         if (window.pageYOffset <= sticky) {
//         	header.removeClass("sticky");
//         }else{
//         	header.addClass("sticky");
//         }
//     });
$(window).bind('mousewheel', function(event) {
	    if (event.originalEvent.wheelDelta) {
	     	$('.welcomePage').fadeOut();   
	    }
	});
</script>