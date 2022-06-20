<%@page import="java.time.LocalDate"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.Employee.Objects.WorkingDaysCount"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.model.C3P0DataSource"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp"%>

<section class="content-header">
	<h1>
		Employee Monthly Report <small>Preview</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li><a href="#">Forms</a></li>
		<li class="active">Advanced Elements</li>
	</ol>
</section>
<section class="content">
	<!-- SELECT2 EXAMPLE -->
	<div class="box box-default">
		<div class="box-header with-border">
			<div class="box-tools pull-right">
				<i class="fa fa-minus"></i>

			</div>
		</div>

		<div class="box-body">
			<form method="post" action="<%= rootpath %>MonthlyReport">
				<div class="row">
					<div class="col-md-3">
						<%
						Connection con = C3P0DataSource.getInstance().getConnection();
						Statement stTMname=con.createStatement();
                     ResultSet rsTMname=stTMname.executeQuery("select eid, name from employee where usertype='TM'");
                      %>
						<div class="form-group">
							<label>TM Name</label> <select class="form-control select2"
								style="width: 100%;" name="tmname">
								<option selected="selected">Employee Name</option>
								<% while(rsTMname.next()) { %>
								<option value="<%= rsTMname.getInt("eid") %>"><%= rsTMname.getString("name") %></option>
								<% } %>
							</select>
						</div>
					</div>
					<div class="col-md-3">
						<div class="form-group">
							<label>Date range:</label>

							<div class="input-group">
								<div class="input-group-addon">
									<i class="fa fa-calendar"></i>
								</div>
								<input type="text" class="form-control pull-right monthpicker"
									id="daterange_employeeMonthWiseReport" name="date">
							</div>
							<!-- /.input group -->
						</div>
					</div>
					<div class="col-md-3">
						<button type="submit" class="btn btn-primary " name="submit"
							value="submit" style="margin-top: 25px;">Submit</button>
					</div>
				</div>
			</form>
			<div class="row">
			<%
				String msg = null;
				String tmname = null;
				
				
				JSONObject leaves = (JSONObject) session.getAttribute("leaves");
				if(leaves != null){
					tmname = (String) leaves.get("tmname");
					//@SuppressWarnings("unchecked")
					JSONArray leavesarray = (JSONArray) leaves.get("leaves");
					JSONArray visitedCalls = (JSONArray) leaves.get("visitedCalls");
					JSONArray listed_doctors = (JSONArray) leaves.get("listed_doctors");
					JSONArray converted_doctors = (JSONArray) leaves.get("converted_doctors");
					JSONArray Total_sum = (JSONArray) leaves.get("Total_sum");
					JSONArray call_average = (JSONArray) leaves.get("call_average");
					JSONArray Dates = (JSONArray) leaves.get("date");
					int length = 0;
					 length = leavesarray.length();
					System.out.println(length);
					if(length != 0){
					for(int i= 0; i <= length-1; i++){
						int leavecount = 0;int tourCount = 0;int totalTour = 0;int listedDrCount = 0;int convertedCount =0;int callAttendedCount=0;
						double sum =0; double call_avg = 0;
					leavecount = leavesarray.getInt(i);
					callAttendedCount = visitedCalls.getInt(i);
					listedDrCount = listed_doctors.getInt(i);
					convertedCount = converted_doctors.getInt(i);
					sum = Total_sum.getDouble(i);
					call_avg = call_average.getDouble(i);
					LocalDate date = (LocalDate) Dates.get(i);
					
				
			%>
			
				<div class="col-md-4">
		          <!-- Widget: user widget style 1 -->
		          <div class="box box-widget widget-user-2">
		            <!-- Add the bg color to the header using any of the bg-* classes -->
		            <div class="widget-user-header bg-light-blue">
		              <!-- /.widget-user-image -->
		              <h3 class="widget-user-username"><%= date.getMonth()+"-"+date.getYear() %></h3>
		              
		            </div>
		            <div class="box-footer no-padding">
		              <ul class="nav nav-stacked">
		                <li><a>No. of Leaves <span  class="pull-right "><%=leavecount %></span></a></li>
		                <li><a>Total Doctor's call generated <span  class="pull-right "><%= tourCount %></span></a></li>
		                <li><a >Total Calls Attended <span  class="pull-right "><%= callAttendedCount %></span></a></li>
		                <li><a>No. of Doctor Visited <span  class="pull-right "><%= listedDrCount %></span></a></li>
		                <li><a>No. of Doctor Converted <span  class="pull-right "><%= convertedCount %></span></a></li>
		                <li><a>Call Average <span class="<% if(call_avg < 8){out.print("pull-right badge bg-red");}else if(call_avg >= 10){out.print("pull-right badge bg-green");}else{out.print("pull-right badge bg-orange");} %>"><%= call_avg %></span></a></li>
		                <li><a>Total Sale <span class="pull-right "><%=sum %></span></a></li>
		              </ul>
		            </div>
		          </div>
		          <!-- /.widget-user -->
		        </div>
							
			<% 			} 
					}
				}
			%>
			</div>
		</div>

	</div>
</section>
<!-- /.content -->

<%@ include file="footer.jsp"%>