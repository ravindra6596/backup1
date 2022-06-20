<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp" %>
			<section class="content-header">
			<h1>Add Product</h1>
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
				<li class="active">Add Product</li>
			</ol>
			</section>
			<!-- Main content -->
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
					<h3 class="box-title">Product Details</h3>
				</div>
				<form method="post" action="<%= rootpath %>productController">
				<div class="box-body">
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label>Name</label> <input type="text"  autocomplete="off" class="form-control" required="required" placeholder="Enter Product Name" name="pname">
							</div>
							<div class="row">
								<div class="form-group col-md-6">
									<label for="Status">Type</label>
									<div class="radio">
										<label> <input type="radio" name="ptype"
											id="optionsRadios1" value="Syrup" required="required">Syrup
										</label> <label> <input type="radio" name="ptype"
											id="optionsRadios1" value="Tablet" required="required" >Tablet
										</label>
									</div>
								</div>
								<div class="form-group col-md-6">
									<label for="Status">Group</label>
									<div class="radio">
										<label> <input type="radio" name="pgroup" id="optionsRadios4" value="Calcium" required >Calcium
										</label>
										<label> <input type="radio" name="pgroup" id="optionsRadios4" value="Protein" required>Protein
										</label>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="form-group col-md-3">
									<label for="contactnumber">MRP</label>
									<input type="number" autocomplete="off" class="form-control" id="contactnumber" placeholder="Enter MRP" name="mrp" step="any"required>
								</div>
								<div class="form-group col-md-3">
									<label for="contactnumber">PTR</label>
									<input type="number" autocomplete="off" class="form-control" id="contactnumber" placeholder="Enter PTR" name="ptr"required>
								</div>
								<div class="form-group col-md-3">
									<label for="contactnumber">PTS</label>
									<input type="number" autocomplete="off" class="form-control" id="contactnumber" placeholder="Enter PTS" name="pts"required>
								</div>
								<div class="form-group col-md-3">
									<label for="contactnumber">GST</label>
									<input type="number" autocomplete="off" class="form-control" id="contactnumber" name="gst" required placeholder="Enter GST">
								</div>
							</div>
							
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label>Packaging</label>
								<textarea class="form-control" rows="3" autocomplete="off" placeholder="Packaging Details" name="packaging" required></textarea>
							</div>
							<div class="form-group">
								<label>Detailing Story</label>
								<textarea class="form-control" rows="3" autocomplete="off" placeholder="Detailing Story" name="detailingstory" required></textarea>
							</div>
							<div class="form-group">
								<label>Composition</label>
								<textarea class="form-control" rows="3" autocomplete="off" placeholder="Composition" name="composition" required></textarea>
							</div>
						</div>
					</div>
					<div class="box-footer">
						<button type="submit" class="btn btn-primary pull-right" name="submit" value="ADD">Submit</button>
					</div>
				</div>
				<!-- Box Body -->
				</form>
			</div>
			</section>
<%@  include file="footer.jsp" %>