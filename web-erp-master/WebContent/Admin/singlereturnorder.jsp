<%@page import="com.model.C3P0DataSource"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.tomcat.util.codec.binary.Base64"%>
<%@page import="java.io.OutputStream"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ include file="header.jsp"%>
<%
Connection con = C3P0DataSource.getInstance().getConnection();
	Statement st = con.createStatement();
	ResultSet rs = null;
	int orderid = Integer.parseInt(request.getParameter("orderid"));
	String sql = "SELECT DATE_FORMAT(o.orderdate, '%d-%m-%Y') as odate, e.name as empname,c.name AS cname,o.type FROM order_products op INNER JOIN orders o ON o.orderid = op.orderid INNER JOIN chemists c on c.cid = o.cid INNER JOIN employee e ON e.eid = o.eid WHERE o.orderid = '"
			+ orderid + "' LIMIT 1";
	rs = st.executeQuery(sql);
	System.out.println(sql);
	
	
%>
<section class="content-header">
	<h1>Order Type Details</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Order Type</li>
	</ol>
</section>

<section class="content">
	<div class="row">
		<div class="col-sm-12">
			<div class="box box-default">
				
				<div id="box1" class="box-body" style="display: block;">
					<%
						while (rs.next()) {
					%>
					<div class="row">
						<div class="col-sm-6">
							<table class="table table-bordered  ">
								<thead>
									<tr>
										<th>Details</th>
										<th>Data</th>
									</tr>
								</thead>
								<tbody>
								<tr>
										<td>Chemist Name</td>
										<td><%=rs.getString("cname")%></td>
									</tr>
									<tr>
										<td>Employee Name</td>
										<td><%=rs.getString("empname")%></td>
									</tr>
									<tr>
										<td>Order Date</td>
										<td><%=rs.getString("odate")%></td>
									</tr>
										<tr>
										<%
// 												if (rs.getString("type").equals("sale")) {
// 															out.print("Sale");
// 														} else if (rs.getString("type").equals("return")) {
// 															out.print("Return");
// 														} else if (rs.getString("type").equals("expired")) {
// 															out.print("Expired");
// 														}else{
											%>
										<td>Order Type </td>
										<td><%=rs.getString("type")%></td>
										<%//} %>
									</tr>
								</tbody>
							</table>
							<%
						}
					%>
							<table class="table table-bordered  ">
								<thead>
									<tr>
										<th>Product Name</th>
										<th>Quantity</th>
										<th>Price</th>
										<th>Amount</th>
									</tr>
								</thead>
								<%
								ResultSet rst = null;
								
								String proquery = "SELECT p.pname,op.quantity as proquantity,p.mrp,(p.mrp * op.quantity)as total FROM order_products op INNER JOIN product p ON op.pid=p.pid WHERE op.orderid = '"
										+ orderid + "' ";
								rst = st.executeQuery(proquery);
								System.out.println(proquery);
								
								%>
								<tbody>
								<%
								while(rst.next()){
								%>
									<tr>
										<td><%=rst.getString("pname") %></td>
										<td><%=rst.getString("proquantity") %></td>
										<td><%=rst.getFloat("mrp") %></td>
										<td><%=rst.getFloat("total") %></td>
									</tr>
									
									<%}%>
									<tr>
									<%
									ResultSet rstmt=null;
									String total = "SELECT SUM(p.mrp * op.quantity) mrptotal FROM order_products op INNER JOIN product p ON op.pid=p.pid WHERE op.orderid = '"
											+ orderid + "' ";
									rstmt = st.executeQuery(total);
									%>
									<%while(rstmt.next()){ %>
									<td  colspan="3" style="text-align: center;" >Total Amount</td>
									
									<td style="background-color: #eee;opacity: 1;user-select: none;cursor: no-drop;"><%=rstmt.getFloat("mrptotal") %></td></tr>
									<%} %>
								</tbody>
							</table>
							
						</div>
					</div>
					
				</div>
			</div>
		</div>
	</div>
</section>
<%@ include file="footer.jsp"%>