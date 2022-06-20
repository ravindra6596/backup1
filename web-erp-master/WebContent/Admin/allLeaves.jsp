<%@page import="java.sql.ResultSet"%>
<%@page import="com.model.C3P0DataSource"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp"%>
<% 
	String name = null; 
	ResultSet all_leaves = null ;
	Connection con = C3P0DataSource.getInstance().getConnection();
	String leaveQuery = "	Select  leaveid, name ,leavetype,DATE_FORMAT(fromdate, '%d-%m-%Y') as datefrom, DATE_FORMAT(todate, '%d-%m-%Y') AS dateto,status, DATEDIFF(todate,fromdate) as 'days' from leavemgm inner join employee on employee.eid = leavemgm.eid order by status";
	System.out.println(leaveQuery);
	all_leaves = con.createStatement().executeQuery(leaveQuery);
%>
	<section class="content-header">
	<h1>Leaves</h1>
	
	<%
		String msg =null;
		msg = request.getParameter("response");
		if(msg!=null && msg.equals("success")){
		%>
	<div class="callout callout-info fadeout">
		<h4>Success!</h4>
		<p>Leave Status Updated..</p>
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
</section>

<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<form action="<%=rootpath %>/LeaveMgm" method="post">
				<input type="hidden" name="id" value="<%= id %>">
				<div class="box">
					<div class="box-header"></div>
					<!-- /.box-header -->
					<div class="box-body">
						<div class="row">
							<div class="col-md-12">
								<table id="example1" class="table table-bordered table-striped">
					                <thead>
						                <tr>
						                  <th>Employee Name</th>
						                  <th>Leave Type</th>
						                  <th>From Date</th>
						                  <th>To Date</th>
						                  <th>Days</th>
						                  <th>Status</th>
						               	</tr>
					                </thead>
					                <tbody>
					                <%
					                System.out.println("khoitro "+all_leaves);
					                if(all_leaves != null){
					                while(all_leaves.next()){ %>
						                <tr>
						                	<td><a href="Admin/leavestatus.jsp?id=<%= all_leaves.getInt("leaveid") %>"><%= all_leaves.getString("name") %></a></td>
						                	<td><%= all_leaves.getString("leavetype") %></td>
						                	<td><%= all_leaves.getString("datefrom") %></td>
						                	<td><%= all_leaves.getString("dateto") %></td>
						                	<td><%= all_leaves.getInt("days") %></td>
						                	<td><%= all_leaves.getString("status") %></td>  
						                </tr>
						            <% } }%>
						           </tbody>
						        </table>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</section>	

<%@ include file="footer.jsp"%>