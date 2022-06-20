<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.model.C3P0DataSource"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp"%>

<section class="content-header">
	<h1>Target</h1>
	<!-- <ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li><a href="#">Forms</a></li>
		<li class="active">General Elements</li>
	</ol> -->

	<section class="content">
		<%
    //Connection con = BIManager.ConnectDB();
	String msg =null;
	msg = request.getParameter("response");
	if(msg!=null && msg.equals("success")){
%>
		<div class="callout callout-info fadeout">
			<h4>Success!</h4>
			<p>Data Inserted Successfully</p>
		</div>
		<%}else if(msg!=null && msg.equals("fail")){ %>
		<div class="callout callout-danger fadeout">
			<h4>Error!</h4>
			<p>Something went Wrong..!!</p>
		</div>
		<%} %>
		<div class="row">
			<div class="col-md-12">
				<form
					action="<%=rootpath %>/Target"
					method="post">
					<div class="box box-default">
						<div class="box-header with-border">
							<h3 class="box-title">Add Individual Target</h3>
							<div class="box-tools pull-right">
								<button type="button" class="btn btn-box-tool"
									data-widget="collapse">
									<i class="fa fa-minus"></i>
								</button>
							</div>
						</div>
						<!-- box body -->
						<% 
						Connection con = C3P0DataSource.getInstance().getConnection();
	            	Statement stmt1 = con.createStatement();
	            	Statement stmt2 = con.createStatement();
	            	ResultSet rs1 = stmt1.executeQuery("select eid,name from employee where usertype='TM'");
	            	ResultSet rs2 = stmt2.executeQuery("select pid, pname from product");
	            %>
						<div class="box-body">
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label>Select TM</label> <select class="form-control select2"
											style="width: 100%;" name="eid">
											<option selected="selected" disabled="disabled">select
												TM....</option>
											<% while(rs1.next()){ %>
											<option value="<%= rs1.getInt("eid")%>"><%= rs1.getString("name") %></option>
											<% } %>
										</select>
									</div>
								</div>
							</div>

							<div class="field_wrapper">
								<div class="row " data-sel-sr="0">
									<div class="col-md-3">
										<div class="form-group">
											<label>Select Product</label> <select
												class="form-control select2" style="width: 100%;"
												name="pname[]">
												<option selected="selected" disabled="disabled">select
													Product</option>
												<%
													while (rs2.next()) {
												%>
												<option value="<%=rs2.getInt("pid")%>"><%=rs2.getString("pname")%></option>
												<%
													}
												%>
											</select>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<label>Quantity</label> <input type="number"
												class="form-control" placeholder="Quantity"
												name="targetqty[]">
										</div>
									</div>
									<div class="col-md-2" style="margin-top: 24px;">
										<a href="javascript:void(0);"
											class="btn btn-primary add_button">Add More</a>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label>From</label>
										<div class="input-group">
											<div class="input-group-addon">
												<i class="fa fa-clock-o"></i>
											</div>
											<input type="text" class="form-control pull-right"
												id="reservation_individualTarget" name="dateindi">
										</div>
									</div>
								</div>

							</div>
						</div>
						<!-- box-body ends -->
						<div class="box-footer">
							<button type="submit" class="btn btn-primary pull-right"
								value="AddIndividual" name="submit1">Submit</button>
						</div>
					</div>
					<%
				
				Statement stmt = con.createStatement();
				ResultSet rs= stmt.executeQuery("select cname,cid from campaign where status ='active'");
			%>
					<%-- <div class="box box-default">
						<div class="box-header with-border">
							<h3 class="box-title">Team Target</h3>
							<div class="box-tools pull-right">
								<button type="button" class="btn btn-box-tool"
									data-widget="collapse">
									<i class="fa fa-minus"></i>
								</button>
							</div>
						</div>
						<!-- box body -->

						<div class="box-body">
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label>Select Campaign</label> <select
											class="form-control select2" style="width: 100%;"
											name="campaign">
											<option selected="selected" disabled="disabled">select
												Campaign....</option>
											<% while(rs.next()){ %>
											<option value="<%= rs.getInt("cid")%>"><%= rs.getString("cname") %></option>
											<% } %>
										</select>
									</div>
									<div class="form-group">
										<label>Quantity</label> <input type="number"
											class="form-control" placeholder="Quantity"
											name="targetvalue">
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label>From</label>
										<div class="input-group">
											<div class="input-group-addon">
												<i class="fa fa-clock-o"></i>
											</div>
											<input type="text" class="form-control pull-right"
												id="reservation1" name="datefrom">
										</div>
									</div>
								</div>

							</div>
						</div>
						<div class="box-footer">
							<button type="submit" class="btn btn-primary pull-right"
								value="AddTeam" name="submit1">Submit</button>
						</div>
					</div> --%>
				</form>
			</div>
		</div>
	</section>
</section>

<%@ include file="footer.jsp"%>