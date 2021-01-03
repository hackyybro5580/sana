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



//Popup Css Starts

#myImg {
  border-radius: 5px;
  cursor: pointer;
  transition: 0.3s;
}

#myImg:hover {opacity: 0.7;}

/* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 999; /* Sit on top */
  padding-top: 100px; /* Location of the box */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.9); /* Black w/ opacity */
}

/* Modal Content (image) */
.modal-content {
  margin: auto;
  display: block;
  width: 50%;
  z-index: 999;
}

/* Caption of Modal Image */
#caption {
  margin: auto;
  display: block;
  width: 80%;
  max-width: 700px;
  text-align: center;
  color: #ccc;
  padding: 10px 0;
  height: 150px;
}

/* Add Animation */
.modal-content, #caption {  
  -webkit-animation-name: zoom;
  -webkit-animation-duration: 0.6s;
  animation-name: zoom;
  animation-duration: 0.6s;
}

@-webkit-keyframes zoom {
  from {-webkit-transform:scale(0)} 
  to {-webkit-transform:scale(1)}
}

@keyframes zoom {
  from {transform:scale(0)} 
  to {transform:scale(1)}
}

/* The Close Button */
.close {
  position: absolute;
  top: 15px;
  right: 35px;
  color: #f1f1f1;
  font-size: 40px;
  font-weight: bold;
  transition: 0.3s;
}

.close:hover,
.close:focus {
  color: #bbb;
  text-decoration: none;
  cursor: pointer;
}

/* 100% Image Width on Smaller Screens */
@media only screen and (max-width: 700px){
  .modal-content {
    width: 100%;
  }
}

//Popup CSS Ends
</style>
<script>
var imgArr = '<%=request.getAttribute("imagesAsCommaSeperated")%>';
imgArr = imgArr.split(',');
function updateValue(operation){
	  var quanntitybox = $('#quantityBox');
	  if(operation==='+'){
		  quanntitybox.val(parseInt(quanntitybox.val())+100);
	  }else if(operation==='-'){
		  if(quanntitybox.val()>100){
			  quanntitybox.val(parseInt(quanntitybox.val())-100);
		  }
	  }
}
function checkValue(){
	var quanntitybox = $('#quantityBox');
	  if(!parseInt(quanntitybox.val()) || parseInt(quanntitybox.val()) < 0){
		  quanntitybox.val(100);
	  }
}
function setimage(currObj){
	var imgSrc = $(currObj).children('img').attr('src');
	$('#myimage').attr('src', imgSrc);	
}


//Image Zoom Starts
function showImgPopUp(currObj){
	$("#myModal").show();
	$("#img01").attr('src',currObj.src);
}

function hideModal(){
	$("#myModal").hide();
}

function nextImg(){
	if(parseInt($('#imgIndex').val())+1 > imgArr.length-1){
		$('#imgIndex').val('0');
	}else{
		$('#imgIndex').val(parseInt($('#imgIndex').val())+1);
	}
	$("#img01").attr('src',imgArr[parseInt($('#imgIndex').val())]);
}

function prevImg(){
	if(parseInt($('#imgIndex').val())-1 < 0){
		$('#imgIndex').val(imgArr.length-1);
	}else{
		$('#imgIndex').val(parseInt($('#imgIndex').val())-1);
	}
	$("#img01").attr('src',imgArr[parseInt($('#imgIndex').val())]);
}
//Image Zoom Ends
</script>
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
                    	<img class="image" onclick="showImgPopUp(this);" id="myimage" src="<%=request.getAttribute("path")%>" alt="big-1">
                    </div>
                    <div class="product-thumb" style="text-align: center;width: 100%;padding-top:100px">
                        	<%for(int i=0;i<images.length();i++) {%>
                                <a onclick="setimage(this);"><img src="<%=images.get(i)%>" alt="" style="width:160px;padding: 20px;"></a>
                            <%}%>
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
        <p class="product-desc">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor indunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
        <p>*Printing and Shipping Charges Extra</p>
		<div><i class="fa fa-minus p10" onclick="updateValue('-');" aria-hidden="true"></i><input type="text" id="quantityBox" onblur="checkValue();" style="width:150px" class="noselect" value="100"></input><i class="fa fa-plus p10" aria-hidden="true" onclick="updateValue('+');"></i></div>
        
        
        <div class="shop-buttons" style="padding:50px 0 30px 0;">
            <a href="javascript:addToCart('<%=request.getAttribute("id")%>','<%=request.getAttribute("name")%>', $('#quantityBox').val());" class="cart-btn"><span>Add to Bag</span></a>
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
<input type="hidden" id="imgIndex" value="0"/>
<div id="myModal" class="modal" style="display: none;">
	<i class="fa fa-times" style="color: white;float: right;padding: 100px;font-size: 100px !important;" onclick="hideModal();"></i>
	<div style="margin-top: 40%;display: flex;">
		<i onclick="prevImg();" class="fa fa-angle-left" style="color:white;margin-top:20%;padding:10%;font-size:150px !important"></i>
  		<img class="modal-content" id="img01">
  		<i onclick="nextImg();" class="fa fa-angle-right" style="color:white;margin-top:20%;padding:10%;font-size:150px !important"></i>
  	</div>
</div> 
</div>