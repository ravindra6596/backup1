<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<%@ page import ="javax.sql.*" %> 
<%@ page import ="com.model.*" %>

<% String type = request.getParameter("type");
System.out.println(type);
try{
	Connection con = C3P0DataSource.getInstance().getConnection();
	Statement st1= con.createStatement();
	PreparedStatement ps1 = null;
	ResultSet rs = null;
	if(type.equalsIgnoreCase("RBM")){
		String qry = "SELECT eid,name FROM employee WHERE usertype =?";
		 /* rs = st1.executeQuery(qry); */
		ps1 = con.prepareStatement(qry);
		ps1.setString(1,"BU");
		rs=ps1.executeQuery(); 
		List <String> names = new ArrayList<String>();
		List<Integer> ids = new ArrayList<Integer>();
		JSONObject jsobj = new JSONObject();
	}else if(type.equalsIgnoreCase("ABM")){
		String qry = "SELECT eid, name FROM employee WHERE usertype =?";
		 /* rs = st1.executeQuery(qry); */
		ps1 = con.prepareStatement(qry);
		ps1.setString(1,"RBM");
		rs=ps1.executeQuery(); 
		List <String> names = new ArrayList<String>();
		List<Integer> ids = new ArrayList<Integer>();
		JSONObject jsobj = new JSONObject();
		while(rs.next())
			{
			ids.add(rs.getInt("eid"));
			names.add(rs.getString("name"));
			} 
			jsobj.put("name", names);
			jsobj.put("ids",ids);
			out.print(jsobj);
	}else if(type.equalsIgnoreCase("TM")){
		String qry = "SELECT eid,name FROM employee WHERE usertype =?";
		 /* rs = st1.executeQuery(qry); */
		ps1 = con.prepareStatement(qry);
		ps1.setString(1,"ABM");
		rs=ps1.executeQuery();
		List <String> names = new ArrayList<String>();
		List<Integer> ids = new ArrayList<Integer>();
		JSONObject jsobj = new JSONObject();
		while(rs.next())
		{
			ids.add(rs.getInt("eid"));
			names.add(rs.getString("name"));
		} 
		jsobj.put("name", names);
		jsobj.put("ids",ids);
		out.print(jsobj);
	}
	
	String abcstat_option = request.getParameter("option");
	System.out.println(abcstat_option);
	int abcstat_id = Integer.parseInt(request.getParameter("id"));
	System.out.println(abcstat_id);
	System.out.println(abcstat_option);
	
		
	Statement stmt = con.createStatement();
	int update =0;
	update = stmt.executeUpdate("update abcstatrecord set status='"+abcstat_option+"' where recordid='"+abcstat_id+"'");
	if(update!=0){
		System.out.println("updated");
	}
	
}
catch(Exception e)
{
	e.printStackTrace();
	}
%>
