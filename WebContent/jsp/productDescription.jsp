<%@page import="org.json.JSONArray"%>
<style>
.image{
	height:410px;
	width:385px;
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
  	border: 1px solid #d4d4d4;
	width: 670px;
	height: 370px;
	z-index: 99;
}
</style>
<script>
function imageZoom(imgID, resultID) {
  var img, lens, result, cx, cy;
  img = document.getElementById(imgID);
  result = document.getElementById(resultID);
  /*create lens:*/
  lens = document.createElement("DIV");
  lens.setAttribute("class", "img-zoom-lens");
  /*insert lens:*/
  img.parentElement.insertBefore(lens, img);
  /*calculate the ratio between result DIV and lens:*/
  cx = result.offsetWidth / lens.offsetWidth;
  cy = result.offsetHeight / lens.offsetHeight;
  /*set background properties for the result DIV:*/
  result.style.backgroundImage = "url('" + img.src + "')";
  result.style.backgroundSize = (img.width * cx) + "px " + (img.height * cy) + "px";
  /*execute a function when someone moves the cursor over the image, or the lens:*/
  lens.addEventListener("mousemove", moveLens);
  img.addEventListener("mousemove", moveLens);
  /*and also for touch screens:*/
  lens.addEventListener("touchmove", moveLens);
  img.addEventListener("touchmove", moveLens);
  function moveLens(e) {
    var pos, x, y;
    /*prevent any other actions that may occur when moving over the image:*/
    e.preventDefault();
    /*get the cursor's x and y positions:*/
    pos = getCursorPos(e);
    /*calculate the position of the lens:*/
    x = pos.x - (lens.offsetWidth / 2);
    y = pos.y - (lens.offsetHeight / 2);
    /*prevent the lens from being positioned outside the image:*/
    if (x > img.width - lens.offsetWidth) {x = img.width - lens.offsetWidth;}
    if (x < 0) {x = 0;}
    if (y > img.height - lens.offsetHeight) {y = img.height - lens.offsetHeight;}
    if (y < 0) {y = 0;}
    /*set the position of the lens:*/
    lens.style.left = x + "px";
    lens.style.top = y + "px";
    /*display what the lens "sees":*/
    result.style.backgroundPosition = "-" + (x * cx) + "px -" + (y * cy) + "px";
  }
  function getCursorPos(e) {
    var a, x = 0, y = 0;
    e = e || window.event;
    /*get the x and y positions of the image:*/
    a = img.getBoundingClientRect();
    /*calculate the cursor's x and y coordinates, relative to the image:*/
    x = e.pageX - a.left;
    y = e.pageY - a.top;
    /*consider any page scrolling:*/
    x = x - window.pageXOffset;
    y = y - window.pageYOffset;
    return {x : x, y : y};
  }
}
</script>
<%
JSONArray images = (JSONArray)request.getAttribute("images");
%>
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
            <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
               <div class="zoomWrapper clearfix">
                    <div class="product-thumb">
                        <ul class="p-details-slider" id="gallery_01">
                        	<%for(int i=0;i<images.length();i++) {%>
                            	<li>
                                	<a class="elevatezoom-gallery" onclick="setimage(this);"><img src="<%=images.get(i)%>" alt=""></a>
                            	</li>
                            <%}%>
                        </ul>
                    </div>
                    <div style="display: flex;width: 79%;margin-left: 30%;position: relative;">
                    	<img class="image" id="myimage" src="<%=request.getAttribute("path")%>" alt="big-1">
                    </div>
                </div>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12" id="productDescription" style="position:relative;">
                <div class="product-detail shop-product-text" style="position:absolute;z-index:51;">
                    <h4><a href="#"><%=request.getAttribute("name")%></a></h4>
                    <div class="price-rating-container">    
                        <div class="price-box"><span>Rs. <%=request.getAttribute("price")%></span></div>
                    </div>
                    <div class="availability">AVAILABILITY : <span> In stock</span></div>
                    <h5 class="overview">Overview :</h5>
                    <p class="product-desc">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor indunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
                    </p>
                    
                    
                    <div class="shop-buttons">
                        <a onclick="addToCart('<%=request.getAttribute("id")%>','<%=request.getAttribute("name")%>');" class="cart-btn"><span>Add to Bag</span></a>
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
                
                
                <div id="myresult" class="img-zoom-result imageZoom"></div>
            </div>
        </div>     
    </div>
</div>
<script>
	imageZoom("myimage", "myresult");
	$(document).ready(function() {
		$('#myresult').hide();
	  $('.img-zoom-lens').mouseover(function() {
		  	$('#myresult').show();
	  });
	  $('.img-zoom-lens').mouseout(function() {
		  	$('#myresult').hide();
	  });
	});
	function setimage(currObj){
		var imgSrc = $(currObj).children('img').attr('src');
		$('#myimage').attr('src', imgSrc);
		document.getElementById("myresult").style.backgroundImage = "url('"+imgSrc+"')";
		
	}
</script>