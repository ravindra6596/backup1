package com.Employee.Objects;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;

import com.model.C3P0DataSource;

@WebServlet("/MonthlyReport")
public class EmployeeMonthlyReport extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EmployeeMonthlyReport() {
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

//	connection class
	static Connection con;
	static Statement state;
	static String msg = null;
	static {
		try {
			con = C3P0DataSource.getInstance().getConnection();
			state = con.createStatement();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		String tmname = null;
		int tourCount = 0;
		int totalTour = 0;
		int listedDrCount = 0;
		int convertedCount = 0;
		float sum = 0;
		double call_avg = 0;
		String submit = request.getParameter("submit");
		if (submit != null) {
			String tmselect = request.getParameter("tmname");
			int eid = 0;
			if (tmselect != null) {
				eid = Integer.parseInt(tmselect);
			} else {
				msg = "Select TM First";
			}
			try {
				ResultSet rs_emp = state.executeQuery("select name from employee where eid ='" + tmselect + "'");
				while (rs_emp.next()) {
					tmname = rs_emp.getString("name");
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			String date = request.getParameter("date");
			System.out.println(date);
			String[] dates = date.split(" - ");
			/*
			 * SimpleDateFormat sdf = new SimpleDateFormat("yyy-mm-dd"); try {
			 * java.util.Date d1 = sdf.parse(dates[0]); Date startdate = new
			 * java.sql.Date(d1.getTime()); System.out.println(startdate.getMonth()); }
			 * catch (ParseException e) { // TODO Auto-generated catch block
			 * e.printStackTrace(); }
			 */

			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
			LocalDate startdate = LocalDate.parse(dates[0], formatter);
			LocalDate enddate = LocalDate.parse(dates[1], formatter);

			int monthdiff = (int) ChronoUnit.MONTHS.between(startdate, enddate) + 1;

			// int monthdiff = enddate.getMonthValue() - startdate.getMonthValue() ;
			System.out.println("debug=" + monthdiff);

			ArrayList<LocalDate> months = new ArrayList<>();
			for (int i = 1; i <= monthdiff; i++) {
				if (i == 1) {
					months.add(startdate);
				} else {
					LocalDate nextmonth = startdate.plusMonths(i - 1);
					// int month = nextmonth.getMonthValue();
					months.add(nextmonth);
				}
			}
			JSONObject json = new JSONObject();
			ArrayList<Integer> leaves = new ArrayList<>();
			ArrayList<Integer> visited_calls = new ArrayList<>();
			ArrayList<Integer> generated_calls = new ArrayList<>();
			ArrayList<Integer> converted_docs = new ArrayList<>();
			ArrayList<Float> sumList = new ArrayList<>();
			ArrayList<Double> Call_average = new ArrayList<>();

			for (int i = 0; i < months.size(); i++) {
				int year = months.get(i).getYear();
				int month = months.get(i).getMonthValue();
				String date_callavrg = year + "-" + month;
				int no_of_leaves = 0;
				List<Double> callAverage = new ArrayList<>();
				try {
					no_of_leaves = Leaves(year, month, eid);
					tourCount = VisitedCalls(year, month, eid);
					listedDrCount = GeneratedCalls(year, month, eid);
					sum = TotalSale(year, month, eid);
					callAverage = WorkingDaysCount.EmployeeReport_CallCount(eid, date_callavrg);
					System.out.println("call average:" + callAverage);

				} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				leaves.add(no_of_leaves);
				visited_calls.add(tourCount);
				generated_calls.add(listedDrCount);
				converted_docs.add(convertedCount);
				sumList.add(sum);
				call_avg = callAverage.get(2);
				Call_average.add(call_avg);
			}
			try {
				json.put("tmname", tmname);
				json.put("leaves", leaves);
				json.put("visitedCalls", visited_calls);
				json.put("listed_doctors", generated_calls);
				json.put("converted_doctors", converted_docs);
				json.put("Total_sum", sumList);
				json.put("call_average", Call_average);
				json.put("date", months);
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println(json);
			HttpSession session = request.getSession();
			String usertype = (String) session.getAttribute("usertype");
			session.setAttribute("leaves", json);
			if (("admin").equalsIgnoreCase(usertype)) {
				response.sendRedirect("Admin/employeeMonthWiseReport.jsp");
			}
//					else {
//					response.sendRedirect("Employee/employeeMonthWiseReport.jsp");
//				}
		}
	}

	private static int Leaves(int year, int month, int tmselect) throws SQLException {
		String noOfLeaves = "SELECT COUNT(DATEDIFF(todate, fromdate)) AS leavecount FROM leavemgm WHERE eid='"
				+ tmselect + "' AND (YEAR(fromdate)='" + year + "' AND MONTH(fromdate)= '" + month
				+ "') AND STATUS='approved'";
		// System.out.println(noOfLeaves);
		int leavecount = 0;
		ResultSet rs_leaves = state.executeQuery(noOfLeaves);
		while (rs_leaves.next()) {
			leavecount = rs_leaves.getInt("leavecount");
		}
		System.out.println("LEAVE COUNT=" + leavecount);
		System.out.println("LEAVE =" + noOfLeaves);
		con.close();
		return leavecount;
	}

	public static int VisitedCalls(int year, int month, int tmselect) throws SQLException {
		String query = "SELECT COUNT(*) AS COUNT , tourid, doctorid,time,eid, status FROM tourplan WHERE eid='"
				+ tmselect + "' AND (YEAR(DATE)='" + year + "' AND MONTH(DATE)='" + month + "') AND STATUS='visited'";
		ResultSet visitedTourPlans = state.executeQuery(query);
		int tourCount = 0;
		System.out.println("VISITED CALLS=" + query);
		while (visitedTourPlans.next()) {
			tourCount = visitedTourPlans.getInt("count");
		}
		System.out.println("tour Count " + tourCount);
		return 0;
	}

	public static int GeneratedCalls(int year, int month, int tmselect) throws SQLException {
		String sql = "SELECT COUNT(*) AS count FROM tourplan WHERE eid ='" + tmselect + "' and (YEAR(date)='" + year
				+ "' AND MONTH(date)='" + month + "')";
		ResultSet rs = state.executeQuery(sql);
		int generated_calls = 0;
		System.out.println("GENERATED CALLS" + sql);
		while (rs.next()) {
			generated_calls = rs.getInt("count");
		}
		return generated_calls;
	}

	public static float TotalSale(int year, int month, int tmselect) throws SQLException {
		ArrayList<Integer> amt = new ArrayList<Integer>();
		float sum = 0;
		String sql = "SELECT pname,quantity FROM order_products INNER JOIN orders ON orders.orderid=order_products.orderid INNER JOIN product ON product.pid = order_products.pid WHERE eid = '"
				+ tmselect + "' AND (YEAR(orderdate)='" + year + "' AND MONTH(orderdate)='" + month + "')";
		ResultSet rs_getProduct = state.executeQuery(sql);
		System.out.println("Total Sale=" + sql);
		while (rs_getProduct.next()) {
			String pname = rs_getProduct.getString("pname");
			String mrp = "SELECT mrp FROM product WHERE pname='" + pname + "'";
			ResultSet rs_mrp = con.createStatement().executeQuery(mrp);
			// System.out.println("MRP"+mrp);
			while (rs_mrp.next()) {
				amt.add((rs_mrp.getInt("mrp")) * (rs_getProduct.getInt("quantity")));
			}
		}
		for (int i = 0; i < amt.size(); i++) {
			sum += amt.get(i);
		}
		con.close();
		return sum;

	}
}