<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp" %>
<%
	int leaveid = Integer.parseInt(request.getParameter("id"));
	String status = null; int leaveEid =0;
	Connection con = C3P0DataSource.getInstance().getConnection();
	ResultSet get_leave = con.createStatement().executeQuery("select * from leavemgm where leaveid ='"+leaveid+"'");
%>
<section class="content-header">
	<h1>
		Edit Leave <small>Data</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li><a href="#">Tables</a></li>
		<li class="active">Data tables</li>
	</ol>
</section>
<section class="content">
	<%
		String msg =null;
		msg = request.getParameter("response");
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
	
		<div class="box box-default">
			<div class="box-header with-border">
				<h3 class="box-title">Edit Leave</h3>

				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool"
						data-widget="collapse">
						<i class="fa fa-minus"></i>
					</button>

				</div>
			</div>
			<!-- /.box-header -->
			<% while(get_leave.next()){
				status = get_leave.getString("status");
				leaveEid = get_leave.getInt("eid");
				System.out.println("leaveEid="+leaveEid+" eid="+id);
				%>
				<form action="<%= rootpath %>leaveController" method="post">
					<input type="hidden" name="id" value="<%=leaveid%>">
					<input type="hidden" name="eid" value="<%=id%>">
			<div class="box-body">
				<div class="row">
					<div class="col-md-6">
							<div class="form-group">
								<label>Select Leave Type</label> <select class="form-control select2"
									name="leaveType" <%= leaveEid != id ? "disabled" : ""%>
									style="width: 100%;" id="leave_type">
									<option>Select Leave type</option>
									<option value="CL" <%=get_leave.getString("leavetype").equals("CL") ? "selected='selected'": ""%>>Casual Leave</option>
									<option value="PL" <%=get_leave.getString("leavetype").equals("PL") ? "selected='selected'": ""%>>Privilege Leave</option>
									<option value="SL" <%=get_leave.getString("leavetype").equals("SL") ? "selected='selected'": ""%>>Sick Leave</option>
								</select>
							</div>
							<% if(get_leave.getString("leavetype").equals("CL")){ %>
							<div id="cid" style="display: block;">
								<div class="row">
									<div class="col-md-6">
										 <div class="form-group">
							                <label>Date:</label>
							
							                <div class="input-group date">
							                  <div class="input-group-addon">
							                    <i class="fa fa-calendar"></i>
							                  </div>
							                  <input type="text" class="form-control pull-right" name="sdatecl" id="CL_from_datepicker2" value="<%= get_leave.getDate("fromdate") %>" <%= leaveEid != id ? "disabled" : ""%>>
							                </div>
							                <!-- /.input group -->
							              </div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
							                <label>Date:</label>
							
							                <div class="input-group date">
							                  <div class="input-group-addon">
							                    <i class="fa fa-calendar"></i>
							                  </div>
							                  <input type="text" class="form-control pull-right" name="enddatecl" id="CL_to_datepicker2" value="<%= get_leave.getDate("todate") %>" <%= leaveEid != id ? "disabled" : ""%>>
							                </div>
							                <!-- /.input group -->
							              </div>
									</div>
								</div>
							</div>
							<% }else if(get_leave.getString("leavetype").equals("PL")){ %>
							<div id="pid" style="display: block;">
								<div class="row">
									<div class="col-md-6">
										 <div class="form-group">
							                <label>Date:</label>
							
							                <div class="input-group date">
							                  <div class="input-group-addon">
							                    <i class="fa fa-calendar"></i>
							                  </div>
							                  <input type="text" class="form-control pull-right" name="sdatepl" id="PL_from_datepicker2" value="<%= get_leave.getDate("fromdate") %>" <%= leaveEid != id ? "disabled" : ""%>>
							                  <%-- <input type="text" id="demo_datepicker" value="<%= get_leave.getDate("fromdate") %>"> --%>
							                </div>
							                <!-- /.input group -->
							              </div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
							                <label>Date:</label>
							
							                <div class="input-group date">
							                  <div class="input-group-addon">
							                    <i class="fa fa-calendar"></i>
							                  </div>
							                  <input type="text" class="form-control pull-right" name="enddatepl" id="PL_to_datepicker2" value="<%= get_leave.getDate("todate") %>" <%= leaveEid != id ? "disabled" : ""%>>
							                </div>
							                <!-- /.input group -->
							              </div>
									</div>
								</div>
							</div>
							<% }else if(get_leave.getString("leavetype").equals("SL")){ %>
							<div id="sid" style="display: block;">
								<div class="row">
									<div class="col-md-6">
										 <div class="form-group">
							                <label>Date:</label>
							
							                <div class="input-group date">
							                  <div class="input-group-addon">
							                    <i class="fa fa-calendar"></i>
							                  </div>
							                  <input type="text" class="form-control pull-right" name="sdatesl" id="SL_from_datepicker2" value="<%= get_leave.getDate("fromdate") %>" <%= leaveEid != id ? "disabled" : ""%>>
							                </div>
							                <!-- /.input group -->
							              </div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
							                <label>Date:</label>
							
							                <div class="input-group date">
							                  <div class="input-group-addon">
							                    <i class="fa fa-calendar"></i>
							                  </div>
							                  <input type="text" class="form-control pull-right" name="enddatesl" id="SL_to_datepicker2" value="<%= get_leave.getDate("todate") %>" <%= leaveEid != id ? "disabled" : ""%>>
							                </div>
							                <!-- /.input group -->
							              </div>
									</div>
								</div>
							</div>
							<%} %>
							<div class="form-group">
			                  <label>Reason</label>
			                  <textarea class="form-control" rows="3" placeholder="Enter ..." name="comment" <%= leaveEid != id ? "disabled" : ""%>><%= get_leave.getString("comment") %></textarea>
			                </div>
			                <div class="leave_upload_document" style="display: none;">
			                	<div class="form-group">
				                  <label for="exampleInputFile">File input</label>
				                  <input type="file" id="exampleInputFile">
								</div>
			                </div>
						</div>
				</div>
			</div>
			<% }
				if(status.equalsIgnoreCase("pending") && leaveEid == id){
			%>
			<div class="box-footer">
				<button type="submit" class="btn btn-primary " name="submit" value="Edit" style="margin-top: 25px;">Edit</button>
				<button type="submit" class="btn btn-primary " name="submit" value="Delete" style="margin-top: 25px;">Delete</button>
			</div>
			<% } else if(leaveEid != id){ %>
				<div class="box-footer">
					<button type="submit" class="btn btn-primary " name="submit" value="Approve_admin" style="margin-top: 25px;">Approve</button>
					<button type="submit" class="btn btn-primary " name="submit" value="Reject_admin" style="margin-top: 25px;">Reject</button>
				</div>
			<% } %>
			</form>
		</div>
	
</section>

<%@ include file="footer.jsp" %>