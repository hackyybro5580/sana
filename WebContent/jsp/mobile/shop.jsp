<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%
JSONArray products = (JSONArray)request.getAttribute("products");
int totProducts = (int)request.getAttribute("totProducts");
%>
<style>
.section-title li {
	padding: 30px;
}
.submenu li span {
	width: 50px;
    height: 50px;
    display: inline-block;
    border: 1px solid;
    margin-right: 30px;
    float: left;
    margin-top: 10px;
}
.black{
	background: black;
}
.white{
	background: white;
}
.red{
	background: red;
}
.blue{
	background: blue;
}
.pink{
	background: pink;
}
.yellow{
	background: yellow;
}
.hideLayer {
	position: fixed;
	top: 0;
	z-index: 998;
	width: 100%;
	height: 100%;
	display: none;
}
.shopArea *{
	font-size: 50px !important;
}
.paginationjs-pages ul li{
	padding: 10px;
}
.single-left-widget {
	border: none;
}
.single-product-item {
	max-width: 650px;
    max-height: 800px;
    width: 650px;
    height: 800px;
}
.criteriaClass{
	position: fixed;
    top: 0;
    z-index: 999;
    background: white;
    padding-left: 0px;
    left: 0;
    width: 800px;
    height: 100%;
	bottom:0;
	overflow-y:scroll;
    overflow-x:hidden;
}
.criteriaSlider{
	position: fixed;
	z-index: 998;
	left : 0;
	border: 1px solid;
    border-left: 0;
}
.single-left-widget .section-title ul li a, .single-left-widget .section-title h4{
	font-size: 50px;
}
.single-left-widget .section-title ul li {
	padding: 25px;
}
.showSubMenu{
	display: contents;
}
.active{
	color : #F05166 !important;
}
//Pagination Style Starts
body {
	font-family: 'Roboto', sans-serif;
	font-size: 14px;
	line-height: 18px;
	background: #f4f4f4;
}

.list-wrapper {
	padding: 15px;
	overflow: hidden;
}

.list-item {
	border: 1px solid #EEE;
	background: #FFF;
	margin-bottom: 10px;
	padding: 10px;
	box-shadow: 0px 0px 10px 0px #EEE;
}

.list-item h4 {
	color: #FF7182;
	font-size: 18px;
	margin: 0 0 5px;	
}

.list-item p {
	margin: 0;
}

.simple-pagination {
	-webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    -o-user-select: none;
    user-select: none;
}
.simple-pagination ul {
	margin: 10px 0 10px;
	padding: 0;
	list-style: none;
	text-align: center;
}

.simple-pagination li {
	display: inline-block;
	margin-right: 5px;
}

.simple-pagination li a,
.simple-pagination li span {
	color: #666;
	padding: 3px 17px;
	text-decoration: none;
	border: 1px solid #EEE;
	background-color: #FFF;
	box-shadow: 0px 0px 10px 0px #EEE;
}

.simple-pagination .current {
	color: #FFF;
	background-color: #F05166;
	border-color: #FF7182;
}

.simple-pagination .prev.current,
.simple-pagination .next.current {
	background: #e04e60;
}

.paginationjs-page.J-paginationjs-page.active a{
	color: #FFF;
	background-color: #F05166;
	border-color: #FF7182;
}

.paginationjs-page.J-paginationjs-page.active{
	pointer-events: none;
}
//Pagination Style Ends
</style>
 <!-- latest blog start -->
 <div class="shopArea">
 <div class="breadcrumb-area">
     <div class="container">
         <div class="row">
             <div class="col-md-12 text-left">
                 <ul class="breadcrumb">
                     <li><a href="/home">Home</a><span> - </span></li>
                     <li class="active">Shop</li>
                 </ul>
             </div>
         </div>
     </div>
 </div> 
 
 
 
 

<a href="javascript:showCriteriaSlider();" class="criteriaSlider">
	<i class="fa fa-angle-right" style="padding: 20px;font-size: 100px !important;"></i>
