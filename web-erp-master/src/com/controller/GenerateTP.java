package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;

import com.model.C3P0DataSource;
import com.mysql.jdbc.Connection;

/**
 * Servlet implementation class GenerateTP
 */
@WebServlet("/GenerateTP")
public class GenerateTP extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GenerateTP() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			String f = request.getParameter("flag");
			// String action = request.getParameter("flag");
			System.out.println(f);
			if (f.equalsIgnoreCase("add")) {
				add(request, response);
			} else if (("ADDTOUR").equals(f)) {
				add_tour(request, response);
			} else if (f.equalsIgnoreCase("fetchDoctors")) {
				fetchDoctors(request, response);
			} else if (("approve_tp").equals(f)) {
				approved(request, response);
			} else if (("reject_tp").equals(f)) {
				reject(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void add(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, JSONException {
		String msg = null;
		Connection con = (Connection) C3P0DataSource.getInstance().getConnection();
		Statement stmt4 = con.createStatement();

		String status = request.getParameter("status");
		String comment = request.getParameter("feedback");
		int tourid = Integer.parseInt(request.getParameter("tourid"));
		String[] sample_proids = request.getParameterValues("pname[]");
		String[] qty = request.getParameterValues("targetqty[]");
		String[] camp_gift = request.getParameterValues("gift[]");
		String update_query = "UPDATE tourplan SET STATUS='" + status + "', feedback='" + comment + "' WHERE tourid ='"
				+ tourid + "'";
		int rs_update = stmt4.executeUpdate(update_query);
		if (rs_update != 0) {
			int sample_given = 0;
			if (sample_proids != null && qty != null) {
				for (int i = 0; i < qty.length; i++) {
					int sample_proid = Integer.parseInt(sample_proids[i]);
					int given_qty = Integer.parseInt(qty[i]);
					String quString = "insert into sample_given(sample_proid, quantity_given,tourid) values('"
							+ sample_proid + "','" + given_qty + "','" + tourid + "')";
					sample_given = con.createStatement().executeUpdate(quString);
				}
				if (sample_given != 0) {
					System.out.println("inserted into sample_given");
				} else {
					System.out.println("error in sample_given");
				}
			} else if (camp_gift != null) {
				int camp_gifts = 0;
				for (int i = 0; i < camp_gift.length; i++) {
					int gifts = Integer.parseInt(camp_gift[i]);
					System.out.println("gift=" + gifts);
					String sql = "INSERT INTO `campaigngifts_record` (cid, gift_given, tourid) SELECT * FROM (SELECT '"
							+ gifts + "', 'Yes', '" + tourid
							+ "') AS tmp WHERE NOT EXISTS (SELECT * FROM `campaigngifts_record` WHERE tourid = '"
							+ tourid + "' AND cid ='" + gifts + "')";
					camp_gifts = con.createStatement().executeUpdate(sql);
				}
				if (camp_gifts != 0) {
					System.out.println("inserted into camp");
				} else {
					System.out.println("error in camp");
				}
			}
			msg = "success";
			response.sendRedirect("Employee/tourplanStatus.jsp?tour=" + tourid + "&response=" + msg);
		} else {
			msg = "fail";
			response.sendRedirect("Employee/tourplanStatus.jsp?tour=" + tourid + "&response=" + msg);
		}
		con.close();
	}

	protected void add_tour(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, JSONException, ParseException {
		String msg = null;
		java.sql.Connection con = C3P0DataSource.getInstance().getConnection();
		// Statement stmt4 = con.createStatement();

		String _date = request.getParameter("date");
		String _doctorid = request.getParameter("doctorid");
		int doctorid = 0;
		if (_doctorid != null) {
			doctorid = Integer.parseInt(_doctorid);
		}
		String _eid = request.getParameter("eid");
		int eid = 0;
		if (_eid != null) {
			eid = Integer.parseInt(_eid);
		}
		String _aid = request.getParameter("aid");
		int aid = 0;
		if (_aid != null) {
			aid = Integer.parseInt(_aid);
		}
		String _time = request.getParameter("time");
		System.out.println(_time);

		SimpleDateFormat sdfd = new SimpleDateFormat("hh:mm");
		Time time = null;
		Date date = null;
		if (_time != null) {
			Date time2 = sdfd.parse(_time);
			time = new Time(time2.getTime());
		}
		if (_date != null) {
			String[] dotS = _date.split("-");
			_date = dotS[2] + "-" + dotS[1] + "-" + dotS[0];
			System.out.println(_date);
		}

		String sql = "Insert into tourplan (doctorid, date, time, eid) Values ('" + doctorid + "','" + _date + "','"
				+ time + "','" + eid + "')";
		Statement st = con.createStatement();
		int insert_result = st.executeUpdate(sql);
		System.out.println(sql);
		if (insert_result != 0) {
			response.sendRedirect("Admin/manualtourplan.jsp?res=success");

		} else {
			response.sendRedirect("Admin/manualtourplan.jsp?res=fail");
		}
		con.close();
	}

	public void fetchDoctors(HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException, JSONException {
		java.sql.Connection con = C3P0DataSource.getInstance().getConnection();
		PreparedStatement ps1 = null;
		ResultSet rs = null;
		int empname = Integer.parseInt(request.getParameter("eid"));
		String qry = "select eid,haid,name from employee where eid= '" + empname + "'";
		rs = con.createStatement().executeQuery(qry);

		int said = 0;

		while (rs.next()) {
			said = rs.getInt("haid");

		}
		String drqry = "SELECT doctorid,name FROM doctors WHERE haid=" + said;
		rs = con.createStatement().executeQuery(drqry);
		String jsonstring = "[";
		while (rs.next()) {
			int did = rs.getInt("doctorid");
			String dname = rs.getString("name");
			jsonstring += "{\"did\" :  " + did + ", \"name\" : \" " + dname + "\" },";

		}
		jsonstring = jsonstring.substring(0, (jsonstring.length() - 1)) + "]";
		System.out.print(jsonstring);
		PrintWriter out = response.getWriter();
		out.print(jsonstring);
		con.close();
	}

	protected void approved(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
		String id = request.getParameter("tourid");
		System.out.println("id=" + id);
		if (id != null) {
			int tid = Integer.parseInt(id);
			int update;
			try {
				String action = "update tourplan SET approved = 1 where tourid='" + tid + "'";
				java.sql.Connection con = C3P0DataSource.getInstance().getConnection();
				update = con.createStatement().executeUpdate(action);
				System.out.println(action);
				if (update != 0) {
					String msg = "success";
					request.setAttribute("msg", msg);
					response.sendRedirect("Admin/alltours.jsp?response=" + msg);
				}
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		

	}

	protected void reject(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
		String tourid = request.getParameter("tourid");
		System.out.println("id=" + tourid);
		if (tourid != null) {
			int tid = Integer.parseInt(tourid);
			int update;
			try {
				String action = "update tourplan SET approved = 2 where tourid='" + tid + "'";
				java.sql.Connection con = C3P0DataSource.getInstance().getConnection();
				update = con.createStatement().executeUpdate(action);
				System.out.println(action);
				if (update != 0) {
					String msg = "success";
					request.setAttribute("msg", msg);
					response.sendRedirect("Admin/alltours.jsp?response=" + msg);
				}
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
	}
}
