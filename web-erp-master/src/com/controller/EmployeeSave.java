package com.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model.C3P0DataSource;

/**
 * Servlet implementation class EmployeeSave
 */
@WebServlet("/EmployeeSave")
public class EmployeeSave extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EmployeeSave() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);

		try {
			ResultSet rs = null;
			String msg = null;

			Connection con = C3P0DataSource.getInstance().getConnection();
			Statement stmt = con.createStatement();

			String f = request.getParameter("flag");
			System.out.println("flag " + f);

			if (f.equals("ADD")) {

				add_employee(request, response);
			}

			else if (f.equals("update")) {
				update_employee(request, response);

			}

			else if (f.equals("Delete")) {
				delete_employee(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			String msg = "fail";
			response.sendRedirect("Admin/addemployee.jsp?response=" + msg);
		}
	}

	protected void add_employee(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ParseException {
		ResultSet rs = null;
		String msg = null;

		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement stmt = con.createStatement();

		String f = request.getParameter("flag");

		try {
			String username = request.getParameter("uname");
			String name = request.getParameter("name");
			String usertype = request.getParameter("usertype");
			String gender = request.getParameter("gender");
			String presentaddress = request.getParameter("presentaddress");
			String permanentadd = request.getParameter("permanentaddress");
			String email = request.getParameter("email");
			String bankdetail = request.getParameter("bankdetails");
			String dob = request.getParameter("dob");
			String doj = request.getParameter("doj");
			String designation = request.getParameter("designation");
			String education = request.getParameter("education");
			String licenseno = request.getParameter("licenseno");
			String aadharno = request.getParameter("aadharnumber");
			String panno = request.getParameter("pannumber");
			String insurancecovered = request.getParameter("insurancecovered");
			String emptype = request.getParameter("emptype");
			String isactive = request.getParameter("isactive");
			int auth = request.getParameter("auth") != null ? Integer.parseInt(request.getParameter("auth")) : 0;
			// int area = request.getParameter("area") != null ?
			// Integer.parseInt(request.getParameter("area")) : 0;
			String[] area = request.getParameterValues("headquarter");
			String mobile = request.getParameter("mobile");
			String emergencycontact = request.getParameter("emergencycontact");
			int age = request.getParameter("age") != null ? Integer.parseInt(request.getParameter("age")) : 0;

			String value = "";
			for (int i = 0; i < area.length; i++) {
				value += area[i] + ",";
			}

			if (dob != null) {
				String[] dobS = dob.split("-");
				dob = dobS[2] + "-" + dobS[1] + "-" + dobS[0];
			}
			if (doj != null) {
				String[] dojS = doj.split("-");
				doj = dojS[2] + "-" + dojS[1] + "-" + dojS[0];
			}

			String password = request.getParameter("password");
			// String epass = EncryptDecrypt.encrypt(password);

			String checkduplicate = "select * from employee where name = '" + name + "'";
			rs = stmt.executeQuery(checkduplicate);
			if (rs.next()) {
				msg = "duplicate";
				response.sendRedirect("Admin/addemployee.jsp?response=msg");

			} else {

				boolean inserted = RegisterUsingAPI(username, password);
				System.out.println("below" + inserted);
				if (inserted) {
					System.out.println("inside if below" + inserted);
					String query = "update employee set name='" + name + "',usertype='" + usertype + "',assignedauth='"
							+ auth + "',gender='" + gender + "',presentaddress='" + presentaddress
							+ "',permanentaddress='" + permanentadd + "',mobile='" + mobile + "',emergencycontact='"
							+ emergencycontact + "',email='" + email + "',bankdetails='" + bankdetail + "',dob='" + dob
							+ "',doj='" + doj + "',haid='" + area + "',education='" + education + "',age='" + age
							+ "',licenseno='" + licenseno + "',insurancecovered='" + insurancecovered + "',emptype='"
							+ emptype + "',isactive='" + isactive + "',designation='" + designation
							+ "' WHERE username='" + username + "'";
					// int updateFlag=0;
					int updateFlag = stmt.executeUpdate(query);
					System.out.println(query);
					if (updateFlag != 0) {
						msg = "success";
						request.setAttribute("msg", msg);
						response.sendRedirect("Admin/addemployee.jsp?response=msg" + msg);
					}
				}

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		con.close();
	}

	protected void update_employee(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ParseException, IOException {
		ResultSet rs = null;
		String msg = null;

		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement stmt = con.createStatement();

		String username = request.getParameter("uname");
		String name = request.getParameter("name");
		String usertype = request.getParameter("usertype");
		String gender = request.getParameter("gender");
		String presentaddress = request.getParameter("presentaddress");
		String permanentadd = request.getParameter("permanentaddress");
		String mobile = request.getParameter("mobile");
		String emergencycontact = request.getParameter("emergencycontact");
		String email = request.getParameter("email");
		String bankdetail = request.getParameter("bankdetails");
		String pan = request.getParameter("pan");
		String aadhar = request.getParameter("aadhar");
		String dob = request.getParameter("dob");
		String doj = request.getParameter("doj");
		int auth = request.getParameter("auth") != null ? Integer.parseInt(request.getParameter("auth")) : 0;
		int area = request.getParameter("area") != null ? Integer.parseInt(request.getParameter("area")) : 0;
		int age = request.getParameter("age") != null ? Integer.parseInt(request.getParameter("age")) : 0;
		String designation = request.getParameter("designation");
		String education = request.getParameter("education");
		String licenseno = request.getParameter("licenseno");
		String insurancecovered = request.getParameter("insurancecovered");
		String emptype = request.getParameter("emptype");
		String isactive = request.getParameter("isactive");

		if (dob != null) {
			String[] dobS = dob.split("-");
			dob = dobS[2] + "-" + dobS[1] + "-" + dobS[0];
		}
		if (doj != null) {
			String[] dojS = doj.split("-");
			doj = dojS[2] + "-" + dojS[1] + "-" + dojS[0];
		}

		String s_id = request.getParameter("id");
		int id = 0;
		if (s_id != null) {
			id = Integer.parseInt(s_id);
		}

		try {
			int updateFlag = stmt.executeUpdate("update employee set name='" + name + "',usertype='" + usertype
					+ "',assignedauth='" + auth + "',gender='" + gender + "',presentaddress='" + presentaddress
					+ "',permanentaddress='" + permanentadd + "',mobile='" + mobile + "',emergencycontact='"
					+ emergencycontact + "',email='" + email + "',bankdetails='" + bankdetail + "',dob='" + dob
					+ "',doj='" + doj + "',haid='" + area + "',education='" + education + "',age='" + age
					+ "',licenseno='" + licenseno + "',insurancecovered='" + insurancecovered + "',emptype='" + emptype
					+ "',isactive='" + isactive + "',designation='" + designation + "' WHERE eid='" + id + "'");
			if (updateFlag != 0) {
				msg = "success";
				request.setAttribute("msg", msg);
				response.sendRedirect("Admin/singleEmployee.jsp?eid=" + id + "&res=" + msg);
			} else {
				msg = "fail";
				request.setAttribute("msg", msg);
				response.sendRedirect("Admin/singleEmployee.jsp?eid=" + id + "&res=" + msg);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		con.close();
	}

	protected void delete_employee(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ResultSet rs = null;
		String msg = null;

		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement stmt = con.createStatement();

		String f = request.getParameter("flag");

		int id = Integer.parseInt(request.getParameter("id"));
		try {
			int DeleteFlag = stmt.executeUpdate("delete from employee where eid = '" + id + "'");

			msg = null;
			if (DeleteFlag != 0) {
				msg = "success";
				response.sendRedirect("Admin/Employeemgm.jsp?response=" + msg);
			} else {
				msg = "fail";
				response.sendRedirect("Admin/Employeemgm.jsp?response=" + msg);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		con.close();
	}

	protected boolean RegisterUsingAPI(String username, String password) {
		try {

			URL url = new URL("https://45f33f7c8771.ngrok.io/register");// your url i.e fetch data from .
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setDoOutput(true);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Type", "application/json");

			String input = "{\"username\":\"" + username + "\",\"password\":\"" + password + "\"}";
			OutputStream os = conn.getOutputStream();
			os.write(input.getBytes());
			os.flush();

			if (conn.getResponseCode() != 200) {
				// throw new RuntimeException("Failed : HTTP Error code : "
//                        + conn.getResponseCode());
				return true;
			}

			conn.disconnect();
			return false;
		} catch (Exception e) {
			System.out.println("Exception in NetClientGet:- " + e);
			return false;
		}

	}
}
