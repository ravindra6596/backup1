package com.controller;

import java.io.IOException;
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
 * Servlet implementation class ChemistSave
 */
@WebServlet("/ChemistSave")
public class ChemistSave extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ChemistSave() {
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

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);

		try {

			int cid1 = 0;
			String f = request.getParameter("flag");

			if (f.equalsIgnoreCase("ADD")) {
				add_chemist(request, response);
			}

			else if (f.equalsIgnoreCase("Update")) {
				update_chemist(request, response);
			} else if (f.equalsIgnoreCase("delete")) {
				delete_chemist(request, response);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	protected void add_chemist(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ParseException, IOException {

		ResultSet rs = null;
		String msg = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement stmt = con.createStatement();

		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String email = request.getParameter("email");
		String shopactlicense = request.getParameter("shopactlicense");
		String druglicense = request.getParameter("druglicensen");
		String gst1 = request.getParameter("gst");
		String headquarter = request.getParameter("headquarter");
		String firmconstitution = request.getParameter("firmconstitution");
		String foodlicense = request.getParameter("foodlicense");
		String cpname1 = request.getParameter("cpname1");
		String cpname2 = request.getParameter("cpname2");
		long shoptelephone = 0, mobile = 0, phone1 = 0, phone2 = 0;
		String cpphone1 = request.getParameter("cpphone1");
		String cpphone2 = request.getParameter("cpphone2");
		String shoptelephone1 = request.getParameter("shoptelephone");
		String mobile1 = request.getParameter("mobile");
		String druglicensevalidity = request.getParameter("druglicensevalidity");
		if (druglicensevalidity != null) {
			String[] dobS = druglicensevalidity.split("-");
			druglicensevalidity = dobS[2] + "-" + dobS[1] + "-" + dobS[0];
			System.out.println(druglicensevalidity);
		}
		if (shoptelephone1 != "") {
			shoptelephone = Long.parseLong(shoptelephone1);
		} else {
			shoptelephone = 0;
		}

		if (mobile1 != "") {

			mobile = Long.parseLong(mobile1);
		} else {
			mobile = 0;

		}

		if (cpphone2 != "") {
			phone2 = Long.parseLong(cpphone2);
		} else {
			phone2 = 0;

		}

		if (cpphone1 != "") {
			phone1 = Long.parseLong(cpphone1);
		} else {
			phone1 = 0;
		}
		try {
			String checkduplicate = "select * from chemists where name ='" + name + "'";
			rs = stmt.executeQuery(checkduplicate);
			if (rs.next()) {
				msg = "duplicate";
				response.sendRedirect("Admin/addchemist.jsp?response=" + msg);
			} else {
				int insertflag = stmt.executeUpdate(
						"insert into chemists(name,address,shoptelephone,mobile,email,shopactlicense,druglicense,druglicensevalidity,gst,headquarter,firmconstitution,foodlicense) value('"
								+ name + "','" + address + "','" + shoptelephone + "','" + mobile + "','" + email
								+ "','" + shopactlicense + "','" + druglicense + "','" + druglicensevalidity + "','"
								+ gst1 + "','" + headquarter + "','" + firmconstitution + "','" + foodlicense + "')");
				if (insertflag != 0) {
					String said = "SELECT cid FROM chemists WHERE name='" + name + "'";
					rs = stmt.executeQuery(said);
					int insertcont = 0;
					if (rs.next()) {
						int chemistsid = rs.getInt("cid");
						insertcont = stmt.executeUpdate(
								"insert into chemistscontact (cpname1,cpphone1,cpname2,cpphone2,cid) values('" + cpname1
										+ "','" + phone1 + "','" + cpname2 + "','" + phone2 + "','" + chemistsid
										+ "')");
						if (insertcont != 0) {
							msg = "success";
							// response.sendRedirect("Admin/doc_upload.jsp?response="+msg);
							response.sendRedirect("Admin/addchemist.jsp?response=" + msg);
						}
					}
				}
				msg = "fail";
				response.sendRedirect("Admin/addchemist.jsp?response=" + msg);

			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		con.close();
	}

	protected void update_chemist(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ParseException, IOException {

		ResultSet rs = null;
		String msg = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement stmt = con.createStatement();

		String druglicensevalidity = request.getParameter("druglicensevalidity");
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String email = request.getParameter("email");
		String shopactlicense = request.getParameter("shopactlicense");
		String druglicense = request.getParameter("druglicense");
		String gst1 = request.getParameter("gst");
		String headquarter = request.getParameter("headquarter");
		String firmconstitution = request.getParameter("firmconstitution");
		String foodlicense = request.getParameter("foodlicense");
		String cpname1 = request.getParameter("cpname1");
		String cpname2 = request.getParameter("cpname2");
		long shoptelephone = 0, mobile = 0, phone1 = 0, phone2 = 0;
		String cpphone1 = request.getParameter("cpphone1");
		String cpphone2 = request.getParameter("cpphone2");
		String shoptelephone1 = request.getParameter("shoptelephone");
		String mobile1 = request.getParameter("mobile");
		if (druglicensevalidity != null) {
			String[] dobS = druglicensevalidity.split("-");
			druglicensevalidity = dobS[2] + "-" + dobS[1] + "-" + dobS[0];
			System.out.println(druglicensevalidity);
		}
		if (shoptelephone1 != "") {
			shoptelephone = Long.parseLong(shoptelephone1);
		} else {
			shoptelephone = 0;
		}

		if (mobile1 != "") {

			mobile = Long.parseLong(mobile1);
		} else {
			mobile = 0;

		}

		if (cpphone2 != "") {
			phone2 = Long.parseLong(cpphone2);
		} else {
			phone2 = 0;

		}

		if (cpphone1 != "") {
			phone1 = Long.parseLong(cpphone1);
		} else {
			phone1 = 0;
		}
		String _cid = request.getParameter("id");
		int cid = 0;
		if (_cid != null) {
			cid = Integer.parseInt(_cid);
		}
		int updatechemists = stmt.executeUpdate("update chemists set name='" + name + "',address='" + address
				+ "',shoptelephone='" + shoptelephone + "',mobile='" + mobile + "',email='" + email
				+ "',shopactlicense='" + shopactlicense + "',druglicense='" + druglicense + "',druglicensevalidity='"
				+ druglicensevalidity + "',gst='" + gst1 + "',headquarter='" + headquarter + "',firmconstitution='"
				+ firmconstitution + "',foodlicense='" + foodlicense + "' WHERE cid='" + cid + "' ");
		if (updatechemists != 0) {
			int updatecont = stmt.executeUpdate("update chemistscontact set cpname1='" + cpname1 + "',cpphone1='"
					+ phone1 + "',cpname2='" + cpname2 + "',cpphone2='" + phone2 + "' where cid='" + cid + "' ");
			if (updatecont != 0) {
				msg = "success";
				response.sendRedirect("Admin/updatechemist.jsp?id=" + cid + "&response=" + msg);
			}

		}

		else {
			System.out.println("somthing went wrong");
		}

		con.close();
	}

	protected void delete_chemist(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ParseException, IOException {

		ResultSet rs = null;
		String msg = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement stmt = con.createStatement();

		int cid = Integer.parseInt(request.getParameter("id"));
		int deletescont = stmt.executeUpdate("delete from chemistscontact where cid='" + cid + "'");
		if (deletescont != 0) {
			int deleteflag = stmt.executeUpdate("delete from chemists where cid='" + cid + "'");
			if (deleteflag != 0) {
				msg = "success";
				response.sendRedirect("Admin/allchemist.jsp?response=" + msg);
			}
		} else {
			System.out.println("somthing went wrong");
			msg = "fail";
			response.sendRedirect("Admin/allchemist.jsp?response=" + msg);
		}

		con.close();
	}

}
