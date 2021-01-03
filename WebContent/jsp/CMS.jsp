<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/font-awesome.min.css">
<title>Admin Tool</title>
<script src="/js/jquery-1.12.3.min.js"></script>
<script src="js/bootstrap-notify.min.js"></script>
<script src="/js/crypto-js.js"></script>
<style>
.limitText{
	display:block;
	text-overflow: ellipsis;
	width: 200px;
	overflow: hidden;
	white-space: nowrap;
}
.adminClass{
	padding : 10px;
}
.fullPage{
	width: 100%;
    height: 100%;
}
a:hover, i:hover, button:hover{
	cursor : pointer;
}
#products{
	margin-top: 5%;
}
.edit{
	display:none;
}
</style>
</head>
<body>
<div class="adminClass">
	<div style="text-align: center;">
		<a href="/homepage"><img id="sanaCard" src="img/sanaLogo.jpg" style="width: 35%;" alt="SANA CARDS"></a>
	</div>
</div>

<div class="fullPage">
	<table class="fullPage">
		<tr>
			<th width="20%" style="min-width:250px;">Type</th>
			<th>Items</th>
		</tr>
		<tr>
			<td style="vertical-align: baseline;">
				<aside>
				   <nav>
				      <div>
				         <ul>
				            <li>
				               <span>Index</span>
				               <i style="font-size: 50px;"></i>
				               <div>
				                  <ul>
									<li><a onclick="viewItems(this);" id="sliderContent" value="sliderContent">Slider Content</a></li>
									<li><a onclick="viewItems(this);" id="blogs" value="blogs">Blogs</a></li>
				                  </ul>
				               </div>
				            </li>
				            <li>
				               <span>Wedding</span>
				               <i style="font-size: 50px;"></i>
				               <div>
				                  <ul>
				                     <li><a onclick="viewItems(this);" id="hinduInvitation" value="hinduInvitation">Hindu Invitations</a></li>
									 <li><a onclick="viewItems(this);" id="muslimInvitation" value="muslimInvitation">Muslims Invitations</a></li>
									 <li><a onclick="viewItems(this);" id="christianInvitation" value="christianInvitation">Christian Invitations</a></li>
				                  </ul>
				               </div>
				            </li>
				            <li>
				               <span class="menu-text">Type</span>
				               <i style="font-size: 50px;"></i>
				               <div>
				                  <ul>
									<li><a onclick="viewItems(this);" id="single" value="single">Single sheet Cards</a></li>
									<li><a onclick="viewItems(this);" id="scroll" value="scroll">Scroll Type Cards</a></li>
									<li><a onclick="viewItems(this);" id="book" value="book">Book Type Cards</a></li>
									<li><a onclick="viewItems(this);" id="laser" value="laser">Laser Cut Cards</a></li>
									<li><a onclick="viewItems(this);" id="hand" value="hand">Hand-made Cards</a></li>
				                  </ul>
				               </div>
				            </li>
				            <li>
				               <span>Occasional</span>
				               <i style="font-size: 50px;"></i>
				               <div class="sidebar-submenu">
				                  <ul>
									<li><a onclick="viewItems(this);" id="engagement" value="engagement">Engagement</a></li>
									<li><a onclick="viewItems(this);" id="reception" value="reception">Reception</a></li>
									<li><a onclick="viewItems(this);" id="housewarming" value="housewarming">House Warming</a></li>
									<li><a onclick="viewItems(this);" id="inauguration" value="inauguration">Inauguration</a></li>
									<li><a onclick="viewItems(this);" id="earPiercing" value="earPiercing">Ear Piercing ceremony</a></li>
									<li><a onclick="viewItems(this);" id="namingCeremony" value="namingCeremony">Naming ceremony</a></li>
									<li><a onclick="viewItems(this);" id="babyShower" value="babyShower">Baby shower</a></li> 
				                  </ul>
				               </div>
				            </li>
				            <li>
				               <span>Add Ons</span>
				               <i style="font-size: 50px;"></i>
				               <div>
				                  <ul>
									<li><a onclick="viewItems(this);" id="thankyouCards" value="thankyouCards">Thank You Cards</a></li>
				                    <li><a onclick="viewItems(this);" id="thamboolamBags" value="thamboolamBags">Thamboolam Bags</a></li>
				                    <li><a onclick="viewItems(this);" id="friendsInvitation" value="friendsInvitation">Friends Invitations</a></li> 
				                  </ul>
				               </div>
				            </li>
				            <li style="display:none">
				               <span>Our Story</span>
				               <i style="font-size: 50px;"></i>
				               <div>
				                  <ul>
									<li><a onclick="viewItems(this);" id="aboutus" value="aboutus">About Us</a></li>
				                    <li><a onclick="viewItems(this);" id="ourblog" value="ourblog">Our Blog</a></li> 
				                  </ul>
				               </div>
				            </li>
				         </ul>
				      </div>
				   </nav>
				</aside>	
			</td>
			<td style="vertical-align:baseline;">
				<div id="products">
					<h3>Choose an option.</h3>
				</div>
			</td>
		</tr>
	</table>
</div>
<input type="hidden" id="currentSelector"/>
</body>

