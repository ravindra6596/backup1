<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.model.C3P0DataSource"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp"%>
<%
Connection con = C3P0DataSource.getInstance().getConnection();

	ResultSet rs = null;
	Statement st = con.createStatement();
%>
<section class="content-header">
	<h1>
		Orders <small>Data</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li><a href="#">Tables</a></li>
		<li class="active">Data tables</li>
	</ol>
</section>
<section class="content">
	<div class="row">
		<div class="col-xs-12">

			<div class="box">
				<div class="box-header">
					<h3 class="box-title">All Orders</h3>
				</div>
				<!-- /.box-header -->
				<div class="box-body">
					<form method="post">
						<div class="row">
							<div class="col-md-2">
								<div class="form-group">
									<div class="input-group date">

										<div class="input-group-addon">
											<i class="fa fa-calendar"></i><i class="form_mandatory">*</i>
										</div>
										<input type="text" class="form-control pull-right monthdatepicker" id=""
											name="month" autocomplete="off" value="Select Month" required>
									</div>
									<!-- /.input group -->
								</div>
							</div>
							<div class="col-md-2">
								<%
									rs = st.executeQuery("select eid , name from employee where usertype = 'TM'");
								%>
								<select class="form-control select2" multiple="multiple"
									name="o.eid" data-placeholder="Select Employee"
									style="width: 100%;">
									<%
										while (rs.next()) {
									%>
									<option value="<%=rs.getInt("eid")%>"><%=rs.getString("name")%></option>
									<%
										}
									%>
								</select>
							</div>

							<div class="col-md-2"></div>
							<div class="col-md-2">
								<button type="submit" class="btn btn-primary " name="search"
									value="search">Search</button>
							</div>
						</div>
					</form>
					<hr>
					<h4>Selected Month:<label><%=request.getParameter("month") %></label>
<%-- 					Selected Employee:<label><%=request.getParameter("o.eid") %></label> --%>
					</h4>
					<hr>
					<div class="row">
						<div class="col-md-9">
							<table id="example1" class="table table-bordered table-striped ">
								<thead>
									<tr>
										<th>Sr.No</th>
										<th>Employee Name</th>
										<th>Order Date</th>
										<th>Amount</th>
										<th>Action</th>

									</tr>
								</thead>
								<%
									String search = request.getParameter("search");
									String month = request.getParameter("month");
									String query1 = "SELECT DATE_FORMAT(o.orderdate, '%d-%m-%Y') AS orderdate,o.orderid,e.name as employeename,o.totalAmt as amount FROM orders o INNER JOIN employee e ON e.eid=o.eid where ";
									String whr = "(";
									String cquery = null;
//SELECT o.orderid,e.name as emoloyeename, o.orderdate,o.totalAmt as amount FROM orders o INNER JOIN employee e ON e.eid=o.eid
									if (search != null) {

										Map map = request.getParameterMap();
										System.out.println(map);
										Set s = map.entrySet();
										Iterator it = s.iterator();
										while (it.hasNext()) {
											Map.Entry<String, String[]> entry = (Map.Entry<String, String[]>) it.next();
											String key = entry.getKey();
											String[] value = entry.getValue();

											if (value.length > 1) {
												for (int i = 0; i < value.length; i++) {
													System.out.println(key + "=" + value[i]);
													whr = whr + "" + key + "='" + value[i] + "' OR ";
												}
											} else {
												if (key.equalsIgnoreCase("month"))
													whr = whr + " DATE_FORMAT(o.orderdate, '%m-%Y') = '" + month + "'  OR ";
												else
													whr = whr + key + "='" + value[0] + "' OR ";
											}
											whr = whr.substring(0, whr.length() - 4) + ") AND (";
										}
										query1 = query1 + whr.substring(0, whr.length() - 28);
										System.out.println(query1);

										rs = st.executeQuery(query1);
										int i = 1;
										
								%>
								<tbody>
									<%
										while (rs.next()) {
												ResultSet rs1 = null;
												Statement st1 = con.createStatement();
												
// 										
									%>
									<tr>
										<td><%=i++%></td>
										<td><%=rs.getString("employeename")%></td>
										<td><%=rs.getString("orderdate")%></td>
										<td><%=rs.getFloat("amount")%></td>
										<td>
											<form action="Admin/singleOrder.jsp?orderid=<%= rs.getString("orderid") %>" method="GET"
												>

												<input type="hidden" value="<%=rs.getString("orderid")%>"
													name="orderid">
												<button type="submit" class="btn btn-info btn-sm">
													<i  class="fa fa-eye fa-lg " ></i>
												</button>
											</form>
										</td>
									</tr>
									<%
										}
									%>



								</tbody>
								<%
									} else {
										rs = st.executeQuery(
"SELECT DATE_FORMAT(o.orderdate, '%d-%m-%Y') AS orderdate,o.orderid,e.name as employeename, o.totalAmt as amount FROM orders o INNER JOIN employee e ON e.eid=o.eid ");			
										%>
								<tbody>
									<%
										while (rs.next()) {
									%>

									<%} %>
								</tbody>
								<%
									}
								%>
								<tfoot>
									<tr>
										<th>Sr.No</th>
										<th>Employee Name</th>
										<th>Order Date</th>
										<th>Amount</th>
										<th>Action</th>
									</tr>
								</tfoot>
							</table>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
</section>

<%@ include file="footer.jsp"%>