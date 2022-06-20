<%@page import="java.util.HashMap"%>
<%@page import="org.json.JSONArray"%>
<%@page import="com.Admin.Classes.BrandTrend"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp" %>

	<section class="content-header">
	<h1>Month-wise Product-wise Sale Report</h1>
	
</section>

<!-- Main content -->
<section class="content">
	<div class="row">
		<div class="col-xs-12">

			<div class="box">
				<div class="box-header"></div>
				<!-- /.box-header -->
				<div class="box-body">
					<form action="" method="post">
						<div class="row">
							<div class="col-md-3">
								<div class="form-group">
					                <label>Select Months:</label>
					                <select class="form-control select2" multiple="multiple" data-placeholder="Select months" name="month[]"
					                        style="width: 100%;">
					                    <option>January</option>
					                    <option>February</option>
					                    <option>March</option>
					                    <option>April</option>
					                    <option>May</option>
					                    <option>June</option>
					                    <option>July</option>
					                    <option>August</option>
					                    <option>September</option>
					                    <option>October</option>
					                    <option>November</option>
					                    <option>December</option>
					                </select>
					            </div>
							</div>
							<div class="col-md-3">
								<div class="form-group">
					                <label>Year:</label>
					
					                <div class="input-group date">
					                  <div class="input-group-addon">
					                    <i class="fa fa-calendar"></i>
					                  </div>
					                  <input type="text" autocomplete="off" class="form-control pull-right" id="brandtrend_datepicker" name="year">
					                </div>
					                <!-- /.input group -->
					            </div>
							</div>
							<div class="col-md-2">
								<div class="form-group">
									<button type="submit" class="btn btn-primary " name="submit"
										value="submit" style="margin-top: 25px;">Search</button>
								</div>
							</div>
						</div>
					</form>
					<%
						
						String submit = request.getParameter("submit");
						//List <String> plist = new ArrayList<String>();
				    	//List<String> month = new ArrayList<String>();
				    	
					if(submit != null){
						String [] months = request.getParameterValues("month[]");
						int year = Integer.parseInt(request.getParameter("year"));
						
						JSONObject json = BrandTrend.GetBrandTrend(months, year);   
						int procount=0;
						JSONArray plist = json.getJSONArray("plist");
						JSONArray month = json.getJSONArray("months");
						int [][] list = (int [][]) json.get("list");
						procount = json.getInt("procount");
						
						String json_parse = json.toString();
						System.out.println(json_parse);
						
						HashMap< String , int[][]> listMap = new HashMap<String, int[][]>();
						listMap.put("list", list);
						
				    	
					
					%>
					
					<%
					Connection con = C3P0DataSource.getInstance().getConnection();
					ResultSet rs=null;
			    	String get_productMonth = "SELECT pname, quantity, MONTHNAME(orders.orderdate) AS MONTH FROM placeorder INNER JOIN orders ON orders.`orderid`=placeorder.`orderid` INNER JOIN product ON product.pid = placeorder.pid";
					rs = con.createStatement().executeQuery(get_productMonth);
					
					%>
					
					<div class="row">
						<div class="col-md-12">
							<table class="table table-bordered">
								<tr>
									<th style="background-color: #d2d6de ; font-weight: bold; max-width: 200px;">Products</th>
									<% for(int j=0;j<month.length();j++) {%>
							 		<th style="background-color: #3c8dbc; color: white; ">
					            		<%= month.getString(j) %>
					            	</th>
					            	<%} %>
								</tr>
								<% for(int i=0;i<procount;i++){ %>
								<tr>
									<td style=" font-weight: bold;"><%= plist.getString(i) %></td>
									<%for(int j=0;j<month.length();j++){ %>
									<td><%= list[i][j] %></td>
									<% } %>
								</tr>
								<% } %>
							</table>

						</div>
					</div>
					
				</div>
				<div class="box-footer">
	            	<form action="<%= rootpath %>Exporter" method="post">
	            		<input type="hidden" name="jsonobject" value='<%= json %>'>
	            		<input type="hidden" name="list" value="<%= listMap %>">
	            		<button type="submit" class="btn btn-primary pull-right" name="export" value="export_BrandTrend" style="background-color: #00a65a;">Export Sheet</button>
	             	</form>
	            </div>
	            <%} 
					%>
			</div>
		</div>
	</div>
</section>

<%@ include file="footer.jsp" %>