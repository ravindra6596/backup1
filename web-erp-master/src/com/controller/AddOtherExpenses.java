package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.model.C3P0DataSource;

/**
 * Servlet implementation class AddOtherExpenses
 */
@WebServlet("/AddOtherExpenses")
public class AddOtherExpenses extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddOtherExpenses() {
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
			String submit = request.getParameter("flag");

			String msg = null;
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
			LocalDateTime now = LocalDateTime.now();
			String time = dtf.format(now);
			System.out.println(dtf.format(now));
			Connection con = C3P0DataSource.getInstance().getConnection();
			if (submit.equalsIgnoreCase("ADD")) {
				float amt = Float.parseFloat(request.getParameter("amount"));
				String dtl = request.getParameter("details");
				String mail_sts = request.getParameter("mail_status");

				int eid = Integer.parseInt(request.getParameter("eid"));

				String insertQuery = "Insert into other_expenses(amount, details, mail_status, updated_at, eid) values('"
						+ amt + "','" + dtl + "','" + mail_sts + "','" + time + "','" + eid + "')";
				Statement stmt_insert = con.createStatement();
				int success = stmt_insert.executeUpdate(insertQuery);
				if (success != 0) {
					msg = "success";
					response.sendRedirect("Employee/addOtherExpenses.jsp?id=" + eid + "&response=" + msg);
				} else {
					msg = "fail";
					response.sendRedirect("Employee/addOtherExpenses.jsp?id=" + eid + "&response=" + msg);
				}

			}

			else {
				String[] expenseid = request.getParameterValues("exid[]");
				int result = 0;
				if (expenseid != null) {
					for (int i = 0; i < expenseid.length; i++) {
						int exid = Integer.parseInt(expenseid[i]);
						String sql = " ";
						if (submit.equalsIgnoreCase("approve")) {
							sql = "update other_expenses set approval = 'APPROVED' where id='" + exid + "'";
						} else if (submit.equalsIgnoreCase("reject")) {
							sql = "update other_expenses set approval = 'REJECTED' where id='" + exid + "'";
						}

						Statement state = con.createStatement();
						result = state.executeUpdate(sql);
					}
					HttpSession session = request.getSession();
					String user = (String) session.getAttribute("usertype");
					System.out.println("user:" + user);
					if (user.equalsIgnoreCase("admin")) {
						if (result != 0) {
							response.sendRedirect("Admin/appliedExpense.jsp?res=success");
						} else {
							response.sendRedirect("Admin/appliedExpense.jsp?res=fail");
						}
					} else {
						if (result != 0) {
							response.sendRedirect("Employee/allExpenses.jsp?res=success");
						} else {
							response.sendRedirect("Employee/allExpenses.jsp?res=fail");
						}
					}

				}
			}
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