<script>
function viewItems(currObj){
	var subcategory = $(currObj).attr('value');
	$('#currentSelector').val(subcategory);
	window.history.replaceState(null, null, "?selector="+subcategory);
	$.post("/viewItems",{"subcategory":subcategory},
		function(data, textStatus, jqXHR){
			$('#products').html(data);		
		});
}
function deleteItem(id, currObj){
	if (window.confirm('Remove item?')){
		performOperation('delete',$('#currentSelector').val(), id, currObj);
	}
}
function editItem(id, currObj){
	var selector = $('.'+id);
	currObj = $(currObj);
	currObj.parent().hide();
	currObj.parent().siblings().show();
	
	$($(currObj.parent().parent().parent().children()[0]).children()[0]).hide();
	$($(currObj.parent().parent().parent().children()[0]).children()[1]).show();
	
	$($(currObj.parent().parent().parent().children()[1]).children()[0]).hide();
	$($(currObj.parent().parent().parent().children()[1]).children()[1]).show();
	selector.siblings().hide();
	selector.show();
}
function cancelEdit(id, currObj){
	var selector = $('.'+id);
	selector.siblings().show();
	currObj = $(currObj);
	
	$($(currObj.parent().parent().parent().children()[0]).children()[1]).hide();
	$($(currObj.parent().parent().parent().children()[0]).children()[0]).show();
	
	$($(currObj.parent().parent().parent().children()[1]).children()[1]).hide();
	$($(currObj.parent().parent().parent().children()[1]).children()[0]).show();
	selector.hide();
}
function saveChange(currObj, id){
	var tempObj = currObj;
	currObj = $(currObj);
	currObj.parent().hide();
	currObj.parent().siblings().show();
	var inputs = currObj.parent().parent().parent().find('input,select');

	var editVal = {};
	if(id!==undefined && id!==''){
		editVal.id = id;
	}
	inputs.each(function(index){
		var element = $(inputs[index]);
		editVal[element.attr('selectorVal')] = element.val(); 
	});
	performOperation('update', $('#currentSelector').val(), JSON.stringify(editVal), tempObj);
}
function addProduct(currObj){
	var tempObj = currObj;
	currObj = $(currObj);
	currObj.parent().hide();
	currObj.parent().siblings().show();
	var inputs = currObj.parent().parent().parent().find('input,select');

	var editVal = {};
	editVal.subCategory = $('#currentSelector').val();
	inputs.each(function(index){
		var element = $(inputs[index]);
		editVal[element.attr('selectorVal')] = element.val(); 
	});
	performOperation('create', editVal.subCategory, JSON.stringify(editVal), tempObj);
}
function addRow(){
	$('#productsTable tbody').append('<tr><td><span> <i onclick="addProduct(this);" class="fa fa-check"></i></span></td><td><span> <i onclick="deleteItem(undefined, this);" class="fa fa-times"></i></span></td><td><span><input selectorVal="id" type="text"></span></td><td width="15%"><span><input selectorVal="path" type="text"></span></td><td><span><input selectorVal="name" type="text"></span></td><td><span><input selectorVal="price" type="text"></span></td><td><span><select name="type" selectorVal="type"><option value="single">single</option><option value="scroll">scroll</option><option value="book">book</option><option value="laser">laser</option><option value="hand">hand</option></select></span></td><td><span><select name="orientation" selectorVal="orientation"><option value="vertical">vertical</option><option value="horizontal">horizontal</option><option value="square">square</option></select></span></td><td><span><select name="color" selectorVal="color"><option value="black">black</option><option value="white">white</option><option value="red">red</option><option value="blue">blue</option><option value="pink">pink</option><option value="yellow">yellow</option></select></span></td><td><span><input selectorVal="description" type="text"></span></td><td><span><input selectorVal="images" type="text"></span></td><td><span><select name="isShowCaseItem" selectorVal="isShowCaseItem"><option value="true">true</option><option value="false">false</option></select></span></td></tr>');
}
function addSliderRow(){
	$('#productsTable tbody').append('<tr><td><span> <i onclick="addProduct(this);" class="fa fa-check"></i></span></td><td><span> <i onclick="deleteItem(undefined, this);" class="fa fa-times"></i></span></td><td><span><input selectorVal="path" type="text"></span></td><td><span><input selectorVal="title1" type="text"></span></td><td><span><input selectorVal="title2" type="text"></span></td></tr>');
}
function addBlogRow(){
	$('#productsTable tbody').append('<tr><td><span> <i onclick="addProduct(this);" class="fa fa-check"></i></span></td><td><span> <i onclick="deleteItem(undefined, this);" class="fa fa-times"></i></span></td><td><span><input selectorVal="path" type="text"></span></td><td><span><input selectorVal="date" type="text"></span></td><td><span><input selectorVal="likeURL" type="text"></span></td><td><span><input selectorVal="postURL" type="text"></span></td><td><span><input selectorVal="title1" type="text"></span></td><td><span><input selectorVal="title2" type="text"></span></td><td><span><input selectorVal="title3" type="text"></span></td></tr>');
}
function performOperation(type, subCategory,  param, currObj){
	$.post("/CMS",{"type":type, "subCategory":subCategory, "inputData":param})
		.done(function(){
			if(type==="update" || type==="create"){
				window.location.href=window.location.href.split('?')[0]+"?selector="+$('#currentSelector').val();
			}else if(type==="delete"){
				$(currObj).parent().parent().parent().remove();
			}
		});
	
}
$(document).ready(function(){
	var selector = getUrlParameter('selector');
	if(selector!=undefined){
		$('#'+selector).click();
	}
});

var getUrlParameter = function getUrlParameter(sParam) {
    var sPageURL = window.location.search.substring(1),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
        }
    }
};
</script>
</html>