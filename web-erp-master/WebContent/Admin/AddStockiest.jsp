<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

			<%@ include file="header.jsp" %>
			<%
			Connection con = C3P0DataSource.getInstance().getConnection();
				ResultSet rs = con.createStatement().executeQuery("select daid , district from districts");
			%>
			<section class="content-header">
			<h1>
				Add Stockist
			</h1>
			<!-- <ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
				<li><a href="#">Forms</a></li>
				<li class="active">Advanced Elements</li>
			</ol> -->
			</section>
			<!-- Main content -->
		   <form name="savestockiest" method="post" action="<%= rootpath %>StockiestSave">
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
					<h3 class="box-title">Stockist Details</h3>
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
                  <label>Stockiest Name</label>
                  <input type="text" class="form-control" required autocomplete="off" placeholder="Enter Name " name="name">
                </div>
              <!-- /.form-group -->
              <div class="form-group">
								<label for="contactnumber">Contect Number</label> <input
									type="number" class="form-control" autocomplete="off"  id="contactnumber"
									placeholder="Enter Contact Number" name="mobile">
							</div>
              <!-- /.form-group -->
              <div class="form-group">
                  <label>Alternate No.</label>
                  <input type="number" class="form-control"  autocomplete="off" placeholder="Enter Shop Phone Number " name="shoptelephone">
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
            <label>District</label> <select class="form-control select2" required
									style="width: 100%;" name="headquarter">
									<option selected disabled>Select District</option>
									<% while(rs.next()){ %>
									<option value="<%= rs.getInt("daid")%>"><%= rs.getString("district") %></option>
									<%} %>
								</select>
            </div>
              <div class="form-group">
					<label>Shop Address</label>
					<textarea class="form-control" rows="3"  autocomplete="off" placeholder="Enter Shop Address..." name="address"></textarea>
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
									type="number" class="form-control"  autocomplete="off" id="contactnumber" name="shopactlicense"
									placeholder="Enter Shop Act License Number">
							</div>
              <!-- /.form-group -->
               <div class="form-group">
								<label for="contactnumber">Food License Number</label> <input
									type="text" class="form-control" id="contactnumber"  autocomplete="off" name="foodlicense"
									placeholder="Enter Food License Number">
							</div>
              <!-- /.form-group -->
              <div class="form-group">
								<label for="contactnumber">Drug License Number</label> <input
									type="text" class="form-control" id="contactnumber" autocomplete="off"  name="druglicensen"
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
                  <input type="text" class="form-control pull-right datepicker"  autocomplete="off" id="addStockiest_datepicker"  name="druglicensevalidity">
                </div>
                <!-- /.input group -->
              </div>
              <!-- /.form-group -->
              <div class="form-group">
					<label for="contactnumber">GST Number</label> <input
						type="text" class="form-control" id="contactnumber"  autocomplete="off" name="gst"
						placeholder="Enter GST">
			  </div>
              <!-- /.form-group -->
              <div class="form-group">
					<label for="Status">Firm Constitution</label>
                  <div class="radio">
                    <label>
                      <input type="radio" name="firmconstitution" id="optionsRadios1" value="Proprietor" >Proprietor </label>
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
							<input type="text" class="form-control" autocomplete="off"   name="cpname1"
								placeholder="Enter Name">
						</div>
						<div class="col-md-3">
							<input type="number" class="form-control" 
								placeholder="Enter Contact Number"  autocomplete="off" name="cpphone1">
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
							<input type="text" class="form-control"   autocomplete="off" name="cpname2"
								placeholder="Enter Name">
						</div>
						<div class="col-md-3">
							<input type="number" class="form-control" 
								placeholder="Enter Contact Number"  autocomplete="off" name="cpphone2">
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