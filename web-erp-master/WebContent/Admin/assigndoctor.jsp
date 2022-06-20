<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp" %>
<%
Connection con = C3P0DataSource.getInstance().getConnection();
	ResultSet rs = null;
	rs = con.createStatement().executeQuery("select eid , name from employee where usertype != 'admin' and usertype != 'TM' ");
%>
<section class="content-header">
	<h1>Assign Doctor</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li><a href="#">Forms</a></li>
		<li class="active">General Elements</li>
	</ol>
</section>

<section class="content">
<%
		String msg =null;
		msg = request.getParameter("response");
		if(msg!=null && msg.equals("success")){
		%>
		<div class="callout callout-info fadeout">
			<h4>Success!</h4>
			<p>Data Inserted Successfully</p>
		</div>
		<% }else if(msg != null && msg.equals("duplicate")){ %>
			<div class="callout callout-warning fadeout">
			<h4>Success!</h4>
			<p>Duplicate record available!!</p>
		</div>
		<% }else if(msg!=null && msg.equals("fail")){ %>
		<div class="callout callout-danger fadeout">
		<h4>Error!</h4>
		<p>Something went Wrong..!!</p>
	</div>
	<%} %>
	<div class="box box-default">
		<div class="box-header with-border">
			<h3 class="box-title"></h3>

			<div class="box-tools pull-right">
				<button type="button" class="btn btn-box-tool"
					data-widget="collapse">
					<i class="fa fa-minus"></i>
				</button>
			</div>
		</div>
		<!-- /.box-header -->
		
		<div class="box-body">
			<div class="row">
			<form method="post" action="<%= rootpath%>AssignDoctor">
				<div class="col-md-4">
					<div class="form-group">
						<label>User Type</label> <select class="form-control select2_assigndoctor"
							style="width: 100%;" name="eid" onselect="selectArea_assignDoctor()">
							<option selected="selected" disabled="disabled">Select
								Employee</option>
							<% while(rs.next()){ %>
							<option value="<%= rs.getInt("eid")%>"><%= rs.getString("name") %></option>
							<% } rs= con.createStatement().executeQuery("select aid, areaname from area"); %>
						</select>
					</div>
					<div class="form-group" id="assign_doctor_area" style="display: none">
						<label>Area</label> <select class="form-control select2"
							style="width: 100%;" name="aid" >
							<option selected="selected" disabled="disabled">Select
								Area</option>
							<% while(rs.next()){ %>
							<option value="<%= rs.getInt("aid")%>"><%= rs.getString("areaname") %></option>
							<% } %>
						</select>
					</div> 
					<div class="form-group">
						<button type="submit" class="btn btn-primary pull-right" name="submit" value="Search">Search</button>
					</div>
				</div>
				</form>
				<%
					JSONObject json_assignDoc = (JSONObject) session.getAttribute("assigndoctorslist");
					if(json_assignDoc != null){
						int eid = json_assignDoc.getInt("empid");
						rs = (ResultSet) json_assignDoc.get("resultset");
						String name = json_assignDoc.getString("empname");
						String areaname = json_assignDoc.getString("areaname");
				%>
				<div class="col-md-8">
				<form action="<%= rootpath%>AssignDoctor" method="post">
					<input type="hidden" name="eid" value="<%= eid %>">
					<dl class="dl-horizontal">
		                <dt>Selected Employee Name:</dt>
		                <dd><%= name %></dd><hr>
		                <dt>Selected Area:</dt>
		                <dd><%= areaname %></dd>
		            </dl>
					<table id="example1" class="table table-bordered table-striped">
		                <thead>
			                <tr>
			                  <th>Select</th>
			                  <th>Doctor Name</th>
			                </tr>
		                </thead>
		                <tbody>
		                <% while(rs.next()){ %>
		                	<tr>
		                		<td><input type="checkbox" name="doctorid[]" value="<%= rs.getInt("doctorid") %>"></td>
		                		<td><%= rs.getString("name") %></td>
		                	</tr>
		                <% } %>
		                </tbody>
	              	</table>
	              	<div class="form-group">
						<button type="submit" class="btn btn-primary pull-right" name="submit" value="Assign">Assign</button>
					</div>
	              	</form>
				</div>
				<% } %>
			</div>
		</div>
		<div class="box-footer">
		
		</div>
	</div>
</section>

<%@ include file="footer.jsp" %>