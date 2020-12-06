package org.sana.core;

import java.io.PrintWriter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.json.JSONArray;
import org.json.JSONObject;
import org.sana.util.DefaultValues;
import org.sana.util.MailUtil;
import org.sana.util.PropertyUtil;
import org.sana.util.SQLUtil;

import com.rmz.cryptoutil.CryptoUtil;

public class SanaAction{

	public static JSONObject requestObj;
	public static JSONObject products;
	HttpServletRequest request;
	HttpServletResponse response;
	public String execute()
	{
		 String result="success";
		 try {
			 request  = ServletActionContext.getRequest();
			 response = ServletActionContext.getResponse();
			 
			 if(requestObj==null) {
			     requestObj = new JSONObject();
				 requestObj.put("sliderContent", limitShowCaseItems(PropertyUtil.getValue("sliderContent")));
				 requestObj.put("showCaseHindu", limitShowCaseItems(PropertyUtil.getValue("showCaseHindu")));
				 requestObj.put("showCaseMuslim", limitShowCaseItems(PropertyUtil.getValue("showCaseMuslim")));
				 requestObj.put("showCaseChristian", limitShowCaseItems(PropertyUtil.getValue("showCaseChristian")));
				 requestObj.put("friendsInvitation", limitShowCaseItems(PropertyUtil.getValue("friendsInvitation")));
				 requestObj.put("thamboolamBags", limitShowCaseItems(PropertyUtil.getValue("thamboolamBags")));
				 requestObj.put("engagementInvitations", limitShowCaseItems(PropertyUtil.getValue("engagementInvitations")));
				 requestObj.put("latestNews", limitShowCaseItems(PropertyUtil.getValue("latestNews")));
				 requestObj.put("instaFeed", limitShowCaseItems(PropertyUtil.getValue("instaFeed")));
			 }
			 if(products==null) {
				 products = new JSONObject();	
				 String[] productsArray = DefaultValues.productArray;
				 for(String product : productsArray) {
					 JSONArray item = new JSONArray(PropertyUtil.getValue(product));
					 for(int i=0;i<item.length();i++) {
						 JSONObject itemObj = item.getJSONObject(i);
						 if(itemObj.has("id")) {
							 products.put(itemObj.get("id")+"", itemObj);
						 }
					 }
				 }
			 }
			 
			 if(requestObj!=null) {
				 request.setAttribute("requestObj", requestObj);
			 }
			 
			 if(products!=null) {
				//Loading Cart Values
				 JSONArray cart = new JSONArray();
				 String items = getCartItemsFromCookie();
				 String chosenItems[] = items.split(",");
				 String pId = null;
				 int pCount;
				 JSONObject product = null;
				 for(String item : chosenItems) {
					 pId = item.split("#")[0];
					 if(products.has(pId)) {
						 pCount = Integer.parseInt(item.split("#")[1]);
						 product = (JSONObject)products.get(pId);
						 product.put("count", pCount);
						 product.put("totalPrice", Math.round(Float.parseFloat(product.get("price")+"")*pCount*100.0)/100.0);
						 cart.put(products.get(pId));
					 }
				 }
				 if(cart.length()>0) {
					 request.setAttribute("cart", cart);
				 }
			 }
			 
//			 if(hasAgreedToCookiePolicy()) {
//				 Cookie cookie = new Cookie("hasAgreed", "");
//				 cookie.setMaxAge(3600 * 24 * 365 * 1);	//Expires in one year
//					response.addCookie(cookie);
//					request.setAttribute("cart", cart);
//			 }
			 boolean isFirstVisit = isFirstVisit();
			 if(isFirstVisit) {
				 Cookie cookie = new Cookie("isFirstVisit", "false");
				 response.addCookie(cookie);
			 }
			 request.setAttribute("isFirstVisit", isFirstVisit);
			 
		 }catch(Exception e) {
			 result = "error";
		 }
		 return result;
	}
	
	public String addToCart() {
		execute();
		try {
			String productId = request.getParameter("id");
			String count = request.getParameter("count");
			Boolean isPresentInCart = Boolean.FALSE;
			
			if(productId==null) {
				return "error";
			}
			if(count==null) {
				count="1";
			}
			
			JSONArray cart = new JSONArray();
			JSONObject product = null; 
			String items = getCartItemsFromCookie();
			String chosenItems[] = items.split(",");
			String pId = null;
			int pCount;
			items="";
			for(String item : chosenItems) {
				pId = item.split("#")[0];
				if(products.has(pId)) {
					pCount = Integer.parseInt(item.split("#")[1]);
					if(pId.equals(productId)) {
						isPresentInCart = Boolean.TRUE;
						pCount+=Integer.parseInt(count);
					}
					items+=pId+"#"+pCount+",";
					product = (JSONObject)products.get(pId);
					product.put("count", pCount);
					product.put("totalPrice", Math.round(Float.parseFloat(product.get("price")+"")*pCount*100.0)/100.0);
					cart.put(product);
				}
			}
			if(!isPresentInCart) {
				if(products.has(productId)) {
					product = (JSONObject)products.get(productId);
					product.put("count", count);
					product.put("totalPrice", Math.round(Float.parseFloat(product.get("price")+"")*Integer.parseInt(count)*100.0)/100.0);
					cart.put(product);
					items = items.equals("") ? productId+"#"+count : items+","+productId+"#"+count;
				}
			}
			if(items.endsWith(",")) {
				items = items.substring(0, items.length()-1);
			}
			CryptoUtil cUtil = new CryptoUtil(PropertyUtil.getValue("encryptionKey"));
			Cookie cookie = new Cookie("cart", cUtil.encrypt(items));
			cookie.setMaxAge(3600 * 24 * 365 * 1);	//Expires in one year
			response.addCookie(cookie);
			request.setAttribute("cart", cart);
			return "success";
		}catch(Exception e) {
			return "error";
		}
	}
	
