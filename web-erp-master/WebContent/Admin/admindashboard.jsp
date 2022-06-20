<%@page import="java.text.DecimalFormat"%>
<%@page import="com.Admin.Classes.AdminDashboard"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.time.Month"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.model.C3P0DataSource"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ include file="header.jsp"%>
<%
	JSONObject adminDash = AdminDashboard.SaleGraph();
	String total_avg = adminDash.has("total_avg") ? String.format( "%.2f", adminDash.getDouble("total_avg") ) : "0";
	String total_sale = adminDash.has("total_sale") ? String.format( "%.2f", adminDash.getDouble("total_sale") ) : "0";
	String cdataArray = adminDash.has("cdataArray") ? adminDash.getString("cdataArray") : "";
	
%>

<div id="hiddenChartData">
	<input type="hidden" name="chartdata" value='<%=cdataArray%>'>
</div>
<section class="content">
	<div class="box box-info">
		<div class="box-header with-border">
			<h3 class="box-title">Sales Graph</h3>

			<div class="box-tools pull-right">
				<button type="button" class="btn btn-box-tool"
					data-widget="collapse">
					<i class="fa fa-minus"></i>
				</button>
				<button type="button" class="btn btn-box-tool" data-widget="remove">
					<i class="fa fa-times"></i>
				</button>
			</div>
		</div>
		<div class="box-body chart-responsive">
			<canvas id="bar-chart" style="width: 100%;" height="350"></canvas>
		</div>
		<!-- /.box-body -->
		<div class="box-footer no-border">
			<div class="row">
				<div class="col-md-3">
                	<div class="info-box">
			            <span class="info-box-icon bg-green" ><i class="fa fa-line-chart"></i></span>
			            <div class="info-box-content">
			              <span class="info-box-text">Total Sale</span>
			              <span class="info-box-number"><%= total_sale %></span>
			            </div>
			            <!-- /.info-box-content -->
			          </div>
                </div>
                <div class="col-md-3">
                	<div class="info-box">
			            <span class="info-box-icon bg-light-blue"><i class="fa fa-rupee"></i></span>
			            <div class="info-box-content">
			              <span class="info-box-text">Avg Monthly Sale</span>
			              <span class="info-box-number"><%= total_avg %></span>
			            </div>
			          </div>
                </div>
                <div class="col-md-3">
                	<div class="info-box">
			            <span class="info-box-icon bg-red" ><i class="fa fa-line-chart"></i></span>
			            <div class="info-box-content">
			              <span class="info-box-text">Total Target</span>
			              <span class="info-box-number"><%= total_sale %></span>
			            </div>
			            <!-- /.info-box-content -->
			          </div>
                </div>
                <div class="col-md-3">
                	<div class="info-box">
			            <span class="info-box-icon bg-orange"><i class="fa fa-rupee"></i></span>
			            <div class="info-box-content">
			              <span class="info-box-text">Avg Monthly Target</span>
			              <span class="info-box-number"><%= total_avg %></span>
			            </div>
			          </div>
                </div>
           	</div>
		</div>
	</div>
	
	
	<div class="row">
		<div class="col-md-6">
			<div class="box box-success">
				<div class="box-header">
					<h3 class="box-title">Today's Tours Plan</h3>
				</div>
				<div class="box-body">
					<table id="example1" class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>Employee Name</th>
								<th>Doctor's Name</th>
								<th>Time</th>
								<th>Area</th>
								<th>Status</th>
							</tr>
						</thead>
						<tbody>
							<%
							int idx = 0;	
							String result = AdminDashboard.GetTodaysTourPlan();
							JSONArray array = new JSONArray(result);  
							for(int i=0; i < array.length(); i++)   
							{  
								JSONObject rs = array.getJSONObject(i);  
								%>
								<tr style="<% if(rs.getString("status").equals("notvisited")) out.print("color:red;");%>">
									<td><%=rs.getString("empname")%></td>
									<td><%=rs.getString("dname")%></td>
									<td><%=rs.getString("time")%></td>
									<td><%=rs.getString("headquarter")%></td>
									<td><%=rs.getString("status")%></td>
								</tr>
								<%
							}  
							%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="col-md-6">
			<div class="box box-warning">
				<div class="box-header">
					<h3 class="box-title">
						Today's Leaves <small>(All Employees)</small>
					</h3>
				</div>
				<!-- /.box-header -->
				<div class="box-body">
					<table id="leaveAdminDashboard" class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>Employee Name</th>
								<th>Leave Type</th>
								<th>Status</th>
							</tr>
						</thead>
						<tbody>
							<%
							String result1 = AdminDashboard.Leaves();
							
							JSONArray array1 = new JSONArray(result1);  
							for(int i=0; i < array1.length(); i++)   
							{  
								JSONObject rs_leave = array1.getJSONObject(i);  
								%>
								<tr>
									<td><%=rs_leave.getString("name")%></td>
									<td><%=rs_leave.getString("leavetype")%></td>
									<td><%=rs_leave.getString("status")%></td>
								</tr>
								<%
							}
							%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

</section>
<%@ include file="footer.jsp"%>