</a>        
<div class="hideLayer">
    <div class="shop-left-sidebar criteriaClass" style="display: none;">
        <div class="single-left-widget">
            <div class="section-title">
                <h4>Category</h4>
                <ul>
                    <li><a class="show-submenu" onclick="showDropMenu(this);" id="wedding">Wedding<i class="fa fa-angle-down"></i></a>
                        <ul class="submenu">
                            <li><a onclick="setSubCategoryAndFetch(this);" value="subCategory#hinduInvitation" id="hinduInvitation">Hindu Invitations</a></li>
                            <li><a onclick="setSubCategoryAndFetch(this);" value="subCategory#muslimInvitation" id="muslimInvitation">Muslim Invitations</a></li>
                            <li><a onclick="setSubCategoryAndFetch(this);" value="subCategory#christianInvitation" id="christianInvitation">Christian Invitations</a></li>
                        </ul>
                    </li>
                    <li><a class="show-submenu" onclick="showDropMenu(this);" id="occassional">Occasional<i class="fa fa-angle-down"></i></a>
                        <ul class="submenu">
                            <li><a onclick="setSubCategoryAndFetch(this);" value="subCategory#engagement" id="engagement">Engagement</a></li>
                            <li><a onclick="setSubCategoryAndFetch(this);" value="subCategory#reception" id="reception">Reception</a></li>
                            <li><a onclick="setSubCategoryAndFetch(this);" value="subCategory#housewarming" id="housewarming">House Warming</a></li>
                            <li><a onclick="setSubCategoryAndFetch(this);" value="subCategory#inauguration" id="inauguration">Inauguration</a></li>
                            <li><a onclick="setSubCategoryAndFetch(this);" value="subCategory#earPiercing" id="earPiercing">Ear Piercing ceremony</a></li>
                            <li><a onclick="setSubCategoryAndFetch(this);" value="subCategory#namingCeremony" id="namingCeremony">Naming ceremony</a></li>
                            <li><a onclick="setSubCategoryAndFetch(this);" value="subCategory#babyShower" id="babyShower">Baby shower</a></li>
                        </ul>
                    </li>
                    <li><a class="show-submenu" onclick="showDropMenu(this);" id="addons">Add On's<i class="fa fa-angle-down"></i></a>
                        <ul class="submenu">
                         <li><a onclick="setSubCategoryAndFetch(this);" value="subCategory#thankyouCards" id="thankyouCards">Thank You Cards</a></li>
                         <li><a onclick="setSubCategoryAndFetch(this);" value="subCategory#thamboolamBags" id="thamboolamBags">Thamboolam Bags</a></li>
                         <li><a onclick="setSubCategoryAndFetch(this);" value="subCategory#friendsInvitation" id="friendsInvitation">Friends Invitations</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
        
        <div class="single-left-widget">
            <div class="section-title">
                <h4>Type</h4>
	                <ul class="submenu" style="display: contents;">
	                	<li><a onclick="setMultipleSubCategoryAndFetch(this);" value="type#single" id="single">Single sheet Cards</a></li>
	                	<li><a onclick="setMultipleSubCategoryAndFetch(this);" value="type#scroll" id="scroll">Scroll Type Cards</a></li>
	                	<li><a onclick="setMultipleSubCategoryAndFetch(this);" value="type#book" id="book">Book Type Cards</a></li>
	                	<li><a onclick="setMultipleSubCategoryAndFetch(this);" value="type#laser" id="laser">Laser Cut Cards</a></li>
	                	<li><a onclick="setMultipleSubCategoryAndFetch(this);" value="type#hand" id="hand">Hand-made Cards</a></li>
                   	</ul>
                   </div>
               </div>
               
				<div class="single-left-widget">
                   <div class="section-title">
                       <h4>Orientation</h4>
                       <ul class="submenu" style="display: contents;">
                		<li><a onclick="setSubCategoryAndFetch(this);" value="orientation#vertical">Vertical Cards</a></li>
						<li><a onclick="setSubCategoryAndFetch(this);" value="orientation#horizontal">Horizontal Cards</a></li>
						<li><a onclick="setSubCategoryAndFetch(this);" value="orientation#square">Square Cards</a></li>
                       </ul>
                   </div>
               </div>
               
				<div class="single-left-widget">
                   <div class="section-title">
                       <h4>Price (<i class="fa fa-inr" aria-hidden="true"></i>)</h4>
                       <ul class="submenu" style="display: contents;">
	                	<li><a onclick="setPriceSortAndFetch(this);" value="1">&lt; 10</a></li>
						<li><a onclick="setPriceSortAndFetch(this);" value="2">10-20</a></li>
						<li><a onclick="setPriceSortAndFetch(this);" value="3">20-30</a></li>
						<li><a onclick="setPriceSortAndFetch(this);" value="4">&gt; 50</a></li>
                		</ul>
		            </div>
		        </div>
		        
				<div class="single-left-widget">
                   <div class="section-title">
                       <h4>filter by color</h4>
                       <ul class="submenu" style="display: contents;">
	                	   <li><span class="black"></span><a onclick="setMultipleSubCategoryAndFetch(this);" value="color#black">black</a></li>
		                   <li><span class="white"></span><a onclick="setMultipleSubCategoryAndFetch(this);" value="color#white">white</a></li>
		                   <li><span class="red"></span><a onclick="setMultipleSubCategoryAndFetch(this);" value="color#red">red</a></li>
		                   <li><span class="blue"></span><a onclick="setMultipleSubCategoryAndFetch(this);" value="color#blue">blue</a></li>
		                   <li><span class="pink"></span><a onclick="setMultipleSubCategoryAndFetch(this);" value="color#pink">pink</a></li>
		                   <li><span class="yellow"></span><a onclick="setMultipleSubCategoryAndFetch(this);" value="color#yellow">yellow</a></li>
                		</ul>
		            </div>
		        </div>
    </div>
