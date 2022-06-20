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
 * Servlet implementation class StockiestSave
 */
@WebServlet("/StockiestSave")
public class StockiestSave extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public StockiestSave() {
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

			int sid1 = 0;

			String f = request.getParameter("flag");

			if (f.equalsIgnoreCase("ADD")) {

				add_stockiest(request, response);
			}

			else if (f.equalsIgnoreCase("Update")) {
				update_stockiest(request, response);

			} else if (f.equalsIgnoreCase("delete")) {
				delete_stockiest(request, response);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	protected void add_stockiest(HttpServletRequest request, HttpServletResponse response)
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
//		SimpleDateFormat sdfd = new SimpleDateFormat("dd-mm-yyyy");
//		java.util.Date d1 = sdfd.parse(druglicensevalidity);
//		Date dateDB1 = new java.sql.Date(d1.getTime());
		if (druglicensevalidity != null) {
			String[] dobS = druglicensevalidity.split("-");
			druglicensevalidity = dobS[2] + "-" + dobS[1] + "-" + dobS[0];
			System.out.println(druglicensevalidity);
		}
//		if (druglicensevalidity == null) {
//			druglicensevalidity = "";
//		}
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
			String checkduplicate = "select * from stockiest where name ='" + name + "'";
			rs = stmt.executeQuery(checkduplicate);
			if (rs.next()) {
				msg = "duplicate";
				response.sendRedirect("Admin/AddStockiest.jsp?response=" + msg);
			} else {
				int insertflag = stmt.executeUpdate(
						"insert into stockiest(name,address,shoptelephone,mobile,email,shopactlicense,druglicense,druglicensevalidity,gst,district,firmconstitution,foodlicense) value('"
								+ name + "','" + address + "','" + shoptelephone + "','" + mobile + "','" + email
								+ "','" + shopactlicense + "','" + druglicense + "','" + druglicensevalidity + "','"
								+ gst1 + "','" + headquarter + "','" + firmconstitution + "','" + foodlicense + "')");
				if (insertflag != 0) {
					String said = "SELECT sid FROM stockiest WHERE name='" + name + "'";
					rs = stmt.executeQuery(said);
					int insertcont = 0;
					if (rs.next()) {
						int stockiestid = rs.getInt("sid");
						insertcont = stmt.executeUpdate(
								"insert into stokiestcontact (cpname1,cpphone1,cpname2,cpphone2,sid) values('" + cpname1
										+ "','" + phone1 + "','" + cpname2 + "','" + phone2 + "','" + stockiestid
										+ "')");
						if (insertcont != 0) {
							msg = "success";
							// response.sendRedirect("Admin/doc_upload.jsp?response="+msg);
							response.sendRedirect("Admin/AddStockiest.jsp?response=" + msg);
						}
					}
				}
//				msg = "fail";
//				response.sendRedirect("Admin/AddStockiest.jsp?response=" + msg);

			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		con.close();
	}

	protected void update_stockiest(HttpServletRequest request, HttpServletResponse response)
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
		String _sid = request.getParameter("id");
		int sid = 0;
		if (_sid != null) {
			sid = Integer.parseInt(_sid);
		}
		int updatestockiest = stmt.executeUpdate("update stockiest set name='" + name + "',address='" + address
				+ "',shoptelephone='" + shoptelephone + "',mobile='" + mobile + "',email='" + email
				+ "',shopactlicense='" + shopactlicense + "',druglicense='" + druglicense + "',druglicensevalidity='"
				+ druglicensevalidity + "',gst='" + gst1 + "',district='" + headquarter + "',firmconstitution='"
				+ firmconstitution + "',foodlicense='" + foodlicense + "' WHERE sid='" + sid + "' ");
		if (updatestockiest != 0) {
			int updatecont = stmt.executeUpdate("update stokiestcontact set cpname1='" + cpname1 + "',cpphone1='"
					+ phone1 + "',cpname2='" + cpname2 + "',cpphone2='" + phone2 + "' where sid='" + sid + "' ");
			if (updatecont != 0) {
				msg = "success";
				response.sendRedirect("Admin/UpdateStockiest.jsp?id=" + sid + "&response=" + msg);
			}

		}

		else {
			System.out.println("somthing went wrong");
		}
		con.close();
	}

	protected void delete_stockiest(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ParseException, IOException {

		ResultSet rs = null;
		String msg = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement stmt = con.createStatement();

		int sid = Integer.parseInt(request.getParameter("id"));
		int deletescont = stmt.executeUpdate("delete from stokiestcontact where sid='" + sid + "'");
		if (deletescont != 0) {
			int deleteflag = stmt.executeUpdate("delete from stockiest where sid='" + sid + "'");
			if (deleteflag != 0) {
				msg = "success";
				response.sendRedirect("Admin/allstockiest.jsp?response=" + msg);
			}
		} else {
			System.out.println("somthing went wrong");
			msg = "fail";
			response.sendRedirect("Admin/allstockiest.jsp?response=" + msg);
		}
		con.close();
	}

}
