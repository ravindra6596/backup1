<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

			<%@ include file="header.jsp" %>
			<%
			Connection con = C3P0DataSource.getInstance().getConnection();
				ResultSet rs = con.createStatement().executeQuery("select haid , headquarter from headquarters");
			%>
			<section class="content-header">
			<h1>
				Add Chemist
			</h1>
			<!-- <ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
				<li><a href="#">Forms</a></li>
				<li class="active">Advanced Elements</li>
			</ol> -->
			</section>
			<!-- Main content -->
		   <form name="savechemist" method="post" action="<%= rootpath %>ChemistSave">
			<section class="content">
			<%
		String msg =null;
		msg = request.getParameter("response");
		if(msg!=null && msg.equals("success")){
		%>
		<div class="callout callout-info fadeout">
			<h4>Success!</h4>
			<p>Data Added Successfully</p>
		</div>
		<% }else if(msg != null && msg.equals("delete")){ %>
			<div class="callout callout-warning fadeout">
			<h4>Success!</h4>
			<p>Data deleted successfully</p>
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
					<h3 class="box-title">Chemist Details</h3>
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
             <div class="form-group">
                  <label>Chemist Name</label>
                  <input type="text" class="form-control" required="required" placeholder="Enter Name " autocomplete="off" name="name">
                </div>
              <!-- /.form-group -->
              <div class="form-group">
								<label for="contactnumber">Contect Number</label> <input
									type="number" class="form-control" id="contactnumber" autocomplete="off"
									placeholder="Enter Contact Number" name="mobile">
							</div>
              <!-- /.form-group -->
              <div class="form-group">
                  <label>Alternate No.</label>
                  <input type="number" class="form-control" autocomplete="off" placeholder="Enter Shop Phone Number " name="shoptelephone">
                </div>
              
            </div>
            <!-- /.col -->
            <div class="col-md-6">
              <div class="form-group">
								<label for="exampleInputEmail1">Email Id</label> <input
									type="email" class="form-control" id="exampleInputEmail1" autocomplete="off"
									placeholder ="Enter Email" name="email">
							</div>
              <!-- /.form-group -->
              <div class="form-group">
            <label>Head Quarter</label> <select class="form-control select2"
									style="width: 100%;" name="headquarter" required="required">
									<option selected disabled>Select Headquarter</option>
									<% while(rs.next()){ %>
									<option value="<%= rs.getInt("haid")%>"><%= rs.getString("headquarter") %></option>
									<%} %>
								</select>
            </div>
              <div class="form-group">
					<label>Shop Address</label>
					<textarea class="form-control" rows="3" placeholder="Enter Shop Address..." name="address"></textarea>
				</div>
            </div>
            <!-- /.col -->		
            </div>
			<!-- Row -->
					
				</div>
				<!-- Box Body -->
			</div>
			<!-- Box default -->
			
			<div class="box box-default">
				<div class="box-header with-border">
					<h3 class="box-title">Documents</h3>
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
             <div class="form-group">
								<label for="contactnumber">Shop Act License Number</label> <input
									type="number" class="form-control" id="contactnumber" name="shopactlicense" autocomplete="off"
									placeholder="Enter Shop Act License Number">
							</div>
              <!-- /.form-group -->
               <div class="form-group">
								<label for="contactnumber">Food License Number</label> <input
									type="text" class="form-control" id="contactnumber" name="foodlicense" autocomplete="off"
									placeholder="Enter Food License Number">
							</div>
              <!-- /.form-group -->
              <div class="form-group">
								<label for="contactnumber">Drug License Number</label> <input
									type="text" class="form-control" id="contactnumber" name="druglicensen" autocomplete="off"
									placeholder="Enter Drug License Number">
							</div>
              <!-- /.form-group -->
            </div>
            <!-- /.col -->
            <div class="col-md-6">
              <div class="form-group">
                <label>Drug License Validity</label>

                <div class="input-group date">
                  <div class="input-group-addon">
                    <i class="fa fa-calendar"></i>
                  </div>
                  <input type="text" autocomplete="off" class="form-control pull-right datepicker" id="addStockiest_datepicker"  name="druglicensevalidity">
                </div>
                <!-- /.input group -->
              </div>
              <!-- /.form-group -->
              <div class="form-group">
					<label for="contactnumber">GST Number</label> <input
						type="text" class="form-control " id="contactnumber" name="gst" autocomplete="off"
						placeholder="Enter GST">
			  </div>
              <!-- /.form-group -->
              <div class="form-group">
					<label for="Status">Firm Constitution</label>
                  <div class="radio">
                    <label>
                      <input type="radio" name="firmconstitution" id="optionsRadios1" checked="checked" value="Proprietor" >Proprietor </label>
                      <label>
                      <input type="radio" name="firmconstitution" id="optionsRadios1" value="Partnership" >Partnership </label>
                  </div>
                </div>
                <!-- /.form-group -->
            </div>
            <!-- /.col -->
            		
            </div>
			<!-- Row -->
					
				</div>
				<!-- Box Body -->
			</div>
			<!-- Box default -->
			<div class="box box-default">
				<div class="box-header with-border">
					<h3 class="box-title">Contact Person Details</h3>
					<div class="box-tools pull-right">
						<button type="button" class="btn btn-box-tool"
							data-widget="collapse">
							<i class="fa fa-minus"></i>
						</button>
					</div>
				</div>
				<div class="box-body">
					<div class="form-group">
					<div class="row">
						<div class="col-md-3">
							<label>Contect Person 1</label>
						</div>
						<div class="col-md-3">
							<input type="text" class="form-control"  name="cpname1" autocomplete="off"
								placeholder="Enter Name">
						</div>
						<div class="col-md-3">
							<input type="number" class="form-control" 
								placeholder="Enter Contact Number" name="cpphone1" autocomplete="off">
						</div>
					</div>
					<!-- ./row -->
				</div>
				<!-- ./form-group -->
				<div class="form-group">
					<div class="row">
						
						<div class="col-md-3">
							<label>Contect Person 2</label>
						</div>
						<div class="col-md-3">
							<input type="text" class="form-control"  name="cpname2" autocomplete="off"
								placeholder="Enter Name">
						</div>
						<div class="col-md-3">
							<input type="number" class="form-control" 
								placeholder="Enter Contact Number" name="cpphone2" autocomplete="off">
						</div>
						
					</div>
					<!-- ./row -->
				</div>
				<!-- ./form-group -->	
				<div class="box-footer">
						<button type="submit" class="btn btn-primary pull-right" name="flag" value="ADD">Submit</button>
					</div>			
				</div>
				<!-- Box Body -->
				
			</div>
			<!-- Box default -->
			
			
			</section>
			</form>
		<%@ include file="footer.jsp"%>