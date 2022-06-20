package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model.C3P0DataSource;

@WebServlet("/SaveData")
public class AddDoctor extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AddDoctor() {
		super();

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

			String f = request.getParameter("flag");

			if (f.equalsIgnoreCase("ADD")) {
				add_doctor(request, response);
			} else if (f.equalsIgnoreCase("Update")) {
				update_doctor(request, response);

			} else if (f.equalsIgnoreCase("DeLeTe")) {
				delete_doctor(request, response);
			}

		} catch (Exception e) {
			e.printStackTrace();
			String msg = "<p style='color:white;'>Please Provide all the details...</p>";
			request.setAttribute("msg", msg);
			RequestDispatcher rd = request.getRequestDispatcher("Admin/addnewdoctor.jsp");
			rd.forward(request, response);
		}
	}

	protected void add_doctor(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ParseException, IOException {
		ResultSet rs = null;
		String msg = null;
		long did = 0;
		// int did1 = 0;
		int pid1 = 0;
		String f = request.getParameter("flag");
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement stmt = con.createStatement();

		String name = request.getParameter("name");
		String gender = request.getParameter("gender");
		String dob = request.getParameter("dob");
		String doa = request.getParameter("doa");
		int headquarter = Integer.parseInt(request.getParameter("headquarter"));
		String address = request.getParameter("address");
		String clinicphone = request.getParameter("clinicphone");
		long clinicno = 0;
		if (clinicphone != null || !"".equals(clinicphone)) {
			clinicno = Long.parseLong(clinicphone);
		}
		String mobile = request.getParameter("mobile");
		long mobileno = 0;
		if (mobile != null || !"".equals(mobile)) {
			mobileno = Long.parseLong(mobile);
		}
		String degree = request.getParameter("degree");
		String speciality = request.getParameter("speciality");
		String mortimefrom = request.getParameter("mortimefrom");
		String mortimeto = request.getParameter("mortimeto");
		String evetimefrom = request.getParameter("evetimefrom");
		String evetimeto = request.getParameter("evetimeto");
		String grade = request.getParameter("grade");
		String pname[] = request.getParameterValues("pname[]");
		String active = request.getParameter("activepassive");
		Float clinic_lat = Float.parseFloat(request.getParameter("latitude"));
		Float clinic_long = Float.parseFloat(request.getParameter("longitude"));

		if (dob != null) {
			String[] dobS = dob.split("-");
			dob = dobS[2] + "-" + dobS[1] + "-" + dobS[0];
			System.out.println(dob);
		}
		if (doa != null) {
			String[] doaS = doa.split("-");
			doa = doaS[2] + "-" + doaS[1] + "-" + doaS[0];
		}

		// morning time from
		SimpleDateFormat sdfd = new SimpleDateFormat("hh:mm");
		Time timeDB = null;
		Time timeDB2 = null;
		Time timeetf = null;
		Time timeett = null;
		Time timecmtf = null;
		Time timecmtt = null;
		Time timecetf = null;
		Time timecett = null;
		if (mortimefrom != null) {
			Date time2 = sdfd.parse(mortimefrom);
			timeDB = new Time(time2.getTime());
		}
		if (mortimeto != null) {
			// morning time to
			Date timeto2 = sdfd.parse(mortimeto);
			timeDB2 = new Time(timeto2.getTime());
		}

		// evening time from
		if (evetimefrom != null) {
			Date time3 = sdfd.parse(evetimefrom);
			timeetf = new Time(time3.getTime());
		}
		// evening time to
		if (evetimeto != null) {
			Date time4 = sdfd.parse(evetimeto);
			timeett = new Time(time4.getTime());
		}
		/* parsing for schedule table time */
		// cmorning time from
		String checkduplicate = "select * from doctors where name ='" + name + "'";
		System.out.println(checkduplicate);
		rs = stmt.executeQuery(checkduplicate);
		if (rs.next()) {
			msg = "duplicate";
			request.setAttribute("msg", msg);
			response.sendRedirect("Admin/addnewdoctor.jsp");
		} else {

			String query = "insert into doctors(name,gender,dob,doa,haid,address,clinicphone,mobile,degree,speciality,mortimefrom,mortimeto,evetimefrom,evetimeto,grade,activepassive,clinic_lat,clinic_long) values('"
					+ name + "','" + gender + "','" + dob + "','" + doa + "','" + headquarter + "','" + address + "','"
					+ clinicno + "','" + mobileno + "','" + degree + "','" + speciality + "','" + timeDB + "','"
					+ timeDB2 + "','" + timeetf + "','" + timeett + "','" + grade + "','" + active + "','" + clinic_lat
					+ "','" + clinic_long + "')";
			did = stmt.executeUpdate(query, stmt.RETURN_GENERATED_KEYS);
			System.out.println("inserted");

			if (did != 0) {
				System.out.println("inside rs");
				if (pname != null) {
					int insertFlag = 0;
					ResultSet rs1 = stmt.getGeneratedKeys();
					rs1.next();
					int docid = rs1.getInt(1);
					System.out.println("inside pname");
					for (int j = 0; j < pname.length; j++) {
						System.out.println("inside for");
						String focquery = "insert into focusedproduct1(doctorid,pid) values('" + docid + "','"
								+ pname[j] + "')";
						insertFlag = stmt.executeUpdate(focquery);
						System.out.println("focus");
						System.out.println(insertFlag + "\n" + focquery);
					}

					if (insertFlag != 0) {
						System.out.println("inside flag");
						msg = "success";
						request.setAttribute("msg", msg);
						response.sendRedirect("Admin/addnewdoctor.jsp?response=" + msg);
					} else {

						msg = "fail";
						request.setAttribute("msg", msg);
						response.sendRedirect("Admin/addnewdoctor.jsp?response=" + msg);
					}

				}
			}

		}
		con.close();
	}

	protected void update_doctor(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ParseException, IOException {
		ResultSet rs = null;
		String msg = null;
		long did = 0;
		// int did1 = 0;
		int pid1 = 0;
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement stmt = con.createStatement();

		String _id = request.getParameter("did");
		int doctorid = 0;
		if (_id != null) {
			doctorid = Integer.parseInt(_id);
		}
		String name = request.getParameter("name");
		String gender = request.getParameter("gender");
		String dob = request.getParameter("dob");
		String doa = request.getParameter("doa");
		int area = 0;
		String string_area = request.getParameter("area");
		if (string_area != null) {
			area = Integer.parseInt(string_area);
		}
		String string_hq = request.getParameter("headquarter");
		int headquarter = 0;
		if (string_hq != null) {
			headquarter = Integer.parseInt(string_hq);
		}
		String address = request.getParameter("address");
		String clinicphone = request.getParameter("clinicphone");
		long clinicno = 0;
		if (clinicphone != null || !"".equals(clinicphone)) {
			clinicno = Long.parseLong(clinicphone);
		}
		String mobile = request.getParameter("mobile");
		long mobileno = 0;
		if (mobile != null || !"".equals(mobile)) {
			mobileno = Long.parseLong(mobile);
		}
		String degree = request.getParameter("degree");
		String speciality = request.getParameter("speciality");
		String mortimefrom = request.getParameter("mortimefrom");
		String mortimeto = request.getParameter("mortimeto");
		String evetimefrom = request.getParameter("evetimefrom");
		String evetimeto = request.getParameter("evetimeto");
		String grade = request.getParameter("grade");
		String pname[] = request.getParameterValues("pname[]");
		String active = request.getParameter("activepassive");
		Float clinic_lat = Float.parseFloat(request.getParameter("latitude"));
		Float clinic_long = Float.parseFloat(request.getParameter("longitude"));

		if (dob != null) {
			String[] dobS = dob.split("-");
			dob = dobS[2] + "-" + dobS[1] + "-" + dobS[0];
		}
		if (doa != null) {
			String[] doaS = doa.split("-");
			doa = doaS[2] + "-" + doaS[1] + "-" + doaS[0];
		}

		// morning time from
		SimpleDateFormat sdfd = new SimpleDateFormat("hh:mm");
		Time timeDB = null;
		Time timeDB2 = null;
		Time timeetf = null;
		Time timeett = null;
		Time timecmtf = null;
		Time timecmtt = null;
		Time timecetf = null;
		Time timecett = null;
		if (mortimefrom != null) {
			Date time2 = sdfd.parse(mortimefrom);
			timeDB = new Time(time2.getTime());
		}
		if (mortimeto != null) {
			// morning time to
			Date timeto2 = sdfd.parse(mortimeto);
			timeDB2 = new Time(timeto2.getTime());
		}

		// evening time from
		if (evetimefrom != null) {
			Date time3 = sdfd.parse(evetimefrom);
			timeetf = new Time(time3.getTime());
		}
		// evening time to
		if (evetimeto != null) {
			Date time4 = sdfd.parse(evetimeto);
			timeett = new Time(time4.getTime());
		}
		/* parsing for schedule table time */
		// cmorning time from
		System.out.println("update doctor id is: " + doctorid);
		int j = stmt.executeUpdate("update doctors set name='" + name + "',gender='" + gender + "',dob='" + dob
				+ "',doa='" + doa + "',haid='" + headquarter + "',address='" + address + "',clinicphone='" + clinicno
				+ "',mobile='" + mobileno + "',degree='" + degree + "',speciality='" + speciality + "',mortimefrom='"
				+ timeDB + "',mortimeto='" + timeDB2 + "',evetimefrom='" + timeetf + "',evetimeto='" + timeett
				+ "',grade='" + grade + "',activepassive='" + active + "',clinic_lat='" + clinic_lat + "',clinic_long='"
				+ clinic_long + "' WHERE doctorid='" + doctorid + "' ");
		System.out.println("Data Updated Successfully");

		int updateFlag = 0;
		System.out.println("focusproduct1");
		if (pname != null) {
//				ResultSet rs1 =stmt.getGeneratedKeys();
//				rs1.next();
//				int docid=rs1.getInt(1);
//				

			System.out.println("focusproduct2");
			for (int k = 0; k < pname.length; k++) {
				System.out.println("inside for loop");
				String plid = "select doctorid from doctors where name ='" + name + "'";
				rs = stmt.executeQuery(plid);
				System.out.println(plid);
				if (rs.next()) {
					pid1 = rs.getInt("doctorid");
				}
				// updateFlag = stmt.executeUpdate("update focusedproduct1 set doctorid="+ pid1
				// + ",pname='" + pname[k] + "')");
				String deletequery = "delete from focusedproduct1 where doctorid= '" + doctorid + " ' ";
				int deleteflag = stmt.executeUpdate(deletequery);
				System.out.println(deletequery);
				updateFlag = stmt.executeUpdate(
						"INSERT INTO focusedproduct1 (doctorid,pid) VALUES (" + pid1 + ",'" + pname[k] + "')");
				System.out.println("focusproduct3");
			}

		}
		if (updateFlag != 0) {
			System.out.println("Inside Flag");
			msg = "success";
			request.setAttribute("msg", msg);
			response.sendRedirect("Admin/singledoctor.jsp?id=" + doctorid + "&response=" + msg);
		} else {

			msg = "fail";
			request.setAttribute("msg", msg);
			response.sendRedirect("Admin/singledoctor.jsp?id=" + doctorid + "&response=" + msg);
		}
		con.close();
	}

	protected void delete_doctor(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		ResultSet rs = null;
		String msg = null;
		long did = 0;
		// int did1 = 0;
		int pid1 = 0;
		String f = request.getParameter("flag");
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement stmt = con.createStatement();

		int docid = Integer.parseInt(request.getParameter("did"));
		System.out.println("doctor id " + docid);

		int deletedoc = stmt.executeUpdate("delete from doctors where doctorid='" + docid + "'");

		if (deletedoc != 0) {
			System.out.println("in deletesch if");
			int deletefoc = stmt.executeUpdate("delete from focusedproduct1 where doctorid='" + docid + "'");

			System.out.println("below statement");
			if (deletefoc != 0) {
				System.out.println("delete Success");
				msg = "success";
				request.setAttribute("msg", msg);
				response.sendRedirect("Admin/alldoctors.jsp?id=" + docid + "&response=" + msg);

			} else {
				System.out.println("messege show");
				msg = "<p style='color:white;'>Something went wrong. please try again!</p>";
				request.setAttribute("msg", msg);
				response.sendRedirect("Admin/alldoctors.jsp?id=" + docid + "&response=" + msg);

			}

		}
		con.close();
	}

}
