package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model.C3P0DataSource;

/**
 * Servlet implementation class PlaceOrder
 */
@WebServlet("/PlaceOrder")
public class PlaceOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PlaceOrder() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String type = request.getParameter("type");

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
			String msg = null;
			Connection con = C3P0DataSource.getInstance().getConnection();
			String submit = request.getParameter("submit");
			if (submit != null) {
				System.out.println("in try");

				if (submit.equals("ADD")) {
					add_order(request, response);
				} else if (submit.equals("UPDATE")) {
					update_order(request, response);
				} else if (submit.equals("DELETE")) {
					delete_order(request, response);
				}
			} else {
				PrintWriter out = response.getWriter();
				// Connection con = BIManager.ConnectDB();
				int areaid = Integer.parseInt(request.getParameter("area"));
				Statement st = con.createStatement();
				ResultSet rs = null;

				rs = st.executeQuery("select areaname from area where aid='" + areaid + "'");
				if (rs.next()) {
					Statement stmt = con.createStatement();
					ResultSet rs1 = st.executeQuery(
							"select name, doctorid from doctors where area='" + rs.getString("areaname") + "'");
					if (rs1.next()) {
						System.out.print(rs1.getString("name") + ",");
						out.print(rs1.getString("name") + ",");

					}

				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void add_order(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {

		String msg = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		PreparedStatement ps1 = null;
		ResultSet rs = null;
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
		LocalDateTime now = LocalDateTime.now();
		String time = dtf.format(now);
		Statement stmt = con.createStatement();

		String dname = request.getParameter("dname");
		String cname = request.getParameter("campname");
		String stname = request.getParameter("stname");
		String tmname = request.getParameter("tmname");
		String pname[] = request.getParameterValues("name[]");
		String quant[] = request.getParameterValues("qty[]");
		String area = request.getParameter("area");
		String insertQuery = "INSERT INTO orders(doctorname,campaign,stockiest,tmname,ordertime,area) VALUES (?,?,?,?,?,?)";
		ps1 = con.prepareStatement(insertQuery);
		ps1.setString(1, dname);
		ps1.setString(2, cname);
		ps1.setString(3, stname);
		ps1.setString(4, tmname);
		ps1.setString(5, time);
		ps1.setString(6, area);

		int insertFlag = ps1.executeUpdate();
		System.out.println("order placed successfully");
		if (insertFlag != 0) {
			String selectOid = "SELECT orderid FROM orders WHERE ordertime='" + time + "'";
			rs = stmt.executeQuery(selectOid);
			while (rs.next()) {
				int insertFlag1 = 0;
				int orderid = rs.getInt("orderid");
				for (int i = 0; i < pname.length; i++) {
					int quantt = Integer.parseInt(quant[i]);
					String insertData = "INSERT INTO placeorder(orderid,pname,quantity) VALUES (?,?,?)";
					ps1 = con.prepareStatement(insertData);
					ps1.setInt(1, orderid);
					ps1.setString(2, pname[i]);
					ps1.setInt(3, quantt);

					insertFlag1 = ps1.executeUpdate();
					float price = 0;
					stmt = con.createStatement();
					rs = stmt.executeQuery("select mrp from product where pname='" + pname[i] + "'");
					if (rs.next()) {
						price = price + (quantt * rs.getFloat("mrp"));
					}

				}

			}
			msg = "<p style='color:white;'>Order Placed Successfully!</p>";
			request.setAttribute("msg", msg);
			RequestDispatcher rd = request.getRequestDispatcher("placeorder.jsp");
			rd.forward(request, response);
		} else {
			msg = "<p style='color:white;'>Something went wrong. please try again!</p>";
			request.setAttribute("msg", msg);
			RequestDispatcher rd = request.getRequestDispatcher("placeorder.jsp");
			rd.forward(request, response);
		}
		con.close();
	}

	protected void update_order(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {

		String msg = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		PreparedStatement ps1 = null;
		ResultSet rs = null;
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
		LocalDateTime now = LocalDateTime.now();
		String time = dtf.format(now);
		Statement stmt = con.createStatement();

		int id = Integer.parseInt(request.getParameter("id"));
		String dname = request.getParameter("dname");
		String cname = request.getParameter("campname");
		String stname = request.getParameter("stname");
		String tmname = request.getParameter("tmname");
		String pname[] = request.getParameterValues("name[]");
		String quant[] = request.getParameterValues("qty[]");
		String area = request.getParameter("area");
		String updateQuery = "UPDATE orders SET doctorname = ?, campaign = ?, stockiest = ?, tmname = ?, ordertime = ?, area = ? WHERE orderid="
				+ id + "";
		ps1 = con.prepareStatement(updateQuery);
		ps1.setString(1, dname);
		ps1.setString(2, cname);
		ps1.setString(3, stname);
		ps1.setString(4, tmname);
		/*
		 * ps1.setString(5,pname); ps1.setInt(6,quant);
		 */
		ps1.setString(5, dtf.format(now));
		ps1.setString(6, area);

		int insertFlag = ps1.executeUpdate();
		if (insertFlag != 0) {
			msg = "<p style='color:white;'>Order updated Successfully!</p>";
			request.setAttribute("msg", msg);
			RequestDispatcher rd = request.getRequestDispatcher("singleorder.jsp");
			rd.forward(request, response);
		} else {
			msg = "<p style='color:white;'>Something went wrong. please try again!</p>";
			request.setAttribute("msg", msg);
			RequestDispatcher rd = request.getRequestDispatcher("singleorder.jsp");
			rd.forward(request, response);
		}
		con.close();
	}

	protected void delete_order(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {

		String msg = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		PreparedStatement ps1 = null;
		ResultSet rs = null;

		System.out.println("in delete");
		int id = Integer.parseInt(request.getParameter("id"));
		String deleteQuery = "DELETE FROM orders WHERE orderid=" + id + "";
		ps1 = con.prepareStatement(deleteQuery);
		int insertFlag = ps1.executeUpdate();
		if (insertFlag != 0) {
			String deletePro = "DELETE FROM placeorder WHERE orderid=" + id + "";
			ps1 = con.prepareStatement(deletePro);
			int insertFlag1 = ps1.executeUpdate();
			if (insertFlag1 != 0) {
				msg = "<p style='color:white;'>Order deleted Successfully!</p>";
				request.setAttribute("msg", msg);
				RequestDispatcher rd = request.getRequestDispatcher("ordermanagement.jsp");
				rd.forward(request, response);
			}
		} else {
			msg = "<p style='color:white;'>Something went wrong. please try again!</p>";
			request.setAttribute("msg", msg);
			RequestDispatcher rd = request.getRequestDispatcher("singleorder.jsp");
			rd.forward(request, response);
		}
		con.close();
	}

}
