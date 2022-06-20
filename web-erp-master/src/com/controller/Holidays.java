package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
 * Servlet implementation class Holidays
 */
@WebServlet("/Holidays")
public class Holidays extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

	public Holidays() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("hid");
		if (id != null) {
			int hid = Integer.parseInt(id);
			int deleteSub;
			try {
				String delete = "delete from holidays where hid='" + hid + "'";
				Connection con = C3P0DataSource.getInstance().getConnection();
				deleteSub = con.createStatement().executeUpdate(delete);
				System.out.println(delete);
				if (deleteSub != 0) {
					String msg = "Success";
					request.setAttribute("msg", msg);
					response.sendRedirect("Admin/holidays.jsp?response=" + msg);
				}
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		try {
			String submit = request.getParameter("submit");

			PrintWriter out = response.getWriter();

			PreparedStatement ps1 = null;
			Connection con = C3P0DataSource.getInstance().getConnection();
			Statement st1 = con.createStatement();
			String msg = null;

			if (submit.equals("ADD")) {
				add_holiday(request, response);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}

	protected void add_holiday(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ParseException, IOException {
		String msg = null;
		String sub = request.getParameter("Submit");
		Connection con = C3P0DataSource.getInstance().getConnection();
		System.out.println(con);
		String date = request.getParameter("hdate");
		String title = request.getParameter("title");
		if (date != null) {
			String[] dobS = date.split("-");
			date = dobS[2] + "-" + dobS[1] + "-" + dobS[0];
			System.out.println(date);
		}

		PreparedStatement stmt = con.prepareStatement("insert into holidays (date,title) value (?,?)");
		stmt.setString(1, date);
		stmt.setString(2, title);
		int add = stmt.executeUpdate();
		if (add != 0) {
			msg = "success";
			response.sendRedirect("Admin/holidays.jsp?response=" + msg);
		} else {
			msg = "fail";
			response.sendRedirect("Admin/holidays.jsp?response=" + msg);
		}
		con.close();
	}

}
