package com.Admin.Classes;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.Employee.Objects.GetData;
import com.model.C3P0DataSource;

/**
 * Servlet implementation class ProductSale
 */
@WebServlet("/PersonalSale")
public class PersonalSale extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PersonalSale() {
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

		ArrayList<String> dlist = new ArrayList<String>();
		ArrayList<String> plist = new ArrayList<String>();

		int doccount = 0;
		int procount = 0;

		ResultSet rsprocount = null;
		try {
			rsprocount = state.executeQuery("SELECT COUNT(*) FROM product");
			if (rsprocount.next()) {
				procount = rsprocount.getInt(1);
			}
			ResultSet products = GetData.Products();
			while (products.next()) {
				plist.add(products.getString("pname"));
			}
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		String submit = request.getParameter("submit");
		if (submit.equalsIgnoreCase("search")) {
			int eid = 0;
			String eidstring = request.getParameter("eid");
			if (eidstring != null) {
				eid = Integer.parseInt(eidstring);
			}
			String cname = request.getParameter("campaign");
			String date = request.getParameter("daterange");
			String[] date_parts = date.split(" - ");
			String date_from = date_parts[0].replace("-", "");
			String date_to = date_parts[1].replace("-", "");
//			String date_from = date_parts[0];
//			String date_to = date_parts[1];
			String path = request.getParameter("rootpath");
			System.out.println(date_from + date_to);
			try {
				String empselect = "select haid from employee where eid='" + eid + "'";
				System.out.println("Employee Select = " + empselect);
				ResultSet rs_emparea = state.executeQuery(empselect);
				if (rs_emparea.next()) {
					String drselect = "select name from doctors where haid='" + rs_emparea.getString("haid") + "'";
					ResultSet rs_doctor = con.createStatement().executeQuery(drselect);
					System.out.println("Doctor Select = " + drselect);

					while (rs_doctor.next()) {
						String dname = rs_doctor.getString("name");
						dlist.add(dname);
					}
					String drcount = "SELECT COUNT(NAME) AS COUNT FROM doctors WHERE haid='"
							+ rs_emparea.getString("haid") + "'";
					ResultSet rs_drCount = con.createStatement().executeQuery(drcount);
					System.out.println("Count = " + drcount);
					if (rs_drCount.next()) {
						System.out.println("inside if");
						doccount = rs_drCount.getInt("COUNT");
					}
				}
				int[][] list = new int[doccount][procount];
				for (int i = 0; i < dlist.size(); i++) {
					ResultSet rsorder = null;
					if (date != null) {
						System.out.println("inside if dr");
						String sql = "select name,pname, quantity from orders inner join order_products on order_products.orderid=orders.orderid where name='"
								+ dlist.get(i) + "' AND (orderdate BETWEEN '" + date_from + "' AND '" + date_to + "')";
						rsorder = state.executeQuery(sql);
						System.out.println("Dr query" + sql);
					}

					while (rsorder.next()) {
						int docindex = dlist.indexOf(rsorder.getString("name"));
						int proindex = plist.indexOf(rsorder.getString("pname"));
						if (docindex != -1 && proindex != -1) {
							list[docindex][proindex] = rsorder.getInt("quantity");
						}
					}
				}

				JSONObject ProductSale = new JSONObject();

				ProductSale.put("products", plist);
				ProductSale.put("doctors", dlist);
				ProductSale.put("quantity", list);

				HttpSession session = request.getSession();
				session.setAttribute("ProductSale", ProductSale);
				if (path.contains("Admin")) {
					response.sendRedirect("Admin/productsale.jsp");
				} else if (path.contains("Employee")) {
					response.sendRedirect("Employee/productsale.jsp");
				}

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("error: " + e.getLocalizedMessage());
				String error = e.getMessage();
				response.sendRedirect("Admin/500.jsp");

			}
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}
