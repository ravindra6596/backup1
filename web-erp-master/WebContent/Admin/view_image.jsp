<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Blob"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp" %>
<%
Blob image = null;
byte[ ] imgData = null ;
String getData = "select * from emp_docs where eid = '14'";
Connection con = C3P0DataSource.getInstance().getConnection();
ResultSet rs = con.createStatement().executeQuery(getData);
if(rs.next()) {
	image = rs.getBlob("pan");
	imgData = image.getBytes(1,(int)image.length());
}

response.setContentType("image/png");

out.print(imgData);
out.flush();
out.close();
%>
<section class="content">

</section>

<%@ include file="footer.jsp" %>