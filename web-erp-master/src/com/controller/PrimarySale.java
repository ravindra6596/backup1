package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model.C3P0DataSource;

/**
 * Servlet implementation class PrimarySale
 */
@WebServlet("/PrimarySale")
public class PrimarySale extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PrimarySale() {
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

		String submit = request.getParameter("submit");
		if (submit.equalsIgnoreCase("save")) {
			save_sale(request, response);
		}
	}

	protected void save_sale(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String date = request.getParameter("date");
		String amount = request.getParameter("amount");
		if (date != null && amount != null) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date d1 = null;
			try {
				d1 = sdf.parse(date);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			Date parsed_date = new java.sql.Date(d1.getTime());
			float parsed_amt = Float.parseFloat(amount);
			String sql = "insert into primary_sale (date, amount) values ('" + parsed_date + "','" + parsed_amt + "')";
			try {
				int insert = state.executeUpdate(sql);
				if (insert != 0) {
					msg = "success";
					response.sendRedirect("Admin/primarysale.jsp?response=" + msg);
				} else {
					msg = "fail";
					response.sendRedirect("Admin/primarysale.jsp?response=" + msg);
				}
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
	}
}
