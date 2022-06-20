package com.controller;

import java.io.IOException;
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

import com.model.C3P0DataSource;

/**
 * Servlet implementation class Area
 */
@WebServlet("/Area")
public class Area extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String hq_expense;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Area() {
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
		String id = request.getParameter("id");
		if (id != null) {
			int said = Integer.parseInt(id);
			int deleteSub;
			try {
				Connection con = C3P0DataSource.getInstance().getConnection();
				deleteSub = con.createStatement().executeUpdate("delete from headquarters where haid='" + said + "'");
				if (deleteSub != 0) {
					String msg = "success";
					request.setAttribute("msg", msg);
					response.sendRedirect("Admin/areamgm.jsp");
				}
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
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

		String submit = request.getParameter("submit");
		String submit1 = request.getParameter("submit_delete");
		try {
			if (submit != null && submit.equals("ADD_REGION")) {
				add_region(request, response);
			} else if (submit != null && submit.equals("ADD_DISTRICT")) {
				add_district(request, response);
			} else if (submit != null && submit.equals("ADD_HEADQUARTER")) {
				add_headquarter(request, response);
			} else if (submit1 != null && submit1.equals("REGION_DELETE")) {
				region_delete(request, response);
			} else if (submit1 != null && submit1.equals("DISTRICT_DELETE")) {
				district_delete(request, response);
			} else if (submit1 != null && submit1.equals("HEADQUARTER_DELETE")) {
				headquarter_delete(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static ResultSet Headquarter() throws SQLException {
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement state = con.createStatement();
		ResultSet rs = state.executeQuery("select * from regions");
		return rs;
	}

	protected void add_region(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		PreparedStatement ps1 = null;
		Statement st = null;
		ResultSet rs = null;
		int hid1 = 0;
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement st1 = con.createStatement();
		String region = request.getParameter("region");
		if (region != null) {
			String headidcheck = "SELECT raid FROM regions WHERE region='" + region + "'";
			rs = st1.executeQuery(headidcheck);
			if (rs.next()) {
				hid1 = rs.getInt("raid");
				response.sendRedirect("Admin/regions.jsp?res=duplicate&msg=Duplicate data available");
			} else {
				String headQuery = "INSERT INTO regions(region) VALUES (?)";
				ps1 = con.prepareStatement(headQuery);
				ps1.setString(1, region);

				int insertflag = ps1.executeUpdate();
				if (insertflag != 0) {
					response.sendRedirect("Admin/regions.jsp?res=success&msg=Data inserted successfully");
				} else {
					response.sendRedirect("Admin/regions.jsp?res=fail&msg=Data insertion failed");
				}
			}
		}
		con.close();
	}

	protected void add_district(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		PreparedStatement ps1 = null;
		Statement st = null;
		ResultSet rs = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement st1 = con.createStatement();
		String headquarter = request.getParameter("district");
		String raid = request.getParameter("raid");
		if (headquarter != null && raid != null) {
			int hid = Integer.parseInt(raid);
			String areaidcheck = "SELECT daid FROM districts WHERE district='" + headquarter + "'";
			rs = st1.executeQuery(areaidcheck);
			if (rs.next()) {
				response.sendRedirect("Admin/addArea.jsp?res=duplicate&msg=Duplicate data available");
			} else {
				String areaQuery = "INSERT INTO districts(district, raid) VALUES (?,?)";
				ps1 = con.prepareStatement(areaQuery);
				ps1.setString(1, headquarter);
				ps1.setInt(2, hid);

				int insertflag = ps1.executeUpdate();
				if (insertflag != 0) {
					response.sendRedirect("Admin/districts.jsp?res=success&msg=Data inserted successfully");
				} else {
					response.sendRedirect("Admin/districts.jsp?res=fail&msg=Data insertion failed");
				}
			}
		}
		con.close();
	}

	protected void add_headquarter(HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException {

		PreparedStatement ps1 = null;
		Statement st = null;
		ResultSet rs = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement st1 = con.createStatement();
		String headquarter = request.getParameter("headquarter");
		String daid = request.getParameter("daid");

		if (headquarter != null && daid != null) {
			int aid = Integer.parseInt(daid);
			String subareaidcheck = "SELECT haid FROM headquarters WHERE headquarter='" + headquarter + "'";
			rs = st1.executeQuery(subareaidcheck);
			if (rs.next()) {
				response.sendRedirect("Admin/headquarters.jsp?res=duplicate&msg=Duplicate data available");
			} else {
				String sareaQuery = "INSERT INTO headquarters(headquarter, daid) VALUES (?,?)";
				ps1 = con.prepareStatement(sareaQuery);
				ps1.setString(1, headquarter);
				ps1.setInt(2, aid);

				int insertflag = ps1.executeUpdate();
				if (insertflag != 0) {
					response.sendRedirect("Admin/headquarters.jsp?res=success&msg=Data inserted successfully");
				} else {
					response.sendRedirect("Admin/headquarters.jsp?res=fail&msg=Data insertion failed");
				}
			}
		}
		con.close();
	}

	protected void headquarter_delete(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		String msg = null;
		int haid = Integer.parseInt(request.getParameter("haid"));
		Connection con = C3P0DataSource.getInstance().getConnection();
		int deleteSub = con.createStatement().executeUpdate("delete from headquarters where haid='" + haid + "'");
		if (deleteSub != 0) {
			response.sendRedirect("Admin/headquarters.jsp?res=success&msg=Data Deleted Successfully");
		}
		con.close();
	}

	protected void district_delete(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		int aaid = Integer.parseInt(request.getParameter("daid"));
		Connection con = C3P0DataSource.getInstance().getConnection();
		int deleteSub = con.createStatement().executeUpdate("delete from districts where daid='" + aaid + "'");
		if (deleteSub != 0) {
			response.sendRedirect("Admin/districts.jsp?res=success&msg=Data Deleted Successfully");
		}
		con.close();
	}

	protected void region_delete(HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException {
		String msg = null;
		int raid = Integer.parseInt(request.getParameter("raid"));
		Connection con = C3P0DataSource.getInstance().getConnection();
		int deleteSub = con.createStatement().executeUpdate("delete from regions where raid='" + raid + "'");
		if (deleteSub != 0) {
			response.sendRedirect("Admin/regions.jsp?res=success&msg=Data Deleted Successfully");
		}
		con.close();
	}

}