</div> 
             
 <div class="shop-grid-leftsidebar-area" style="height: 100%;">
     <div class="container">   
         <div class="row">
             <div>   
                 <div class="shop-item-filter" style="display:none;">
                     <div class="col-lg-4 col-md-3 col-sm-4 col-xs-12">
                         <div class="shop-tab clearfix">
                             <!-- Nav tabs -->
                             <ul role="tablist" style="display: none;">
                                 <li role="presentation" class="active"><a data-toggle="tab" role="tab" aria-controls="grid" class="grid-view" href="#grid"><i class="fa fa-th"></i></a></li>
<!--                                  <li role="presentation"><a data-toggle="tab" role="tab" aria-controls="list" class="list-view" href="#list"><i class="fa fa-th-list"></i></a></li> -->
                             </ul>
                         </div>
                     </div>    
                     <div class="col-lg-4 col-md-5 col-sm-4 hidden-xs">      
                         <div class="filter-by text-center" style="width: 500px;">
                             <h4>Sort by: </h4>
                             <form action="#">
                                 <div class="select-filter">
                                     <select id="sortOrder" onchange="pagination();">
                                       <option value="name">Name</option>
                                       <option value="price">Price</option>
                                     </select> 
                                 </div>
                             </form>								
                         </div>
                     </div> 
                     <div class="col-lg-4 col-md-4 col-sm-4 hidden-xs">
                         <div class="filter-by right">
                             <form action="#">
                                 <div class="select-filter">
                                     <select id="limit" onchange="pagination();">
                                        <option value="12">12</option>
                                        <option value="24">24</option>
                                        <option value="36">36</option>
                                      </select> 
                                 </div>
                             </form>	
                         </div>
                     </div>    
                 </div>
                 <div class="clearfix"></div>
                 <div id="productsListAndPagination">             
                 <div id="productsList" style="min-height:990px; !important">
	                 <div class="tab-content">
	                     <div id="grid" class="tab-pane active" style="min-height:990px;" role="tabpanel">
		                     <%if(totProducts==0){%>
                         		 <div class="col-md-4 col-sm-4 col-xs-12" style="border: 1px solid #ddd;width: 100%;padding: 75px;">
                                 <div class="single-product">
                                    <div style="text-align: center;">
                                         <p style="color: #494039 !important;font-size: 19px;font-style: italic;font-weight: 100;">No items match your search!</p>
                                 	</div>
                                 </div>
                             </div>
                         	<%}else{%>
	                         <div class="row">
	                         	<table style="width: 100%;">
	                         		<%for(int i=0, y=0;i<=products.length();i+=2){%>
	                         		  <tr>
	                         		  	<% int z = (i%2==0 && i>=2) ? 2 : i<2 ? i : i/2;
	                         		  	for(int j=0;j<z;j++){JSONObject obj = products.getJSONObject(y++);%>
	                         		  	<td>
			                             <div class="col-md-4 col-sm-4 col-xs-12" style="width:260px;">
			                                 <div class="single-product">
			                                     <div class="single-product-item">
			                                         <div class="single-product-img clearfix hover-effect">
			                                             <a onclick="openProductDetails('<%=obj.get("id")%>');">
			                                                 <img class="primary-image" src="<%=obj.get("path")%>" alt="">
			                                             </a>
			                                         </div>
			                                         <div class="single-product-info clearfix"> 
			                                             <div class="pro-price">
			                                                 <span class="new-price">Rs. <%=obj.get("price")%></span>
			                                             </div>
			                                         </div>
			                                         <div class="product-content text-center">
			                                             <h4><a onclick="openProductDetails('<%=obj.get("id")%>');"></a></h4>
			                                         </div>
			                                     </div>
			                                 </div>
			                               </div>
			                             <td>
			                        	<%}%>     
		                               </tr>
		                            <%}}%>
	                         	</table>
	                         </div>    
	                     </div>
                 	</div>
             	</div>   
	            <div class="row">
	                 <div>   
	                     <div class="shop-item-filter bottom">
	                     <div class="col-lg-4 col-md-4 col-sm-4 hidden-xs"></div>
	                         <div class="col-lg-4 col-md-4 col-sm-4 hidden-xs" style="width:100%;padding: 30px;">
								<div id="pagination-container" class="light-theme simple-pagination"></div> 
	                         </div>    
	                     </div>
	                 </div>    
	            </div> 
             </div>
         </div>
     </div>
 </div>
 </div> 
 </div>
 
 
 
