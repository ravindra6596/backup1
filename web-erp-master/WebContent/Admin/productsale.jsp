<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.Employee.Objects.GetData"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.model.C3P0DataSource"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp"%>
<%
    JSONObject ProductSale =(JSONObject) session.getAttribute("ProductSale");
	ResultSet empname = GetData.Admin_Emp();
%>
<section class="content-header">
	<h1>Doctor-wise Sale</h1>
	
</section>

<!-- Main content -->
<section class="content">
	<div class="row">
		<div class="col-xs-12">

			<div class="box">
				<div class="box-header"></div>
				<!-- /.box-header -->
				<div class="box-body">
					<form action="<%= rootpath %>PersonalSale" method="post">
					<input type="hidden" name="rootpath" value="<%= pathInfo %>">
						<div class="row">
							<div class="col-md-3">
								<div class="form-group">
									<label>Select TM:</label> <select class="form-control select2"
										name="eid" data-placeholder="Select TM"
										style="width: 100%;">
										<option selected="selected" disabled="disabled">Select
											TM</option>
										<%
											while (empname.next()) {
										%>
											<option value="<%=empname.getInt("eid")%>"><%=empname.getString("name")%></option>
										<%
											}
										//	ResultSet campains = GetData.Campaigns();
										%>
									</select>
								</div>
							</div>
							<div class="col-md-3">
								<div class="form-group">
					                <label>Date range:</label>
					
					                <div class="input-group">
					                  <div class="input-group-addon">
					                    <i class="fa fa-calendar"></i>
					                  </div>
					                  <input type="text" class="form-control pull-right monthpicker" name="daterange" id="productSale_reservation">
					                </div>
					                <!-- /.input group -->
					              </div>
							</div>
<!-- 							<div class="col-md-3"> -->
<!-- 								<div class="form-group"> -->
<!-- 									<label>Select Campaign:</label> <select class="form-control select2" -->
<!-- 										name="campaign" data-placeholder="Select Campaign" -->
<!-- 										style="width: 100%;"> -->
<!-- 										<option selected="selected" disabled="disabled">Select -->
<!-- 											Campaign</option> -->
<%-- 										<% --%>
<!-- 											while (campains.next()) { -->
<%-- 										%> --%>
<%-- 											<option value="<%=campains.getString("cname")%>"><%=campains.getString("cname")%></option> --%>
<%-- 										<% --%>
<!--  											} -->
<%-- 										%> --%>
<!-- 									</select> -->
<!-- 								</div> -->
<!-- 							</div> -->
							<div class="col-md-2">
								<div class="form-group">

									<button type="submit" class="btn btn-primary " name="submit"
										value="search" style="margin-top: 25px;">Search</button>
								</div>
							</div>
						</div>
					</form>
					
					<%
						if(ProductSale != null){
							JSONArray plist = (JSONArray) ProductSale.get("products");
							JSONArray dlist	= (JSONArray) ProductSale.get("doctors");
							int [][] list = (int[][]) ProductSale.get("quantity");
					%>
					<div class="row">
						<div class="col-md-12">
						<div class="container-fluid">
						
						
							<table class="table table-bordered" style="width:100%; overflow-x:scroll; display: block;">
								<tr>
									<th style="background-color: #3c8dbc; color: white; ">Doctors/ Products</th>
									<% for(int j=0;j<plist.length();j++) {%>
							 		<th>
					            		<%= plist.get(j) %>
					            	</th>
					            	<%} %>
								</tr>
								<%for( int i=0;i<dlist.length();i++) { %>
									<tr>
										<th style="background-color: #3c8dbc; color: white; "><%= dlist.get(i) %></th>
										 <%  for(int j=0;j<plist.length();j++) {%>
							              	<td><%= list[i][j] %></td>
							              	<% } %>
									</tr>
								<% } %>
							</table>
							</div>
						</div>
					</div>
					<% } %>
				</div>
			</div>
		</div>
	</div>
</section>

<%@ include file="footer.jsp"%>