<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%
	JSONArray productsArray = new JSONArray(request.getAttribute("products")+"");
%>
<table style="width: 100%;text-align: center;" id="productsTable">
	<tr>
		<th colspan="2"><button style="padding:5px 18px;" onclick="addRow();"><i class="fa fa-plus"></i></button></th>
		<th>Id</th>
		<th>Path</th>
		<th>Name</th>
		<th>Price</th>
		<th>Type</th>
		<th>Orientation</th>
		<th>Colour</th>
		<th>Description</th>
		<th>Additional Images</th>
		<th>Is_ShowCase_Item</th>
	</tr>
	<%if(productsArray.length()>0){%>
		<%for(int i=0;i<productsArray.length();i++){JSONObject obj = productsArray.getJSONObject(i);%>
			<tr>
				<td>
					<span class="default"><i onclick="deleteItem('<%=obj.get("id")%>', this);" class="fa fa-trash"></i></span>
					<span class="edit"> <i onclick="saveChange(this);" class="fa fa-check"></i></span>
				</td>
				<td>
					<span class="default"><i onclick="editItem('<%=obj.get("id")%>', this);" class="fa fa-pencil-square-o"></i></span>
					<span class="edit"> <i onclick="cancelEdit('<%=obj.get("id")%>', this);" class="fa fa-times"></i></span>
				</td>
				<td>
					<span><%=obj.get("id")%></span>
					<span class="edit <%=obj.get("id")%>"><input type="text" selectorVal="id" value='<%=obj.get("id")%>' disabled></span>
				</td>
				<td width="15%">
					<span class="default"><img src='<%=obj.get("path")%>' style="width:38%;"></img></span>
					<span class="edit <%=obj.get("id")%>"><input type="text" selectorVal="path" value='<%=obj.get("path")%>'></span>
				</td>
				<td>
					<span class="default"><%=obj.get("name")%></span>
					<span class="edit <%=obj.get("id")%>"><input type="text" selectorVal="name" value='<%=obj.get("name")%>'></span>
				</td>
				<td>
					<span class="default"><%=obj.get("price")%></span>
					<span class="edit <%=obj.get("id")%>"><input type="text" selectorVal="price" value='<%=obj.get("price")%>'></span>
				</td>
				<td>
					<span class="default"><%=obj.get("type")%></span>
					<span class="edit <%=obj.get("id")%>"><input type="text" selectorVal="type" value='<%=obj.get("type")%>'></span>
				</td>
				<td>
					<span class="default"><%=obj.get("orientation")%></span>
					<span class="edit <%=obj.get("id")%>"><input type="text" selectorVal="orientation" value='<%=obj.get("orientation")%>'></span>
				</td>
				<td>
					<span class="default"><%=obj.get("color")%></span>
					<span class="edit <%=obj.get("id")%>"><input type="text" selectorVal="color" value='<%=obj.get("color")%>'></span>
				</td>
				<td>
					<span class="default"><%=obj.get("description")%></span>
					<span class="edit <%=obj.get("id")%>"><input type="text" selectorVal="description" value='<%=obj.get("description")%>'></span>
				</td>
				<td>
					<span class="default"><%=obj.get("images")%></span>
					<span class="edit <%=obj.get("id")%>"><input type="text" selectorVal="images" value='<%=obj.get("images")%>'></span>
				</td>
				<td>
					<span class="default"><%=obj.get("isShowCaseItem")%></span>
					<span class="edit <%=obj.get("id")%>"><input type="text" selectorVal="images" value='<%=obj.get("isShowCaseItem")%>'></span>
				</td>
			</tr>
		<%}%>
	<%}else{%>
	<%}%>
</table>