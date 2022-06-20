<%@page import="java.util.ArrayList"%>
<%@page import="com.Employee.Objects.GetData"%>
<%@page import="com.Admin.Classes.GetDoctorData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.model.C3P0DataSource"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ include file="header.jsp"%>
	<%
				Connection con = C3P0DataSource.getInstance().getConnection();
				Statement st =con.createStatement();
				ResultSet rst= null;
				int docid = Integer.parseInt(request.getParameter("id"));
				String sql=" SELECT product.pname,focusedproduct1.pid,focusedproduct1.doctorid from product inner join focusedproduct1 on product.pid=focusedproduct1.pid where focusedproduct1.doctorid=' "+docid +" '   ";
				rst=st.executeQuery(sql);
				System.out.println(sql);
				
				ArrayList<Integer> list=new ArrayList<Integer>();
				
				%>
<%
	String string_did = request.getParameter("id");
	int did = 0;
	ResultSet rs = null;
	
	if (string_did != null) {
		did = Integer.parseInt(string_did);
		rs = GetDoctorData.doctor_data(did);
	} else {
		response.sendRedirect("500.jsp");
	}
	
%>

<section class="content-header">
	<h1>Doctor Information</h1>
	<%
		String msg = null;
		msg = request.getParameter("response");
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
</section>
<section class="content">
	<div class="row">
		<div class="col-sm-12">
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
				<!-- /.box-header -->
				<%
					if (rs.next()) {
				%>
				<div class="box-body" id="box1" style="display: block;">

					<div class="row">
						<div class="col-md-6">
							<table class="table table-bordered ">
								<thead>
									<tr>
										<th>Details</th>
										<th>Data</th>
									</tr>
								</thead>
								<tbody>

									<tr>
										<td>Doctor's Name</td>
										<td><%=rs.getString("name")%></td>
									</tr>
									<tr>
										<td>Gender</td>
										<td><%=rs.getString("gender")%></td>
									</tr>
									<tr>
										<td>Headquarter</td>
										<td><%=GetData.area_name(rs.getInt("haid"))%></td>
									</tr>
									<tr>
										<td>Date of Birth</td>
										<td><%=rs.getString("dobF")%></td>
									</tr>
									<tr>
										<td>Date of Anniversary</td>
										<td><%=rs.getString("doaF")%></td>
									</tr>
									<tr>
										<td>Address</td>
										<td><%=rs.getString("address")%></td>
									</tr>
									<tr>
										<td>Clinic Phone No.</td>
										<td><%=rs.getString("clinicphone")%></td>
									</tr>
									<tr>
										<td>Mobile No.</td>
										<td><%=rs.getString("mobile")%></td>
									</tr>
									<tr>
										<td>Degree</td>
										<td><%=rs.getString("degree")%></td>
									</tr>
									<tr>
										<td>Grade</td>
										<td><%=rs.getString("grade")%></td>
									</tr>
									<tr>
										<td>Address</td>
										<td><%=rs.getString("address")%></td>
									</tr>

								</tbody>
							</table>
						</div>
						<div class="col-md-6">
							<table class="table table-bordered">
								<thead>
									<tr>
										<th>Details</th>
										<th>Data</th>
									</tr>
								</thead>
								<tbody>

									<tr>
										<td>Clinic Timings:</td>
										<td></td>
									</tr>
									<tr>
										<td>Morning</td>
										<td><%=rs.getString("mortimefrom")%> TO <%=rs.getString("mortimeto")%></td>
									</tr>
									<tr>
										<td>Evening</td>
										<td><%=rs.getString("evetimefrom")%> TO <%=rs.getString("evetimeto")%></td>
									</tr>

									<tr>
										<td>Clinic Location:</td>
										<td></td>
									</tr>
									<tr>
										<td>Latitude</td>
										<td><%=rs.getString("clinic_lat")%></td>
									</tr>
									<tr>
										<td>Longitude</td>
										<td><%=rs.getString("clinic_long")%></td>
									</tr>
								
									<tr>
										<td>Focused Product</td>
										<td>	<%
									while(rst.next()){
										list.add(rst.getInt("pid"));
									out.println(rst.getString("pname")+", ");
									}%></td>
									</tr>
									
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<form action="<%=rootpath%>SaveData" method="post">
					<input type="hidden" value="<%=did%>" name="did">
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
									<label>Gender</label> <input type="text" class="form-control"
										placeholder="Enter Name" name="gender"
										value="<%=rs.getString("gender")%>">
								</div>
								<div class="form-group">
									<label>Date of Birth</label>

									<div class="input-group date">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input type="text" class="form-control pull-right datepicker"
											id="updateDoctor_datepicker" name="dob" autocomplete="off"data-date-end-date="-18y" 
											value="<%=rs.getString("dobF")%>">
									</div>
									<!-- /.input group -->
								</div>
								<div class="form-group">
									<label>Date of Anniversary</label>

									<div class="input-group date">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input type="text" class="form-control pull-right datepicker"
											id="updateDoctor_datepicker2" name="doa" autocomplete="off"
											value="<%=rs.getString("doaF")%>">
									</div>
									<!-- /.input group -->
								</div>
								<div class="form-group">
									<label for="contactnumber">Contact Number</label> <input
										type="number" class="form-control" id="contactnumber"
										placeholder="Contact Number" autocomplete="off"
										value="<%=rs.getString("mobile")%>" name="mobile">
								</div>
							</div>
							<div class="col-md-4">
								<label style="font-size: 18px; text-decoration: underline;">Official
									Details</label>
								<div class="form-group">
									<label>Headquarter</label> <select class="form-control select2"
										style="width: 100%;" name="headquarter">
										<option selected="selected" disabled="disabled">Select
											Headquarter</option>
										<%
											ResultSet rs_area = GetData.Area();
												while (rs_area.next()) {
										%>
										<option value="<%=rs_area.getInt("haid")%>"
											<%=rs.getInt("haid") == rs_area.getInt("haid") ? "selected='selected'" : ""%>><%=rs_area.getString("headquarter")%></option>
										<%
											}
										%>
									</select>
								</div>
								<div class="form-group">
									<label>Clinic Phone No.</label>
									<div class="input-group">
										<span class="input-group-addon"><i class="fa fa-phone"></i></span>
										<input type="number" class="form-control"
											placeholder="Clinic Phone no." name="clinicphone"
											autocomplete="off" value="<%=rs.getString("clinicphone")%>">
									</div>
								</div>
								<div class="form-group">
									<label>Address</label>
									<textarea class="form-control" rows="1" placeholder="Enter ..."
										name="address"><%=rs.getString("address")%></textarea>
								</div>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label>From</label>
											<div class="input-group">
												<span class="input-group-addon"><i
													class="fa fa-clock-o"></i></span> <input type="text"
													class="form-control timepicker" autocomplete="off"
													value="<%=rs.getString("mortimefrom")%>" name="mortimefrom">
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label>To</label>
											<div class="input-group">
												<span class="input-group-addon"><i
													class="fa fa-clock-o"></i></span> <input type="text"
													class="form-control timepicker" autocomplete="off"
													value="<%=rs.getString("mortimeto")%>" name="mortimeto">
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
													class="form-control timepicker" autocomplete="off"
													value="<%=rs.getString("evetimefrom")%>" name="evetimefrom">
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label>To</label>
											<div class="input-group">
												<span class="input-group-addon"><i
													class="fa fa-clock-o"></i></span> <input type="text"
													class="form-control timepicker" autocomplete="off"
													value="<%=rs.getString("evetimeto")%>" name="evetimeto">
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label>Latitude</label>
											<div class="input-group">
												<span class="input-group-addon"><i
													class="fa fa-map-marker" style="font-size:20px"></i></span> <input type="text"
													class="form-control " autocomplete="off"
													value="<%=rs.getString("clinic_lat")%>" name="latitude">
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label>Longitude</label>
											<div class="input-group">
												<span class="input-group-addon"><i
													class="fa fa-map-marker" style="font-size:20px"></i></span> <input type="text"
													class="form-control " autocomplete="off"
													value="<%=rs.getString("clinic_long")%>" name="longitude">
											</div>
										</div>
									</div>
								</div>
								
							</div>
							<div class="col-md-4">
								<label style="font-size: 18px; text-decoration: underline;">Professional
									Details</label>
								<div class="form-group">
									<label>Degree</label> <select class="form-control select2"
										style="width: 100%;" name="degree">
										<option value="MBBS"
											<%=rs.getString("degree").equals("MBBS") ? "selected='selected'" : ""%>>MBBS</option>
										<option value="MS"
											<%=rs.getString("degree").equals("MS") ? "selected='selected'" : ""%>>MS</option>
										<option value="MD"
											<%=rs.getString("degree").equals("MD") ? "selected='selected'" : ""%>>MD</option>
										<option value="BDS"
											<%=rs.getString("degree").equals("BDS") ? "selected='selected'" : ""%>>BDS</option>
										<option value="BHMS"
											<%=rs.getString("degree").equals("BHMS") ? "selected='selected'" : ""%>>BHMS</option>

									</select>
								</div>
								<div class="form-group">
									<label for="contactnumber">Specialty</label> <input type="text"
										class="form-control" id="contactnumber"
										placeholder="Enter Specialtity" name="speciality"
										autocomplete="off" value="<%=rs.getString("speciality")%>">
								</div>


								<div class="form-group">
									<label>Grade</label><select class="form-control select2"
										style="width: 100%;" name="grade">

										<option value="1"
											<%=rs.getString("grade").equals("1") ? "selected='selected'" : ""%>>1</option>
										<option value="2"
											<%=rs.getString("grade").equals("2") ? "selected='selected'" : ""%>>2</option>
										<option value="3"
											<%=rs.getString("grade").equals("3") ? "selected='selected'" : ""%>>3</option>
										<option value="4"
											<%=rs.getString("grade").equals("4") ? "selected='selected'" : ""%>>4</option>
									</select>
								</div>
								
								<div class="form-group">
								<div class="col-md-12">
									<label>Focused Product</label> <select
										class="form-control select2" multiple="multiple"
										name="pname[]" style="width: 100%;"
										data-placeholder="Select Focused Product" >
										<%
										
											rst = con.createStatement().executeQuery("select pid, pname from product");
											while (rst.next()) {
												String pname1 = rst.getString("pname");
												int pid=rst.getInt("pid");
												String selected=list.indexOf(rst.getInt("pid")) != (-1) ? "selected" :" ";
										%>
										
										<option value="<%=pid%>"  <%= selected %>><%=pname1%></option>
										<%
											}
										%>

									</select>
								</div>
							</div>

								<div class="form-group">
									<label for="Status">Status</label>
									<div class="radio">
										<label> <input type="radio" name="activepassive"
											id="optionsRadios1" value="Active"
											<%=rs.getString("activepassive").equalsIgnoreCase("Active") ? "checked" : ""%>>Active
										</label> <label> <input type="radio" name="activepassive"
											id="optionsRadios1" value="Inactive"
											<%=rs.getString("activepassive").equalsIgnoreCase("Inactive") ? "checked" : ""%>>Inactive
										</label>
									</div>
								</div>
							</div>
						</div>


						<div class="box-footer">
							<button type="submit" class="btn btn-primary" name="flag"
								value="Delete">Delete</button>
							<button type="submit" class="btn btn-primary pull-right"
								name="flag" value="Update">Update</button>
						</div>
					</div>
				</form>
				<%
					}
				%>
			</div>
		</div>
	</div>
</section>
<%@ include file="footer.jsp"%>