package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;

import com.Employee.Objects.IndividualReportClass;
import com.model.C3P0DataSource;

/**
 * Servlet implementation class Target
 */
@WebServlet("/Target")
public class Target extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Target() {
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

		String targetid1 = request.getParameter("t");
		int tid = 0;
		if (targetid1 != null) {
			try {
				Connection con = C3P0DataSource.getInstance().getConnection();
				tid = Integer.parseInt(targetid1);
				JSONObject json = IndividualReportClass.gettarget_report(tid);
				HttpSession session = request.getSession();
				session.setAttribute("target_data", json);
				String utype = (String) session.getAttribute("usertype");
				if (utype.equalsIgnoreCase("admin")) {
					response.sendRedirect("Admin/individualtargetreport.jsp");
				} else {
					response.sendRedirect("Employee/individualtargetreport.jsp");
				}
				con.close();
			} catch (SQLException | JSONException e) {
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

		try {
			String submit = request.getParameter("submit1");

			if (submit.equalsIgnoreCase("addteam")) {
				additem(request, response);
			}

			if (submit.equalsIgnoreCase("addindividual")) {
				addindividual_target(request, response);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	protected void additem(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
		String msg = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement statement = con.createStatement();

		try {
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
			LocalDateTime now = LocalDateTime.now();
			String time = dtf.format(now);
			int campiagn = Integer.parseInt(request.getParameter("campaign"));
			double qty = Double.parseDouble(request.getParameter("targetvalue"));
			String date1 = request.getParameter("datefrom");

			System.out.println(date1);
			String[] parts = date1.replace(" ", "").split("-");
			String part1 = parts[0];
			System.out.println(part1);
			String part2 = parts[1];
			System.out.println(part2);
			SimpleDateFormat sdfd = new SimpleDateFormat("MM/dd/yyyy");
			/*
			 * java.util.Date d1 = sdfd.parse(part1); Date datefrom = new
			 * java.sql.Date(d1.getTime()); java.util.Date d2 = sdfd.parse(part2); Date
			 * dateto = new java.sql.Date(d2.getTime());
			 */

			// SELECT
			// employee.name,target.amount,primary_sale.amount,target.month,target.amount/primary_sale.amount*100,
			// target.amount - primary_sale.amount FROM target INNER JOIN employee INNER
			// JOIN primary_sale on employee.eid=target.eid
			String insert_team = "insert into teamtarget (campaignid, targetvalue,datefrom,dateto,created_at) values('"
					+ campiagn + "','" + qty + "','" + part1 + "','" + part2 + "','" + time + "')";
			int rs_insert = statement.executeUpdate(insert_team);
			if (rs_insert != 0) {
				System.out.println("Success");
				msg = "success";
				response.sendRedirect("Admin/individualtarget.jsp?response=msg");
			} else {

				msg = "fail";
				response.sendRedirect("Admin/individualtarget.jsp?response=msg");

			}
		} catch (Exception e) {
			msg = "fail";
			response.sendRedirect("Admin/individualtarget.jsp?response=msg");
		}
		con.close();
	}

	protected void addindividual_target(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {

		String msg = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement statement = con.createStatement();

		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
		LocalDateTime now = LocalDateTime.now();
		String time = dtf.format(now);
		String[] pname = request.getParameterValues("pname[]");
		String[] qty = request.getParameterValues("targetqty[]");
		int eid = Integer.parseInt(request.getParameter("eid"));
		String datefrom = request.getParameter("dateindi");
		System.out.println(datefrom);
		/*
		 * String[] parts = datefrom.split(" - "); String part1 = parts[0]; String part2
		 * = parts[1]
		 */;
		/*
		 * SimpleDateFormat sdfd = new SimpleDateFormat("yyyy-mm-dd"); Date d1 = new
		 * java.sql.Date(sdfd.parse(part1).getTime()); Date d2 = new
		 * java.sql.Date(sdfd.parse(part2).getTime());
		 */

		String target = null;

		target = "insert into individualtarget(eid,datefrom,created_at) values ('" + eid + "','" + datefrom + "','"
				+ time + "')";

		int rs_target = statement.executeUpdate(target);
		if (rs_target != 0) {
			int individualid = 0;
			Statement stmt5 = con.createStatement();
			ResultSet rs_id = stmt5
					.executeQuery("select individualid from individualtarget where created_at='" + time + "' ");
			while (rs_id.next()) {
				individualid = rs_id.getInt("individualid");
			}
			for (int p = 0; p < pname.length; p++) {
				for (int q = 0; q < qty.length; q++) {
					if (p == q) {
						Statement stmt3 = con.createStatement();
						String targetq = "insert into targetproducts (individualid ,pid, target,created_at) values('"
								+ individualid + "','" + pname[p] + "','" + qty[q] + "','" + time + "')";
						stmt3.executeUpdate(targetq);
					}
				}
			}
			msg = "success";
			response.sendRedirect("Admin/individualtarget.jsp?response=" + msg);
		} else {
			System.out.println("fail");
			msg = "fail";
			response.sendRedirect("Admin/individualtarget.jsp?response=" + msg);
		}
		con.close();
	}

}
