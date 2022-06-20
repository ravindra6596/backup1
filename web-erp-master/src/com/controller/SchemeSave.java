package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model.C3P0DataSource;

@WebServlet("/SchemeSave")
public class SchemeSave extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SchemeSave() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String submit = request.getParameter("submit");
		try {
			if (submit.equalsIgnoreCase("add")) {
				add_scheme(request, response);
			}

			else if (submit.equalsIgnoreCase("delete")) {
				delete_scheme(request, response);
			} else if (submit.equalsIgnoreCase("update")) {
				update_scheme(request, response);
			} else if (submit.equalsIgnoreCase("approve")) {
				approve_scheme(request, response);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	protected void add_scheme(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		int sid = 0, eid = 0;
		int did = 0;
		String msg = null;
		Connection con = C3P0DataSource.getInstance().getConnection();

		String chemistname = request.getParameter("chemistname");
		String stockiestid = request.getParameter("stockiestname");
		if (stockiestid != null) {
			sid = Integer.parseInt(stockiestid);
		}
		String doctorid = request.getParameter("doctorname");
		if (doctorid != null) {
			did = Integer.parseInt(doctorid);
		}
		String comments = request.getParameter("comments");
		String pname[] = request.getParameterValues("pname[]");
		String scheme[] = request.getParameterValues("scheme[]");
		System.out.println(pname.length + " " + scheme.length);
		int geteid = Integer.parseInt(request.getParameter("eid"));
		Statement schemeInsert = con.createStatement();
		String queryScheme = "insert into scheme(chemist_name,sid,doctorid,comment,eid) values('" + chemistname + "','"
				+ stockiestid + "','" + doctorid + "','" + comments + "','" + geteid + "')";
		int result = schemeInsert.executeUpdate(queryScheme);
		if (result != 0) {
			String getsechemeidQuery = "select scheme_id from scheme where chemist_name='" + chemistname + "' and sid='"
					+ stockiestid + "' and doctorid='" + doctorid + "' and comment='" + comments + "' and eid='"
					+ geteid + "'";
			ResultSet rsgetsechemeid = schemeInsert.executeQuery(getsechemeidQuery);
			while (rsgetsechemeid.next()) {
				int schemeid = rsgetsechemeid.getInt("scheme_id");
				if (rsgetsechemeid != null) {
					int insert = 0;
					for (int i = 0; i < pname.length; i++) {
						for (int j = 0; j < scheme.length; j++) {
							if (i == j) {
								String query = "insert into scheme_product (pid,scheme_given,scheme_id)values(?,?,?)";
								PreparedStatement ps = con.prepareStatement(query);
								ps.setString(1, pname[i]);
								ps.setString(2, scheme[j]);
								ps.setInt(3, schemeid);
								insert = ps.executeUpdate();
							}
						}
					}
					if (insert != 0) {
						msg = "success";
						response.sendRedirect("Employee/addscheme.jsp?response=" + msg);
					} else {
						msg = "fail";
						response.sendRedirect("Employee/addscheme.jsp?response=" + msg);
					}
				}
			}
		}
		con.close();
	}

	protected void update_scheme(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		int sid = 0, eid = 0;
		int did = 0;
		String msg = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		System.out.println("in update if");
		int scid = Integer.parseInt(request.getParameter("schemeid"));
		System.out.println("scid is" + scid);
		String chemistname = request.getParameter("chemistname");
		int stockiestid = Integer.parseInt(request.getParameter("stockiestname"));
		int doctorid = Integer.parseInt(request.getParameter("doctorname"));
		String comments = request.getParameter("comments");
		String pname[] = request.getParameterValues("pname[]");
		String scheme[] = request.getParameterValues("scheme[]");
		Statement stUpdate = con.createStatement();
		String updateQuery = "update scheme set chemist_name='" + chemistname + "',sid='" + stockiestid + "',doctorid='"
				+ doctorid + "',comment='" + comments + "'  where scheme_id='" + scid + "'";
		System.out.println("updateQuery");
		int result = stUpdate.executeUpdate(updateQuery);
		if (result != 0) {
			System.out.println("data updataed successfully from scheme table");
		}
		con.close();
	}

	protected void delete_scheme(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		int sid = 0, eid = 0;
		int did = 0;
		String msg = null;
		Connection con = C3P0DataSource.getInstance().getConnection();

		System.out.println("in delete");
		int schemeid = Integer.parseInt(request.getParameter("schemeid"));
		System.out.println("scheme id for delete is" + schemeid);
		String deleteQuery = "DELETE FROM scheme WHERE scheme_id=" + schemeid + "";
		PreparedStatement ps1 = con.prepareStatement(deleteQuery);
		int insertFlag = ps1.executeUpdate();
		if (insertFlag != 0) {
			String deletePro = "DELETE FROM scheme_product WHERE scheme_id=" + schemeid + "";
			ps1 = con.prepareStatement(deletePro);
			int insertFlag1 = ps1.executeUpdate();
			if (insertFlag1 != 0) {
				System.out.println("deleted");
			}
		} else {
			System.out.println("error");
		}
		con.close();
	}

	protected void approve_scheme(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		int sid = 0, eid = 0;
		int did = 0;
		String msg = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		String[] req_schemeid = request.getParameterValues("scheme_approve[]");
		int update = 0;
		Statement st = con.createStatement();
		System.out.println("length " + req_schemeid.length);
		if (req_schemeid != null) {
			for (int i = 0; i < req_schemeid.length; i++) {
				int scheme_id = Integer.parseInt(req_schemeid[i]);
				String updateStatus = "update scheme set status = 'Approved' where scheme_id ='" + scheme_id + "'";
				System.out.println(updateStatus);
				update = st.executeUpdate(updateStatus);
			}
		}
		if (update != 0) {
			msg = "success";
			response.sendRedirect("Admin/allschemes.jsp?response=" + msg);
		} else {
			msg = "fail";
			response.sendRedirect("Admin/allschemes.jsp?response=" + msg);
		}
		con.close();
	}
}
