package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model.C3P0DataSource;

/**
 * Servlet implementation class PurchaseOrder
 */
@WebServlet("/PurchaseOrder")
public class PurchaseOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PurchaseOrder() {
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
	static Connection con = null;
	static {
		con = C3P0DataSource.getInstance().getConnection();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		String submit = request.getParameter("submit");
		if (submit != null) {
			String count = request.getParameter("doc_count");
			String string_eid = request.getParameter("eid");
			int doc_count = 0;
			int eid = 0;
			if (count != null) {
				doc_count = Integer.parseInt(count);
			}
			if (string_eid != null) {
				eid = Integer.parseInt(string_eid);
			}
			int orderid = 0;
			String timeStamp = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new Date());
			for (int i = 1; i < doc_count; i++) {
				String name = "dname_row" + i;
				String dname = request.getParameter(name);
				if (dname != null) {
					String[] qty_row1 = request.getParameterValues("qty_row" + i + "[]");
					String[] products = request.getParameterValues("pro_row" + i + "[]");
					System.out.println("qty= " + Arrays.toString(qty_row1));
					int previous = 0;
					for (int j = 0; j < qty_row1.length; j++) {
						int Qty = Integer.parseInt(qty_row1[j]);
						previous = previous + Qty;
					}
					if (previous != 0) {
						String sql = "insert into orders (doctorname, eid, ordertime) values('" + dname + "','" + eid
								+ "','" + timeStamp + "')";
						Statement state = null;
						try {
							state = con.createStatement();
							int insert = state.executeUpdate(sql);
							if (insert != 0) {
								Statement state2 = con.createStatement();
								String sql1 = "SELECT LAST_INSERT_ID() as last_inserted_orderid;";
								ResultSet rs = state2.executeQuery(sql1);
								if (rs.next()) {
									orderid = rs.getInt("last_inserted_orderid");
								}
								if (qty_row1 != null || products != null) {

									for (int j = 0; j < products.length; j++) {
										int qty = 0;
										if (qty_row1[j] != "") {
											qty = Integer.parseInt(qty_row1[j]);
										} else {
											qty = 0;
										}
										if (qty != 0) {
											String sql2 = "insert into placeorder (orderid, pname, quantity) values ('"
													+ orderid + "', '" + products[j] + "','" + qty + "')";
											Statement state3 = con.createStatement();
											state3.executeUpdate(sql2);
											System.out.println("done");
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
			}
			String msg = "success";
			response.sendRedirect("Employee/purchaseOrder.jsp?response=" + msg);
		}
	}

}
