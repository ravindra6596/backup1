<%@page import="com.model.C3P0DataSource"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="org.apache.tomcat.util.codec.binary.Base64"%>
<%@page import="java.io.OutputStream"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ include file="header.jsp"%>
<%
Connection con = C3P0DataSource.getInstance().getConnection();
	Statement st =con.createStatement();
	ResultSet rs= null;
	int pid = Integer.parseInt(request.getParameter("id"));
	String sql="select * from product where pid='"+pid+"'";
	rs=st.executeQuery(sql);				
%>
<section class="content-header">
	<h1>Single Product Details</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Single Product</li>
	</ol>	
</section>
<%
String msg =null;
msg = request.getParameter("response");
if(msg!=null && msg.equals("success")){
	%>
	<div class="callout callout-info fadeout">
		<h4>Success!</h4>
		<p>Data Updated Successfully</p>
	</div>
<%}else if(msg!=null && msg.equals("success")){ %>
	<div class="callout callout-danger fadeout">
		<h4>Success!</h4>
		<p>Data Deleted Successfully</p>
	</div>
<%}else if(msg!=null && msg.equals("fail")){ %>
	<div class="callout callout-danger fadeout">
		<h4>Error!</h4>
		<p>Something went Wrong..!!</p>
	</div>
<%} %>

<section class="content">
	<div class="row">
		<div class="col-sm-12">
			<div class="box box-default">
				<div class="box-tools pull-right">
					<a href="javascript:void(0)" onclick="toggle_edit()" class="btn btn-primary pull-right" id="toggle_button" style="display: block;">Edit</a>
					<a href="javascript:void(0)" onclick="toggle_edit()" class="btn btn-primary pull-right" id="toggle_button_2" style="display: none;">Cancel</a>
				</div>
				<div id="box1" class="box-body" style="display: block;">
					<% while(rs.next()){ %>
					<div class="row">
						<div class="col-sm-6">
							<dl class="dl-horizontal">
								<dt>Name</dt>
								<dd><%= rs.getString("pname")%></dd>
								<dt>Type</dt>
								<dd><%= rs.getString("ptype")%></dd>
								<dt>Group</dt>
								<dd><%= rs.getString("pgroup") %></dd>
								<dt>MRP</dt>
								<dd><%= rs.getFloat("mrp") %></dd>
								<dt>PTR</dt>
								<dd><%= rs.getFloat("ptr")  %></dd>
								<dt>PTS</dt>
								<dd><%= rs.getFloat("pts") %></dd>
								<dt>GST</dt>
								<dd><%= rs.getFloat("gst") %></dd>
								<dt>Composition</dt>
								<dd><%= rs.getString("composition")%></dd>
								<dt>Detailing Story</dt>
								<dd><%= rs.getString("detailingstory")%></dd>
								<dt>Packaging</dt>
								<dd><%= rs.getString("packaging")%></dd>
							</dl>
						</div>
						<div class="col-sm-6">
							<label>Existing pic</label>
							<%
							if(rs.getBlob("prod_pic") != null){
								
								Blob blob = rs.getBlob("prod_pic");
						        byte [] bytes = blob.getBytes(1l, (int)blob.length());
						        System.out.println(bytes);
								String binaryAsAString = Base64.encodeBase64String(bytes);
 								%> 
 								
								<img src="data:image/png;base64,<%= binaryAsAString %>" width="100" height="100">
								<%
							}
							%>
							<hr>
							<form method="post" action="<%= rootpath %>productController" enctype="multipart/form-data" style="box-shadow: 2px 2px 2px 2px #CCC; margin: 25px; padding: 10px">
								<div class="form-group">
									<label for="prod_pic">Upload New Product Pic</label>
									<input type="file" name="prod_pic">
									<input type="hidden" name="pid" value="<%= pid %>">
								</div>
								<button type="submit" class="btn btn-primary" name="submit" value="UPLOAD">Upload</button>
							</form>
						</div>
					</div>
					<%} %>
				</div>
				<%
				rs = st.executeQuery("select * from product where pid = '"+pid+"'");
				while(rs.next()){ %>
				<div id="box2" class="box-body" style="display: none;">
					<form action="<%= rootpath %>productController" method="post">
						<input type="hidden" name="pid" value="<%=pid%>">
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label>Name</label>
									<input type="text" class="form-control" autocomplete="off" placeholder="Enter Product Name" name="pname" value="<%=rs.getString("pname") %>">
								</div>
								<div class="row">
									<div class="form-group col-md-6">
										<label for="Status">Type</label>
										<div class="radio">
											<label><input type="radio" name="ptype" value="Syrup" required="required" <%= rs.getString("ptype").equalsIgnoreCase("Syrup") ? "checked" : "" %> />Syrup</label>
											<label><input type="radio" name="ptype" value="Tablet" required="required" <%= rs.getString("ptype").equalsIgnoreCase("Tablet") ? "checked" : "" %> />Tablet</label>
										</div>
									</div>
									<div class="form-group col-md-6">
										<label for="Status">Group</label>
										<div class="radio">
											<label> <input type="radio" name="pgroup" value="Calcium" required="required" <%= rs.getString("pgroup").equalsIgnoreCase("Calcium") ? "checked" : "" %> /> Calcium </label>
											<label> <input type="radio" name="pgroup" value="Protein" required="required" <%= rs.getString("pgroup").equalsIgnoreCase("Protein") ? "checked" : "" %> /> Protein </label>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="form-group col-md-3">
										<label for="contactnumber">MRP</label>
										<input type="number" autocomplete="off" class="form-control" id="contactnumber" placeholder="Enter MRP" name="mrp" value="<%=rs.getInt("mrp") %>">
									</div>
									<div class="form-group col-md-3">
										<label for="contactnumber">PTR</label>
										<input type="number" autocomplete="off"  class="form-control" id="contactnumber" placeholder="Enter PTR" name="ptr" value="<%=rs.getInt("ptr") %>">
									</div>
									<div class="form-group col-md-3">
										<label for="contactnumber">PTS</label>
										<input type="number" autocomplete="off" class="form-control" id="contactnumber" placeholder="Enter PTS" name="pts" value="<%=rs.getInt("pts") %>">
									</div>
									<div class="form-group col-md-3">
										<label for="contactnumber">GST</label>
										<input type="number" autocomplete="off" class="form-control" id="contactnumber" name="gst" placeholder="Enter GST" value="<%=rs.getInt("gst") %>">
									</div>
								</div>
								<div class="form-group">
									<label for="prod_pic">Product Picture</label>
									<input type="file" name="prod_pic">
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Detailing Story</label>
									<textarea class="form-control" rows="2" placeholder="Clinic Address" name="detailingstory"><%=rs.getString("detailingstory") %></textarea>
								</div>
								<div class="form-group">
									<label>Composition</label>
									<textarea class="form-control" rows="2" placeholder="Clinic Address" name="composition"><%= rs.getString("composition") %></textarea>
								</div>
								<div class="form-group">
									<label>Packaging</label>
									<textarea class="form-control" rows="3" autocomplete="off" 
										placeholder="Packaging Details" name="packaging"><%=rs.getString("packaging") %></textarea>
								</div>
							</div>
						</div>
						<div class="box-footer">
							<button type="submit" class="btn btn-primary" name="submit" value="DELETE">Delete</button>
							<button type="submit" class="btn btn-primary pull-right" name="submit" value="UPDATE">Update</button>
						</div>
					</form>
				</div>
				<% } %>
			</div>
		</div>
	</div>
</section>
<%@ include file="footer.jsp"%>