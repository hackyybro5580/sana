//window.onload = function() {
//  let check = false;
//  (function(a){if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4))) check = true;})(navigator.userAgent||navigator.vendor||window.opera);
//  document.cookie = "isMobile="+check;
//  return check;
//};
$('.mainmenu ul li, .mainmenu ul li').hover(function(){
	if(isSafari){
		$('.mainmenu ul li, .mainmenu ul li').css('transform','unset');
	}
});
function addToCart(id, name, count, isPageReload, isUpdate){
	$('.product-details-area, #grid').loadingView({'state':true});
	var operation = null;
	if(isUpdate){
		operation = 'update';
	}
	$.post("/addToCart",{"id":id,"count":count, "operation":operation},
		function(data, textStatus, jqXHR){
		if($('.cartContainer').length>0){
			location.reload();
		}else{
			data = $(data);
			var shoppingCart = data.find('#shoppingCart');
			if(shoppingCart.length>0){
				$('#shoppingCart').replaceWith(shoppingCart);
			}
		}
		$('.product-details-area, #grid').loadingView({'state':false});
		//Notifier
		if(name!=='undefined' && name!==''){
			$.notify({
				title: '<strong>'+name+'</strong>',
			    message : 'Added to cart'
			},{
				type: 'success',
			    animate: {
					enter: 'animated fadeInRight',
					exit: 'animated fadeOutRight'
				},
				placement: {
					from: 'bottom'
				}
			});
		}
		if(isPageReload){
			window.location.reload();
		}
	});
}

