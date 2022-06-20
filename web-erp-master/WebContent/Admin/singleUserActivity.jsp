<%@page import="com.model.C3P0DataSource"%>
<%@page import="java.sql.*"%>
<%@page import="org.apache.tomcat.util.codec.binary.Base64"%>
<%@page import="java.io.OutputStream"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ include file="header.jsp"%>
<%
Connection con = C3P0DataSource.getInstance().getConnection();
	Statement st = con.createStatement();
	ResultSet rs = null;
	int aid = Integer.parseInt(request.getParameter("aid"));
	String sql = "SELECT DATE_FORMAT(ua.created_at, '%d-%m-%Y') AS activitydate ,ua.aid,e.name as employeename,ua.place_type as place,ua.latitude,ua.longitude,ua.feedback FROM user_activity ua INNER JOIN employee e ON e.eid=ua.eid WHERE ua.aid = '"+aid+"'";
	rs = st.executeQuery(sql);
	System.out.println(sql);
%>
<section class="content-header">
	<h1>Selected User Activity</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">User Activity</li>
	</ol>
</section>

<section class="content">
	<div class="row">
		<div class="col-sm-12">
			<div class="box box-default">
				
				<div id="box1" class="box-body" style="display: block;">
					<%
						while (rs.next()) {
					%>
					<div class="row">
						<div class="col-sm-6">
							<table class="table table-bordered  ">
								<thead>
									<tr>
										<th>Details</th>
										<th>Data</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>Employee Name</td>
										<td><%=rs.getString("employeename")%></td>
									</tr>
									<tr>
										<td>Place</td>
										<td><%=rs.getString("place")%></td>
									</tr>
									<tr>
										<td>Activity Date</td>
										<td><%=rs.getString("activitydate")%></td>
									</tr>
									<tr>
										<td>Feedback</td>
										<td><%=rs.getString("feedback")%></td>
									</tr>
									<tr>
										<td>Latitude</td>
										<td><%=rs.getFloat("latitude")%></td>
									</tr>
									<tr>
										<td>Longitude</td>
										<td><%=rs.getFloat("longitude")%></td>
									</tr>
								</tbody>
							</table>
							<%
						}
					%>
							
						</div>
					</div>
					
				</div>
			</div>
		</div>
	</div>
</section>
<%@ include file="footer.jsp"%>