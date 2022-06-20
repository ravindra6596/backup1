<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="com.model.C3P0DataSource"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp" %>
 <%
 	Connection con = C3P0DataSource.getInstance().getConnection();
	Statement st = con.createStatement();
	ResultSet rs = null;
	rs = st.executeQuery("select name, doctorid from doctors");
%>
<!-- Content Header (Page header) -->
<section class="content-header">
	<h1>Doctor Information</h1>
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
  <h1>
    All Doctors
    
  </h1>
  <!-- <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="#">Tables</a></li>
    <li class="active">Data tables</li>
  </ol> -->
</section>
<section class="content">
	<div class="row">
        <div class="col-xs-12">
       <div class="box">
           
            <!-- /.box-header -->
            <div class="box-body">
       			<table id="example1" class="table table-bordered table-striped">
	                <thead>
		                <tr>
		                  <th>Doctor Name</th>
		                  <th>Headquarter</th>
		                  <th>Contact No.</th>
		                  <th>Active/Inactive</th>
		                  <th>action</th>
		                </tr>
	                </thead>
	                <form method="post">
                <thead>
	                <tr>
	                  <th>
	                  	 <select class="form-control select2" style="width: 100%;" name="doctorid" multiple="multiple" data-placeholder="select name">
			                 
			                  <% while(rs.next()){ %>
			                  <option value="<%= rs.getInt("doctorid")%>"><%= rs.getString("name") %></option>
			                  <% } rs=st.executeQuery("select haid, headquarter from headquarters");%>
			             </select>
				      </th>
	                  <th>
	                  	<select class="form-control select2" style="width: 100%;" name="aid" multiple="multiple" data-placeholder="select area">
			                 
			                  <% while(rs.next()){ %>
			                  <option value="<%= rs.getString("haid")%>"><%= rs.getString("headquarter") %></option>
			                  <% } rs=st.executeQuery("select doctorid, mobile from doctors"); %>
			             </select>
					  </th>
	                  <th>
	                  	<select class="form-control select2" style="width: 100%;" name="doctorid" multiple="multiple" data-placeholder="select contact">
			                 
			                  <% while(rs.next()){ %>
			                  
			                  <option value="<%= rs.getInt("doctorid")%>"><%= rs.getString("mobile") %></option>
			                  <% } %>
			             </select>
	                  </th>
	                  
	                  <th>
	                  	<select class="form-control select2" style="width: 100%;" name="activepassive" >
			                  <option selected="selected" disabled="disabled">Select</option>
			                  <option value="active">Active</option>
			                  <option value="passive">Inactive</option>
			             </select>
	                  </th>
	                  <th>
	                  	<button type="submit" class="btn btn-primary " name="submit"
											value="search">Search</button>
	                  </th>
	                </tr>
                </thead>
                </form>
                <% String search = request.getParameter("submit");
							
							String query1 = "select * from doctors where ";
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
	                <% while(rs.next()){ 
	                	Statement st_area = con.createStatement();
	                	ResultSet area_rs = st_area.executeQuery("select headquarter from headquarters where haid ='"+rs.getInt("doctorid")+"'");
	                	String areaname = null;
	                	if(area_rs.next()){
	                		areaname = area_rs.getString("headquarter");
	                	}
	                %>
		                <tr>
		                  <td><a method="post" href='Admin/singledoctor.jsp?id=<%=rs.getInt("doctorid") %>'><%= rs.getString("name") %></a></td>
	                  <td><%= areaname %></td>
	                  <td><%= rs.getString("mobile") %></td>
	                  <td><%= rs.getString("activepassive") %></td>
	                  <td></td>
		                </tr>
		                <% } %>
	                </tbody>
	                <%}else{ 
	                	cquery = "select * from doctors inner join headquarters on headquarters.haid = doctors.haid ";
					rs = st.executeQuery(cquery);
				%>
				<tbody>
					<% while(rs.next()){ %>
					<tr>
						<td><a method="post" href='Admin/singledoctor.jsp?id=<%=rs.getInt("doctorid") %>'><%= rs.getString("name") %></a></td>
	                  <td><%= rs.getString("headquarter") %></td>
	                  <td><%= rs.getString("mobile") %></td>
	                  <td><%= rs.getString("activepassive") %></td>
	                  <td></td>
					</tr>
				<% } %>
				</tbody>
			<% }
								
			%>
			<tfoot>
                <tr>
                  <th>Doctor Name</th>
                  <th>Headquarter</th>
                  <th>Contact No.</th>
                  <th>Active/Inactive</th>
                  <th>Action</th>
                </tr>
                </tfoot>
                </table>
            </div>
            <!-- /.box-body -->
            <div class="box-footer">
            	<form action="<%= rootpath %>Exporter" method="post">
            		<input type="hidden" name="query" value="<%= cquery %>">
              		<button type="submit" class="btn btn-primary pull-right" name="export" value="export_alldoctors" style="background-color: #00a65a;">Export Sheet</button>
             	</form>
            </div>
          </div>
    	</div>
  	</div>
</section>


<%@ include file="footer.jsp" %>