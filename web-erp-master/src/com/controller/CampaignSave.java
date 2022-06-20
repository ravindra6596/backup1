package com.controller;

import java.io.IOException;
import java.sql.Connection;
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
import javax.servlet.http.HttpSession;

import com.model.C3P0DataSource;

@WebServlet("/CampaignSave")
public class CampaignSave extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public CampaignSave() {
		super();
	}

	static Connection con;
	static {
		con = C3P0DataSource.getInstance().getConnection();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String submit = request.getParameter("submit");
		try {

			Statement state = con.createStatement();

			HttpSession session = request.getSession();
			String utype = (String) session.getAttribute("usertype");
			String currentUserDir = utype.equalsIgnoreCase("admin") ? "Admin" : "Employee";

			if (submit.equalsIgnoreCase("submit")) {
				add_Campaign(request, response);
			}

			else if (submit.equalsIgnoreCase("delete")) {
				delete_Campaign(request, response);
			} else if (submit.equalsIgnoreCase("update")) {
				update_Campaign(request, response);
			} else if (submit.equals("approve")) {
				approve_Campaign(request, response);
			} else if (submit.equals("reject")) {
				reject_Campaign(request, response);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	public static ResultSet CampaignGifts(String dname) throws SQLException {
		Statement state = con.createStatement();
		String sql = "SELECT cname, gift , campaign.cid FROM campaign INNER JOIN campmap ON campmap.`cid`= campaign.`cid` WHERE campmap.`name`='"
				+ dname + "'  AND campaign.`status`='active' AND campaign.`gift` != 'No gifts'";
		ResultSet rs = state.executeQuery(sql);
		con.close();
		return rs;
	}

	protected void add_Campaign(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ParseException, IOException {
		Statement state = con.createStatement();

		HttpSession session = request.getSession();
		String utype = (String) session.getAttribute("usertype");
		String currentUserDir = utype.equalsIgnoreCase("admin") ? "Admin" : "Employee";

		String campaignname = request.getParameter("campaignname");
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String campvalue = request.getParameter("campaignvalue");
		int campaignvalue = 0;
		if (campvalue != null) {
			campaignvalue = Integer.parseInt(campvalue);
		}
		String gift = request.getParameter("gift");
		String doctorname[] = request.getParameterValues("doctorname[]");
		String colorcode = request.getParameter("colorcode");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = sdf.parse(startdate);
		Date start = new java.sql.Date(date.getTime());
		Date date1 = sdf.parse(enddate);
		Date end = new java.sql.Date(date1.getTime());
		Statement st = con.createStatement();
		String query = "insert into campaign(cname,startdate,enddate,campaignvalue,status,color,gift)values('"
				+ campaignname + "','" + start + "','" + end + "','" + campaignvalue + "','Pending','" + colorcode
				+ "','" + gift + "')";

		int result = st.executeUpdate(query, st.RETURN_GENERATED_KEYS);
		if (result != 0) {
			// Write Doctor ID query here
			if (doctorname != null) {
				long recentCampId = 0;
				try (ResultSet generatedKeys = st.getGeneratedKeys()) {
					if (generatedKeys.next()) {
						recentCampId = generatedKeys.getLong(1);

						Statement stInsert = con.createStatement();
						for (int i = 0; i < doctorname.length; i++) {
							String insertquery = "insert into campmap(cid,doctorid ) values('" + recentCampId + "','"
									+ doctorname[i] + "') ";
							System.out.println("campmap inserting data = " + insertquery);
							int res = stInsert.executeUpdate(insertquery);
							if (res != 0) {
								String msg = "add";
								response.sendRedirect(currentUserDir + "/addcampaign.jsp?response=" + msg);
							} else {
								String msg = "fail";
								response.sendRedirect(currentUserDir + "/addcampaign.jsp?response=" + msg);
							}
						}
					} else {
						throw new SQLException("Creating user failed, no ID obtained.");
					}
				}
			}
			con.close();

		} else {
			String msg = "fail";
			response.sendRedirect(currentUserDir + "/addcampaign.jsp?response=" + msg);
		}
	}

	protected void update_Campaign(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ParseException, IOException {

		Statement state = con.createStatement();

		HttpSession session = request.getSession();
		String utype = (String) session.getAttribute("usertype");
		String currentUserDir = utype.equalsIgnoreCase("admin") ? "Admin" : "Employee";

		int id = Integer.parseInt(request.getParameter("cid"));
		// System.out.println("Update Called");
		String campaignname = request.getParameter("campaignname");
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String campvalue = request.getParameter("campaignvalue");
		int campaignvalue = 0;
		if (campvalue != null) {
			campaignvalue = Integer.parseInt(campvalue);
		}
		String colorcode = request.getParameter("colorcode");
		String gift = request.getParameter("gift");
		String status = request.getParameter("status");
		String doctorname[] = request.getParameterValues("doctorname[]");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");
		Date date = sdf.parse(startdate);
		Date start = new java.sql.Date(date.getTime());
		Date date1 = sdf.parse(enddate);
		Date end = new java.sql.Date(date1.getTime());

		Statement deletefrommap = con.createStatement();
		int resultmap = deletefrommap.executeUpdate("delete from campmap where cid='" + id + "'");

		Statement stInsert = con.createStatement();
		if (doctorname != null) {
			for (int i = 0; i < doctorname.length; i++) {
				String insertquery = "insert into campmap(cid,doctorid ) values('" + id + "','" + doctorname[i] + "') ";
				int resultinsert = stInsert.executeUpdate(insertquery);
				if (resultinsert != 0) {
					System.out.println("data inserted in campmap table");
				} else {
					System.out.println("error while inserting data");
				}
			}
		}
		Statement stUpdate = con.createStatement();
		String updateQuery = "update campaign set cname='" + campaignname + "',startdate='" + startdate + "',enddate='"
				+ enddate + "',campaignvalue='" + campaignvalue + "',color='" + colorcode + "', gift='" + gift
				+ "', status='" + status + "' where cid='" + id + "'";
		System.out.println("UpdateQuery= " + updateQuery);
		int resultUpdate = stUpdate.executeUpdate(updateQuery);
		if (resultUpdate != 0) {
			// System.out.println("UpdateQuery= correct ");
			String msg = "update";
			response.sendRedirect(currentUserDir + "/singlecampaign.jsp?cid=" + id + "&response=" + msg);
		} else {
			// System.out.println("UpdateQuery= wrong");
			String msg = "fail";
			response.sendRedirect(currentUserDir + "/singlecampaign.jsp?cid=" + id + "&response=" + msg);
		}
		con.close();
	}

	protected void delete_Campaign(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {

		Statement state = con.createStatement();

		HttpSession session = request.getSession();
		String utype = (String) session.getAttribute("usertype");
		String currentUserDir = utype.equalsIgnoreCase("admin") ? "Admin" : "Employee";

		int cid = 0;
		cid = Integer.parseInt(request.getParameter("cid"));
		Statement deletefrommap = con.createStatement();
		int resultmap = deletefrommap.executeUpdate("delete from campmap where cid='" + cid + "'");
		if (resultmap != 0) {
			Statement stDeleteCampaign = con.createStatement();
			int resultDeleteCampaign = stDeleteCampaign.executeUpdate("delete from campaign where cid='" + cid + "'");
			if (resultDeleteCampaign != 0) {
				String msg = "delete";
				response.sendRedirect(currentUserDir + "/campmgm.jsp?response=" + msg);
			} else {
				String msg = "fail";
				response.sendRedirect(currentUserDir + "/campmgm.jsp?response=" + msg);

			}
		}

		con.close();
	}

	protected void approve_Campaign(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		Statement state = con.createStatement();

		HttpSession session = request.getSession();
		String utype = (String) session.getAttribute("usertype");
		String currentUserDir = utype.equalsIgnoreCase("admin") ? "Admin" : "Employee";

		String cid = request.getParameter("cid");
		int parsedcid = 0;
		if (cid != null) {
			System.out.println("ok");
			parsedcid = Integer.parseInt(cid);

		}
		int updateStatus = state.executeUpdate("update campaign set status ='active' where cid='" + parsedcid + "'");
		if (updateStatus != 0) {
			System.out.println("nook");
			String msg = "update";
			response.sendRedirect(currentUserDir + "/singlecampaign.jsp?cid=" + parsedcid + "&response=" + msg);
		} else {
			String msg = "fail";
			response.sendRedirect(currentUserDir + "/singlecampaign.jsp?cid=" + parsedcid + "&response=" + msg);
		}
		con.close();
	}

	protected void reject_Campaign(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {

		Statement state = con.createStatement();

		HttpSession session = request.getSession();
		String utype = (String) session.getAttribute("usertype");
		String currentUserDir = utype.equalsIgnoreCase("admin") ? "Admin" : "Employee";

		String cid = request.getParameter("cid");
		int parsedcid = 0;
		if (cid != null) {
			parsedcid = Integer.parseInt(cid);
		}
		int updateStatus = state.executeUpdate("update campaign set status ='Rejected' where cid='" + parsedcid + "'");
		if (updateStatus != 0) {
			String msg = "update";
			response.sendRedirect(currentUserDir + "/singlecampaign.jsp?cid=" + parsedcid + "&response=" + msg);
		} else {
			String msg = "fail";
			response.sendRedirect(currentUserDir + "/singlecampaign.jsp?cid=" + parsedcid + "&response=" + msg);
		}
		con.close();
	}
}
