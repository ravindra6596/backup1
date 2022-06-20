<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp"%>
<%
	//ResultSet rs = con.createStatement().executeQuery("SELECT * FROM headquarter INNER JOIN AREA ON area.`hid`=headquarter.`hid` INNER JOIN subarea ON subarea.`aid`= area.`aid` ");
	ResultSet rs = null;
	
	String msg = request.getParameter("msg");
	String res = request.getParameter("res");
	if (res != null && res.equals("success")) {
	%>
	<div class="callout callout-info fadeout">
		<h4>Success!</h4>
		<p><%= msg %></p>
	</div>
	<%
	} else if (res != null && res.equals("duplicate")) {
	%>
	<div class="callout callout-warning fadeout">
		<h4>Success!</h4>
		<p><%= msg %></p>
	</div>
	<%
	} else if (res != null && res.equals("fail")) {
	%>
	<div class="callout callout-danger fadeout">
		<h4>Error!</h4>
		<p><%= msg %></p>
	</div>
	<%
	}
	%>
	
<section class="content-header">
  <h1> Regions Management </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li class="active">Regions</li>
  </ol>
</section>

<section class="content">
	<div class="row">
		<div class="col-md-6">
			<div class="box">
			    <div class="box-header">
			      <h3 class="box-title">All Regions</h3>
			    </div>
		        <div class="box-body">
        			<table class="table table-bordered table-striped datatable">
		                <thead>
			                <tr>
			                  <th>#</th>
			                  <th>Region</th>
			                 <th>Action</th>
			               	</tr>
		                </thead>
		                <% Connection con = C3P0DataSource.getInstance().getConnection();
		                rs = con.createStatement().executeQuery("SELECT * FROM regions ORDER BY region");
		                	int i = 0;
		                %>
						<tbody>
							<% while(rs.next()){ %>
								<tr>
									<td><%= ++i %></td>
									<td><%= rs.getString("region") %></td>
									<td>
										<form action="<%= rootpath %>Area" method="POST">
											<input type="hidden" name="raid" value="<%=rs.getString("raid")%>">
											<button class="btn btn-danger btn-sm" type="submit" name="submit_delete" value="REGION_DELETE">Delete</button>
										</form>
									</td>
								</tr>
							<% } %>
						</tbody>
					</table>
		       	</div>
		   	</div>
		</div>
		<div class="col-md-4">
			<div class="box box-default">
	            <div class="box-header with-border">
	              <i class="fa fa-plus"></i>
	              <h3 class="box-title">Add New Region</h3>
	            </div>
	            <div class="box-body">
		            <form name="addarea" action="<%= rootpath %>Area" method="post">
				     	<div class="form-group">
							<label for="region">Region Name</label>
							<input type="text" autocomplete="off" class="form-control" name="region" placeholder="Enter Region Name" required>
						</div>
						<div class="box-footer">
							<button type="submit" class="btn btn-primary pull-right" name="submit" value="ADD_REGION">Submit</button>
						</div>
					 </form>
	            </div>
	         </div>
	    </div>
	</div>
</section>

<%@ include file="footer.jsp"%>