//$Id$
package org.sana.util;

import java.net.URL;
import java.util.Properties;
import java.util.UUID;

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
	
	public static String sendMail() {
		try {
			HttpServletRequest request = ServletActionContext.getRequest();
			Properties properties = System.getProperties();
			properties.put("mail.smtp.host", "smtp.gmail.com");
			properties.put("mail.smtp.port", "587");
			properties.put("mail.smtp.auth", "true");
			properties.put("mail.smtp.starttls.enable", "true");
			Session session = Session.getDefaultInstance(properties);
			MimeMessage message = new MimeMessage(session);  
			message.setFrom(new InternetAddress(PropertyUtil.getValue("from")));
			
			JSONArray cart = (JSONArray)request.getAttribute("cart");
			float total=0;
			String replaceContent = "<tbody>";
			for(int i=0;i<cart.length();i++){
				JSONObject obj = cart.getJSONObject(i);
				total+=Float.parseFloat(obj.get("totalPrice")+"");
				replaceContent+="<tr><td>"+(i+1)+"</td><td>"+obj.get("id")+"</td><td>"+obj.get("name")+"</td><td>"+obj.get("count")+"</td><td>"+"Rs. "+obj.get("totalPrice")+"</td></tr>";
			}
			replaceContent += "</tbody>";
			
			String serverName = request.getScheme()+"://"+request.getServerName()+(request.getServerPort() != 0 ? ":"+request.getServerPort() : "")+"/template/MailTemplate.html";
			URL url = new URL(serverName);
			String mailTemplate = IOUtils.toString(url.openStream());
			mailTemplate = mailTemplate.replace("#TBODY", replaceContent);
			mailTemplate = mailTemplate.replace("#SUBTOTAL", (Math.round(total*100.0)/100.0)+"");
			mailTemplate = mailTemplate.replace("#GRANDTOTAL", (Math.round(total*100.0)/100.0)+"");
			mailTemplate = mailTemplate.replace("#NAME", request.getParameter("name"));
			mailTemplate = mailTemplate.replace("#EMAIL", request.getParameter("email"));
			mailTemplate = mailTemplate.replace("#MOBILE", request.getParameter("mobile"));
			mailTemplate = mailTemplate.replace("#ORDERID", UUID.randomUUID().toString());
			message.setSubject("Order Summary");
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(request.getParameter("email")));
			message.addRecipient(Message.RecipientType.BCC, new InternetAddress(PropertyUtil.getValue("from")));
			message.setContent(mailTemplate, "text/html; charset=utf-8" );
			Transport.send(message, PropertyUtil.getValue("from"), PropertyUtil.getValue("password"));
			return "success";
		}catch(Exception e) {
			return "error";
		}
	}
}
