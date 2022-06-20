<%@page import="java.sql.Statement"%>
<%@page import="com.controller.SampleController"%>
<%@page import=" java.text.SimpleDateFormat"%>
<%@page import=" java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.model.FilterData"%>
<%@page import="java.util.Map"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.model.C3P0DataSource" %>
<%@page import="com.Employee.Objects.GetData"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ include file="header.jsp"%>
<%
Connection con = C3P0DataSource.getInstance().getConnection();
	ResultSet rstmname = con.createStatement()
			.executeQuery("select eid, name from employee where usertype = 'tm' ");
	String submit = request.getParameter("submit");
	Statement stmt = con.createStatement();
	ResultSet rs;
%>
<section class="content-header">
	<h1>Tours</h1>
</section>
<section class="content">
	<div class="box box-default">
		<div class="box-header with-border">
			<div class="box-tools pull-right">
				<i class="fa fa-minus"></i>

			</div>
		</div>

		<div class="box-body">
			<form action="" method="post">
				<div class="row">
					
					
					<div class="col-md-3">
						<div class="form-group">
							<label>Select Month:</label>

							<div class="input-group date">
								<div class="input-group-addon">
									<i class="fa fa-calendar"></i>
								</div>
								<input type="text" class="form-control pull-right"
									id="datepicker" name="month" autocomplete="off">
							</div>
							<!-- /.input group -->
						</div>
					</div>
					<div class="col-md-2">
						<div class="form-group">

							<button type="submit" class="btn btn-primary " name="submit"
								value="submit" style="margin-top: 25px;">Search</button>
						</div>
					</div>
				</div>
			</form>
			<%
				if (submit != null) {
					String month = request.getParameter("month");
					if (!month.isEmpty()) {
						
						String query1 = "SELECT employee.name AS empname, doctors.name as drname, tourplan.date FROM employee INNER JOIN tourplan ON employee.eid = tourplan.eid INNER JOIN doctors ON tourplan.doctorid = doctors.doctorid WHERE DATE_FORMAT(tourplan.date, '%Y-%m') = '" + month + "' ORDER BY DATE ";
								System.out.println(query1);
						rs = con.createStatement().executeQuery(query1);
			%>
			<div class="form-group">
				
				<h4>
					Selected Month: <label> <%=month%></label>
				</h4>
			</div>
			<hr>
			<br> <br>
			<div class="row">
				<div class="col-md-12">
					<table id="" class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>Employee Name</th>
								<th>Doctor Name</th>
								<th>Date</th>
								
							</tr>
						</thead>
						<tbody>
							<%
								while (rs.next()) {
							%>
							<tr>
								<td><%=rs.getString("empname")%></td>
								<td><%=rs.getString("drname")%></td>
								<td><%=rs.getString("date")%></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
				</div>
				
			</div>
<!-- 			<input class="btn btn-primary" type="button" -->
<!-- 				onclick="tablesToExcel(['1', '2'], ['first', 'second'], 'myfile.xls')" -->
<!-- 				value="Export to Excel"> -->

			<%
				}
				}
			%>
		</div>
	</div>
</section>

<%@ include file="footer.jsp"%>