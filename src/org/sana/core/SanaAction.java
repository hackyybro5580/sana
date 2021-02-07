package org.sana.core;

import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;

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

public class SanaAction {

	private final static Logger LOGGER = Logger.getLogger(MailUtil.class.getName());
	public static JSONObject requestObj;
	public static JSONObject products;
	HttpServletRequest request;
	HttpServletResponse response;

	public String execute() {
		String result = "success";
		try {
			request = ServletActionContext.getRequest();
			response = ServletActionContext.getResponse();

			if (requestObj == null) {
				requestObj = new JSONObject();
				requestObj.put("sliderContent", fetchShowCaseItems("sliderContent", 4));
				requestObj.put("blogs", fetchShowCaseItems("blogs", 2));
				requestObj.put("instaFeed", limitShowCaseItems(PropertyUtil.getValue("instaFeed")));
				requestObj.put("showCaseHindu", fetchShowCaseItems("hinduInvitation", 6));
				requestObj.put("showCaseMuslim", fetchShowCaseItems("muslimInvitation", 6));
				requestObj.put("showCaseChristian", fetchShowCaseItems("christianInvitation", 6));
			}
			if (products == null) {
				products = new JSONObject();
				JSONArray item = SQLUtil.getProductsWithCriteria("select * from products", null);
				for (int i = 0; i < item.length(); i++) {
					JSONObject itemObj = item.getJSONObject(i);
					if (itemObj.has("id")) {
						products.put(itemObj.get("id") + "", itemObj);
					}
				}
			}

			if (requestObj != null) {
				request.setAttribute("requestObj", requestObj);
			}

			if (products != null) {
				// Loading Cart Values
				JSONArray cart = new JSONArray();
				String items = getCartItemsFromCookie();
				String chosenItems[] = items.split(",");
				String pId = null;
				int pCount;
				JSONObject product = null;
				for (String item : chosenItems) {
					pId = item.split("#")[0];
					if (products.has(pId)) {
						pCount = Integer.parseInt(item.split("#")[1]);
						product = (JSONObject) products.get(pId);
						product.put("count", pCount);
						product.put("totalPrice", Math.round(Float.parseFloat(product.get("price") + "") * pCount * 100.0) / 100.0);
						cart.put(products.get(pId));
					}
				}
				if (cart.length() > 0) {
					request.setAttribute("cart", cart);
				}
			}

			// if(hasAgreedToCookiePolicy()) {
			// Cookie cookie = new Cookie("hasAgreed", "");
			// cookie.setMaxAge(3600 * 24 * 365 * 1); //Expires in one year
			// response.addCookie(cookie);
			// request.setAttribute("cart", cart);
			// }
			boolean isFirstVisit = isFirstVisit();
			if (isFirstVisit) {
				Cookie cookie = new Cookie("isFirstVisit", "false");
				response.addCookie(cookie);
			}
			request.setAttribute("isFirstVisit", isFirstVisit);

		} catch (Exception e) {
			LOGGER.log(Level.SEVERE, "Exception in execute method!", e);
			result = "error";
		}
		result = isMobile() ? "mob_" + result : result;
		return result;
	}

