package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
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

import com.Employee.Objects.GetData;
import com.model.C3P0DataSource;

/**
 * Servlet implementation class AssignDoctor
 */
@WebServlet("/AssignDoctor")
public class AssignDoctor extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AssignDoctor() {
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
	static {
		try {
			Connection con = C3P0DataSource.getInstance().getConnection();
			Statement state = con.createStatement();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		try {
			Connection connection = C3P0DataSource.getInstance().getConnection();
			String msg = null;
			String submit = request.getParameter("submit");
			if (submit.equals("Assign")) {
				assign(request, response);
			} else if (submit.equalsIgnoreCase("search")) {
				search(request, response);
			} else if (submit.equalsIgnoreCase("search_area")) {
				searcharea(request, response);
			}
		} catch (SQLException | JSONException e) {
			String msg = "fail";
			response.sendRedirect("Admin/assigndoctor.jsp?response=" + msg);
			e.printStackTrace();
		}

	}

	protected void assign(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
		Connection connection = C3P0DataSource.getInstance().getConnection();
		String msg = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement state = con.createStatement();
		int eid = Integer.parseInt(request.getParameter("eid"));
		String[] doctorid = request.getParameterValues("doctorid[]");
		if (doctorid != null) {
			int insert = 0;
			for (int i = 0; i < doctorid.length; i++) {
				insert = connection.createStatement().executeUpdate(
						"insert into asigneddoctor(doctorid, eid) values('" + doctorid[i] + "','" + eid + "')");

			}
			if (insert != 0) {
				msg = "success";
				response.sendRedirect("Admin/assigndoctor.jsp?response=" + msg);
			} else {
				msg = "fail";
				response.sendRedirect("Admin/assigndoctor.jsp?response=" + msg);
			}
		}
		connection.close();
		con.close();
	}

	protected void search(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, JSONException {
		Connection connection = C3P0DataSource.getInstance().getConnection();
		String msg = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement state = con.createStatement();
		String _eid = request.getParameter("eid");
		int eid = 0;
		if (_eid != null) {
			eid = Integer.parseInt(_eid);
		}
		String areaid = request.getParameter("aid");
		int aid = 0;
		String name = null;
		String areaname = null;
		if (areaid != null) {
			aid = Integer.parseInt(areaid);
			ResultSet rs = state.executeQuery("select name from employee where eid = '" + eid + "'");
			while (rs.next()) {
				name = rs.getString("name");
			}
			rs = state.executeQuery(" SELECT areaname FROM AREA WHERE aid ='" + areaid + "'");
			while (rs.next()) {
				areaname = rs.getString("areaname");
			}

		} else {
			ResultSet area = connection.createStatement()
					.executeQuery("select usertype, aid , name from employee where eid ='" + eid + "'");

			if (area.next()) {
				aid = area.getInt("aid");
				name = area.getString("name");
			}
			areaname = GetData.area_name(aid);
		}
		String doctors = "select doctorid , name from doctors where aid ='" + aid + "'";
		ResultSet rs = connection.createStatement().executeQuery(doctors);
		HttpSession session = request.getSession();
		JSONObject assignjson = new JSONObject();
		if (rs != null) {
			assignjson.put("empid", eid);
			assignjson.put("resultset", rs);
			assignjson.put("empname", name);
			assignjson.put("areaname", areaname);
			session.setAttribute("assigndoctorslist", assignjson);
			response.sendRedirect("Admin/assigndoctor.jsp");
		} else {
			response.sendRedirect("Admin/assigndoctor.jsp");
		}
		connection.close();
		con.close();
	}

	protected void searcharea(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		Connection connection = C3P0DataSource.getInstance().getConnection();
		String msg = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement state = con.createStatement();
		PrintWriter out = response.getWriter();
		String eid = request.getParameter("eid");
		String sql = "select aid, usertype from employee where eid ='" + eid + "'";
		// int aid = 0;
		ResultSet rs = state.executeQuery(sql);
		while (rs.next()) {
			String usertype = rs.getString("usertype");
			if (usertype.equals("BU") || usertype.equals("RBM")) {
				out.print("select area");
			} else {
				out.print("search");
			}
		}
		connection.close();
		con.close();
	}
}