function removeFromCart(id, name, currObj, count){
	$.post("/removeFromCart",{"id":id,"isCartPage":"true"},
			function(data, textStatus, jqXHR){
				if($('.cartContainer').length>0){
					location.reload();
				}else{
					if($('div.cart-area').length>0){
						var cartPage = $(data).find('div.cart-area');
						$('div.cart-area').replaceWith(cartPage);
						
						var shoppingCart = $(data).find('#shoppingCart');
						if(shoppingCart.length>0){
							$('#shoppingCart').replaceWith(shoppingCart);
						}
					}else{
						if(data!="error"){
							if($(currObj).parents().find('li.single-cart-item.clearfix').length>2){
								currObj.parentNode.parentElement.remove();
								var cartLength = $('#cartLength');
								cartLength.text(cartLength.text()-1);
							}else{
								var shoppingCart = $(data).find('#shoppingCart');
								if(shoppingCart.length>0){
									$('#shoppingCart').replaceWith(shoppingCart);
								}
							}
						}
					}
				}
			//Notifier
			$.notify({
				title: '<strong>'+name+'</strong>',
			    message : 'removed from cart'
			},{
				type: 'info',
			    animate: {
					enter: 'animated fadeInRight',
					exit: 'animated fadeOutRight'
				},
				placement: {
					from: 'bottom'
				}
			});
		});
}
function proceedToEnquire(){
	if(!validate()){
		return;
	}
	$('.loader').fadeIn();
	$('#processText').text('Processing');
	var name = $("input[type='text'][name='name']").val();
	var email = $("input[type='email'][name='email']").val();
	var mobile = $("input[type='tel'][name='number']").val();
	$.post("/proceedToEnquire",{"name":name,"email":email,"mobile":mobile},
		function(data, textStatus, jqXHR){
			if(data=="success"){
				$('.left_comment, .section-heading, .fa.fa-close').hide();
				$('.orderSuccess').show();
//				$('.proceedToEnquireClass').css('height', '800px');
			}else{
				closePopup();
				myAlert('danger', 'Error occurred while placing your order', 'Please try again or contact us.');
			}
	});
}
function showPopup(){
	$('#backgroundDiv').fadeIn();
	$('#proceedToEnquirePopUp').show();
}
function closePopup(){
	$('#proceedToEnquirePopUp').hide();
	$('#backgroundDiv').fadeOut();
	$('.loader').hide();
	$('#processText').text('Proceed');
}
function validate(){
	var nameValidator = /^[a-zA-Z ]+$/;
	var emailValidator = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
	var phoneNumberValidator = /^([0|\+[0-9]{1,5})?([7-9][0-9]{9})$/;
	var result = true;
	if($("input[type='text'][name='name']").val().match(nameValidator)==null){
		myAlert('danger', "Error!", "Enter a valid name.");
		result = false;
	}
	if($("input[type='email'][name='email']").val().match(emailValidator)==null){
		myAlert('danger', "Error!", "Enter a valid email.");
		result = false;
	}
	if($("input[type='tel'][name='number']").val().match(phoneNumberValidator)==null){
		myAlert('danger', "Error!", "Enter a valid mobile number.");
		result = false;
	}
	return result;
}
function myAlert(alertType, titleContent, messageContent){
	$.notify({
		title: titleContent,
	    message : messageContent
	},{
		type: alertType,
	    animate: {
			enter: 'animated fadeInRight',
			exit: 'animated fadeOutRight'
		},
		placement: {
			from: 'bottom'
		}
	});
}
function showDropMenu(currentObj){
	$(currentObj).parent().siblings().children('ul').removeClass('showSubMenu');;
	var currentObjSelection = $(currentObj).parent().children('ul');
	if(currentObjSelection.hasClass('showSubMenu')){
		currentObjSelection.removeClass('showSubMenu');
	}else{
		currentObjSelection.addClass('showSubMenu');
	}
} 
function getProducts(){
	var subCategory = $('#subCategory').val();
	var type = $('#type').val();
	var orientation = $('#orientation').val();
	var priceOrder = $('#price').val();
	var color = $('#color').val();
	
	var replaceElement = '#productsList';
	var limit = $('#limit').find(":selected").text();
	var page = $('#page').val();
	if(page==""){
		page = "1";
	}
	var sortOrder = $('#sortOrder').val();
	$('#grid').loadingView({'state':true});
	return $.post("/shop",{"crit":subCategory+"#"+type+"#"+orientation+"#"+priceOrder+"#"+color+"#"+sortOrder+"#"+limit+"#"+page},
		function(data, textStatus, jqXHR){
		data = $(data);
		var products = data.find(replaceElement);
		if(products.length>0){
			$(replaceElement).replaceWith(products);
			if(data.find('#totProducts').length>0){
				$('#totProducts').val(data.find('#totProducts').val());
			}else{
				$('#totProducts').val(data.filter('#totProducts').val());
			}
		}
		$('#grid').loadingView({'state':false});
	});
}
function setSubCategoryAndFetch(currObj){
	resetPage();
	
	currObj = $(currObj);
	var idVsValue = currObj.attr('value').split('#');
	if(idVsValue[1]==$('#'+idVsValue[0]).val()){
		$('#'+idVsValue[0]).val('all');
	}else{
		$('#'+idVsValue[0]).val(idVsValue[1]);
	}
	
	var ul = currObj.parent().siblings().find('a');
	ul.removeClass('active');
	ul.children().remove();
	if(currObj.hasClass('active')){
		currObj.removeClass('active');
		currObj.children().remove();
	}else{
		currObj.addClass('active');
		currObj.append('<i class="fa fa-check-square mT4 noBorder fR"></i>');
	}
	
	fetchProductsAndApplyPagination();
}
function setMultipleSubCategoryAndFetch(currObj){
	resetPage();
	
	currObj = $(currObj);
	var idVsValue = currObj.attr('value').split('#');
	var values = $('#'+idVsValue[0]).val();
	if (values.includes('$'+idVsValue[1])) {
		$('#'+idVsValue[0]).val(values.replace('$'+idVsValue[1],''));
	}else if(values.includes(idVsValue[1])){
		$('#'+idVsValue[0]).val(values.replaceAll(idVsValue[1],''));
	}else{
		var selectorID = $('#'+idVsValue[0]);
		$('#'+idVsValue[0]).val($('#'+idVsValue[0]).val()+'$'+idVsValue[1]);
	}
	
	if(currObj.hasClass('active')){
		currObj.removeClass('active');
		currObj.children().remove();
	}else{
		currObj.addClass('active');
		currObj.append('<i class="fa fa-check-square mT4 noBorder fR"></i>');
	}
	
	fetchProductsAndApplyPagination();
}
function setPriceSortAndFetch(currObj){
	resetPage();
	var priceObj = $('#price');
	priceObj.val($(currObj).attr('value'));
	
	currObj = $(currObj);
	var ul = currObj.parent().siblings().find('a');
	ul.removeClass('active');
	ul.children().remove();
	if(currObj.hasClass('active')){
		currObj.removeClass('active');
		currObj.children().remove();
		priceObj.val(0);
	}else{
		currObj.addClass('active');
		currObj.append('<i class="fa fa-check-square mT4 noBorder fR"></i>');
	}
	
	fetchProductsAndApplyPagination();
}
function resetPage(){
	var page = $('#page').val(1);
}
function fetchProductsAndApplyPagination(){
	$.when( getProducts() ).done(function() {
		pagination();
	});
}
function openShopPage(currObj){
//	currObj = $(currObj);
//	var postURL = "/shop#"+currObj.attr('value');
//	var selector = currObj.attr('value').split('#'); 
//	$.post(postURL,
//		function(data, textStatus, jqXHR){
//		$("html").html(data);
//	}).done(function(){
//		window.history.pushState('shop', 'SANA', '/shop');
//		if(selector[0]=='type'){
//			$('#'+selector[1]).click();
//		}else{
//			$('#'+selector[0]).click();
//			$('#'+selector[1]).click();
//		}
//	});
	
	currObj = $(currObj);
	document.cookie = "subCategory="+currObj.attr('value').split('#')[1];
	var postURL = "/shop#"+currObj.attr('value');
	$('html').loadingView({'state':true});
	window.location.href = postURL;
	if(window.location.pathname === '/shop'){
		window.location.reload();
	}
}
function openProductDetails(productId){
	window.open("/productDescription?prodId="+productId);
}