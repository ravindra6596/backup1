package com.controller;

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

import com.model.C3P0DataSource;

/**
 * Servlet implementation class SampleController
 */
@WebServlet("/SampleController")
public class SampleController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SampleController() {
		super();
		// TODO Auto-generated constructor stub
	}

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
			String submit = request.getParameter("flag");
			if (submit.equalsIgnoreCase("Add")) {
				add(request, response);
			} else if (submit.equalsIgnoreCase("delete")) {
				delete(request, response);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	static Statement state;
	static {
		Connection con;
		try {
			con = C3P0DataSource.getInstance().getConnection();
			state = con.createStatement();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public static ResultSet sampleData() throws SQLException {

		String query = "SELECT `sample_products`.`sample_proid`,samples.sampleid,doctors.`name` , product.`pname`, `sample_products`.`sample_quantity` FROM samples INNER JOIN `sample_products` ON `sample_products`.`sampleid`= `samples`.`sampleid` INNER JOIN doctors ON doctors.`doctorid`= `samples`.`doctorid` INNER JOIN `product` ON `product`.`pid`= `sample_products`.`pid`";
		ResultSet rs = state.executeQuery(query);
		return rs;
	}

	public static ArrayList<String> Sample_sums(int pid, int doctorid) throws SQLException {
		String query1 = "SELECT SUM(sample_quantity) AS sum_quantity , `sample_products`.`pid` FROM `sample_products` INNER JOIN samples ON samples.sampleid = sample_products.`sampleid` WHERE pid = '"
				+ pid + "' AND doctorid = '" + doctorid + "'";
		ResultSet rs = state.executeQuery(query1);
		while (rs.next()) {

		}
		return null;
	}

	protected void add(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		Connection con = C3P0DataSource.getInstance().getConnection();
		String msg = null;
		Statement state = con.createStatement();

		String eid = request.getParameter("eid");
		int parsed_eid = 0;
		if (eid != null || eid != "") {
			parsed_eid = Integer.parseInt(eid);
		}
		String[] pid = request.getParameterValues("pname[]");
		String[] Qty = request.getParameterValues("targetqty[]");

		String query = "insert into samples (eid) values('" + parsed_eid + "')";
		int insert_sample = state.executeUpdate(query);
		if (insert_sample != 0) {
			ResultSet rs = con.createStatement().executeQuery("SELECT LAST_INSERT_ID() AS last_id");
			int sample_id = 0;
			if (rs.next()) {
				sample_id = rs.getInt("last_id");
			}
			if (pid != null && Qty != null) {
				if (pid.length == Qty.length) {
					int samplepro = 0;
					for (int i = 0; i < pid.length; i++) {
						int pid_parsed = Integer.parseInt(pid[i]);
						int qty_parsed = Integer.parseInt(Qty[i]);
						String query1 = "insert into sample_products (sampleid, pid, sample_quantity) values('"
								+ sample_id + "','" + pid_parsed + "','" + qty_parsed + "')";

						samplepro = con.createStatement().executeUpdate(query1);

					}
					if (samplepro != 0) {
						msg = "success";
						response.sendRedirect("Admin/sample.jsp?response=" + msg);
					} else {
						msg = "fail";
						response.sendRedirect("Admin/sample.jsp?response=" + msg);
					}
				} else {
					System.out.println("error");
				}

			}
		}
		con.close();
	}

	protected void delete(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		Connection con = C3P0DataSource.getInstance().getConnection();
		String msg = null;
		Statement state = con.createStatement();

		String[] ids = request.getParameterValues("sampleid[]");
		if (ids != null) {
			int delete = 0;
			for (int i = 0; i < ids.length; i++) {
				int sample_id = Integer.parseInt(ids[i]);
				Statement statement = con.createStatement();
				String query = "delete from sample_products where sample_proid = '" + sample_id + "'";
				delete = statement.executeUpdate(query);
			}
			if (delete != 0) {
				msg = "success";
				response.sendRedirect("Admin/allsamples.jsp?response=" + msg);
			} else {
				msg = "fail";
				response.sendRedirect("Admin/allsamples.jsp?response=" + msg);
			}
		}
		con.close();
	}
}
