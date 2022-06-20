<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.model.C3P0DataSource"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp" %>

<%
Connection con = C3P0DataSource.getInstance().getConnection();
	Statement st = con.createStatement();
	ResultSet rs = null;
	rs = st.executeQuery("select pname, pid from product");
%><section class="content-header">
	<h1>Product Information</h1>
	<%
		String msg = null;
		msg = request.getParameter("response");
		if (msg != null && msg.equals("success")) {
	%>
	<div class="callout callout-info fadeout">
		<h4>Success!</h4>
		<p>Record Deleted Successfully</p>
	</div>
	<%
		} else if (msg != null && msg.equals("duplicate")) {
	%>
	<div class="callout callout-warning fadeout">
		<h4>Success!</h4>
		<p>Duplicate record available!!</p>
	</div>
	<%
		} else if (msg != null && msg.equals("fail")) {
	%>
	<div class="callout callout-danger fadeout">
		<h4>Error!</h4>
		<p>Something went Wrong..!!</p>
	</div>
	<%
		}
	%>
</section>

<section class="content-header">
	<h1>All Products</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i>Home</a></li>
		<li class="active">All Products</li>
	</ol>
</section>

	<section class="content">
		<div class="row">
			<div class="col-xs-12">
				<div class="box">
					<div class="box-header"></div>
					<div class="box-body">
						<table id="example1" class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>Name</th>
									<th>Type</th>
									<th>Group</th>
								</tr>
							</thead>
							<form method="post">
							<thead>
								<tr>
									<th><select class="form-control select2"
										multiple="multiple" name="pid"
										data-placeholder="Select Product" style="width: 100%;">
										<% while(rs.next()){ %>
											<option value="<%=rs.getString("pid")%>"><%= rs.getString("pname") %></option>
										<% } %>
									</select></th>
									<th><select class="form-control select2"
										style="width: 100%;"name="ptype" >
											<option selected disabled>Select Type</option>
											<option value="silver">Syrup</option>
											<option value="gold">Tablet</option>
									</select></th>
								
									<th><select class="form-control select2"
										style="width: 100%;" name="pgroup">
											<option selected disabled>Select Group</option>
											<option value="protein">Protein</option>
											<option value="alaska">Calcium</option>
											
									</select></th>
									<th>
										<button type="submit" class="btn btn-primary " name="submit"
											value="search">Search</button>

									</th>
								</tr>
							</thead>
							</form>
							<% String search = request.getParameter("submit");
							
							String query1 = "select * from product where ";
							  String whr = "(";
							  String cquery = null;
								if(search != null){
									Map map = request.getParameterMap();
									System.out.println(map);
									Set s = map.entrySet();
							        Iterator it = s.iterator();
							        while(it.hasNext()){
							        	Map.Entry<String,String[]> entry = (Map.Entry<String,String[]>)it.next();
							        	 String key             = entry.getKey();
							             String[] value         = entry.getValue();
							             
							             if(value.length>1){
							            	 for(int i=0;i<value.length;i++){
							            		 System.out.println(key+"="+value[i]);
							            		 whr = whr+""+key+"='"+value[i]+"' OR ";
							            	 }
							             }else{
							            	 whr = whr+key+"='"+value[0]+"' OR ";
							             }
							             whr = whr.substring(0, whr.length()-4)+") AND (";
						            }
							        query1 =query1+ whr.substring(0, whr.length()-28);
							        System.out.println(query1);
									cquery = query1;
									rs= st.executeQuery(query1); 
								
							%>
							<tbody>
								<% while(rs.next()){ %>
									<tr>
										<td><a method="post" href='Admin/singleproduct.jsp?id=<%=rs.getInt("pid") %>'><%= rs.getString("pname") %></a></td>
										<td><%= rs.getString("ptype") %></td>
										<td><%= rs.getString("pgroup") %></td>
									</tr>
								<% } %>
							</tbody>
							<% }else{ 
									cquery = "select * from product";
									rs = st.executeQuery(cquery);
								%>
								<tbody>
									<% while(rs.next()){ %>
									<tr>
										<td><a method="post" href='Admin/singleproduct.jsp?id=<%=rs.getInt("pid") %>'><%= rs.getString("pname") %></a></td>
										<td><%= rs.getString("ptype") %></td>
										<td><%= rs.getString("pgroup") %></td>
									</tr>
								<% } %>
								</tbody>
							<% } %>
							<tfoot>
								<tr>
									<th>Name</th>
									<th>Type</th>
									<th>Group</th>
								</tr>
							</tfoot>
						</table>
					</div>
					<!-- /.box-body -->
					<div class="box-footer">
		            	<form action="<%= rootpath %>Exporter" method="post">
		            		<input type="hidden" name="query" value="<%= cquery %>">
		              		<button type="submit" class="btn btn-primary pull-right" name="export" value="export_allProducts" style="background-color: #00a65a;">Export Sheet</button>
		             	</form>
		            </div>
				</div>
				<!-- /.box -->
			</div>
			<!-- /.col -->

		</div>
		<!-- /.row -->
	</section>
	<!-- /.content -->

<%@ include file="footer.jsp"%>