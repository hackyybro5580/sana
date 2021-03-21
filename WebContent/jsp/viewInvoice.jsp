<%@page import="org.json.JSONArray"%>
<%
	JSONArray invoiceArray = new JSONArray(request.getAttribute("invoice")+"");
	for(int i =0;i<invoiceArray.length();i++){
		out.println(invoiceArray.get(i));
	}
%>