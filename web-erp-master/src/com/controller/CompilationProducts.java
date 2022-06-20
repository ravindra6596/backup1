package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.model.C3P0DataSource;

/**
 * Servlet implementation class CompilationProducts
 */
@WebServlet("/CompilationProducts")
public class CompilationProducts extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CompilationProducts() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	static Connection con;
	static Statement state;
	static String msg;
	static {
		try {
			con = C3P0DataSource.getInstance().getConnection();
			state = con.createStatement();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

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
		System.out.println(submit);
		if (submit.equalsIgnoreCase("filterdoc")) {
			try {
				filterdoc(request, response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (submit.equalsIgnoreCase("add")) {
			try {
				add(request, response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}

	public static ResultSet compiledQty(String date, String proid) throws SQLException {
		ResultSet rs = null;
		if (proid != null && date != null) {
			int sid = Integer.parseInt(proid);
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			LocalDate date1 = LocalDate.parse(date, dtf);
			int month = date1.getMonthValue();
			int year = date1.getYear();
			String sql2 = "SELECT product.pname ,`suspense_compilation_products`.`pid`, quantity, sid, MONTH(DATE) AS MONTH , YEAR(DATE) AS YEAR FROM `suspense_compilation_products` INNER JOIN `suspense_compilation` ON `suspense_compilation`.`id`= `suspense_compilation_products`.`sus_compilation_id` INNER JOIN product ON product.`pid`= `suspense_compilation_products`.`pid`  WHERE sid ='"
					+ sid + "' AND MONTH(DATE)='" + month + "' AND YEAR(DATE)='" + year + "'";
			try {
				rs = state.executeQuery(sql2);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		con.close();
		return rs;
	}

	public static Long GetsuspenseQty(int sid, int pid, int month, int year) throws SQLException {
		String sql = "SELECT pname, SUM(quantity) AS total_qty FROM placeorder INNER JOIN orders ON orders.`orderid` = placeorder.`orderid` WHERE sid = '"
				+ sid + "' AND pname = (SELECT pname FROM product WHERE pid ='" + pid + "') AND MONTH(`ordertime`)='"
				+ month + "' AND YEAR(ordertime)='" + year + "'";
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(sql);
		long total_qty = 0;
		if (rs.next()) {
			total_qty = rs.getLong("total_qty");
		}
		con.close();
		return total_qty;
	}

	public static Long Suspense_diff(long compiled_qty, long purchased_qty) {
		long difference = compiled_qty - purchased_qty;
		return difference;
	}

	protected void filterdoc(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, JSONException {

		PrintWriter out = response.getWriter();
		String aid = request.getParameter("aid");
		if (aid != null) {
			int areaid = Integer.parseInt(aid);
			String sql = "select name , sid from stockiest where headquarter ='" + areaid + "'";
			ArrayList<String> stockiest_name = new ArrayList<>();
			ArrayList<Integer> doctor_ids = new ArrayList<>();
			try {
				ResultSet rs = state.executeQuery(sql);
				while (rs.next()) {
					stockiest_name.add(rs.getString("name"));
					doctor_ids.add(rs.getInt("sid"));
				}

				JSONObject json = new JSONObject();
				json.put("name", stockiest_name);
				json.put("ids", doctor_ids);

				out.print(json);
			} catch (SQLException | JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		con.close();
	}

	protected void add(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, JSONException {
		try {
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
			LocalDateTime now = LocalDateTime.now();
			String time = dtf.format(now);

			String date = request.getParameter("date");
			java.sql.Date date1 = null;
			if (date != null) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
				Date d1 = sdf.parse(date);
				SimpleDateFormat sdfd = new SimpleDateFormat("MM-yyyy");
				Date d2 = sdfd.parse(date);
				date1 = new java.sql.Date(d1.getTime());
			}
			String id = request.getParameter("sid");
			int sid = 0;
			if (id != null) {
				sid = Integer.parseInt(id);
			}
			String sql = "insert into suspense_compilation (sid, date, created_at) values ('" + sid + "','" + date1
					+ "','" + time + "')";
			int insert = state.executeUpdate(sql);
			if (insert != 0) {
				String[] pids = request.getParameterValues("pname[]");
				String[] quantity = request.getParameterValues("targetqty[]");
				if (pids != null && quantity != null) {
					for (int i = 0; i < quantity.length; i++) {
						int pid = Integer.parseInt(pids[i]);
						long qty = Long.parseLong(quantity[i]);
						String sql2 = "insert into suspense_compilation_products (sus_compilation_id, pid, quantity) values ((select id from suspense_compilation where created_at = '"
								+ time + "'),'" + pid + "','" + qty + "')";
						state.executeUpdate(sql2);
					}
				}
				msg = "success";
				response.sendRedirect("Admin/compilationProducts.jsp?response=" + msg);
			} else {
				msg = "fail";
				response.sendRedirect("Admin/compilationProducts.jsp?response=" + msg);
			}
		} catch (ParseException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		con.close();
	}

}
