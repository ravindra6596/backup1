<%@page import="com.Employee.Objects.GetData"%>
<%@page import="com.Admin.Classes.Expenses"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.model.C3P0DataSource"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp"%>

<%
Connection con = C3P0DataSource.getInstance().getConnection();
	ResultSet rstmname = con.createStatement().executeQuery("select eid, name from employee where usertype='tm'");
	String submit = request.getParameter("submit");
%>

<section class="content-header">
	<h1>
		Expense Sheet 
	</h1>
	
</section>

<!-- Main content -->
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<div class="box">
				
				<!-- /.box-header -->
				<div class="box-body">
					<form action="" method="post">
						<div class="row">
							<div class="col-md-3">
								<div class="form-group">
									<label>Select TM:</label> 
									<select class="form-control select2" name="eid" style="width: 100%;" required>
										<option selected="selected" disabled="disabled">Select
											TM</option>
										<% while(rstmname.next()){%>
										<option value="<%= rstmname.getString("eid") %>"><%= rstmname.getString("name") %></option>
										<% } %>
									</select>
								</div>
							</div>
							<div class="col-md-3">
								<div class="form-group">
									<label>Select Month:</label>

									<div class="input-group date">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input type="text" class="form-control pull-right"
											id="datepicker" name="month" autocomplete="off" required>
									</div>
									<!-- /.input group -->
								</div>
							</div>
							<div class="col-md-2">
								<div class="form-group">

									<button type="submit" class="btn btn-primary " name="submit"
										value="submit" style="margin-top: 25px;">Search</button>
								</div>
							</div>
						</div>
					</form>
					<%
					System.out.println("submit="+submit);
		            if(submit != null){
		            	List<Integer> areas = new ArrayList<Integer>();
		            	List<Float> total = new ArrayList <Float>();
		            	String eid1 = request.getParameter("eid");
		            	String month = request.getParameter("month");
		            	System.out.println("eid="+eid1+" month="+month);
		            	if(eid1 != null && (!eid1.isEmpty() && !month.isEmpty())) {
		            		int eid = Integer.parseInt(eid1);
		            		ResultSet rsarea = Expenses.Expense_area(eid, month);
		            		%>
		            		<div class="form-group">
		            			<h4>Selected Employee Name: <label> <%= GetData.emp_name(eid) %></label></h4>
		            			<h4>Selected Month: <label> <%= month %></label></h4>
		            		</div>
							<div class="row">
								<div class="col-md-12">
									<table id="1" class="table table-bordered table2excel">
										<thead>
											<tr>
												<th rowspan="2">Date</th>
												<th rowspan="2">Area</th>
												<th colspan="3" style="text-align: center;">Allowances</th>
												<th rowspan="2">Total</th>
											</tr>
											<tr>
												<th>Daily Allowances</th>
												<th>Ex.HQ</th>
												<th>Traveling Allowances</th>
											</tr>
										</thead>
										<tbody>
											<% while(rsarea.next()){
												int aid = rsarea.getInt("aid");
							              		areas.add(aid);
							              		ResultSet rsallow = Expenses.Getallowance(aid);
							              		String areaname = GetData.area_name(aid);
							              	%>
											<tr>
												<td rowspan="2"><%= rsarea.getString("date") %></td>
												<td rowspan="2"><%= areaname %></td>
											</tr>
											<% if(rsallow.next()){
										 		ResultSet rstotal = Expenses.ExpenseTotal(aid);
										 	%>
												<tr>
													<td><%= rsallow.getFloat("hq") %></td>
													<td><%= rsallow.getFloat("exhq") %></td>
													<td><%= rsallow.getFloat("tour") %></td>
													<% if(rstotal.next()){ total.add(rstotal.getFloat("total")); %>
														<td><%= rstotal.getFloat("total") %></td>
													<% } %>
												</tr>
											<% }else{
												%>
												<tr>
													<td>0</td>
													<td>0</td>
													<td>0</td>
													<td>0</td>
												</tr>
											<% 
												}
		              						}
		              	
										    float sum = 0;
										    for(int t=0; t<total.size(); t++){
										    	sum += total.get(t);
										    }
							              		%>
										</tbody>
									</table>
								</div>
							</div>

							<div class="row">
								<div class="col-md-6">
									<table id="2" class="table table-bordered">
										<tr>
											<td>1.</td>
											<th>Total Tour Expenses:</th>
											<td><%= sum %> INR</td>
										</tr>
										<tr>
											<td>2.</td>
											<th>Telephone Bill:</th>
											<% float telebill = Expenses.telephone();%>
											<td><%= telebill %> INR</td>
										</tr>
										<tr>
											<td>3.</td>
											<th>Total Payable:</th>
											<% 
												float total_sum = 0;
												total_sum = sum + telebill ;
											%>
											<td><%= total_sum %> INR</td>
										</tr>
									</table>
								</div>
							</div>
							<!-- <button class="btn btn-success exportexcel">Export</button></div> -->
							<input class="btn btn-primary" type="button" onclick="tablesToExcel(['1', '2'], ['first', 'second'], 'myfile.xls')" value="Export to Excel">
						<%
		            	}
		            	else{
		            		%>
		            		<div class="alert alert-danger alert-dismissible fade in">
							    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
							    Please Select Employee and Month...
							</div>
		            		<%
		            	}
					 } %>
				</div>
			</div>
		</div>
	</div>
</section>


<%@ include file="footer.jsp"%>