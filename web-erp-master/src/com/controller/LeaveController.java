package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;

import com.model.C3P0DataSource;

/**
 * Servlet implementation class LeaveControler
 */
@WebServlet("/leaveController")
public class LeaveController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LeaveController() {
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
		try {
			String submit = request.getParameter("submit");
			if (submit != null) {
				if (submit.equals("Reject")) {
					// reject(request, response);
				} else if (submit.equals("Approve")) {
					// approved(request, response);
				} else if (submit.equals("Reject_admin")) {
					reject_admin(request, response);
					System.out.println("In condition");

				} else if (submit.equals("Approve_admin")) {
					approved_admin(request, response);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	protected void reject(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, JSONException {
		String msg = null;
		int id = Integer.parseInt(request.getParameter("id"));
		int eid = Integer.parseInt(request.getParameter("eid"));
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement stmt = con.createStatement();
		System.out.println("In statement");
		int j = stmt.executeUpdate("update leavemgm set status='Rejected' WHERE leaveid='" + id + "' ");
		if (j != 0) {
			msg = "success";
			// request.setAttribute("msg",msg);
			response.sendRedirect("Admin/allLeaves.jsp?response=" + msg);
			System.out.println("Status changed to Rejected");
		} else {
			msg = "fail";
			response.sendRedirect("Admin/allLeaves.jsp?response=" + msg);
		}
		con.close();
	}

	protected void approved(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, JSONException {
		String msg = null;
		int id = Integer.parseInt(request.getParameter("id"));
		int eid = Integer.parseInt(request.getParameter("eid"));
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement stmt = con.createStatement();

		int j = stmt.executeUpdate("update leavemgm set status='Approved' WHERE leaveid='" + id + "' ");
		if (j != 0) {
			msg = "success";
			// request.setAttribute("msg",msg);
			response.sendRedirect("Employee/allLeaves.jsp?response=" + msg);
			System.out.println("Status changed to Approved!");
		} else {
			msg = "fail";
			// request.setAttribute("msg",msg);
			response.sendRedirect("Employee/allLeaves.jsp?response=" + msg);
		}
		con.close();
	}

	protected void reject_admin(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, JSONException {
		String msg = null;
		int id = Integer.parseInt(request.getParameter("id"));
		int eid = Integer.parseInt(request.getParameter("eid"));
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement stmt = con.createStatement();

		String query = ("update leavemgm set status='Rejected' WHERE leaveid='" + id + "' ");
		int j = stmt.executeUpdate(query);
		System.out.println(query);
		if (j != 0) {
			msg = "success";
			// request.setAttribute("msg",msg);
			response.sendRedirect("Admin/allLeaves.jsp?response=" + msg);
			System.out.println("Status changed to Rejected");
		} else {
			msg = "fail";
			response.sendRedirect("Admin/allLeaves.jsp?response=" + msg);
		}
		con.close();
	}

	protected void approved_admin(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		String msg = null;
		int id = Integer.parseInt(request.getParameter("id"));
		int eid = Integer.parseInt(request.getParameter("eid"));
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement stmt = con.createStatement();

		int j = stmt.executeUpdate("update leavemgm set status='Approved' WHERE leaveid='" + id + "' ");
		if (j != 0) {
			msg = "success";
			// request.setAttribute("msg",msg);
			response.sendRedirect("Admin/allLeaves.jsp?response=" + msg);
			System.out.println("Status changed to Approved!");
		} else {
			msg = "fail";
			// request.setAttribute("msg",msg);
			response.sendRedirect("Admin/allLeaves.jsp?response=" + msg);
		}
		con.close();
	}

}
