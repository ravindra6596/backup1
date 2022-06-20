<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.model.C3P0DataSource"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ include file="header.jsp" %>
<%
Connection con = C3P0DataSource.getInstance().getConnection();
Statement stmt = con.createStatement();
ResultSet rs_camp= stmt.executeQuery("select cname , cid from campaign where status='active'");
String submit = request.getParameter("submit");
float sale1 = 0;
float total_per =0;
System.out.println(submit);
%>

	<section class="content-header">
	<h1>
		Target Analysis <small>preview of target analysis</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li><a href="#">Tables</a></li>
		<li class="active">Simple</li>
	</ol>
</section>
<!-- Main content -->
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<div class="box box-default">
				<div class="box-header with-border">
					<h3 class="box-title">Individual Target</h3>
					<div class="box-tools pull-right">
	            		<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
	          		</div>
				</div>
				<!-- /.box-header -->
				<div class="box-body">
					<form method="post">
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label>Select Campaign</label> <select class="form-control select2"
										style="width: 100%;" name="cid">
										<option selected="selected" disabled="disabled">select
											Campaign....</option>
										<%
											while (rs_camp.next()) {
										%>
										<option value="<%=rs_camp.getInt("cid")%>"><%=rs_camp.getString("cname")%></option>
										<%
											}
										%>
									</select>
								</div>
							</div>
							<div class="col-md-2" style="margin-top: 24px;">
								<input type="submit" class="btn btn-primary" value="Search" name="submit">
							</div>
						</div>
					</form>
					
					<% if(submit==null){ %>
					<div class="row">
					
					</div>
					<% 
					}else if(submit.equals("Search")){
						//ArrayList<Float> sale = new ArrayList<Float>();
							int cid= Integer.parseInt(request.getParameter("cid"));
							String cname =null;
							Statement stmt2 = con.createStatement();
							ResultSet rs_cname = stmt2.executeQuery("select cname from campaign where cid='"+cid+"'");
							while(rs_cname.next()){
								cname= rs_cname.getString("cname");
							}
							System.out.println(cname);
							Statement stmt1= con.createStatement();
							ResultSet rs_target = stmt1.executeQuery("select targetvalue from teamtarget where campaignid='"+cid+"'");
							float total_target = 0;
							while(rs_target.next()){
								total_target= rs_target.getFloat("targetvalue");
							}
							Statement stmt3 = con.createStatement();
							ResultSet rs_achieved = stmt3.executeQuery("SELECT pname, quantity FROM placeorder INNER JOIN orders ON orders.`orderid`= placeorder.`orderid` WHERE orders.`campaign`='"+cname+"'");
							while(rs_achieved.next()){
								Statement stmt4 = con.createStatement();
								ResultSet rs_price = stmt4.executeQuery("select mrp from product where pname='"+rs_achieved.getString("pname")+"'");
								while(rs_price.next()){
									sale1 =sale1+(rs_price.getFloat("mrp"))*(rs_achieved.getInt("quantity"));
									/* sale.add(sale1); */
								}
							}
							total_per = (sale1/total_target)*100;
					%>
					<div class="row">
						<div class="col-md-6">
							<table class="table">
								<tr>
									<th style="width: 10px">#</th>
									<th>Task</th>
									<th>Progress</th>
									<th style="width: 40px">Label</th>
								</tr>
								<tr>
									<td>1.</td>
									<td>Campaign Name:</td>
									<td><label><%= cname %></label></td>
									
								</tr>
								<tr>
									<td>2.</td>
									<td>Total target:</td>
									<td><label><%= total_target %></label></td>
									
								</tr>
								<tr>
									<td>3.</td>
									<td>Target Achieved:</td>
									<td><label><%= sale1 %></label></td>
									
								</tr>
								<tr>
									<td>4.</td>
									<td>Target achieved(in %):</td>
									
									<td><label><%= total_per %>%</label></td>
									<td>
										<div class="progress progress-xs">
											<div class="progress-bar progress-bar-danger"
												style="width:<%= total_per%>% ; background-color:<%if(total_per >50){ out.print("green");}else if(total_per<30){out.print("red");}else{out.print("darkorange");} %>;"></div>
										</div>
									</td>
								</tr>
							</table>
						</div>
					</div>
					<% } %>
				</div>
			</div>
		</div>
	</div>
</section>


<%@ include file="footer.jsp" %>