<%@page import="java.sql.*"%>
<%@page import="com.model.C3P0DataSource"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp"%>
<section class="content-header">
	<h1>Doctor</h1>
	<!-- <ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li><a href="#">Forms</a></li>
		<li class="active">General Elements</li>
	</ol> -->
</section>
<form name="addnewdoctor" method="post" action="<%=rootpath%>SaveData">
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
		<div class="box box-default">
			<div class="box-header with-border">
				<h3 class="box-title">Add New Doctor</h3>

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
					<div class="col-md-6">
						<div class="form-group">
							<label>Name</label><i class="form_mandatory">*</i> <input
								type="text" autocomplete="off" class="form-control"
								placeholder="Enter name" name="name" required>
						</div>
						<div class="form-group">
							<label for="Status">Gender</label>
							<div class="radio">
								<label> <input type="radio" name="gender"
									id="optionsRadios2" value="male" required checked="checked">Male
								</label> <label> <input type="radio" name="gender"
									id="optionsRadios2" value="female" required>Female
								</label>
							</div>
						</div>
						<!-- /.form-group -->
						<div class="form-group">
							<label>Clinic Phone No.</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-phone"></i></span>
								<input type="number" class="form-control" autocomplete="off"
									placeholder="Clinic Phone no." name="mobile">
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<label>Date of Birth</label> <i class="form_mandatory">*</i>
							<div class="input-group date">
								<div class="input-group-addon">
									<i class="fa fa-calendar"></i>
								</div>
								<input type="text" class="form-control pull-right datepicker"
									id="addDoctor_datepicker1" name="dob" autocomplete="off"
									onselect="_calculateAge()" data-date-end-date="-18y" required>
							</div>
							<!-- /.input group -->
						</div>
						<div class="form-group">
							<label>Age</label> <input type="text" class="form-control"
								placeholder="Age" name="age" id="doctors_age" autocomplete="off"
								disabled="disabled">
						</div>
						<div class="form-group">
							<label>Date Of Anniversary</label>

							<div class="input-group date">
								<div class="input-group-addon">
									<i class="fa fa-calendar"></i>
								</div>
								<input type="text" class="form-control pull-right datepicker"
									autocomplete="off" id="addDoctor_datepicker2" name="doa">
							</div>
							<!-- /.input group -->
						</div>
					</div>

				</div>
			</div>
			<!-- /.box-body -->
		</div>
		<div class="box box-default">
			<div class="box-header with-border">
				<h3 class="box-title">Office details</h3>

				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool"
						data-widget="collapse">
						<i class="fa fa-minus"></i>
					</button>

				</div>
			</div>
			<div class="box-body">
				<div class="row">
					<div class="col-md-6">
						<div class="row">
							<div class="col-md-12">

								<!-- /.form-group -->
							</div>
							<!-- /.col -->
						</div>
						<!-- /.row -->
						<div class="row">
							<div class="col-md-12">
								<%
									ResultSet rs = null;
									Connection con = C3P0DataSource.getInstance().getConnection();
									rs = con.createStatement().executeQuery("select haid, headquarter from headquarters");
								%>

								<div class="form-group">
									<label>Headquarter</label><i class="form_mandatory">*</i> <select
										class="form-control select2" style="width: 100%;"
										name="headquarter" required="required">
										<option selected="selected" disabled="disabled">Select
											Headquarter</option>
										<%
											while (rs.next()) {
										%>
										<option value="<%=rs.getInt("haid")%>"><%=rs.getString("headquarter")%></option>
										<%
											}
										%>
									</select>
								</div>
								<!-- /.form-group -->
							</div>
							<!-- /.col -->
						</div>
						<!-- /.row -->
						<div class="row">
							<div class="col-md-12">
								<div class="form-group">
									<label>Address</label>
									<textarea class="form-control" rows="5" placeholder="Enter ..."
										autocomplete="off" name="address"></textarea>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="row">
							<div class="col-md-12">
								<div class="form-group">
									<label>Clinic Phone No.</label>
									<div class="input-group">
										<span class="input-group-addon"><i class="fa fa-phone"></i></span>
										<input type="number" class="form-control" autocomplete="off"
											placeholder="Clinic Phone no." name="clinicphone">
									</div>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label>From</label>
									<div class="input-group">
										<span class="input-group-addon"><i
											class="fa fa-clock-o"></i></span> <input type="text"
											autocomplete="off" class="form-control timepicker"
											placeholder="" name="mortimefrom">
									</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>To</label>
									<div class="input-group">
										<span class="input-group-addon"><i
											class="fa fa-clock-o"></i></span> <input type="text"
											class="form-control timepicker" placeholder=""
											autocomplete="off" name="mortimeto">
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label>From</label>
									<div class="input-group">
										<span class="input-group-addon"><i
											class="fa fa-clock-o"></i></span> <input type="text"
											autocomplete="off" class="form-control timepicker"
											placeholder="" name="evetimefrom">
									</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>To</label>
									<div class="input-group">
										<span class="input-group-addon"><i
											class="fa fa-clock-o"></i></span> <input type="text"
											autocomplete="off" class="form-control timepicker"
											placeholder="" name="evetimeto">
									</div>
								</div>
							</div>
						</div>
						<div class="row">

							<div class="col-md-6">
								<div class="form-group">
									<label>Latitude</label><i class="form_mandatory">*</i>
									<div class="input-group">
										<span class="input-group-addon"><i
											class="fa fa-map-marker" style="font-size: 20px"></i></span> <input
											type="text" autocomplete="off" class="form-control "
											placeholder="Latitude" name="latitude" required>
									</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Longitude</label><i class="form_mandatory">*</i>
									<div class="input-group">
										<span class="input-group-addon"><i
											class="fa fa-map-marker" style="font-size: 20px"></i></span> <input
											type="text" autocomplete="off" class="form-control "
											placeholder="Longitude" name="longitude" required>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="box box-default">
			<div class="box-header with-border">
				<h3 class="box-title">Professional Details</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool"
						data-widget="collapse">
						<i class="fa fa-minus"></i>
					</button>

				</div>
			</div>
			<div class="box-body">
				<div class="row">
					<div class="col-md-6">
						<div class="row">
							<div class="col-md-12">
								<div class="form-group">
									<label>Degree</label><i class="form_mandatory">*</i> <select
										class="form-control select2" style="width: 100%;"
										name="degree" required>
										<option selected="selected">Select Degree</option>
										<option value="MBBS">MBBS</option>
										<option value="MS">MS</option>
										<option value="MD">MD</option>
										<option value="BDS">BDS</option>
										<option value="BHMS">BHMS</option>

									</select>
								</div>
								<!-- /.form-group -->
							</div>
							<!-- /.col -->
						</div>
						<!-- /.row -->
						<div class="row">
							<div class="col-md-12">
								<div class="form-group">
									<label for="contactnumber">Specialty</label> <input type="text"
										class="form-control" id="contactnumber" autocomplete="off"
										placeholder="Enter Specialtity" name="speciality">
								</div>
								<!-- /.form-group -->
							</div>
							<!-- /.col -->
						</div>
						<!-- /.row -->
						<div class="row">
							<div class="col-md-12">
								<div class="form-group">
									<label>Grade</label><i class="form_mandatory">*</i> <select
										class="form-control select2" style="width: 100%;" name="grade"
										required>
										<option selected="selected" disabled="disabled">Select
											Grade</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
									</select>
								</div>
								<!-- /.form-group -->
							</div>
							<!-- /.col -->
						</div>
						<!-- /.row -->
					</div>
					<div class="col-md-6">

						<!-- /.row -->
						<div class="row">
							<div class="col-md-12">
								<div class="form-group">
									<label for="Status">Status</label>
									<div class="radio">
										<label> <input type="radio" name="activepassive"
											checked="checked" id="optionsRadios1" value="Active">Active
										</label> <label> <input type="radio" name="activepassive"
											id="optionsRadios1" value="Inactive">Inactive
										</label>
									</div>
								</div>
							</div>
							<!-- /.form-group -->

							<div class="form-group">
								<div class="col-md-12">
									<label>Focused Product</label> <select
										class="form-control select2" multiple="multiple"
										name="pname[]" style="width: 100%;"
										data-placeholder="Select Focused Product">
										<%
											rs = con.createStatement().executeQuery("select pid, pname from product");
											while (rs.next()) {
												String pname1 = rs.getString("pname");
										%>
										<option value="<%=rs.getInt("pid")%>"><%=pname1%></option>
										<%
											}
										%>

									</select>
								</div>
							</div>

						</div>
					</div>
				</div>
			</div>
			<div class="box-footer">
				<button type="submit" class="btn btn-primary pull-right" name="flag"
					value="ADD">Submit</button>
			</div>
		</div>


	</section>
</form>


<%@ include file="footer.jsp"%>