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
	<%
		String msg = null;
		msg = request.getParameter("response");

		if (msg != null && msg.equals("success")) {
	%>
	<div class="callout callout-info fadeout">
		<h4>Success!</h4>
		<p>Tour Updated Successfully</p>
	</div>
	<%
		} else if (msg != null && msg.equals("Success")) {
	%>
	<div class="callout callout-info fadeout">
		<h4>Success!</h4>
		<p>Data Deleted Successfully</p>
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

	<h1>
		Tours <small>Data</small>
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
					<h3 class="box-title">All Tours</h3>
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
										<input type="text" class="form-control pull-right monthdatepicker"
											id="datepicker" name="month" autocomplete="off"
											value="Select Month" required>
									</div>
									<!-- /.input group -->
								</div>
							</div>
							<div class="col-md-2">
								<%
									rs = st.executeQuery("select eid , name from employee where usertype = 'TM'");
								%>
								<select class="form-control select2" multiple="multiple"
									name="t.eid" data-placeholder="Select Employee"
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
							<div class="col-md-2">
								<%
									rs = st.executeQuery("select doctorid , name from doctors");
								%>
								<select class="form-control select2" multiple="multiple"
									name="t.doctorid" data-placeholder="Select Doctors"
									style="width: 100%;">
									<%
										while (rs.next()) {
									%>
									<option value="<%=rs.getInt("doctorid")%>"><%=rs.getString("name")%></option>
									<%
										}
									%>
								</select>
							</div>
							<div class="col-md-2">
								<%
									String hqry = "select haid,headquarter from headquarters";
									rs = st.executeQuery(hqry);
								%>
								<select class="form-control select2" multiple="multiple"
									name="d.haid" data-placeholder="Select Headquarter"
									style="width: 100%;">
									<%
										while (rs.next()) {
									%>
									<option value="<%=rs.getInt("haid")%>"><%=rs.getString("headquarter")%></option>
									<%
										}
									%>
								</select>
							</div>
							<div class="col-md-2">
								<select class="form-control select2" multiple="multiple"
									name="status" data-placeholder="Select status"
									style="width: 100%;">
									<option value="Visited">Visited</option>
									<option value="pending">Not Visited</option>
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
						<div class="col-md-12">
							<table id="example1" class="table table-bordered table-striped">
								<thead>
									<tr>
										<th>Tour ID</th>
										<th>Employee Name</th>
										<th>Doctor Name</th>
										<th>Date</th>
										<th>HeadQuarter</th>
										<th>Status</th>
										<th>Action</th>
									</tr>
								</thead>
								<%
									String search = request.getParameter("search");
									String month = request.getParameter("month");
									String query1 = "SELECT t.*, DATE_FORMAT(date, '%d-%m-%Y') as tourdate,d.name as docname, h.headquarter, e.name as empname FROM tourplan  t LEFT JOIN doctors d ON t.doctorid = d.doctorid LEFT JOIN headquarters h ON d.haid = h.haid LEFT JOIN employee e ON t.eid = e.eid where ";
									String whr = "(";
									String cquery = null;

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
													whr = whr + " DATE_FORMAT(t.date, '%m-%Y') = '" + month + "'  OR ";
												else
													whr = whr + key + "='" + value[0] + "' OR ";
											}
											whr = whr.substring(0, whr.length() - 4) + ") AND (";
										}
										query1 = query1 + whr.substring(0, whr.length() - 28);
										System.out.println(query1);

										rs = st.executeQuery(query1);
								%>
								<tbody>
									<%
										while (rs.next()) {
												ResultSet rs1 = null;
												Statement st1 = con.createStatement();
									%>
									<tr>
										<td><%=rs.getInt("tourid")%></td>
										<td><%=rs.getString("empname")%></td>
										<td><%=rs.getString("docname")%></td>
										<td><%=rs.getString("tourdate")%></td>
										<td><%=rs.getString("headquarter")%></td>
										<td><%=rs.getString("status")%></td>
										<td>
											<%
												if (rs.getString("approved").equals("1")) {
															out.print("Approved");
														} else if (rs.getString("approved").equals("2")) {
															out.print("Rejected");
														} else {
											%>
											<form action="GenerateTP" method="post"  onsubmit="return confirm('Are you sure you want to Approve ?')">
												<input type="hidden" value="<%=rs.getString("tourid")%>"
													name="tourid">
												<button type="submit" style="float: left;" class="btn btn-success btn-sm" name="flag" value="approve_tp">
													<i class="fa fa-check fa-lg" style="color: #FFFFFF;"></i>
												</button>
											</form>
											<form action="GenerateTP" method="post"  onsubmit="return confirm('Are you sure you want to Reject ?')">
												<input type="hidden"  value="<%=rs.getString("tourid")%>"
													name="tourid">
												<button  type="submit" style="float: right;" class="btn btn-danger btn-sm" name="flag" value="reject_tp">
													<i class="fa fa-close fa-lg" style="color: #FFFFFF;"></i>
												</button>
											</form>
										</td>
										<%
											}
										%>
									</tr>
									<%
										}
									%>



								</tbody>
								<%
									} else {
										rs = st.executeQuery(
												"SELECT t.*, DATE_FORMAT(date, '%d-%m-%Y') as tourdate, d.name as docname, h.headquarter, e.name as empname FROM tourplan  t LEFT JOIN doctors d ON t.doctorid = d.doctorid LEFT JOIN headquarters h ON d.haid = h.haid LEFT JOIN employee e ON t.eid = e.eid  ORDER BY STATUS");
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
										<th>Tour ID</th>
										<th>Employee Name</th>
										<th>Doctor Name</th>
										<th>Date</th>
										<th>HeadQuarter</th>
										<th>Status</th>
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