	public String addToCart() {
		execute();
		String result = "success";
		try {
			String productId = request.getParameter("id");
			String count = request.getParameter("count");
			String operation = request.getParameter("operation");
			Boolean isPresentInCart = Boolean.FALSE;

			if (productId == null) {
				return "error";
			}
			if (count == null) {
				count = "1";
			} else if (Integer.parseInt(count) < 0) {
				count = "1";
			}

			JSONArray cart = new JSONArray();
			JSONObject product = null;
			String items = getCartItemsFromCookie();
			String chosenItems[] = items.split(",");
			String pId = null;
			int pCount;
			items = "";
			for (String item : chosenItems) {
				pId = item.split("#")[0];
				if (products.has(pId)) {
					pCount = Integer.parseInt(item.split("#")[1]);
					if (pId.equals(productId)) {
						isPresentInCart = Boolean.TRUE;
						if (operation != null && operation.equals("update")) {
							pCount = 0;
						}
						pCount += Integer.parseInt(count);
					}
					items += pId + "#" + pCount + ",";
					product = (JSONObject) products.get(pId);
					product.put("count", pCount);
					product.put("totalPrice", Math.round(Float.parseFloat(product.get("price") + "") * pCount * 100.0) / 100.0);
					cart.put(product);
				}
			}
			if (!isPresentInCart) {
				if (products.has(productId)) {
					product = (JSONObject) products.get(productId);
					product.put("count", count);
					product.put("totalPrice", Math.round(Float.parseFloat(product.get("price") + "") * Integer.parseInt(count) * 100.0) / 100.0);
					cart.put(product);
					items = items.equals("") ? productId + "#" + count : items + "," + productId + "#" + count;
				}
			}
			if (items.endsWith(",")) {
				items = items.substring(0, items.length() - 1);
			}
			CryptoUtil cUtil = new CryptoUtil(PropertyUtil.getValue("encryptionKey"));
			Cookie cookie = new Cookie("cart", cUtil.encrypt(items));
			cookie.setMaxAge(3600 * 24 * 365 * 1); // Expires in one year
			response.addCookie(cookie);
			request.setAttribute("cart", cart);
			result = isMobile() ? "mob_" + result : result;
			return result;
		} catch (Exception e) {
			LOGGER.log(Level.SEVERE, "Exception in addToCart method!", e);
			return "error";
		}
	}

	public String removeFromCart() {
		execute();
		String result = "success";
		try {
			String productId = request.getParameter("id");
			String isCartPage = request.getParameter("isCartPage");
			if (isCartPage != null && isCartPage.equals("true")) {
				result = "showCartPage";
			}
			String items = getCartItemsFromCookie();
			items = items.replaceAll("(" + productId + "+#\\w+,?)", "");

			CryptoUtil cUtil = new CryptoUtil(PropertyUtil.getValue("encryptionKey"));
			Cookie cookie = new Cookie("cart", cUtil.encrypt(items));
			cookie.setMaxAge(3600 * 24 * 365 * 1); // Expires in one year
			response.addCookie(cookie);

			JSONArray cart = new JSONArray();
			String chosenItems[] = items.split(",");
			String pId = null;
			int pCount;
			JSONObject product = null;
			for (String item : chosenItems) {
				pId = item.split("#")[0];
				if (products.has(pId)) {
					pCount = Integer.parseInt(item.split("#")[1]);
					product = (JSONObject) products.get(pId);
					product.put("count", pCount);
					product.put("totalPrice", Math.round(Float.parseFloat(product.get("price") + "") * pCount * 100.0) / 100.0);
					cart.put(products.get(pId));
				}
			}

			request.setAttribute("cart", cart);
		} catch (Exception e) {
			LOGGER.log(Level.SEVERE, "Exception in removeFromCart method!", e);
			result = "error";
		}
		result = isMobile() ? "mob_" + result : result;
		return result;
	}

