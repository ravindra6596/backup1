<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.model.C3P0DataSource"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp"%>
<%
	ResultSet rs = null;
Connection con = C3P0DataSource.getInstance().getConnection();
	Statement st = con.createStatement();
%>
<section class="content-header">
	<h1>
		User Activity <small>Data</small>
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
					<h3 class="box-title">All User Activity</h3>
				</div>
				<!-- /.box-header -->
				<div class="box-body">
					<form method="post">
						<div class="row">
							<div class="col-md-3">
								<div class="form-group">
									<div class="input-group date">

										<div class="input-group-addon">
											<i class="fa fa-calendar"></i><i class="form_mandatory">*</i>
										</div>
										<input type="text" class="form-control pull-right monthpicker"
											id="" name="daterange" autocomplete="off" required>
									</div>
									<!-- /.input group -->
								</div>
							</div>
							<div class="col-md-2">
								<%
									rs = st.executeQuery("select eid , name from employee where usertype = 'TM'");
								%>
								<select class="form-control select2" multiple="multiple"
									name="ua.eid" data-placeholder="Select Employee"
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
					<div class="row">
						<div class="col-md-9">
							<table id="example1" class="table table-bordered table-striped ">
								<thead>
									<tr>
										<th>Sr.No</th>
										<th>Employee Name</th>
										<th>Place Type</th>
										<th>Acivity Date</th>
										<th>Action</th>

									</tr>
								</thead>
								<%
									String search = request.getParameter("search");
									String query1 = "SELECT DATE_FORMAT(ua.created_at, '%d-%m-%Y') AS activitydate ,ua.aid,e.name as employeename,ua.place_type as place FROM user_activity ua INNER JOIN employee e ON e.eid=ua.eid where ua.created_at BETWEEN ";
									String whr = "";
									String cquery = null;
									if (search != null) {
										String date = request.getParameter("daterange");
										String[] range = date.split(" - ");
										String from = range[0];
										String to = range[1];
										SimpleDateFormat formater = new SimpleDateFormat("dd-MM-yyyy");
										Date fromdate = formater.parse(from);
										SimpleDateFormat AppDateFormat = new SimpleDateFormat("yyyy-MM-dd");
										String date1 = AppDateFormat.format(fromdate);

										SimpleDateFormat todate = new SimpleDateFormat("dd-MM-yyyy");
										Date todate1 = todate.parse(to);
										SimpleDateFormat AppDateFormat1 = new SimpleDateFormat("yyyy-MM-dd");
										String date2 = AppDateFormat1.format(todate1);

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
													whr = whr + "" + key + " = '" + value[i] + "' OR ";
												}
											} else {
												if (key.equalsIgnoreCase("daterange"))
													whr = whr + "  '" + date1 + "' AND'" + date2 + "'  OR ";
												else
													whr = whr + key + "='" + value[0] + "' OR ";
											}
											whr = whr.substring(0, whr.length() - 3) + " AND ";
										}
										query1 = query1 + whr.substring(0, whr.length() - 27);
										System.out.println(query1);

										rs = st.executeQuery(query1);
										int i = 1;
								%>
								<tbody>
									<%
										while (rs.next()) {
												ResultSet rs1 = null;
												Statement st1 = con.createStatement();
									%>
									<tr>
										<td><%=i++%></td>
										<td><%=rs.getString("employeename")%></td>
										<td><%=rs.getString("place")%></td>
										<td><%=rs.getString("activitydate")%></td>
										<td>
											<form
												action="Admin/singleUserActivity.jsp?aid=<%=rs.getString("aid")%>"
												method="GET">

												<input type="hidden" value="<%=rs.getString("aid")%>"
													name="aid">
												<button type="submit" class="btn btn-info btn-sm">
													<i class="fa fa-eye fa-lg "></i>
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
												"SELECT DATE_FORMAT(ua.created_at, '%d-%m-%Y') AS activitydate ,ua.aid,e.name as employeename,ua.place_type as place FROM user_activity ua INNER JOIN employee e ON e.eid=ua.eid");
								%>
								<tbody>
									<%
										while (rs.next()) {
									%>

									<%
										}
									%>
								</tbody>
								<%
									}
								%>
								<tfoot>
									<tr>
										<th>Sr.No</th>
										<th>Employee Name</th>
										<th>Place Type</th>
										<th>Activity Date</th>
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