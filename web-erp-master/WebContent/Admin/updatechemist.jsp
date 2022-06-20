<%@page import="java.sql.*"%>
<%@page import="com.Employee.Objects.GetData"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp"%>
<section class="content-header">
	<h1>
		Single Chemist Details
	</h1>
	<!-- <ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li><a href="#">Forms</a></li>
		<li class="active">Advanced Elements</li>
	</ol> -->
	<%
		String msg =null;
		msg = request.getParameter("response");
		if(msg!=null && msg.equals("success")){
		%>
	<div class="callout callout-info fadeout">
		<h4>Success!</h4>
		<p>Data Updated Successfully</p>
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
</section>
<!-- Main content -->
<section class="content">
	<div class="box box-default">
		<div class="box-header with-border">
			<br>
			<div class="box-tools pull-right">
				<button type="button" class="btn btn-block btn-primary"
					id="toggle_button" style="display: block;" onclick="toggle_edit()">Edit</button>
				<a href="#" class="btn btn-block btn-primary" id="toggle_button_2"
					style="display: none;" onclick="toggle_edit()">Cancle</a>
			</div>
		</div>
		<%
					int cid = Integer.parseInt(request.getParameter("id"));
		Connection con = C3P0DataSource.getInstance().getConnection();
					ResultSet rs1=con.createStatement().executeQuery("SELECT *,DATE_FORMAT(druglicensevalidity, '%d-%m-%Y') as drug FROM chemists INNER JOIN `chemistscontact` ON `chemistscontact`.`cid`=`chemists`.`cid` WHERE `chemists`.`cid`='"+cid+"'");
					 
				%>
		<form method="post" action="<%= rootpath %>ChemistSave">
			<input type="hidden" name="id" value="<%= cid%>">
			<div class="box-body" id="box1" style="display: block;">
			<% while(rs1.next()){ %>
				<div class="row">
					<div class="col-md-4">
						<dl class="dl-horizontal">
							<dt style="font-size: 130%;">Name</dt>
							<dd style="font-size: 130%;"><%= rs1.getString("name") %></dd>
							<dt style="font-size: 130%;">Contact Number</dt>
							<dd style="font-size: 130%;"><%= rs1.getString("mobile") %></dd>
							<dt style="font-size: 130%;">Email_Id</dt>
							<dd style="font-size: 130%;"><%= rs1.getString("email") %></dd>
							<dt style="font-size: 130%;">Contact Person 1</dt>
							<dd style="font-size: 130%;"><%= rs1.getString("cpname1") %></dd>
							<dd style="font-size: 130%;"><%= rs1.getString("cpphone1") %></dd>
							<dt style="font-size: 130%;">Contact Person 2</dt>
							<dd style="font-size: 130%;"><%= rs1.getString("cpname2") %></dd>
							<dd style="font-size: 130%;"><%= rs1.getString("cpphone2") %></dd>
						</dl>
					</div>
					<div class="col-md-4">
						<dl class="dl-horizontal">
							<dt style="font-size: 130%;">Shop Contact</dt>
							<dd style="font-size: 130%;"><%= rs1.getString("shoptelephone") %></dd>
							<dt style="font-size: 130%;">Shop Address</dt>
							<dd style="font-size: 130%;"><%= rs1.getString("address") %></dd>
							<dt style="font-size: 130%;">HeadQuarter</dt>
							<dd style="font-size: 130%;"><%=GetData.area_name(rs1.getInt("headquarter"))%></dd>
						</dl>
						<!-- dl-horizontal -->
					</div>
					<!-- col-md-4 -->
					<div class="col-md-4">
						<dl class="dl-horizontal">
							<dt style="font-size: 130%;">Shop License</dt>
							<dd style="font-size: 130%;"><%= rs1.getString("shopactlicense") %></dd>
							<dt style="font-size: 130%;">Food License</dt>
							<dd style="font-size: 130%;"><%= rs1.getString("foodlicense") %></dd>
							<dt style="font-size: 130%;">Drug License</dt>
							<dd style="font-size: 130%;"><%= rs1.getString("druglicense") %></dd>
							<dt style="font-size: 130%;">Drug Validity</dt>
							<dd style="font-size: 130%;"><%= rs1.getString("drug") %></dd>
							<dt style="font-size: 130%;">Firm Constitution</dt>
							<dd style="font-size: 130%;"><%= rs1.getString("firmconstitution") %></dd>
							<dt style="font-size: 130%;">GST</dt>
							<dd style="font-size: 130%;"><%= rs1.getString("gst") %>%</dd>
						</dl>
						<!-- dl-horizontal -->
					</div>
					<!-- col-md-4 -->
				</div>
				<!-- row -->
				<% } %>
				<div class="box-footer">
					<button type="submit" class="btn btn-primary pull-right"
						name="flag" value="delete">Delete</button>
				</div>
			</div>
			<!-- Box Body -->
		</form>
		
		<form name="updateform" action="<%= rootpath %>ChemistSave" method="post">
			<input type="hidden" name="id" value="<%= cid %>">
			<%
				
				Statement st;
				ResultSet rs;
				st=con.createStatement();
					 rs=st.executeQuery("SELECT *,DATE_FORMAT(druglicensevalidity, '%d-%m-%Y') as drug FROM chemists INNER JOIN `chemistscontact` ON `chemistscontact`.`cid`=`chemists`.`cid` WHERE `chemists`.`cid`='"+cid+"'");
					 while(rs.next())
					 {
				%>
			<div id="box2" style="display: none;">
			<div class="box-body" >
				<div class="row">
					<div class="col-md-4">
						<div class="box-header ">
							<h3 class="box-title">
								<b><u>Personal Details</u></b>
							</h3>
						</div>
						<div class="form-group">
							<label>Name</label> <input type="text" class="form-control"
								placeholder="Enter Name " name="name" autocomplete="off"
								value="<%=rs.getString("name")%>">
						</div>
						<!-- /.form-group -->
						<!-- /.form-group -->
						<div class="form-group">
							<label for="contactnumber">Contect Number</label> <input
								type="number" class="form-control" id="contactnumber" autocomplete="off"
								placeholder="Enter Contact Number" name="mobile"
								value="<%=rs.getString("mobile")%>">
						</div>
						<!-- /.form-group -->
						<div class="form-group">
							<label for="exampleInputEmail1">Email Id</label> <input
								type="email" class="form-control" id="exampleInputEmail1" autocomplete="off"
								placeholder="Enter Email" name="email"
								value="<%=rs.getString("email")%>">
						</div>
						<!-- /.form-group -->
						
						<div class="form-group">
							<label>Contact Person 1</label>
							<div class="row">
								<div class="col-md-6">
									<input type="text" class="form-control" name="cpname1" autocomplete="off"
										placeholder="Enter Name"
										value="<%=rs.getString("cpname1") %>">
								</div>
								<!-- col -->
								<div class="col-md-6">
									<input type="text" class="form-control" id="contactnumber" autocomplete="off"
										name="cpphone1" placeholder="Enter Phone Number"
										value="<%=rs.getString("cpphone1") %>">
								</div>
								<!-- col -->
							</div>
							<!-- row -->
						</div>
						<!-- /.form-group -->
						<div class="form-group">
							<label>Contact Person 2</label>
							<div class="row">
								<div class="col-md-6">
									<input type="text" class="form-control" id="contactnumber" autocomplete="off"
										name="cpname2" value="<%=rs.getString("cpname2") %>"
										placeholder="Enter Name">
								</div>
								<!-- col -->
								<div class="col-md-6">
									<input type="text" class="form-control" id="contactnumber" autocomplete="off"
										name="cpphone2" value="<%=rs.getString("cpphone2") %>"
										placeholder="Enter Phone Number">
								</div>
								<!-- col -->
							</div>
							<!-- row -->
						</div>
						<!-- /.form-group -->

					</div>
					<!-- /.col-md-4 -->
					
					<div class="col-md-4">
						<div class="box-header ">
							<h3 class="box-title">
								<b><u>Postal Details</u></b>
							</h3>
						</div>
						<div class="form-group">
							<label>Shop Phone Number</label> <input type="text"
								class="form-control" placeholder="Enter Shop Phone Number " autocomplete="off"
								name="shoptelephone" value="<%=rs.getString("shoptelephone")%>">
						</div>
						<!-- /.form-group -->
						<div class="form-group">
							<label>Shop Address</label>
							<textarea class="form-control" rows="3"
								placeholder="Enter Shop Address" name="address"><%=rs.getString("address")%></textarea>
						</div>
						<!-- /.form-group -->
						<%Statement sthq=con.createStatement();
								ResultSet rshq=sthq.executeQuery("select haid, headquarter from headquarters");
										%>
						<div class="form-group">
							<label>Head Quarter</label> <select class="form-control select2"
								style="width: 100%;" name="headquarter">
								<%while(rshq.next()){ %>
								<option value="<%= rshq.getString("haid")%>"
									<%=rs.getString("headquarter").equals(rshq.getString("haid")) ? "selected='selected'" : "" %>><%=rshq.getString("headquarter")%></option>
								<%} %>
							</select>
						</div>
						<!-- /.form-group -->
					</div>
					<!-- /.col-md-4 -->
					<div class="col-md-4">
						<div class="box-header ">
							<h3 class="box-title">
								<b><u>Documents</u></b>
							</h3>
						</div>
						<div class="form-group">
							<label for="contactnumber">Shop Act License Number</label> <input
								type="number" class="form-control" id="contactnumber" autocomplete="off"
								name="shopactlicense" value="<%=rs.getInt("shopactlicense") %>"
								placeholder="Enter Shop Act License Number">
						</div>
						<!-- /.form-group -->
						<div class="form-group">
							<label for="contactnumber">Food License Number</label> <input
								type="text" class="form-control" name="foodlicense" autocomplete="off"
								value="<%=rs.getString("foodlicense") %>"
								placeholder="Enter Food License Number">
						</div>
						<!-- /.form-group -->
						<div class="form-group">
							<label for="contactnumber">Drug License Number</label> <input
								type="text" class="form-control" name="druglicense" autocomplete="off"
								value="<%=rs.getString("druglicense") %>"
								placeholder="Enter Drug License Number">
						</div>
						<!-- /.form-group -->
						<div class="form-group">
							<label>Drug License Validity</label>

							<div class="input-group date">
								<div class="input-group-addon">
									<i class="fa fa-calendar"></i>
								</div>
								<input type="text" class="form-control pull-right datepicker"
									name="druglicensevalidity"  autocomplete="off"
									value="<%=rs.getString("drug")%>" id="updateStockiest_datepicker1">
							</div>
							<!-- /.input group -->
						</div>
						<!-- /.form-group -->
						<div class="form-group">
							<label for="contactnumber">GST</label> <input type="text" autocomplete="off"
								class="form-control" name="gst" value="<%=rs.getString("gst")%>"
								placeholder="Enter GST">
						</div>
						<!-- /.form-group -->
						<div class="form-group">
							<label for="Status">Firm Constitution</label>
							<div class="radio">
								<label> <input type="radio" name="firmconstitution"
									value="Proprietor"
									<%=rs.getString("firmconstitution").equals("Proprietor") ? "checked='checked'" : "" %>>Proprietor
								</label> <label> <input type="radio" name="firmconstitution"
									value="Partnership"
									<%= rs.getString("firmconstitution").equals("Partnership") ? "checked='checked'" : "" %>>Partnership
								</label>
							</div>
						</div>
						<!-- /.form-group -->
					</div>
					<!-- /.col-md-4 -->

				</div>
				<!-- Row -->
				
			</div>
			<!-- Box Body -->
			<% } %>
			<div class="box-footer">
				<button type="submit" class="btn btn-primary pull-right"
					name="flag" value="Update">Update</button>
			</div>
		</div>
		</form>
		
	</div>
</section>
<%@ include file="footer.jsp"%>