	public String removeFromCart() {
		execute();
		String action = "success";
		try {
			String productId = request.getParameter("id");
			String isCartPage = request.getParameter("isCartPage");
			if(isCartPage!=null && isCartPage.equals("true")) {
				action = "showCartPage";
			}
			String items = getCartItemsFromCookie();
			items = items.replaceAll("("+productId+"+#\\w+,?)", "");
			
			CryptoUtil cUtil = new CryptoUtil(PropertyUtil.getValue("encryptionKey"));
			Cookie cookie = new Cookie("cart", cUtil.encrypt(items));
			cookie.setMaxAge(3600 * 24 * 365 * 1);	//Expires in one year
			response.addCookie(cookie);
			
			
			JSONArray cart = new JSONArray();
			String chosenItems[] = items.split(",");
			String pId = null;
			int pCount;
			JSONObject product = null;
			for(String item : chosenItems) {
				pId = item.split("#")[0];
				if(products.has(pId)) {
					pCount = Integer.parseInt(item.split("#")[1]);
					product = (JSONObject)products.get(pId);
					product.put("count", pCount);
					product.put("totalPrice", Math.round(Float.parseFloat(product.get("price")+"")*pCount*100.0)/100.0);
					cart.put(products.get(pId));
				}
			}

			request.setAttribute("cart", cart);
		}catch(Exception e) {
			action = "error";
		}
		return action;
	}
	
	public String getCartItemsFromCookie() {
		Cookie[] cookies = request.getCookies();
		 CryptoUtil cUtil = new CryptoUtil(PropertyUtil.getValue("encryptionKey"));
		 if(cookies!=null) {
			 for(Cookie cookie : cookies) {
				 if(cookie.getName().equals("cart")) {
					 return cUtil.decrypt(cookie.getValue());
				 }
			 }
		 }
		 return "";
	}
	
	public boolean hasAgreedToCookiePolicy() {
		Cookie[] cookies = request.getCookies();
		 CryptoUtil cUtil = new CryptoUtil(PropertyUtil.getValue("encryptionKey"));
		 if(cookies!=null) {
			 for(Cookie cookie : cookies) {
				 if(cookie.getName().equals("hasAgreed")) {
					 return Boolean.valueOf(cUtil.decrypt(cookie.getValue()));
				 }
			 }
		 }
		 return false;
	}
	
	public boolean isFirstVisit() {
		Cookie[] cookies = request.getCookies();
		 if(cookies!=null) {
			 for(Cookie cookie : cookies) {
				 if(cookie.getName().equals("isFirstVisit")) {
					 return Boolean.valueOf(cookie.getValue());
				 }
			 }
		 }
		 return true;
	}
	
	public String cart() {
		execute();
		try {
			String items = getCartItemsFromCookie();
			JSONArray cart = new JSONArray();
			String chosenItems[] = items.split(",");
			String pId = null;
			int pCount;
			JSONObject product = null;
			for(String item : chosenItems) {
				pId = item.split("#")[0];
				if(products.has(pId)) {
					pCount = Integer.parseInt(item.split("#")[1]);
					product = (JSONObject)products.get(pId);
					product.put("count", pCount);
					product.put("totalPrice", Math.round(Float.parseFloat(product.get("price")+"")*pCount*100.0)/100.0);
					cart.put(products.get(pId));
				}
			}
			request.setAttribute("cart", cart);
			return "success";
		}catch(Exception e) {
			return "error";
		}
	}
	
	public void proceedToEnquire() {
		execute();
		String action = MailUtil.sendMail();
		PrintWriter pw = null;
		if(action.equals("success")) {
			//Clearing cart
			Cookie cookie = new Cookie("cart", "");
			cookie.setMaxAge(3600 * 24 * 365 * 1);	//Expires in one year
			response.addCookie(cookie);
		}
		try {
			pw = response.getWriter();
			pw.print(action);
		}catch(Exception e) {
			if(pw!=null) {
				pw.print("error");
			}
		}finally {
			if(pw!=null) {
				pw.close();
			}
		}
	}
	
