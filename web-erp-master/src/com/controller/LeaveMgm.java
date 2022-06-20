package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
 * Servlet implementation class LeaveMgm
 */
@WebServlet("/LeaveMgm")
public class LeaveMgm extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LeaveMgm() {
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

			Connection con = C3P0DataSource.getInstance().getConnection();
			if (submit.equals("Apply")) {
				apply_leave(request, response);
			} else if (submit.equals("Edit")) {
			} else if (submit.equals("Delete")) {
				delete_leave(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void apply_leave(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ParseException, IOException {

		ResultSet rs = null;
		String msg = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement stmt = con.createStatement();
		String leaveType = request.getParameter("leaveType");
		String sdatecl = null;
		String enddatecl = null;
		String sdatepl = null;
		String enddatepl = null;
		String sdatesl = null;
		String enddatesl = null;
		Date parseDate = null;
		Date leaveFrom = null;
		Date leaveTo = null;
		SimpleDateFormat sdfd = new SimpleDateFormat("MM/dd/yyyy");

		int id = Integer.parseInt(request.getParameter("id"));
		if (leaveType.equalsIgnoreCase("CL")) {
			sdatecl = request.getParameter("sdatecl");
			enddatecl = request.getParameter("enddatecl");
			parseDate = sdfd.parse(sdatecl);
			leaveFrom = new java.sql.Date(parseDate.getTime());
			parseDate = sdfd.parse(enddatecl);
			leaveTo = new java.sql.Date(parseDate.getTime());

		} else if (leaveType.equalsIgnoreCase("PL")) {
			sdatepl = request.getParameter("sdatepl");
			enddatepl = request.getParameter("enddatepl");
			parseDate = sdfd.parse(sdatepl);
			leaveFrom = new java.sql.Date(parseDate.getTime());
			parseDate = sdfd.parse(enddatepl);
			leaveTo = new java.sql.Date(parseDate.getTime());
		} else if (leaveType.equalsIgnoreCase("SL")) {
			sdatesl = request.getParameter("sdatesl");
			enddatesl = request.getParameter("enddatesl");
			parseDate = sdfd.parse(sdatesl);
			leaveFrom = new java.sql.Date(parseDate.getTime());
			parseDate = sdfd.parse(enddatesl);
			leaveTo = new java.sql.Date(parseDate.getTime());
		}
		String comment = request.getParameter("comment");

		PreparedStatement ps1 = null;
		Statement st = null;

		Statement st1 = con.createStatement();

		String headQuery = "INSERT INTO leavemgm (eid,leavetype,fromdate,todate,comment,status) VALUES (?,?,?,?,?,?)";
		ps1 = con.prepareStatement(headQuery);
		ps1.setInt(1, id);
		ps1.setString(2, leaveType);
		if (leaveType.equalsIgnoreCase("CL")) {
			ps1.setDate(3, (java.sql.Date) leaveFrom);
			ps1.setDate(4, (java.sql.Date) leaveTo);
		} else if (leaveType.equalsIgnoreCase("PL")) {
			ps1.setDate(3, (java.sql.Date) leaveFrom);
			ps1.setDate(4, (java.sql.Date) leaveTo);
		} else if (leaveType.equalsIgnoreCase("SL")) {
			ps1.setDate(3, (java.sql.Date) leaveFrom);
			ps1.setDate(4, (java.sql.Date) leaveTo);
		} else {

		}
		ps1.setString(5, comment);
		ps1.setString(6, "pending");
		int insertflag = ps1.executeUpdate();
		if (insertflag != 0) {
			msg = "success";
			response.sendRedirect("Employee/leaves.jsp?id=" + id + "&response=" + msg);
		} else {
			msg = "fail";
			response.sendRedirect("Employee/leaves.jsp?id=" + id + "&response=" + msg);
		}
		con.close();
	}

	protected void edit_leave(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ParseException, IOException {

		ResultSet rs = null;
		String msg = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement stmt = con.createStatement();
		String leaveType = request.getParameter("leaveType");
		String sdatecl = null;
		String enddatecl = null;
		String sdatepl = null;
		String enddatepl = null;
		String sdatesl = null;
		String enddatesl = null;
		Date parseDate = null;
		Date leaveFrom = null;
		Date leaveTo = null;
		SimpleDateFormat sdfd = new SimpleDateFormat("MM/dd/yyyy");

		int eid = Integer.parseInt(request.getParameter("eid"));
		int leaveid = Integer.parseInt(request.getParameter("id"));
		String leavetype = request.getParameter("leavetype");

		if (leaveType.equalsIgnoreCase("CL")) {
			sdatecl = request.getParameter("sdatecl");
			enddatecl = request.getParameter("enddatecl");
			parseDate = sdfd.parse(sdatecl);
			leaveFrom = new java.sql.Date(parseDate.getTime());
			parseDate = sdfd.parse(enddatecl);
			leaveTo = new java.sql.Date(parseDate.getTime());

		} else if (leaveType.equalsIgnoreCase("PL")) {
			sdatepl = request.getParameter("sdatepl");
			enddatepl = request.getParameter("enddatepl");
			parseDate = sdfd.parse(sdatepl);
			leaveFrom = new java.sql.Date(parseDate.getTime());
			parseDate = sdfd.parse(enddatepl);
			leaveTo = new java.sql.Date(parseDate.getTime());
		} else if (leaveType.equalsIgnoreCase("SL")) {
			sdatesl = request.getParameter("sdatesl");
			enddatesl = request.getParameter("enddatesl");
			parseDate = sdfd.parse(sdatesl);
			leaveFrom = new java.sql.Date(parseDate.getTime());
			parseDate = sdfd.parse(enddatesl);
			leaveTo = new java.sql.Date(parseDate.getTime());
		}
		String comment = request.getParameter("comment");
		PreparedStatement ps1 = null;
		Statement st = null;

		Statement st1 = con.createStatement();

		String headQuery = "update leavemgm set eid=? , leavetype=?, fromdate=? , todate=? , comment =? where leaveid = '"
				+ leaveid + "'";
		ps1 = con.prepareStatement(headQuery);
		ps1.setInt(1, eid);
		ps1.setString(2, leaveType);
		if (leaveType.equalsIgnoreCase("CL")) {
			ps1.setDate(3, (java.sql.Date) leaveFrom);
			ps1.setDate(4, (java.sql.Date) leaveTo);
		} else if (leaveType.equalsIgnoreCase("PL")) {
			ps1.setDate(3, (java.sql.Date) leaveFrom);
			ps1.setDate(4, (java.sql.Date) leaveTo);
		} else if (leaveType.equalsIgnoreCase("SL")) {
			ps1.setDate(3, (java.sql.Date) leaveFrom);
			ps1.setDate(4, (java.sql.Date) leaveTo);
		} else {

		}
		ps1.setString(5, comment);
		int insertflag = ps1.executeUpdate();
		if (insertflag != 0) {
			msg = "success";
			response.sendRedirect("Employee/leaves.jsp?id=" + eid + "&response=" + msg);
		} else {
			msg = "fail";
			response.sendRedirect("Employee/leaves.jsp?id=" + eid + "&response=" + msg);
		}
		con.close();

	}

	protected void delete_leave(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ParseException, IOException {

		ResultSet rs = null;
		String msg = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement stmt = con.createStatement();

		int leaveid = Integer.parseInt(request.getParameter("id"));
		int delete = con.createStatement().executeUpdate("delete from leavemgm where leaveid ='" + leaveid + "'");
		if (delete != 0) {
			msg = "success";
			request.setAttribute("msg", msg);
			response.sendRedirect("Employee/allLeaves.jsp");
		} else {
			msg = "fail";
			request.setAttribute("msg", msg);
			response.sendRedirect("Employee/allLeaves.jsp");
		}
		con.close();
	}

}
