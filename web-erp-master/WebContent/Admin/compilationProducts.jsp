<%@page import="com.Employee.Objects.GetData"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp"%>

<section class="content-header">
	<h1>Products Compilation</h1>
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
			<p>Something went Wrong..!!Try Again</p>
		</div>
		<%
			}
		%>
</section>
<form action="<%= rootpath%>/CompilationProducts" method="post">
<section class="content">
	<div class="box box-default">
		<div class="box-header with-border">
			<h3 class="box-title">Add Compilation</h3>
		</div>
		<div class="box-body">
			<div class="row">
				<div class="col-md-6">
					<div class="form-group">
						<label>Select Date:</label>

						<div class="input-group date">
							<div class="input-group-addon">
								<i class="fa fa-calendar"></i>
							</div>
							<input type="text" class="form-control pull-right"
								id="datepicker1" name="date">
						</div>
						<!-- /.input group -->
					</div>
					<div class="form-group">
						<label>Select Area to filter Stockist:</label> <select class="form-control select2"
							style="width: 100%;" id="select_area">
							<option selected="selected" disabled="disabled">Select
								Area</option>
							<% ResultSet rs_area = GetData.Area();
								while(rs_area.next()){
							%>
							<option value="<%= rs_area.getInt("aid")%>"><%= rs_area.getString("areaname") %></option>
							<% } %>
						</select>
					</div>
					<div class="form-group">
						<label>Select Stockiest:</label> <select class="form-control select2"
							style="width: 100%;" name="sid" id="selectDoc_compilePro">
							<option selected="selected" disabled="disabled">Select
								Stockiest</option>
							<% ResultSet rs = GetData.Stockiest();
								while(rs.next()){
							%>
							<option value="<%= rs.getInt("sid")%>"><%= rs.getString("name") %></option>
							<% } %>
						</select>
					</div>
				</div>
				<div class="col-md-6">
					<div class="field_wrapper">
						<div class="row " data-sel-sr="0">
							<div class="col-md-4">
								<div class="form-group">
									<label>Select Product</label> <select
										class="form-control select2" style="width: 100%;"
										name="pname[]">
										<option selected="selected" disabled="disabled">select
											Product</option>
										<% ResultSet rs_pro = GetData.Products();
														while (rs_pro.next()) {
													%>
										<option value="<%=rs_pro.getInt("pid")%>"><%=rs_pro.getString("pname")%></option>
										<%
														}
													%>
									</select>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label>Quantity</label> <input type="number"
										class="form-control" placeholder="Quantity" name="targetqty[]">
								</div>
							</div>
							<div class="col-md-2" style="margin-top: 24px;">
								<a href="javascript:void(0);" class="btn btn-primary add_more">Add
									More</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="box-footer">
			<button type="submit" class="btn btn-primary pull-right"
						name="submit" value="ADD">Submit</button>
		</div>
	</div>
</section>
</form>

<%@ include file="footer.jsp"%>