<input type="hidden" id="subCategory" value="all">
<input type="hidden" id="type" value="all">
<input type="hidden" id="orientation" value="all">
<input type="hidden" id="price" value="0">
<input type="hidden" id="color" value="all">
<input type="hidden" id="page" value="1">  
<input type="hidden" id="totProducts" value="<%=totProducts%>">
 <!-- latest blog end -->
 
<script>
$(document).ready(function(){
	pagination();
	if(location.pathname == '/shop'){
		var hashes = window.location.href.split('#');
		if(hashes.length > 2){
			if(hashes[1] == "type"){
				$('#'+hashes[2]).click();
			}else{
				$('#'+hashes[1]).click();
				$('#'+hashes[2]).click();
			}	
		}
	}
//	window.history.pushState('shop', 'SANA', '/shop');
//	if(selector[0]=='type'){
//		$('#'+selector[1]).click();
//	}else{
//		$('#'+selector[0]).click();
//		$('#'+selector[1]).click();
//	}
});
function pagination(){
	$('#pagination-container').pagination({
	    dataSource: function(done){
	        			var result = [];
	        			var totProducts = $('#totProducts').val();
	        			for (var i = 1; i <= totProducts; i++) {
	            			result.push(i);
	        			}
	        			done(result);
	    			},
		pageSize: 12,
		callback: function(data, pagination) {
	        $('#page').val($('.paginationjs-page.J-paginationjs-page.active').attr('data-num'));
	        getProducts();	
	    }
	});
}
function showCriteriaSlider(){
 	$('.criteriaClass, .hideLayer').show();	
}
$(document).click(function(e) {
    var container = $(".criteriaClass");
    if (!container.is(e.target) && container.has(e.target).length === 0) 
    {
    	$(".criteriaClass, .hideLayer").hide();
    }
});
</script>