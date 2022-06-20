<%@page import="java.sql.Statement"%>
<%@page import="com.controller.SampleController"%>
<%@page import=" java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import=" java.util.Date"%>
<%@page import=" java.util.HashMap"%>
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
			.executeQuery("select haid, headquarter from headquarters order by haid ");
	String submit = request.getParameter("submit");

	Statement stmt = con.createStatement();
	ResultSet rs;
%>
<%
	String msg = null;
	msg = request.getParameter("response");
	if (msg != null && msg.equals("success")) {
%>
<div class="callout callout-info fadeout">
	<h4>Success!</h4>
	<p>Data Inserted Successfully</p>
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




<%
	int fy1, fy2;
	String y = request.getParameter("year");
	
	if (y != null) {
		String[] gyears = y.split("-");
		fy1 =Integer.parseInt(gyears[0]) ;
		fy2 = Integer.parseInt(gyears[1]) ;
	} else {

		LocalDate currentdate = LocalDate.now();
		int month = currentdate.getMonthValue();
		int year = currentdate.getYear();

		if (month < 4) {
			fy1 = (year - 1);
			fy2 = year;
		} else {
			fy1 = year;
			fy2 = year + 1;
		}
	}

	//System.out.println("Current Year=" + year + "\n Current Month=" + month);
	
	String curYear = fy1 + "-" + fy2;
		//System.out.println("Current Finance Year: " + curYear + "\nfy1=" + fy1 + "\nfy2=" + fy2);

	String date1 = fy1 + "-04-01";
	String date2 = fy2 + "-03-31";
	
	
	Map<Integer, Map<String, String>> tarTable = new HashMap<Integer, Map<String, String>>();
	Map<Integer,String>hqname=new HashMap<Integer,String>();
	while (rstmname.next()) {
		tarTable.put(rstmname.getInt("haid"), getMonthsMap(fy1, fy2));
		hqname.put(rstmname.getInt("haid"), rstmname.getString("headquarter"));

		//System.out.println("Tar Table"+tarTable);
	}
	
	
	
	String query = "select * from target where( month between' " + date1 + " ' AND ' " + date2
			+ " ' )order by haid,month ";
	ResultSet rst = con.createStatement().executeQuery(query);

	System.out.println("Date1=" + date1 + "\ndate2=" + date2);
	System.out.println(query);

	while (rst.next()) {
		tarTable.get(rst.getInt("haid")).put(rst.getString("month"), rst.getString("amount"));
	}
%>







<section class="content-header">
	<h1>Target Management</h1>
</section>
<section class="content">
	<div class="box box-default">
		<div class="box-header with-border">
			<div class="box-tools pull-right">
				<i class="fa fa-minus"></i>

			</div>
		</div>

		<div class="box-body">
			<form action="" method="get">
				<div class="row">

					<div class="col-md-3">
						<div class="form-group">
							<label>Select FY Year:</label>

							<div class="input-group date">
								<div class="input-group-addon">
									<i class="fa fa-calendar"></i>
								</div>
								<select class="form-control select2"
									data-placeholder="Select FY year" name="year"
									required="required" style="width: 100%;">
									<option value="2020-2021"
										<%=curYear.equals("2020-2021") ? "selected" : ""%>>2020-21</option>
									<option value="2021-2022"
										<%=curYear.equals("2021-2022") ? "selected" : ""%>>2021-22</option>
									<option value="2022-2023"
										<%=curYear.equals("2022-2023") ? "selected" : ""%>>2022-23</option>
									<option value="2023-2024"
										<%=curYear.equals("2023-2024") ? "selected" : ""%>>2023-24</option>
									<option value="2024-2025"
										<%=curYear.equals("2024-2025") ? "selected" : ""%>>2024-25</option>
									<option value="2025-2026"
										<%=curYear.equals("2025-2026") ? "selected" : ""%>>2025-26</option>
									<option value="2026-2027"
										<%=curYear.equals("2026-2027") ? "selected" : ""%>>2026-27</option>
									<option value="2027-2028"
										<%=curYear.equals("2027-2028") ? "selected" : ""%>>2027-28</option>
									<option value="2028-2029"
										<%=curYear.equals("2028-2029") ? "selected" : ""%>>2028-29</option>
									<option value="2029-2030"
										<%=curYear.equals("2029-2030") ? "selected" : ""%>>2029-30</option>
								</select>

							</div>
							<!-- /.input group -->
						</div>
					</div>
					<div class="col-md-2">
						<div class="form-group">

							<button type="submit" class="btn btn-primary " name=""
								style="margin-top: 25px;">Search</button>
						</div>
					</div>
				</div>
			</form>


			<hr>
			<br> <br>

			<div class="row">
				<form action="<%=rootpath%>MultipleRecord" method="post">

					<div class="col-md-12">
						<div class="form-group">
							<h4>
								Selected Year: <label> <%=curYear%></label>
								<input type="hidden" name="year" value="<%=curYear%>">
							</h4>
						</div>
						<table id="" class="table table-bordered table-striped">
							<thead>
								<tr>
									<th rowspan="2" style="text-align: center; vertical-align: top">Headquarters</th>
									<th colspan="12" style="text-align: center;">Months</th>
								</tr>
								<tr>
									<th>April <%=fy1%></th>
									<th>May <%=fy1%></th>
									<th>Jun <%=fy1%></th>
									<th>July <%=fy1%></th>
									<th>August <%=fy1%></th>
									<th>Sept <%=fy1%></th>
									<th>Oct <%=fy1%></th>
									<th>Nov <%=fy1%></th>
									<th>Dec <%=fy1%></th>
									<th>Jan <%=fy2%></th>
									<th>Feb <%=fy2%></th>
									<th>March <%=fy2%></th>
								</tr>
							</thead>
							<tbody>
								<%
									for (Map.Entry<Integer, Map<String, String>> entry : tarTable.entrySet()) {
										//		System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());
										int haid = entry.getKey();
										//while (rstmname.next()) {
										//int eid = rstmname.getInt("eid");
								%>
								<tr>
									<td><%=hqname.get(haid)%></td>
									<%
										for (Map.Entry<String, String> entry1 : entry.getValue().entrySet()) {
									%>
									<td><input type="text" autocomplete="off" value="<%=entry1.getValue()%>"
										name="target[<%=haid%>][<%=entry1.getKey()%>]"
										class="form-control " size="1" /></td>

									<%
										}
									%>

								</tr>
								<%
									}
								%>
							</tbody>
						</table>
						<div class="box-footer">
							<button type="submit" class="btn btn-primary pull-right"
								name="submit" value="SUBMIT">Submit</button>
						</div>
					</div>
				</form>
			</div>


		</div>
	</div>
</section>

<%@ include file="footer.jsp"%>

<%!public Map<String, String> getMonthsMap(int fy1, int fy2) {
		Map<String, String> monthTars = new HashMap<String, String>();
		monthTars.put(fy1 + "-04-01", "0");
		monthTars.put(fy1 + "-05-01", "0");
		monthTars.put(fy1 + "-06-01", "0");
		monthTars.put(fy1 + "-07-01", "0");
		monthTars.put(fy1 + "-08-01", "0");
		monthTars.put(fy1 + "-09-01", "0");
		monthTars.put(fy1 + "-10-01", "0");
		monthTars.put(fy1 + "-11-01", "0");
		monthTars.put(fy1 + "-12-01", "0");
		monthTars.put(fy2 + "-01-01", "0");
		monthTars.put(fy2 + "-02-01", "0");
		monthTars.put(fy2 + "-03-01", "0");

		return monthTars;

	}%>