	public String getCartItemsFromCookie() {
		Cookie[] cookies = request.getCookies();
		CryptoUtil cUtil = new CryptoUtil(PropertyUtil.getValue("encryptionKey"));
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("cart")) {
					return cUtil.decrypt(cookie.getValue());
				}
			}
		}
		return "";
	}

	public boolean isMobile() {
		return request.getHeader("User-Agent").contains("Mobi") ? true : false;
	}

	public boolean hasAgreedToCookiePolicy() {
		Cookie[] cookies = request.getCookies();
		CryptoUtil cUtil = new CryptoUtil(PropertyUtil.getValue("encryptionKey"));
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("hasAgreed")) {
					return Boolean.valueOf(cUtil.decrypt(cookie.getValue()));
				}
			}
		}
		return false;
	}

	public boolean isFirstVisit() {
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("isFirstVisit")) {
					return Boolean.valueOf(cookie.getValue());
				}
			}
		}
		return true;
	}

	public String cart() {
		execute();
		String result = "success";
		try {
			String items = getCartItemsFromCookie();
			JSONArray cart = new JSONArray();
			String chosenItems[] = items.split(",");
			String pId = null;
			int pCount;
			JSONObject product = null;
			for (String item : chosenItems) {
				pId = item.split("#")[0];
				if (products.has(pId)) {
					pCount = Integer.parseInt(item.split("#")[1]);
					product = (JSONObject) products.get(pId);
					product.put("count", pCount);
					product.put("totalPrice", Math.round(Float.parseFloat(product.get("price") + "") * pCount * 100.0) / 100.0);
					cart.put(products.get(pId));
				}
			}
			request.setAttribute("cart", cart);
			result = isMobile() ? "mob_" + result : result;
			return result;
		} catch (Exception e) {
			LOGGER.log(Level.SEVERE, "Exception in cart method!", e);
			return "error";
		}
	}

	public void proceedToEnquire() {
		execute();
		String action = MailUtil.sendMail();
		PrintWriter pw = null;
		if (action.equals("success")) {
			// Clearing cart
			Cookie cookie = new Cookie("cart", "");
			cookie.setMaxAge(3600 * 24 * 365 * 1); // Expires in one year
			response.addCookie(cookie);
		}
		try {
			pw = response.getWriter();
			pw.print(action);
		} catch (Exception e) {
			if (pw != null) {
				LOGGER.log(Level.SEVERE, "Exception in proceedToEnquire method!", e);
				pw.print("error");
			}
		} finally {
			if (pw != null) {
				pw.close();
			}
		}
	}

	public String shop() {
		execute();
		JSONArray allProducts = new JSONArray();
		String result = "success";
		try {
			String criteria = "select * from products {0} {1} {2}";

			String totalProductsCrit = "select count(*) from products {0}";

			String critFromReq = request.getParameter("crit");

			String[] filters = critFromReq != null ? critFromReq.split("#") : new String[] {};

			String limit = "12";

			if (filters.length < 8) {
				criteria = "select * from products limit 12";
				totalProductsCrit = "select count(*) from products";
			} else {
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

				// Category validation
				switch (category) {
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

				if (category != null) {
					query = "where subcategory='" + category + "'";
				} else {
					query = "where subcategory!='null'";
				}

				// Criteria validation
				switch (price) {
				case "1":
				case "2":
				case "3":
				case "4":
					break;
				default:
					price = null;
				}

				if (price != null) {
					if (query.contains("where")) {
						query += "and " + DefaultValues.priceMap.get(price);
					} else {
						query = "where and " + DefaultValues.priceMap.get(price);
					}
				}

				// Type validation
				String typeCrit = "";
				String[] types = type.split("\\$");
				for (int i = 0; i < types.length; i++) {
					boolean isAvailable = true;
					switch (types[i]) {
					case "single":
					case "scroll":
					case "book":
					case "laser":
					case "hand":
						break;
					default:
						isAvailable = false;
					}
					if (isAvailable) {
						if (typeCrit.length() == 0) {
							typeCrit = "'" + types[i] + "'";
						} else {
							typeCrit += ",'" + types[i] + "'";
						}
					}
				}

				if (!typeCrit.equals("")) {
					if (query.contains("where")) {
						query += " and type in (" + typeCrit + ")";
					} else {
						query = " where type in (" + typeCrit + ")";
					}
				}

				// Orientation validation
				switch (orientation) {
				case "vertical":
				case "horizontal":
				case "square":
					break;
				default:
					orientation = null;
				}

				if (orientation != null) {
					if (query.contains("where")) {
						query += " and orientation='" + orientation + "'";
					} else {
						query = " where orientation='" + orientation + "'";
					}
				}

				// Color validation
				String colorCrit = "";
				String[] colors = color.split("\\$");
				for (int i = 0; i < colors.length; i++) {
					boolean isAvailable = true;
					switch (colors[i]) {
					case "black":
					case "white":
					case "red":
					case "blue":
					case "pink":
					case "yellow":
						break;
					default:
						isAvailable = false;
					}
					if (isAvailable) {
						if (colorCrit.length() == 0) {
							colorCrit = "'" + colors[i] + "'";
						} else {
							colorCrit += ",'" + colors[i] + "'";
						}
					}
				}
				if (!colorCrit.equals("")) {
					if (query.contains("where")) {
						query += " and color in (" + colorCrit + ")";
					} else {
						query = " where color in (" + colorCrit + ")";
					}
				}

				// Order By validation
				switch (orderBy) {
				case "name":
				case "price":
					break;
				default:
					orderBy = "name";
				}

				// Limit validation
				switch (limit) {
				case "12":
				case "24":
				case "36":
					break;
				default:
					limit = "12";
				}

				// Page validation
				try {
					page = (Integer.parseInt(page) - 1) + "";
					if (Integer.valueOf(page) < 1) {
						page = "0";
					}
				} catch (Exception e) {
					page = "0";
				}

				range = (Integer.parseInt(limit) * Integer.parseInt(page)) + "," + limit;
				criteria = criteria.replace("{0}", query);
				criteria = criteria.replace("{1}", "order by " + orderBy);
				criteria = criteria.replace("{2}", "limit " + range);

				totalProductsCrit = totalProductsCrit.replace("{0}", query);
			}
			allProducts = SQLUtil.getProductsWithCriteria(criteria, null);

			// Total pages
			request.setAttribute("totProducts", SQLUtil.getRowsCount(totalProductsCrit));
			cart();
		} catch (Exception e) {
			LOGGER.log(Level.SEVERE, "Exception in shop method!", e);
		}

		request.setAttribute("products", allProducts);
		result = isMobile() ? "mob_" + result : result;
		return result;
	}

	public String mailTemplate() {
		execute();
		try {
			cart();
		} catch (Exception e) {
			LOGGER.log(Level.SEVERE, "Exception in mailTemplate method!", e);
		}
		return "success";
	}

	public static JSONArray fetchShowCaseItems(String subCategory, int limit) {
		JSONArray showCaseLimiter = new JSONArray();
		try {
			String criteria = "select * from products where IS_SHOW_CASE_ITEM = true and subcategory=\"" + subCategory + "\" limit " + limit;
			String type = null;
			if (subCategory.equals("blogs")) {
				criteria = "select * from blogs limit " + limit;
			} else if (subCategory.equals("sliderContent")) {
				criteria = "select * from sliderContent limit " + limit;
			} else {
				subCategory = null;
			}
			showCaseLimiter = SQLUtil.getProductsWithCriteria(criteria, subCategory);
		} catch (Exception e) {
			LOGGER.log(Level.SEVERE, "Exception in fetchShowCaseItems method!", e);
			return new JSONArray();
		}
		return showCaseLimiter;
	}

	public static JSONArray limitShowCaseItems(String arrayObj) {
		JSONArray showCaseLimiter = new JSONArray();
		try {
			showCaseLimiter = new JSONArray(arrayObj);
			int showCaseLimiterLength = showCaseLimiter.length();
			if (showCaseLimiterLength > 10) {
				JSONArray obj = new JSONArray();
				for (int i = 0; i < 10; i++) {
					obj.put(showCaseLimiter.get(i));
				}
				showCaseLimiter = obj;
			}
		} catch (Exception e) {
			LOGGER.log(Level.SEVERE, "Exception in limitShowCaseItems method!", e);
			return new JSONArray();
		}
		return showCaseLimiter;
	}

	public String productDescription() {
		execute();
		String result = "success";
		try {
			cart();
			JSONObject prodObj = (JSONObject) products.get(request.getParameter("prodId") + "");
			request.setAttribute("id", request.getParameter("prodId"));
			request.setAttribute("name", prodObj.get("name"));
			request.setAttribute("price", prodObj.get("price"));
			request.setAttribute("path", prodObj.get("path"));
			request.setAttribute("description", prodObj.get("description"));
			request.setAttribute("imagesAsCommaSeperated", prodObj.get("images"));
			JSONArray images = new JSONArray();
			if (prodObj.has("images") && !prodObj.get("images").equals("")) {
				String[] imagesFromDB = (prodObj.get("images") + "").split(",");
				for (int i = 0; i < imagesFromDB.length; i++) {
					images.put(imagesFromDB[i]);
				}
				request.setAttribute("path", imagesFromDB[0]);
			}
			if (images.length() == 0) {
				images.put(prodObj.get("path"));
				request.setAttribute("imagesAsCommaSeperated", prodObj.get("path"));
			}
			request.setAttribute("images", images);
		} catch (Exception e) {
			LOGGER.log(Level.SEVERE, "Exception in productDescription method!", e);
			int a = 1;
		}
		result = isMobile() ? "mob_" + result : result;
		return result;
	}

	public Boolean isUserLoggedIn() {
		try {
			request = ServletActionContext.getRequest();
			response = ServletActionContext.getResponse();
			String[] loginSession = getLoginSession().split("#");
			String userName = loginSession.length == 3 ? loginSession[1] : request.getParameter("encrypted1");
			String password = loginSession.length == 3 ? loginSession[2] : request.getParameter("encrypted2");
			if (password != null && userName != null && !password.equals("") && !userName.equals("")) {
				if (SQLUtil.isValidUser(userName, password)) {
					response.setStatus(HttpServletResponse.SC_ACCEPTED);
					if (loginSession.length != 3) {
						setLoginSession(userName, password);
					}
					return true;
				}
			}
		} catch (Exception e) {
			LOGGER.log(Level.SEVERE, "Exception in isUserLoggedIn method!", e);
		}
		return false;
	}

	public void setLoginSession(String userName, String password) {
		CryptoUtil cUtil = new CryptoUtil(PropertyUtil.getValue("encryptionKey"));
		Cookie cookie = new Cookie("loginSession", cUtil.encrypt(request.getRemoteAddr() + "#" + userName + "#" + password));
		response.addCookie(cookie);
	}

	public String getLoginSession() {
		Cookie[] cookies = request.getCookies();
		CryptoUtil cUtil = new CryptoUtil(PropertyUtil.getValue("encryptionKey"));
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("loginSession")) {
					try {
						String returnString = cUtil.decrypt(cookie.getValue());
						if (returnString.split("#")[0].equals(request.getRemoteAddr())) {
							return returnString;
						}
					} catch (Exception e) {

					}
				}
			}
		}
		return "";
	}

	public String CMS() {
		if (!isUserLoggedIn()) {
			return "login";
		}
		try {
			String operation = request.getParameter("type");
			String subCategory = request.getParameter("subCategory");
			if (operation != null) {
				if (subCategory != null && subCategory.equals("sliderContent")) {
					if (operation.equals("update")) {
						JSONObject inputData = new JSONObject(request.getParameter("inputData"));
						String criteria = "update sliderContent set PATH=\"" + inputData.get("path") + "\"," + "TITLE1=\"" + inputData.get("title1") + "\"," + "TITLE2=\"" + inputData.get("title2") + "\"" + " where ID=" + inputData.get("id");
						SQLUtil.executeCriteria(criteria);
					} else if (operation.equals("create")) {
						JSONObject inputData = new JSONObject(request.getParameter("inputData"));
						String criteria = "insert into sliderContent(PATH, TITLE1, TITLE2) values(\"" + inputData.get("path") + "\",\"" + inputData.get("title1") + "\",\"" + inputData.get("title2") + "\")";
						SQLUtil.executeCriteria(criteria);
					} else if (operation.equals("delete")) {
						String criteria = "delete from sliderContent where id=" + request.getParameter("inputData");
						SQLUtil.executeCriteria(criteria);
					}
				} else if (subCategory != null && subCategory.equals("blogs")) {
					if (operation.equals("update")) {
						JSONObject inputData = new JSONObject(request.getParameter("inputData"));
						String criteria = "update blogs set DATE=\"" + inputData.get("date") + "\"," + "LIKE_URL=\"" + inputData.get("likeURL") + "\"," + "PATH=\"" + inputData.get("path") + "\"," + "TITLE1=\"" + inputData.get("title1") + "\"," + "TITLE2=\"" + inputData.get("title2") + "\"," + "TITLE3=\"" + inputData.get("title3") + "\"," + "POST_URL=\"" + inputData.get("postURL") + "\"" + " where ID=" + inputData.get("id");
						SQLUtil.executeCriteria(criteria);
					} else if (operation.equals("create")) {
						JSONObject inputData = new JSONObject(request.getParameter("inputData"));
						String criteria = "insert into blogs(DATE, LIKE_URL, POST_URL, PATH, TITLE1, TITLE2, TITLE3) values(\"" + inputData.get("date") + "\",\"" + inputData.get("likeURL") + "\",\"" + inputData.get("postURL") + "\",\"" + inputData.get("path") + "\",\"" + inputData.get("title1") + "\",\"" + inputData.get("title2") + "\",\"" + inputData.get("title3") + "\")";
						SQLUtil.executeCriteria(criteria);
					} else if (operation.equals("delete")) {
						String criteria = "delete from blogs where id=" + request.getParameter("inputData");
						SQLUtil.executeCriteria(criteria);
					}
				} else {
					if (operation.equals("update")) {
						JSONObject inputData = new JSONObject(request.getParameter("inputData"));
						String criteria = "update products set path=\"" + inputData.get("path") + "\"," + "name=\"" + inputData.get("name") + "\"," + "price=" + inputData.get("price") + "," + "type=\"" + inputData.get("type") + "\"," + "orientation=\"" + inputData.get("orientation") + "\"," + "color=\"" + inputData.get("color") + "\"," + "description=\"" + inputData.get("description") + "\"," + "images=\"" + inputData.get("images") + "\"," + "IS_SHOW_CASE_ITEM=" + inputData.get("isShowCaseItem") + " where id=\"" + inputData.get("id") + "\"";
						SQLUtil.executeCriteria(criteria);
					} else if (operation.equals("create")) {
						JSONObject inputData = new JSONObject(request.getParameter("inputData"));
						String criteria = "insert into products values(\"" + inputData.get("id") + "\",\"" + inputData.get("name") + "\"," + inputData.get("price") + ",\"" + inputData.get("path") + "\",\"" + inputData.get("type") + "\",\"" + inputData.get("subCategory") + "\",\"" + inputData.get("orientation") + "\",\"" + inputData.get("description") + "\",\"" + inputData.get("color") + "\",\"" + inputData.get("images") + "\"," + inputData.get("isShowCaseItem") + ")";
						SQLUtil.executeCriteria(criteria);
					} else if (operation.equals("delete")) {
						String criteria = "delete from products where id=\"" + request.getParameter("inputData") + "\"";
						SQLUtil.executeCriteria(criteria);
					}
				}
			}
		} catch (Exception e) {
			LOGGER.log(Level.SEVERE, "Exception in CMS method!", e);
		}
		return "success";
	}

	public String viewItems() {
		if (!isUserLoggedIn()) {
			return "login";
		}
		try {
			String result = "success";
			String subcategory = request.getParameter("subcategory");
			subcategory = subcategory == null ? "" : subcategory;
			// Category validation
			switch (subcategory) {
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
			case "sliderContent":
			case "blogs":
				break;
			default:
				subcategory = "";
			}
			String criteria = "select * from products where SUBCATEGORY = \"" + subcategory + "\"";
			if (subcategory.equals("sliderContent")) {
				criteria = "select * from sliderContent";
				result = "sliderContent";
			} else if (subcategory.equals("blogs")) {
				criteria = "select * from blogs";
				result = "blogs";
			} else {
				subcategory = null;
			}
			JSONArray products = SQLUtil.getProductsWithCriteria(criteria, subcategory);
			request.setAttribute("products", products);
			return result;
		} catch (Exception e) {
			LOGGER.log(Level.SEVERE, "Exception in viewItems method!", e);
			return "error";
		}
	}

	public void initDB() {
		PrintWriter pw = null;
		try {
			response = ServletActionContext.getResponse();
			pw = response.getWriter();
			if (!isUserLoggedIn()) {
				pw.print("error");
			} else {
				pw.print("DB Initialised");
				if (SQLUtil.initDB()) {
					if (!SQLUtil.loadTable()) {
						SQLUtil.loadTable();
					}
				}
			}
		} catch (Exception e) {
			LOGGER.log(Level.SEVERE, "Exception in initDB method!", e);
			if (pw != null) {
				pw.print("error");
			}
		} finally {
			if (pw != null) {
				pw.close();
			}
		}
	}

	public String aboutUS() {
		execute();
		String result = "success";
		result = isMobile() ? "mob_" + result : result;
		return result;
	}
}