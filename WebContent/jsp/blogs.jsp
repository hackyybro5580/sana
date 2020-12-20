<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%
	JSONArray productsArray = new JSONArray(request.getAttribute("products")+"");
%>
<table style="width: 100%;text-align: center;" id="productsTable">
	<tr>
		<th colspan="2"><button style="padding:5px 18px;" onclick="addBlogRow();"><i class="fa fa-plus"></i></button></th>
		<th>Date</th>
		<th>Like URL</th>
		<th>Path</th>
		<th>Post URL</th>
		<th>Title 1</th>
		<th>Title 2</th>
		<th>Title 3</th>
	</tr>
	<%if(productsArray.length()>0){%>
		<%for(int i=0;i<productsArray.length();i++){JSONObject obj = productsArray.getJSONObject(i);%>
			<tr>
				<td>
					<span class="default"><i onclick="deleteItem(this);" class="fa fa-trash"></i></span>
					<span class="edit"> <i onclick="saveChange(this);" class="fa fa-check"></i></span>
				</td>
				<td>
					<span class="default"><i onclick="editItem(this);" class="fa fa-pencil-square-o"></i></span>
					<span class="edit"> <i onclick="cancelEdit(this);" class="fa fa-times"></i></span>
				</td>
				<td>
					<span class="default"><%=obj.get("date")%></span>
					<span class="edit"><input type="text" selectorVal="path" value='<%=obj.get("date")%>'></span>
				</td>
				<td>
					<span class="default"><%=obj.get("likeURL")%></span>
					<span class="edit"><input type="text" selectorVal="title1" value='<%=obj.get("likeURL")%>'></span>
				</td>
				<td>
					<span class="default"><%=obj.get("path")%></span>
					<span class="edit"><input type="text" selectorVal="title2" value='<%=obj.get("path")%>'></span>
				</td>
				<td>
					<span class="default"><%=obj.get("postURL")%></span>
					<span class="edit"><input type="text" selectorVal="title2" value='<%=obj.get("postURL")%>'></span>
				</td>
				<td>
					<span class="default"><%=obj.get("title1")%></span>
					<span class="edit"><input type="text" selectorVal="title2" value='<%=obj.get("title1")%>'></span>
				</td>
				<td>
					<span class="default"><%=obj.get("title2")%></span>
					<span class="edit"><input type="text" selectorVal="title2" value='<%=obj.get("title2")%>'></span>
				</td>
				<td>
					<span class="default"><%=obj.get("title3")%></span>
					<span class="edit"><input type="text" selectorVal="title2" value='<%=obj.get("title3")%>'></span>
				</td>
			</tr>
		<%}%>
	<%}else{%>
		<tr>
			<td colspan="12" style="padding: 10%;">No items in this category!</td>
		</tr>
	<%}%>
</table>