package com.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;

import com.model.C3P0DataSource;

import org.apache.tomcat.util.codec.binary.Base64;


/**
 * Servlet implementation class LoginController
 */
@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = request.getParameter("uname");
		String password = request.getParameter("upass");
		String bvalue = request.getParameter("login");
		String path = request.getParameter("urlpath");
		System.out.println("logging - " + username);
		PrintWriter out = response.getWriter();
		try
		{System.out.println("inside try block");
			Connection con = C3P0DataSource.getInstance().getConnection();System.out.println("inside try"+con);
		 Statement stmt = con.createStatement();
		 ResultSet rs=null;
		 System.out.println(con);
		 if(bvalue.equals("Log In"))
		 {System.out.println("inside if");
		 String checkduplicate = "select eid, usertype, username,password, name from employee where username = '"+username+"' ";
		 System.out.println("loggin - " + username);
		 rs = stmt.executeQuery(checkduplicate);
		 System.out.println(checkduplicate);
		 if(rs.next()){
			 boolean validated = false;
			 //Validate token present in DB
			 validated = validateFromDB(username);
			 if(!validated) {
				//Validate from API
				 validated = validateFromAPI(username, password);
			 }
	 
			 if(validated)
			 {
				 String utype = rs.getString("usertype");
				 String name = rs.getString("name");
				 int eid = rs.getInt("eid");
				 if(path.equals("null")) {
					 HttpSession session = request.getSession();
					 session.setAttribute("uname",username);
					 session.setAttribute("usertype",utype);
					 session.setAttribute("id", eid);
					 
					 response.sendRedirect("Admin/admindashboard.jsp");
				 }else if(path != null) {
					 HttpSession session = request.getSession();
					 session.setAttribute("uname",username);
					 session.setAttribute("usertype",utype);
					 session.setAttribute("id", eid);
					 response.sendRedirect(path);
				 }
			 }
			 else
			 {
				 String msg = "wrong details";
				 response.sendRedirect("index.jsp?res="+msg);
			 }
		 }
		
		 else
		 { 
			 String msg = "wrong details";
			 response.sendRedirect("index.jsp?res="+msg);
		 }
		 }
		 else if(bvalue.equals("logout"))
		 {
			 HttpSession session=request.getSession(false);
			 session=request.getSession();
			session.invalidate();
			response.sendRedirect("index.jsp");	
			out.println("<p class='register-title' style='font-size:20px;margin-top:10px'>Logged Out Succesfully!</p>");
			 
		 }
		}
		catch(Exception e)
		{
			System.out.println("Exception while logging in:- " + e);
			HttpSession session=request.getSession(false);
			session=request.getSession();
			session.invalidate();
			response.sendRedirect("index.jsp");
			out.println("<p class='register-title' style='font-size:20px;margin-top:10px'>Something went wrong! Please login again!</p>");
		}
	}
	public void doPost(HttpServletRequest req,HttpServletResponse resp) throws ServletException,IOException
	{
		doGet(req,resp);
	}
	
	private boolean validateFromDB(String username) throws SQLException, JSONException {
		//check if token present in DB
		String token = null;
		//Query here
		
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement stmt = con.createStatement();
		ResultSet rs=null;
		String query="select token from web_token WHERE username ='"+username+"'";
		System.out.println("q - " + query);
	   	rs=stmt.executeQuery(query);

		if(!rs.next()) 
			return false;
		
		
		System.out.println("qs - ");
		//check validity of token, JSON parse
		String jwtToken = rs.getString("token");
		String[] split_string = jwtToken.split("\\.");
        String base64EncodedHeader = split_string[0];
        String base64EncodedBody = split_string[1];
        String base64EncodedSignature = split_string[2];
        
        Base64 base64Url = new Base64(true);
        String header = new String(base64Url.decode(base64EncodedHeader));
        String body = new String(base64Url.decode(base64EncodedBody));
        System.out.println("body - " + body); 
        JSONObject obj = new JSONObject(body);

        long currTime = System.currentTimeMillis() / 1000;
        long expiryTime = obj.getLong("exp") ;
        
        return currTime <= expiryTime ? true : false;
	}
	

	  
	protected boolean validateFromAPI(String username,String password) {
		try {

            URL url = new URL("http://healthcareapi-env.eba-83fpcz2g.ap-south-1.elasticbeanstalk.com/authenticate");//your url i.e fetch data from .
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
    		conn.setRequestMethod("POST");
    		conn.setRequestProperty("Content-Type", "application/json");

    		String input = "{\"username\":\""+username+"\",\"password\":\""+password+"\"}";
    		OutputStream os = conn.getOutputStream();
    		os.write(input.getBytes());
    		os.flush();
    		System.out.println("validated - " + conn.getResponseCode());
    		if (conn.getResponseCode() != 200) {
             //     throw new RuntimeException("Failed : HTTP Error code : "
//                        + conn.getResponseCode());
            	return false;
            }
    		
        
            InputStreamReader in = new InputStreamReader(conn.getInputStream());
            BufferedReader br = new BufferedReader(in);
            String output;
            while ((output = br.readLine()) != null) {
               
                JSONObject obj = new JSONObject(output);
                String token = obj.getString("token");
                //Insert in DB here
                Connection con = C3P0DataSource.getInstance().getConnection();
                
        		PreparedStatement stmt = con.prepareStatement("insert into web_token (username,token) values (?,?)");
        		stmt.setString(1, username);      
        		stmt.setString(2,token);
        		stmt.execute();
        		int rs;
        	  }
            conn.disconnect();
            return true;
        } catch (Exception e) {
            System.out.println("Exception in NetClientGet:- " + e);
            return false;
        }
		
	}
}
