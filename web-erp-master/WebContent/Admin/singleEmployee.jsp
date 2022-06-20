<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.Employee.Objects.GetData"%>
<%@page import="com.model.C3P0DataSource"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp"%>

<%
	int eid = 0;
	String S_eid = request.getParameter("eid");
	if (S_eid != null) {
		eid = Integer.parseInt(S_eid);
	} else {
		response.sendRedirect("500.jsp");
	}
	Connection con = C3P0DataSource.getInstance().getConnection();
	Statement st = con.createStatement();
	ResultSet rs = null;
	String q = "select *, DATE_FORMAT(dob, '%d-%m-%Y') as dobF, DATE_FORMAT(doj, '%d-%m-%Y') as dojF from employee where eid='" + eid + "'";
	rs = st.executeQuery(q);
	System.out.println(q);
%>
<%
				
				ResultSet rst= null;
				String sql="SELECT e.eid,e.haid,h.headquarter FROM employee e INNER JOIN headquarters h ON e.haid=h.haid WHERE e.eid = '"+eid +"'   ";
				rst=st.executeQuery(sql);
				System.out.println(sql);
				
				ArrayList<Integer> list=new ArrayList<Integer>();
				
				%>

<section class="content-header">
	<h1>Employees</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Single Employee</li>
	</ol>
</section>


