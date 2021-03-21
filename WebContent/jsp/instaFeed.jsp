<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%
	JSONArray productsArray = new JSONArray(request.getAttribute("products")+"");
%>
<table style="width: 100%;text-align: center;" id="productsTable">
	<tr>
		<th colspan="2"><button style="padding:5px 18px;" onclick="addInstaFeedRow();"><i class="fa fa-plus"></i></button></th>
		<th>Path</th>
		<th>Post URL</th>
	</tr>
	<%for(int i=0;i<productsArray.length();i++){JSONObject obj = productsArray.getJSONObject(i);%>
		<tr>
			<td>
				<span class="default"><i onclick="deleteItem('<%=obj.get("id")%>', this);" class="fa fa-trash"></i></span>
				<span class="edit <%=obj.get("id")%>"> <i onclick="saveChange(this, '<%=obj.get("id")%>');" class="fa fa-check"></i></span>
			</td>
			<td>
				<span class="default"><i onclick="editItem('<%=obj.get("id")%>', this);" class="fa fa-pencil-square-o"></i></span>
				<span class="edit <%=obj.get("id")%>"> <i onclick="cancelEdit(this);" class="fa fa-times"></i></span>
			</td>
			<td>
				<span class="default limitText"><img src='<%=obj.get("path")%>' style="width:38%;"></img></span>
				<span class="edit <%=obj.get("id")%>"><input type="text" selectorVal="path" value='<%=obj.get("path")%>'></span>
			</td>
			<td>
				<span class="default limitText"><%=obj.get("postURL")%></span>
				<span class="edit <%=obj.get("id")%>"><input type="text" selectorVal="postURL" value='<%=obj.get("postURL")%>'></span>
			</td>
		</tr>
	<%}%>
</table>