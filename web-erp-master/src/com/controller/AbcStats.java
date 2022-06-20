package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model.C3P0DataSource;

/**
 * Servlet implementation class AbcStats
 */
@WebServlet("/AbcStats")
public class AbcStats extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AbcStats() {
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
		String abcstat_option = request.getParameter("option");
		int abcstat_id = Integer.parseInt(request.getParameter("id"));
		System.out.println(abcstat_option);
		try {
			Connection con = C3P0DataSource.getInstance().getConnection();
			Statement stmt = con.createStatement();
			int update = 0;
			update = stmt.executeUpdate(
					"update abcstatrecord set status='" + abcstat_option + "' where recordid='" + abcstat_id + "'");
			if (update != 0) {
				System.out.println("updated");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
