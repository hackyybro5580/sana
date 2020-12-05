function addToCart(id, name, count){
	$.post("/addToCart",{"id":id,"count":count},
		function(data, textStatus, jqXHR){
			var shoppingCart = $(data).find('#shoppingCart');
			if(shoppingCart.length>0){
				$('#shoppingCart').replaceWith(shoppingCart);
			}
		//Notifier
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
	});
}

function removeFromCart(id, name, currObj, count){
	$.post("/removeFromCart",{"id":id,"isCartPage":"true"},
			function(data, textStatus, jqXHR){
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
	return $.post("/shop",{"crit":subCategory+"#"+type+"#"+orientation+"#"+priceOrder+"#"+color+"#"+sortOrder+"#"+limit+"#"+page},
		function(data, textStatus, jqXHR){
		data = $(data);
		var products = data.find(replaceElement);
		if(products.length>0){
			$(replaceElement).replaceWith(products);
			$('#totProducts').val(data.filter('#totProducts').val());
		}
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
	
	currObj.parent().siblings().find('a').removeClass('active');
	if(currObj.hasClass('active')){
		currObj.removeClass('active');
	}else{
		currObj.addClass('active');
	}
	
	fetchProductsAndApplyPagination();
}
function setPriceSortAndFetch(currObj){
	resetPage();
	var priceObj = $('#price');
	priceObj.val($(currObj).attr('value'));
	
	currObj = $(currObj);
	currObj.parent().siblings().find('a').removeClass('active');
	if(currObj.hasClass('active')){
		currObj.removeClass('active');
		priceObj.val(0);
	}else{
		currObj.addClass('active');
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
	currObj = $(currObj);
	var postURL = "/shop#"+currObj.attr('value');
	var selector = currObj.attr('value').split('#'); 
	$.post(postURL,
		function(data, textStatus, jqXHR){
		$("html").html(data);
	}).done(function(){
		window.history.pushState('shop', 'SANA', '/shop');
		if(selector[0]=='type'){
			$('#'+selector[1]).click();
		}else{
			$('#'+selector[0]).click();
			$('#'+selector[1]).click();
		}
	});
}
function openProductDetails(productId){
	window.open("/productDescription?prodId="+productId);
}