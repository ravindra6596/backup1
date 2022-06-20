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
	rs = st.executeQuery("select name, cid from chemists");
%>
<section class="content-header">
	<h1>All Chemist</h1>
	<!-- <ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i>Home</a></li>
		<li><a href="#">Tables</a></li>
		<li class="active">Data tables</li>
	</ol> -->
	<%
		String msg =null;
		msg = request.getParameter("response");
		if(msg!=null && msg.equals("success")){
		%>
	<div class="callout callout-info fadeout">
		<h4>Success!</h4>
		<p>Record Deleted Successfully</p>
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

	<!-- Main content -->
	<section class="content">
		<div class="row">
			<div class="col-xs-12">

				<div class="box">
					<div class="box-header"></div>
					<!-- /.box-header -->
					<div class="box-body">
						<table id="example1" class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>Name</th>
									<!-- <th>Gender</th> -->
									<th>Head-Quarter</th>
									<th>Firm-Constitution</th>
								</tr>
							</thead>
							<form method="post">
							<thead>
								<tr>
									<th><select class="form-control select2" multiple="multiple"
										name="cid" data-placeholder="Select Chemist"
										style="width: 100%;">
											<% while(rs.next()){ %>
											<option value="<%=rs.getString("cid")%>"><%= rs.getString("name") %></option>
											<% } rs= st.executeQuery("select headquarter from headquarters"); %>
									</select></th>
									<!-- <th><select class="form-control select2"
										style="width: 100%;"name="gender">
											<option selected disabled>Select Type</option>
											<option value="female">Female</option>
											<option value="male">Male</option>
									</select></th> -->
									<th><select class="form-control select2"
										style="width: 100%;" name="headquarter" multiple="multiple" data-placeholder="select Head-Quarter">
											
											<% while(rs.next()){ %>
											<option value="<%= rs.getString("headquarter") %>"><%= rs.getString("headquarter") %></option>
											<% } %>
									</select></th>
									<th><select class="form-control select2"
										style="width: 100%;" name="firmconstitution">
											<option selected disabled>Firm-Constitution</option>
											<option value="Proprietor">Proprietor</option>
											<option value="Partnership">Partnership</option>
											
									</select></th>
									<th>
										<button type="submit" class="btn btn-primary " name="submit"
											value="search">Search</button>
									</th>
								</tr>
							</thead>
							</form>
							<% String search = request.getParameter("submit");
							
							String query1 = "select chemists.*, headquarters.headquarter as hname from chemists inner join headquarters on headquarters.haid = chemists.headquarter where ";
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
										<td><a method="post" href='Admin/updatechemist.jsp?id=<%=rs.getInt("cid") %>'><%= rs.getString("name") %></a></td>
										<%-- <td><%= rs.getString("gender") %></td> --%>
										<td><%= rs.getString("hname") %></td>
										<td><%= rs.getString("firmconstitution") %></td>
									</tr>
								<% } %>
							</tbody>
							<% }else{ 
									cquery = "select chemists.*, headquarters.headquarter as hname from chemists inner join headquarters on headquarters.haid = chemists.headquarter";
									System.out.println("ok");
									rs = st.executeQuery(cquery);
									System.out.println(cquery);
								%>
								<tbody>
									<% while(rs.next()){ %>
									<tr>
										<td><a method="post" href='Admin/updatechemist.jsp?id=<%=rs.getInt("cid") %>'><%= rs.getString("name") %></a></td>
										<%-- <td><%= rs.getString("gender") %></td> --%>
										<td><%= rs.getString("hname") %></td>
										<td><%= rs.getString("firmconstitution") %></td>
									</tr>
								<% } %>
								</tbody>
							<% } %>
							<tfoot>
								<tr>
									<th>Name</th>
									<th>Head-Quarter</th>
									<th>Firm-Constitution</th>
									<th></th>
								</tr>
							</tfoot>
						</table>
					</div>
					<!-- /.box-body -->
					<div class="box-footer">
	            	<form action="<%= rootpath %>Exporter" method="post">
	            		<input type="hidden" name="query" value="<%= cquery %>">
	              		<button type="submit" class="btn btn-primary pull-right" name="export" value="export_allStockiest" style="background-color: #00a65a;">Export Sheet</button>
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