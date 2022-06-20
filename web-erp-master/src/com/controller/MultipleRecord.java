package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model.C3P0DataSource;

/**
 * Servlet implementation class MultipleRecord
 */
@WebServlet("/MultipleRecord")
public class MultipleRecord extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MultipleRecord() {
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

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		try {

			String msg = null;
			String sub = request.getParameter("Submit");
			Connection con = C3P0DataSource.getInstance().getConnection();
			System.out.println(con);
			String date = request.getParameter("year");
			System.out.println(date);

			String[] year = date.split("-");
			String fy1 = year[0];
			String fy2 = year[1];
			System.out.println("" + fy1 + "\n" + fy2);

			// String[] amount = request.getParameterValues("target");

			// Stream<String> amount= Arrays.stream(request.getParameterValues("target[]"));

			Enumeration<String> parameterNames = request.getParameterNames();
			String insVals = "";

			while (parameterNames.hasMoreElements()) {

				String paramName = parameterNames.nextElement();
				if (paramName.contains("target")) {

					String eid = paramName.substring(7, (paramName.length() - 13));
					String month = paramName.substring((paramName.length() - 11), (paramName.length() - 1));
					// month = Integer.parseInt(month) < 4 ? fy2 + "-" + month + "-01" : fy1 + "-" +
					// month + "-01";

					String paramValue = request.getParameter(paramName);
					if (paramValue.replaceAll("[\\n\\t ]", "") != "" && !paramValue.equals("0")
							&& !paramValue.equals("0.00"))
						insVals += "(" + eid + ", '" + month + " ', ' " + paramValue + " ' ),".trim();
					// System.out.println(insVals);
				}
			}
			String date1 = fy1 + "-04-01";
			String date2 = fy2 + "-03-31";

			// Delete query between date 1 and date2
			String delete = "delete from target where( month between' " + date1 + " ' AND ' " + date2 + " ' )";
			int flagdelete = con.createStatement().executeUpdate(delete);
			System.out.println("Record Deleted Successfully\n\n" + delete);

			String q = "insert into target (haid,month,amount) values " + insVals.substring(0, insVals.length() - 1);
			System.out.println(q);
			int flag = con.createStatement().executeUpdate(q);
			System.out.println("saved");
			if (flag != 0) {
				msg = "success";
				response.sendRedirect("Admin/multipletarget.jsp?response=" + msg);
			} else {
				msg = "fail";
				response.sendRedirect("Admin/multipletarget.jsp?response=" + msg);
			}
			con.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

}