	public String shop() {
		execute();
		JSONArray allProducts = new JSONArray();
		try {
			String criteria = "select * from products {0} {1} {2}";
			
			String totalProductsCrit = "select count(*) from products {0}";
			
			String critFromReq = request.getParameter("crit");
			
			String[] filters = critFromReq!=null ? critFromReq.split("#") : new String[]{};
			
			String limit = "12";
			
			if(filters.length<8) {
				criteria = "select * from products limit 12";
				totalProductsCrit = "select count(*) from products";
			}else {
				String category = filters[0];
				String type = filters[1];
				String orientation = filters[2];
				String price = filters[3];
				String color = filters[4];
				String orderBy = filters[5];
				limit = filters[6];
				String page = filters[7];
				String range = "";
				String query = "";
				
				//Category validation
				switch(category) {
					case "hinduInvitation":
					case "muslimInvitation":
					case "christianInvitation":
					case "engagement":
					case "reception":
					case "babyShower":
					case "earPiercing":
					case "housewarming":
					case "inauguration":
					case "thankyouCards":
					case "thamboolamBags":
					case "friendsInvitation":
						break;
					default:
						category = null;
				}
				
				if(category!=null) {
					query = "where subcategory='"+category+"'";
				}else {
					query = "where subcategory!='null'";
				}
				
				//Criteria validation
				switch(price) {
					case "1":
					case "2":
					case "3":
					case "4":
						break;
					default:
						price = null;
				}
				
				if(price!=null) {
					if(query.contains("where")) {
						query = "where "+DefaultValues.priceMap.get(price);
					}else {
						query = "and "+DefaultValues.priceMap.get(price);
					}
				}
				
				//Type validation
				switch(type) {
					case "single":
					case "scroll":
					case "book":
					case "laser":
					case "hand":
						break;
					default:
						type = null;
				}
				
				if(type!=null) {
					if(query.contains("where")) {
						query +=" and type='"+type+"'";
					}else {
						query +=" where type='"+type+"'";
					}
				}
				
				//Orientation validation
				switch(orientation) {
					case "vertical":
					case "horizontal":
					case "square":
						break;
					default:
						orientation = null;
				}
				
				if(orientation!=null) {
					if(query.contains("where")) {
						query +=" and orientation='"+orientation+"'";
					}else {
						query +=" where orientation='"+orientation+"'";
					}
				}
				
				//Color validation
				switch(color) {
					case "black":
					case "white":
					case "red":
					case "blue":
					case "pink":
					case "yellow":
						break;
					default:
						color = null;
				}
				
				if(color!=null) {
					if(query.contains("where")) {
						query +=" and color='"+color+"'";
					}else {
						query +=" where color='"+color+"'";
					}
				}
				
				//Order By validation
				switch(orderBy) {
					case "name":
					case "price":
						break;
					default:
						orderBy = "name";
				}
				
				//Limit validation
				switch(limit) {
					case "12":
					case "24":
					case "36":
						break;
					default:
						limit = "12";
				}
				
				//Page validation
			    try {
			    	page = (Integer.parseInt(page)-1)+"";
			    	if(Integer.valueOf(page)<1) {
						page = "0";
					}
			    } catch (Exception e) {
			    	page = "0";
			    }
			    
				range = (Integer.parseInt(limit) * Integer.parseInt(page)) + ","+ limit;
				criteria = criteria.replace("{0}", query);
				criteria = criteria.replace("{1}", "order by "+orderBy);
				criteria = criteria.replace("{2}", "limit "+range);
				
				totalProductsCrit = totalProductsCrit.replace("{0}", query);
			}
			allProducts = SQLUtil.getProductsWithCriteria(criteria);
			
			//Total pages
			request.setAttribute("totProducts", SQLUtil.getRowsCount(totalProductsCrit));
			cart();
		}catch(Exception e) {
			
		}
		 
		request.setAttribute("products", allProducts);
		return "success";
	}
	
	public String mailTemplate() {
		execute();
		try {
			cart();
		}catch(Exception e) {
			
		}
		return "success";
	}
	
	public static JSONArray limitShowCaseItems(String arrayObj) {
		JSONArray showCaseLimiter = new JSONArray();
		try {
			showCaseLimiter = new JSONArray(arrayObj);
			int showCaseLimiterLength = showCaseLimiter.length();
			if(showCaseLimiterLength>10) {
				JSONArray obj = new JSONArray();
				for(int i=0;i<10;i++) {
					obj.put(showCaseLimiter.get(i));
				}
				showCaseLimiter = obj;
			}
		}catch(Exception e) {
			return new JSONArray();
		}
		return showCaseLimiter;
	}
	
	public String productDescription() {
		execute();
		try {
			cart();
			JSONObject prodObj = (JSONObject)products.get(request.getParameter("prodId")+"");
			request.setAttribute("id", request.getParameter("prodId"));
			request.setAttribute("name", prodObj.get("name"));
			request.setAttribute("price", prodObj.get("price"));
			request.setAttribute("path", prodObj.get("path"));
			JSONArray images = prodObj.has("images") ? (JSONArray)prodObj.get("images") : new JSONArray();
			if(images.length()==0) {
				images.put(prodObj.get("path"));
			}
			request.setAttribute("images", images);
		}catch(Exception e) {
			
		}
		return "success";
	}
 }

