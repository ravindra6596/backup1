<%@page import="org.apache.taglibs.standard.lang.jstl.BeanInfoManager"%>
<%@page import="com.model.C3P0DataSource"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.ResultSet" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ include file="header.jsp"%>

<section class="content-header">
	<h1>Add Employee</h1>
	
	<section class="content">
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
		<form action="<%= rootpath %>EmployeeSave" method="post">
			<div class="box box-default">
				<div class="box-header with-border">
					<h3 class="box-title">Login Details..</h3>

					<div class="box-tools pull-right">
						<button type="button" class="btn btn-box-tool"
							data-widget="collapse">
							<i class="fa fa-minus"></i>
						</button>

					</div>
				</div>
				<!-- /.box-header -->
				<div class="box-body">
					<div class="row">
						<div class="col-md-4">
							<div class="form-group">
								<label for="exampleInputPassword1">User Name</label><i class="form_mandatory">*</i> 
								<input type="text" autocomplete="off" class="form-control" id="exampleInputusername1" placeholder="User Name" name="uname" required>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="exampleInputPassword1">Password</label><i class="form_mandatory">*</i>
								<input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password" name="password" required>
							</div>
						</div>
					</div>
				</div>
				<!-- /.box-body -->
			</div>
			<!-- /.box -->
			<div class="box box-default">
				<div class="box-header with-border">
					<h3 class="box-title">Contact Details..</h3>

					<div class="box-tools pull-right">
						<button type="button" class="btn btn-box-tool" data-widget="collapse">
							<i class="fa fa-minus"></i>
						</button>
					</div>
				</div>
				<!-- /.box-header -->
				<div class="box-body">
					<div class="row">
						<div class="col-md-4">
							<div class="form-group">
								<label>Name</label><i class="form_mandatory">*</i>
								<input type="text" autocomplete="off"  class="form-control" placeholder="Enter Name" name="name" required>
							</div>
							<div class="form-group">
								<label>Date of Birth</label>
								<i class="form_mandatory">*</i>
								<div class="input-group date">
									<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
									<input type="text" autocomplete="off" class="form-control pull-right datepicker" id="addEmployee_datepicker1" name="dob" data-date-end-date="-18y" required>
								</div>
							</div>
							<div class="form-group">
								<label for="contactnumber">Age</label>
								<input type="number" class="form-control" placeholder="Age" name="age" id="addEmployee_age" required>
							</div>
							<div class="form-group">
								<label for="Status">Gender</label><i class="form_mandatory">*</i>
								<div class="radio">
									<label> <input type="radio" name="gender" value="male" required checked="checked">Male</label>
									<label> <input type="radio" name="gender" value="female" required>Female</label>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="exampleInputEmail1">Email</label>
								<input type="email" autocomplete="off" class="form-control" id="exampleInputEmail1" placeholder="Enter email" name="email">
							</div>
							<div class="form-group">
								<label for="contactnumber">Contact Number</label>
								<input type="number" autocomplete="off" name="mobile" class="form-control" id="contactnumber" placeholder="Contact Number" maxlength="15"  >
							</div>
							
							<div class="form-group">
								<label for="econtactnumber">Emergency Contact Number</label>
								<input type="number" autocomplete="off"  class="form-control" id="econtactnumber" placeholder="Emergenct Contact Number" name="emergencycontact">
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label>Present Address</label><i class="form_mandatory">*</i>
								<textarea class="form-control"  autocomplete="off" rows="3" placeholder="Enter Present Address ..." name="presentaddress" required></textarea>
							</div>
							<div class="form-group">
								<label>Permanent Address</label>
								<textarea class="form-control"  autocomplete="off" rows="3" placeholder="Enter Permanent Address..." name="permanentaddress"></textarea>
							</div>
						</div>
					</div>
				</div>
				<!-- /.box-body -->
			</div>
			<!-- /.box -->
			<div class="box box-default">
				<div class="box-header with-border">
					<h3 class="box-title">Professional Details..</h3>

					<div class="box-tools pull-right">
						<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
					</div>
				</div>
				<!-- /.box-header -->
				<div class="box-body">
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="econtactnumber">Designation</label> 
								<input type="text"  autocomplete="off" class="form-control" placeholder="Enter Designation" name="designation">
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label>Date of Joining</label>
								<i class="form_mandatory">*</i>
								<div class="input-group date">
									<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
									<input type="text"  autocomplete="off" class="form-control pull-right datepicker" id="addEmployee_datepicker2" name="doj" required>
								</div>
							</div>
						</div>
						<div class="col-md-4">
								<%
									ResultSet rst = null;
										Connection con = C3P0DataSource.getInstance().getConnection();
								rst = con.createStatement().executeQuery("select haid, headquarter from headquarters");
								%>

								<div class="form-group">
									<label>Headquarter</label><i class="form_mandatory">*</i> <select
										class="form-control select2" style="width: 100%;"
										name="headquarter" multiple="multiple" required="required"
										data-placeholder="Select Headquarter">
										<%
											while (rst.next()) {
										%>
										<option value="<%=rst.getInt("haid")%>"><%=rst.getString("headquarter")%></option>
										<%
											}
										%>
									</select>
								</div>
								<!-- /.form-group -->
							</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="Status">Employee Type</label>
								<div class="radio">
									<label> <input type="radio" name="emptype"
										value="Temporary" checked="checked">Temporary
									</label> <label> <input type="radio" name="emptype"
										value="Permanent">Permanent
									</label>
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="aadharnumber">Aadhar No.</label> <input
									type="text" class="form-control" placeholder="Aadhar Number" autocomplete="off"  name="aadharnumber" maxlength="12">
							</div>
							<div class="form-group">
								<label for="pannumber">Pan No.</label> <input
									type="text" class="form-control"
									placeholder="Pan Number" autocomplete="off"  name="pannumber">
							</div>
							<div class="form-group">
								<label for="econtactnumber">License Number</label> 
								<input type="text" autocomplete="off"  class="form-control" placeholder="License Number" name="licenseno">
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label>Education</label><i class="form_mandatory">*</i> 
								<input type="text" autocomplete="off"  class="form-control" placeholder="Enter Name" name="education" required>
							</div>
							<div class="form-group">
								<label>Bank Details</label>
								<textarea class="form-control"  autocomplete="off" rows="2" placeholder="Enter Bank Details ..." name="bankdetails"></textarea>
							</div>
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="Status">Insurance Covered</label>
										<div class="radio">
											<label> <input type="radio" name="insurancecovered" value="Yes" checked="checked">Yes</label> 
											<label> <input type="radio" name="insurancecovered" value="No">No</label>
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="Status">Employment Status</label>
										<div class="radio">
											<label> <input type="radio" name="isactive" value="Active" checked="checked">Active </label> 
											<label> <input type="radio" name="isactive" value="Inactive" >Inactive </label>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- /.box-body -->
				<div class="box-footer">
					<button type="submit" class="btn btn-primary pull-right"
						name="flag" value="ADD">Submit</button>
				</div>
			</div>
			<!-- /.box -->
		</form>
	</section>
</section>
<%@ include file="footer.jsp"%>