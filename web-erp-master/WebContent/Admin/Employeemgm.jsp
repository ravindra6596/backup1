<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.model.C3P0DataSource"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp"%>
<% 
Connection con = C3P0DataSource.getInstance().getConnection();
	Statement st = con.createStatement();
	ResultSet rs=null;
	rs = st.executeQuery("select eid, name from employee where usertype != 'admin'");
%>
<section class="content-header">
	<h1>All Employees</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">All Employees</li>
	</ol>
</section>

	<!-- Main content -->
	<section class="content">
	<%
		String msg =null;
		msg = request.getParameter("response");
		if(msg!=null && msg.equals("success")){
		%>
		<div class="callout callout-info fadeout">
			<h4>Success!</h4>
			<p>Record Deleted Successfully...</p>
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
		<div class="row">
			<div class="col-sm-12">
				<div class="box">
					<div class="box-header"></div>
					<!-- /.box-header -->
					<div class="box-body">
						<table id="example1" class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>Sr.</th>
									<th>Name</th>
									<th>Employee Type</th>
									<th>Headquarter</th>
									<th>Active Status</th>
									<th>Action</th>
								</tr>
							</thead>
							<%
								String cquery = "select employee.*, headquarters.headquarter from employee inner join headquarters on headquarters.haid = employee.haid where usertype != 'admin'";
								rs = st.executeQuery(cquery);
								System.out.println(cquery);
								int i = 1;
							%>
							<tbody>
								<% while(rs.next()){ System.out.println("dta in while");%>
								
									<tr>
										<td><%= i++ %></td>
										<td><a href="Admin/singleEmployee.jsp?eid=<%= rs.getString("eid") %>" ><%= rs.getString("name") %></a></td>
										<td><%= rs.getString("emptype") %></td>
										<td><%= rs.getString("headquarter") %></td>
										<td><%= rs.getString("isactive") %></td>
										<td></td>
									</tr>
								<% } %>
							</tbody>
						</table>
					</div>
					<div class="box-footer">
		            	<form action="<%= rootpath %>Exporter" method="post">
		            		<input type="hidden" name="query" value="<%= cquery %>">
		              		<button type="submit" class="btn btn-primary pull-right" name="export" value="export_allEmployees" style="background-color: #00a65a;">Export Sheet</button>
		             	</form>
		            </div>
				</div>
			</div>
		</div>
	</section>

<%@ include file="footer.jsp"%>