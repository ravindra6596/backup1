<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp"%>
<%
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
  <h1>Headquarters Management </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li class="active">Headquarters</li>
  </ol>
</section>

<section class="content">
	<div class="row">
		<div class="col-md-6">
			<div class="box">
			    <div class="box-header">
			      <h3 class="box-title">All Headquarters</h3>
			    </div>
		        <div class="box-body">
        	
        			<table class="table table-bordered table-striped datatable">
	                <thead>
		                <tr>
		                  <th>#</th>
		                  <th>Headquarter</th>
		                  <th>District</th>
		                  <th>Action</th>
		               	</tr>
	                </thead>
	                
	                <% Connection con = C3P0DataSource.getInstance().getConnection();
	                rs = con.createStatement().executeQuery("SELECT h.*, d.district, r.region FROM headquarters h INNER JOIN districts d ON d.`daid` = h.`daid` INNER JOIN regions r ON r.`raid`= d.`raid`");
	                	int i = 0;
	                %>
					<tbody>
						<% while(rs.next()){ %>
							<tr>
							<td><%= ++i %></td>								
							<td><%= rs.getString("headquarter") %></td>
							<td><%= rs.getString("district")+" ("+rs.getString("region")+")" %></td>
							<td>
								<form action="<%= rootpath %>Area" method="POST">
									<input type="hidden" name="haid" value="<%=rs.getString("haid")%>">
									<button class="btn btn-danger btn-sm" type="submit" name="submit_delete" value="HEADQUARTER_DELETE">Delete</button>
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
	              <h3 class="box-title">Add New Headquarter</h3>
	            </div>
	            <div class="box-body">
		            <form action="<%= rootpath %>Area" method="post">
						<div class="form-group">
							<label>Select District:</label>
							<select class="form-control select2 add_areasecond" style="width: 100%;" name="daid" data-placeholder="select Area">
								<option selected="selected" disabled="disabled">Select District</option>
								<%	ResultSet rs_dist = con.createStatement().executeQuery("select d.*, r.region from districts d LEFT JOIN regions r ON d.raid = r.raid");
									while (rs_dist.next()) {
								%>	<option value="<%=rs_dist.getString("daid")%>"><%=rs_dist.getString("district") + " ("+rs_dist.getString("region")+")"%></option>	<%
									}
								%>
							</select>
						</div>						
						<div class="form-group">
							<label for="headquarter">Headquarter</label>
							<input type="text" class="form-control" name="headquarter" autocomplete="off" placeholder="Enter Headquarter Name">
						</div>
						<div class="box-footer">
							<button type="submit" class="btn btn-primary pull-right" name="submit" value="ADD_HEADQUARTER">Submit</button>
						</div>
					</form>
	            </div>
	         </div>
	    </div>
	</div>
</section>

<%@ include file="footer.jsp"%>