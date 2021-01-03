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
		<th>Additional_Images</th>
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
					<span class="default limitText"><img src='<%=obj.get("path")%>' style="width:38%;"></img></span>
					<span class="edit <%=obj.get("id")%>"><input type="text" selectorVal="path" value='<%=obj.get("path")%>'></span>
				</td>
				<td>
					<span class="default limitText"><%=obj.get("name")%></span>
					<span class="edit <%=obj.get("id")%>"><input type="text" selectorVal="name" value='<%=obj.get("name")%>'></span>
				</td>
				<td>
					<span class="default"><%=obj.get("price")%></span>
					<span class="edit <%=obj.get("id")%>"><input type="text" selectorVal="price" value='<%=obj.get("price")%>'></span>
				</td>
				<td>
					<span class="default"><%=obj.get("type")%></span>
					<span class="edit <%=obj.get("id")%>">
					
					<select name="type" selectorVal="type">
					  <option value="single" <%=obj.get("type").equals("single") ? "selected" : ""%>>single</option>
					  <option value="scroll" <%=obj.get("type").equals("scroll") ? "selected" : ""%>>scroll</option>
					  <option value="book" <%=obj.get("type").equals("book") ? "selected" : ""%>>book</option>
					  <option value="laser" <%=obj.get("type").equals("laser") ? "selected" : ""%>>laser</option>
					  <option value="hand" <%=obj.get("type").equals("hand") ? "selected" : ""%>>hand</option>
					</select>
					
					</span>
				</td>
				<td>
					<span class="default"><%=obj.get("orientation")%></span>
					<span class="edit <%=obj.get("id")%>">
					
					<select name="orientation" selectorVal="orientation">
					  <option value="vertical" <%=obj.get("orientation").equals("vertical") ? "selected" : ""%>>vertical</option>
					  <option value="horizontal" <%=obj.get("orientation").equals("horizontal") ? "selected" : ""%>>horizontal</option>
					  <option value="square" <%=obj.get("orientation").equals("square") ? "selected" : ""%>>square</option>
					</select>
					
					</span>
				</td>
				<td>
					<span class="default"><%=obj.get("color")%></span>
					<span class="edit <%=obj.get("id")%>">
					
					<select name="color" selectorVal="color">
					  <option value="black" <%=obj.get("color").equals("black") ? "selected" : ""%>>black</option>
					  <option value="white" <%=obj.get("color").equals("white") ? "selected" : ""%>>white</option>
					  <option value="red" <%=obj.get("color").equals("red") ? "selected" : ""%>>red</option>
					  <option value="blue" <%=obj.get("color").equals("blue") ? "selected" : ""%>>blue</option>
					  <option value="pink" <%=obj.get("color").equals("pink") ? "selected" : ""%>>pink</option>
					  <option value="yellow" <%=obj.get("color").equals("yellow") ? "selected" : ""%>>yellow</option>
					</select>
					
					</span>
				</td>
				<td>
					<span class="default limitText"><%=obj.get("description")%></span>
					<span class="edit <%=obj.get("id")%>"><input type="text" selectorVal="description" value='<%=obj.get("description")%>'></span>
				</td>
				<td>
					<span class="default limitText"><%=obj.get("images")%></span>
					<span class="edit <%=obj.get("id")%>"><input type="text" selectorVal="images" value='<%=obj.get("images")%>'></span>
				</td>
				<td>
					<%if(Integer.valueOf(obj.get("isShowCaseItem")+"")==1) {%>
						<span class="default">true</span>
					<%}else{ %>
						<span class="default">false</span>
					<%} %>
					<span class="edit <%=obj.get("id")%>">
					
					<select name="isShowCaseItem" selectorVal="isShowCaseItem">
					  <option value="true" <%=obj.get("isShowCaseItem").equals("1") ? "selected" : ""%>>true</option>
					  <option value="false" <%=obj.get("isShowCaseItem").equals("0") ? "selected" : ""%>>false</option>
					</select>
					
					</span>
				</td>
			</tr>
		<%}%>
	<%}else{%>
	<%}%>
</table>