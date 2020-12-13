<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%
JSONArray cart = new JSONArray();
float total = 0;
if(request.getAttribute("cart")!=null){
	cart = (JSONArray)request.getAttribute("cart");
}
%>
<style>
.left_comment{
	padding: 30px;
}
.proceedToEnquireClass {
	width: 888px;
    height: 808px;
    padding: 63px;
}
#backgroundDiv {
	z-index: 998;	
}
#cartPage * {
	font-size: 50px !important;
}
.active {
    color: #F05166 !important;
}
.cart_list tbody td.product_des {
	padding: 0 0;
}
.total {
	width: unset;
}
.p_action {
	position: absolute;
    left: -80px;
    border: none !important;
    margin-top: 73px;
}
</style>
<div id="cartPage" style="min-height: 1200px;">
 <!-- breadcrumb start -->
 <div class="breadcrumb-area">
     <div class="container">
         <div class="row">
             <div class="col-md-12 text-left">
                 <ul class="breadcrumb">
                     <li><a href="/home">Home</a><span> - </span></li>
                     <li class="active">shopping cart</li>
                 </ul>
             </div>
         </div>
     </div>
 </div> 
 <!-- breadcrumb end -->
 <!-- cart start -->
 <div class="cart-area">
     <div class="container">          
         <div class="row">
             <div class="col-xs-12">   
                 <div class="cart_list table-responsive">
                     <table class="table_cart table-bordered">
                         <thead>
                             <tr>
                                 <th class="id">#</th>
                                 <th class="product">Image</th>
                                 <th class="description">Product Name</th>
                                 <th class="quantity">Quantity</th>
                                 <th class="value">Price</th>
                             </tr>
                         </thead>
                         <tbody>
                         	<%if(cart.length()>0){
                         	for(int i=0;i<cart.length();i++){JSONObject obj = cart.getJSONObject(i);total+=Float.parseFloat(obj.get("totalPrice")+"");%>
                             <tr>
                                 <td class="id"><%=i+1%></td>
                                 <td class="product_img"><a onclick="javascript:openProductDetails('<%=obj.get("id")%>');"><img alt="cart" src="<%=obj.get("path")%>" style="max-height: 200px;"></a></td>
                                 <td class="product_des">
                                     <h3><a href="#"><%=obj.get("name")%></a></h3>
                                 </td>
                                 <td class="id"><%=obj.get("count")%></td>
                                 <td class="p_value">Rs. <%=obj.get("totalPrice")%></td>
                                 <td class="p_action">
                                     <a onclick="removeFromCart('<%=obj.get("id")%>','<%=obj.get("name")%>');"><i class="fa fa-trash"></i></a>
                                 </td>
                             </tr>
                            <%}}else{%>
                             <tr>
                             	<td colspan="6" style="padding: 2%;">No items in your cart</td>
                             </tr>
                            <%} %>
                         </tbody>
                     </table>
                 </div>
             </div>
         </div>
         <div class="row">
             <div class="col-lg-5 col-md-4 col-sm-12">           
                 <a href="/homepage" class="continue-shopping" style="display:none;">continue shopping</a>
             </div>   
             <%if(cart.length()>0){%> 
             <div class="col-lg-7 col-md-8 col-sm-12">      
                 <div class="total text-right">
                     <h2>subtotal <span><i class="fa fa-rupee" style="font-size:45px !important;padding-right:20px;"></i> <%=Math.round(total*100.0)/100.0%></span></h2>
                     <h2 class="strong">grandtotal <span><i class="fa fa-rupee" style="font-size:45px !important;padding-right:20px;"></i> <%=Math.round(total*100.0)/100.0%></span></h2>
                     <a class="continue-shopping" style="margin-top: 50px;" id="go" rel="leanModal" onclick="showPopup();">Proceed to Enquire</a>
                 </div>
             </div>    
             <%}%>
         </div>
         
         
         <div id="proceedToEnquirePopUp">
         	  <a class="fa fa-close" style="float: right;margin-right: 8px;margin-top: 6px;" onclick="closePopup();"></a>
              <div class="proceedToEnquireClass" style="margin-left: -150px;">
                  <div class="section-heading">
                      <h3>Please fill in to proceed</h3>
                  </div>  
                  <div class="contact-form">
                      <div class="leave-a-comment">
                          <div class="leave_comment">
                              <form action="mail.php" method="post">
                                  <div class="name_email_form clearfix">
                                      <div class="left_comment">
                                          <input type="text" name="name" placeholder="Name">
                                      </div>
                                      <div class="left_comment">
                                          <input type="email" name="email" placeholder="Email">
                                      </div>
                                      <div class="left_comment">
                                          <input type="tel" name="number" placeholder="Mobile Number">
                                      </div>
                                      <div class="left_comment">
                                          <a class="continue-shopping" style="padding: 30px;" onclick="proceedToEnquire();"><span class="loader" style="float: left;"></span><span id="processText" style="line-height: 24px;">Proceed</span></a>
                                      </div>
                                      <div class="orderSuccess" style="display:none;padding-bottom: 60px;">
                                          <p style="color: #303030;font-size: 18px;">Your order has been placed successfully.<br/>Check your email for order details.</p>
                                      </div>
                                      <div class="orderSuccess" style="display:none;">
                                          <a class="continue-shopping" href="/homepage">OK</a>
                                      </div>
                                  </div>    
                              </form>
                          </div>
                      </div>
                  </div>
              </div>    
		</div>
         
     </div>
 </div>
 </div>
 <div id="backgroundDiv"></div>