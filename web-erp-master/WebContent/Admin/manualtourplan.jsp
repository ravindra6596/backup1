<%@page import="java.sql.ResultSet"%>
<%@page import="com.Employee.Objects.GetData"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp"%>

<section class="content-header">
	<h1>
		Manual Tour Plan
	</h1>
</section>
<section class="content">
	<%
		String msg =null;
		msg = request.getParameter("res");
		if(msg!=null && msg.equals("success")){
		%>
	<div class="callout callout-info fadeout">
		<h4>Success!</h4>
		<p>Data Inserted Successfully</p>
	</div>
	<% }else if(msg != null && msg.equals("duplicate")){ %>
	<div class="callout callout-warning fadeout">
		<h4>Success!</h4>
		<p>Duplicate record available!!</p>
	</div>
	<% }else if(msg!=null && msg.equals("fail")){ %>
	<div class="callout callout-danger fadeout">
		<h4>Error!</h4>
		<p>Something went Wrong..!!</p>
	</div>
	<%} %>
	<form action="<%= rootpath %>GenerateTP" method="post">
		<input type="hidden" name="id" value="<%= id %>">
		<div class="box box-default">
			
			<!-- /.box-header -->
			<div class="box-body">
				<div class="row">
					<div class="col-md-6">
										<div class="form-group">
					<label>Date:</label>

					<div class="input-group date">
						<div class="input-group-addon">
							<i class="fa fa-calendar"></i>
						</div>
						<input type="text" class="form-control pull-right datepicker "
							id="manualtourplan_datepicker" name="date" autocomplete="off">
					</div>
					<!-- /.input group -->
				</div>
				<div class="bootstrap-timepicker">
                <div class="form-group">
                  <label>Pick a time</label>

                  <div class="input-group">
                    <input type="text" class="form-control timepicker" name="time" autocomplete="off" >

                    <div class="input-group-addon">
                      <i class="fa fa-clock-o"></i>
                    </div>
                  </div>
                  <!-- /.input group -->
                </div>
                <!-- /.form group -->
              </div>
                   <div class="form-group">
		                <label>Select Employee</label>
		                <select class="form-control select2" id="toggle_emp" onchange="toggle_select(this)" name="eid" data-placeholder="Select TM"
		                        style="width: 100%;">
		                        <option selected>Select Employee</option>
		                        <% ResultSet rs_gettm = GetData.AllEmployees(); while(rs_gettm.next()){ %>
		                  	<option value="<%= rs_gettm.getInt("eid")%>"><%= rs_gettm.getString("name") %></option>
		                  <% } %>
		                </select>
		              </div>
              <div class="form-group">
		                <label>Select Doctor</label>
		                <select class="form-control select2" name="doctorid" data-placeholder="Select Doctor"
		                        style="width: 100%;" id="doctorsList" >
		                        <option selected>Select Doctor</option>
		                 </select>
		              </div>	
		         
		        
		              		
					</div>
				</div>

			</div>
			<div class="box-footer">
			<button type="submit" class="btn btn-primary pull-right" name="flag" value="ADDTOUR">Submit</button>
		</div>
		</div>
	</form>
</section>

<%@ include file="footer.jsp"%>