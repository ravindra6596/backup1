<%@page import="java.sql.Statement"%>
<%@page import="com.controller.SampleController"%>
<%@page import=" java.text.SimpleDateFormat"%>
<%@page import=" java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.model.FilterData"%>
<%@page import="java.util.Map"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.Employee.Objects.GetData"%>
<%@page import="java.sql.ResultSet"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ include file="header.jsp"%>
<%
Connection con = C3P0DataSource.getInstance().getConnection();
	ResultSet rstmname = con.createStatement()
			.executeQuery("select eid, name from employee where usertype='tm'");
	String submit = request.getParameter("submit");
	Statement stmt = con.createStatement();
	ResultSet rs;
%>
<section class="content-header">
	<h1>Individual Target Report<small>preview of target analysis</small>
	</h1>
	</section>
<section class="content">
	<div class="box box-default">
		<div class="box-header with-border">
			<div class="box-tools pull-right">
				<i class="fa fa-minus"></i>

			</div>
		</div>

		<div class="box-body">
			<form action="" method="post">
				<div class="row">
					<div class="col-md-3">
						<div class="form-group">
							<label>Select TM:</label> <select class="form-control select2"
								name="eid" style="width: 100%;" required>
								<option selected="selected" disabled="disabled">Select
									TM</option>
								<%
									while (rstmname.next()) {
								%>
								<option value="<%=rstmname.getString("eid")%>"><%=rstmname.getString("name")%></option>
								<%
									}
								%>
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
								<input type="text" class="form-control pull-right monthdatepicker"
									id="datepicker" name="month" autocomplete="off">
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
				if (submit != null) {
					String emp_id = request.getParameter("eid");
					String month = request.getParameter("month");
					if (emp_id != null && (!emp_id.isEmpty() && !month.isEmpty())) {
						int eid = Integer.parseInt(emp_id);

						String query1 = "select target.amount,target.month,primary_sale.amount, target.amount-primary_sale.amount,primary_sale.amount/target.amount*100 from employee INNER JOIN target on employee.eid=target.eid INNER JOIN primary_sale on target.eid=primary_sale.eid WHERE employee.eid=' "
								+ emp_id + "' AND DATE_FORMAT(target.month, '%Y-%m') ='" + month + "'  ";
								System.out.println(query1);
						rs = con.createStatement().executeQuery(query1);
			%>
			<div class="form-group">
				<h4>
					Selected Employee Name: <label> <%=GetData.emp_name(eid)%></label>
				</h4>
				<h4>
					Selected Month: <label> <%=month%></label>
				</h4>
			</div>
			<hr>
			<br> <br>
			<div class="row">
				<div class="col-md-12">
					<table id="" class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>Target</th>
								<th>Primary Sale</th>
								<th>Month</th>
								<th>Primary Sale%</th>
								<th>Return</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<%
								while (rs.next()) {
								int status=rs.getInt("primary_sale.amount/target.amount*100");
								System.out.println(status);
							%>
							<tr>
								<td><%=rs.getString("target.amount")%></td>
								<td><%=rs.getString("primary_sale.amount")%></td>
								<td><%=rs.getString("month")%></td>
								<td class="progress-bar" role="progressbar"  height="10" area-valuemax="100" style="width: <%=status%>%"><span class="sr-only"><%=status%>complete</span><%=status%>% Complete</td>
								<td><%=rs.getInt("target.amount-primary_sale.amount")%></td>
								<td><i class="fa fa-edit fa-lg" style="color:  blue;" ></i><i class="fa fa-trash fa-lg" style="color:  red;  
								"></i></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
				</div>
				
			</div>
			<input class="btn btn-primary" type="button"
				onclick="tablesToExcel(['1', '2'], ['first', 'second'], 'myfile.xls')"
				value="Export to Excel">

			<%
				}
				}
			%>
		</div>
	</div>
</section>

<%@ include file="footer.jsp"%>