//$Id$
package org.sana.util;

import java.net.URL;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.apache.struts2.ServletActionContext;
import org.json.JSONArray;
import org.json.JSONObject;

public class MailUtil {
	private final static Logger LOGGER = Logger.getLogger(MailUtil.class.getName());

	public static String sendMail() {
		try {
			String date =new SimpleDateFormat("dd-MM-yyyy").format(new Date());
			String orderId = UUID.randomUUID().toString();
			if(!persistOrderDataInDB(orderId, date.toString())){
				return "error";
			}
			sendMailTo(true, orderId, date);	//Send mail to CX
			sendMailTo(false, orderId, date);	//Send mail to Partner
			return "success";
		} catch (Exception e) {
			LOGGER.log(Level.SEVERE, "Exception occurred while sending mail!", e);
			return "error";
		}
	}
	
	public static boolean persistOrderDataInDB(String orderId,String date) throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		String criteria = "insert into orders values('"+orderId+"','"+request.getParameter("name")+"','"+request.getParameter("email")+"','"+request.getParameter("mobile")+"','"+date+"','"+request.getAttribute("cart")+"');";
		return SQLUtil.executeCriteria(criteria);
	}
	
	public static String sendMailTo(boolean isCXMail, String orderId, String date) throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		Properties properties = System.getProperties();
		properties.put("mail.smtp.host", "smtp.gmail.com");
		properties.put("mail.smtp.port", "587");
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");
		
		String to = isCXMail ? request.getParameter("email") : PropertyUtil.getValue("to");
		Session session = Session.getDefaultInstance(properties);
		MimeMessage message = new MimeMessage(session);
		message.setFrom(new InternetAddress(PropertyUtil.getValue("from")));

		JSONArray cart = (JSONArray) request.getAttribute("cart");
		float total = 0;
		String replaceContent = "<tbody>";
		for (int i = 0; i < cart.length(); i++) {
			JSONObject obj = cart.getJSONObject(i);
			total += Float.parseFloat(obj.get("totalPrice") + "");
			replaceContent += "<tr><td>" + (i + 1) + "</td><td>" + obj.get("id") + "</td><td>" + obj.get("name") + "</td><td>" + obj.get("count") + "</td><td>" + "Rs. " + obj.get("totalPrice") + "</td></tr>";
		}
		replaceContent += "</tbody>";

		String serverName = request.getScheme() + "://" + request.getServerName() + (request.getServerPort() != 0 ? ":" + request.getServerPort() : "") + "/template/MailTemplate.html";
		URL url = new URL(serverName);
		String mailTemplate = IOUtils.toString(url.openStream());
		mailTemplate = mailTemplate.replace("#TBODY", replaceContent);
		mailTemplate = mailTemplate.replace("#SUBTOTAL", (Math.round(total * 100.0) / 100.0) + "");
		mailTemplate = mailTemplate.replace("#GRANDTOTAL", (Math.round(total * 100.0) / 100.0) + "");
		mailTemplate = mailTemplate.replace("#NAME", request.getParameter("name"));
		mailTemplate = mailTemplate.replace("#EMAIL", request.getParameter("email"));
		mailTemplate = mailTemplate.replace("#MOBILE", request.getParameter("mobile"));
		mailTemplate = mailTemplate.replace("#ORDERID", orderId);
		mailTemplate = mailTemplate.replace("#DATEOFPURCHASE", date);
		message.setSubject("Order Summary");
		message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
		message.addRecipient(Message.RecipientType.BCC, new InternetAddress(PropertyUtil.getValue("from")));
		message.setContent(mailTemplate, "text/html; charset=utf-8");
		Transport.send(message, PropertyUtil.getValue("from"), PropertyUtil.getValue("password"));
		return orderId;
	}
}