<section class="content">
	<%
	String msg = null;
	msg = request.getParameter("res");
	if (msg != null && msg.equals("success")) {
	%>
	<div class="callout callout-info fadeout">
		<h4>Success!</h4>
		<p>Data Updated Successfully</p>
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
	<div class="box box-solid">
		<div class="box-header with-border">
			<i class="fa fa-user"></i>
			<h3 class="box-title"></h3>
			<a href="javascript:void(0)" onclick="toggle_edit()"
				class="btn btn-primary pull-right" id="toggle_button"
				style="display: block;">Edit</a> <a href="javascript:void(0)"
				onclick="toggle_edit()" class="btn btn-primary pull-right"
				id="toggle_button_2" style="display: none;">Cancel</a>
		</div>
		
		<div class="box-body" id="box1" style="display: block;">
			<label style="font-size: 18px; text-decoration: underline;">Personal
				Details</label>
			<%
				while (rs.next()) {
			%>
			<dl class="dl-horizontal">
				<dt>Name</dt>
				<dd><%=rs.getString("name")%></dd>
				<dt>Gender</dt>
				<dd><%=rs.getString("gender")%></dd>
				<dt>Date Of Birth</dt>
				<dd><%=rs.getString("dobF")%></dd>
			</dl>
			<hr>
			<label style="font-size: 18px; text-decoration: underline;">Contact
				Details</label>
			<dl class="dl-horizontal">
				<dt>Contact No.</dt>
				<dd><%=rs.getString("mobile")%></dd>
				<dt>Email</dt>
				<dd><%=rs.getString("email")%></dd>
				<dt>Headquarter</dt>
				<dd><%
									while(rst.next()){
										
										list.add(rst.getInt("haid"));
									out.println(rst.getString("headquarter")+", ");
									}%>
									</dd>
				<dt>Present Address</dt>
				<dd><%=rs.getString("presentaddress")%></dd>
				<dt>Permanent Address</dt>
				<dd><%=rs.getString("permanentaddress")%></dd>
				<dt>Emergency Contact No.</dt>
				<dd><%=rs.getString("emergencycontact")%></dd>
			</dl>
			<hr>
			<label style="font-size: 18px; text-decoration: underline;">Professional Details</label>
			<dl class="dl-horizontal">
				<dt>Date of Joining</dt>
				<dd><%=rs.getString("dojF")%></dd>
				<dt>Education</dt>
				<dd><%=rs.getString("education")%></dd>
				<dt>Employee Type</dt>
				<dd><%=rs.getString("emptype")%></dd>
				<dt>Designation</dt>
				<dd><%=rs.getString("designation")%></dd>

				<dt>License No.</dt>
				<dd><%=rs.getString("licenseno")%></dd>
				<dt>Insurance Covered</dt>
				<dd><%=rs.getString("insurancecovered")%></dd>
				<dt>Bank Details</dt>
				<dd><%=rs.getString("bankdetails")%></dd>
				<dt>Status</dt>
				<dd><%=rs.getString("isactive")%></dd>

			</dl>
		</div>
		
		<form action="<%=rootpath%>EmployeeSave" method="post">
			<input type="hidden" name="id" value="<%=eid%>">
			<div class="box-body" id="box2" style="display: none;">

				<div class="row">
					<div class="col-md-4">
						<label style="font-size: 18px; text-decoration: underline;">Personal
							Details</label>
						<div class="form-group">
							<label>Name</label> <input type="text" class="form-control"
								placeholder="Enter Name" name="name" autocomplete="off"
								value="<%=rs.getString("name")%>">
						</div>
						<div class="form-group">
							<label for="exampleInputPassword1">User Name</label> <input
								type="text" autocomplete="off" class="form-control"
								id="exampleInputusername1" placeholder="User Name" name="uname"
								value="<%=rs.getString("username")%>">
						</div>
						<div class="form-group">
							<label>Date of Birth</label>

							<div class="input-group date">
								<div class="input-group-addon">
									<i class="fa fa-calendar"></i>
								</div>
								<input type="text" autocomplete="off" class="form-control pull-right datepicker" id="addEmployee_datepicker1" name="dob" value="<%=rs.getString("dobF")%>" data-date-end-date="-18y">
							</div>
							<!-- /.input group -->
						</div>
						<div class="form-group">
							<label>Date of Joining</label>

							<div class="input-group date">
								<div class="input-group-addon">
									<i class="fa fa-calendar"></i>
								</div>
								<input type="text" autocomplete="off"
									class="form-control pull-right datepicker" id="updateEmployee_datepicker2" name="doj" value="<%=rs.getString("dojF")%>">
							</div>
							<!-- /.input group -->
						</div>
						<div class="form-group">
							<label for="contactnumber">Age</label> <input type="number"
								class="form-control" placeholder="Age" name="age"
								value="<%=rs.getString("age")%>">
						</div>
						<div class="form-group">
							<label for="Gender">Gender</label>
							<div class="radio">
								<label> <input type="radio" name="gender" value="male"
									<%=rs.getString("gender").equals("male") ? "checked='checked'" : ""%>>Male
								</label> <label> <input type="radio" name="gender"
									value="female"
									<%=rs.getString("gender").equals("female") ? "checked='checked'" : ""%>>Female
								</label>
							</div>
							<!-- /.form-group -->
						</div>
					</div>
					<div class="col-md-4">
						<label style="font-size: 18px; text-decoration: underline;">Contact
							Details</label>
						<div class="form-group">
							<label for="contactnumber">Contact Number</label> <input
								type="number" class="form-control" id="contactnumber"
								autocomplete="off" placeholder="Contact Number"
								value="<%=rs.getString("mobile")%>" name="mobile">
						</div>
						<div class="form-group">
							<label for="econtactnumber">Emergency Contact Number</label> <input
								type="number" class="form-control" id="econtactnumber"
								autocomplete="off" placeholder="Emergenct Contact Number"
								value="<%=rs.getString("emergencycontact")%>"
								name="emergencycontact">
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">Email</label> <input type="email"
								class="form-control" id="exampleInputEmail1" autocomplete="off"
								placeholder="Enter email" name="email"
								value="<%=rs.getString("email")%>">
						</div>
						<%
							ResultSet internal_rs = null;
							Statement internalSt = con.createStatement();
							internal_rs = internalSt.executeQuery("select haid, headquarter from headquarters");
						%>
						<div class="form-group">
							<label>Headquarter</label> <select class="form-control select2"
								style="width: 100%;" name="area">
								<option disabled="disabled">Select Headquarter</option>
								<%
									while (internal_rs.next()) {
								%>
								<option
									<%=rs.getString("haid").equals(internal_rs.getString("haid")) ? "selected='selected'" : ""%>
									value="<%=internal_rs.getInt("haid")%>"><%=internal_rs.getString("headquarter")%></option>
								<%
									}
								%>
							</select>
						</div>
						<div class="form-group">
							<label>Present Address</label>
							<textarea class="form-control" rows="1" autocomplete="off"
								placeholder="Enter Present Address ..." name="presentaddress"><%=rs.getString("presentaddress")%></textarea>
						</div>

						<div class="form-group">
							<label>Permanent Address</label>
							<textarea class="form-control" rows="1" autocomplete="off"
								placeholder="Enter Permanent Address..." name="permanentaddress"><%=rs.getString("permanentaddress")%></textarea>
						</div>

					</div>
					<div class="col-md-4">
						<label style="font-size: 18px; text-decoration: underline;">Professional
							Details</label>
						<div class="form-group">
							<label for="exampleInputEmail1">Education</label> <input
								type="text" class="form-control" name="education"
								autocomplete="off" value="<%=rs.getString("education")%>">
						</div>
						<div class="form-group">
							<label>License Number</label> <input type="text"
								autocomplete="off" class="form-control"
								value="<%=rs.getString("licenseno")%>" name="licenseno">
						</div>
						<div class="form-group">
							<label>Aadhar Number</label> <input type="text"
								autocomplete="off" class="form-control"
								value="<%=rs.getString("aadhar")%>" name="aadharnumber">
						</div>
						<div class="form-group">
							<label>Pan Number</label> <input type="text" autocomplete="off"
								class="form-control" value="<%=rs.getString("pan")%>"
								name="pannumber">
						</div>
						<div class="form-group">
							<label for="Status">Employee Type</label>
							<div class="radio">
								<label> <input type="radio" name="emptype"
									value="Temporary"
									<%=rs.getString("emptype").equals("Temporary") ? "checked='checked'" : ""%>>Temporary
								</label> <label> <input type="radio" name="emptype"
									value="Permanent"
									<%=rs.getString("emptype").equals("Permanent") ? "checked='checked'" : ""%>>Permanent
								</label>
							</div>
							<!-- /.form-group -->
						</div>
						<div class="form-group">
							<label>Designation</label> <input type="text"
								class="form-control" name="designation"
								value="<%=rs.getString("designation")%>">
						</div>
						<div class="form-group">
							<label>Insurance Covered</label>
							<div class="radio">
								<label> <input type="radio" name="insurancecovered"
									value="Yes"
									<%=rs.getString("insurancecovered").equals("Yes") ? "checked='checked'" : ""%>>Yes
								</label> <label> <input type="radio" name="insurancecovered"
									value="No"
									<%=rs.getString("insurancecovered").equals("No") ? "checked='checked'" : ""%>>No
								</label>
							</div>
							<!-- /.form-group -->
						</div>
						<div class="form-group">
							<label for="Status">Status</label>
							<div class="radio">
								<label> <input type="radio" name="isactive"
									value="Active"
									<%=rs.getString("isactive").equals("Active") ? "checked='checked'" : ""%>>Active
								</label> <label> <input type="radio" name="isactive"
									value="Inactive"
									<%=rs.getString("isactive").equals("Inactive") ? "checked='checked'" : ""%>>Inactive
								</label>
							</div>
						</div>
						<div class="form-group">
							<label>Bank Details</label>
							<textarea class="form-control" rows="1" name="bankdetails"><%=rs.getString("bankdetails")%></textarea>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<button type="submit" class="btn btn-danger" name="flag"
						value="Delete">Delete</button>
					<button type="submit" class="btn btn-success pull-right"
						name="flag" value="update">Update</button>
				</div>
			</div>
		</form>
		<%
			}
		%>

	</div>
	<!-- /.box -->

</section>


<%@ include file="footer.jsp"%>