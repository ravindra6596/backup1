package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;

import com.model.C3P0DataSource;

/**
 * Servlet implementation class DailyReport
 */
@WebServlet("/DailyReport")
public class DailyReport extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DailyReport() {
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
		String submit = request.getParameter("submit");
		try {

			if (submit.equalsIgnoreCase("add")) {
				add(request, response);
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	protected void add(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, JSONException {
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
		LocalDateTime now = LocalDateTime.now();
		String time = dtf.format(now);
		Connection con = C3P0DataSource.getInstance().getConnection();
		String msg = null;
		int id = Integer.parseInt(request.getParameter("id"));
		String ename = null;
		String date = request.getParameter("date");
		String _workedwith = request.getParameter("workedwith");
		int workedwith = 0;
		if (_workedwith != null) {
			workedwith = Integer.parseInt(_workedwith);
		}
		int chemist = Integer.parseInt(request.getParameter("chemist"));
		String[] stockiest = request.getParameterValues("stockiest[]");
		Statement stid = con.createStatement();
		ResultSet rsid = stid.executeQuery("select name from employee where eid='" + id + "'");
		while (rsid.next()) {
			ename = rsid.getString("name");
		}
		if (id != 0 || workedwith != 0 || chemist != 0 || stockiest != null || date != null) {
			int dailyid = 0;
			String dailyReport = "insert into dailyreport (chemistvisited,empid,date,updated_at) values('" + chemist
					+ "','" + id + "','" + date + "','" + time + "')";
			System.out.println(dailyReport);
			Statement stmt1 = con.createStatement();
			int daily = stmt1.executeUpdate(dailyReport);
			if (daily != 0) {
				Statement stmt2 = con.createStatement();
				Statement stmt3 = con.createStatement();
				// Statement stmt4 = con.createStatement();
				String get_dailyreport = "SELECT LAST_INSERT_ID() AS dailyid ;";
				ResultSet rsdr = stmt2.executeQuery(get_dailyreport);
				if (rsdr.next()) {
					dailyid = rsdr.getInt("dailyid");
				}
				int insert_st = 0;
				for (int i = 0; i < stockiest.length; i++) {
					String stdaily = "insert into dailystockiestvisited(sid, dailyid,empid,updated_at) values ('"
							+ stockiest[i] + "','" + dailyid + "','" + id + "','" + time + "')";
					insert_st = stmt3.executeUpdate(stdaily);

				}
				if (insert_st != 0) {
					String message = "New report has been updated by " + ename;
					String status = "unread";
					Statement stmt5 = con.createStatement();
					stmt5.executeUpdate("insert into notifications(eid,message,status,created_at) values('" + id + "','"
							+ message + "','" + status + "','" + time + "')");

					msg = "success";
					response.sendRedirect("Employee/dailyReport.jsp?id=" + id + "&response=" + msg);
				}
			} else {
				msg = "fail";
				response.sendRedirect("Employee/dailyReport.jsp?id=" + id + "&response=" + msg);
			}

		} else {
			System.out.println("Please enter all the fields");
		}con.close();
	}

}
