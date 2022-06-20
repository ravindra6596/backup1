<%@page import="java.sql.ResultSet"%>
<%@page import="com.model.C3P0DataSource"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp"%>
<%
Connection con = C3P0DataSource.getInstance().getConnection();
	ResultSet rs = con.createStatement().executeQuery("SELECT *,DATE_FORMAT(date, '%d-%m-%Y') as hdate FROM holidays order by date");
%>
<%
%>
<section class="content-header">
	<h1>Holidays Management</h1>

</section>

<!-- Main content -->
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


	<form action=" <%=rootpath%>Holidays" method="post">

		<div class="modal fade " id="myModal">
			<div class="modal-dialog">
				<div class="modal-content">

					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title">Add Holiday</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<!-- Modal body -->

					<div class="modal-body">
						<div class="form-group">
							<div class="input-group date">
								<div class="input-group-addon">
									<i class="fa fa-calendar"></i>
								</div>
								<input type="text" class="form-control pull-right datepicker"
									id="datepicker1" name="hdate" autocomplete="off" required>
							</div>
						</div>
						<div class="form-group">
							<label for="title-text" class="col-form-label">Title:</label>
							<input type="text" autocomplete="off" class="form-control" id="title" name="title">
						</div>

					</div>

					<!-- Modal footer -->

					<div class="modal-footer">
						<button type="submit" class="btn btn-primary pull-left"
							name="submit" value="ADD">Submit</button>
						<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>

					</div>

				</div>
			</div>
		</div>
	</form>
	<div class="row">
		<div class="col-xs-12">

			<div class="box">
				<div class="box-header">
					<h3 class="box-title">All Holidays</h3>
					<div class="pull-right">
						<a class="btn btn-block btn-info " data-toggle="modal"
							data-target="#myModal">Add New Holidays</a>
					</div>
				</div>
				<!-- /.box-header -->
				<div class="box-body">
					<div class="row">
						<div class="col-md-6">
							<form action="">
								<table id="example1" class="table table-bordered table-striped">
									<thead>
										<tr>
											<th>Date</th>
											<th>Title</th>
											<th>Action</th>

										</tr>
									</thead>
									<tbody>
										<%
											while (rs.next()) {
										%>
										<tr>
											<td><%=rs.getString("hdate")%></td>
											<td> <%=rs.getString("title")%></td>
											<td>
											<a href="<%= rootpath %>Holidays?hid=<%=rs.getString("hid")%>"><i class="fa fa-trash fa-lg btn btn-danger" ></i></a></td>


										</tr>
										<%
											}
										%>
									</tbody>
								</table>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<%@ include file="footer.jsp"%>