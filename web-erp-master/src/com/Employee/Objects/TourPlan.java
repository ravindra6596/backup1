package com.Employee.Objects;

import java.sql.Connection;
import java.sql.ResultSet;
//import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.temporal.WeekFields;
import java.util.Locale;

import com.model.C3P0DataSource;

public class TourPlan {
	static LocalDate today = LocalDate.now();
	static LocalDate firstday = today.withDayOfMonth(1);
	static int daysOfMonth = today.lengthOfMonth();
	static int month = today.getMonthValue();
	static int year = today.getYear();

	public static String CheckRecords() throws Exception {
		Connection con = C3P0DataSource.getInstance().getConnection();
		String result = null;
		String query = "select * from tourplan where month(date)='" + month + "' and year(date)='" + year + "'";
		ResultSet rs = con.createStatement().executeQuery(query);
		if (rs.next()) {
			result = "false";
		} else {
			result = "true";
		}

		return result;
	}

	public static String TMtourPlan() throws Exception {
		String result = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		ResultSet TMids = con.createStatement().executeQuery("select eid , aid from employee where usertype='TM'");
		while (TMids.next()) {
			for (int day = 1; day <= daysOfMonth; day++) {
				LocalDate date = today.withDayOfMonth(day);
				int dayOfWeek = date.getDayOfWeek().getValue();
				WeekFields weekFields = WeekFields.of(Locale.getDefault());
				int weekNumber = date.get(weekFields.weekOfWeekBasedYear());
				String Query = "SELECT doctors.name, doctors.aid,doctors.`doctorid`, schedule.cmortimefrom,schedule.cmortimeto,schedule.cevetimefrom,schedule.cevetimeto, doctors.clinicphone,doctors.address FROM doctors INNER JOIN schedule ON schedule.doctorid=doctors.doctorid WHERE (schedule.callweek=('"
						+ weekNumber + "' AND ('every week')) OR doctors.`aid`='" + TMids.getInt("aid")
						+ "') AND schedule.callday='" + dayOfWeek + "' ORDER BY grade";
				// System.out.println(Query);
				Statement st_schedule = con.createStatement();
				ResultSet rs_schedule = st_schedule.executeQuery(Query);
				if (rs_schedule != null) {
					while (rs_schedule.next()) {
						String app_time = null;
						if (rs_schedule.getString("cmortimefrom") != null) {
							app_time = rs_schedule.getString("cmortimefrom");
						} else {
							app_time = rs_schedule.getString("cevetimefrom");
						}
						String add_query = "insert into tourplan(doctorid,date,time,eid,aid) values('"
								+ rs_schedule.getInt("doctorid") + "','" + date + "','" + app_time + "','"
								+ TMids.getInt("eid") + "','" + TMids.getInt("aid") + "')";
						// System.out.println(add_query);
						Statement stmt3 = con.createStatement();
						int rs_add = stmt3.executeUpdate(add_query);
						if (rs_add != 0) {
							System.out.println("Data inserted successfully");
							result = "success";
						}
					}
				}
			}
		}
		con.close();
		return result;
	}

	public static String ABMtourPlans() throws Exception {
		String result = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		ResultSet ABMids = con.createStatement().executeQuery("select eid, aid from employee where usertype='ABM'");
		while (ABMids.next()) {
			String Qu = "select doctorid from asigneddoctor where eid='" + ABMids.getInt("eid") + "'";

			ResultSet rsAssignDoctors = con.createStatement().executeQuery(Qu);
			while (rsAssignDoctors.next()) {
				for (int day = 1; day <= daysOfMonth; day++) {
					LocalDate date = today.withDayOfMonth(day);
					int dayOfWeek = date.getDayOfWeek().getValue();
					WeekFields weekFields = WeekFields.of(Locale.getDefault());
					int weekNumber = date.get(weekFields.weekOfWeekBasedYear());
					String ScheduleQuery = "SELECT * FROM schedule INNER JOIN doctors ON doctors.`doctorid` = `schedule`.`doctorid` WHERE schedule.doctorid ='"
							+ rsAssignDoctors.getInt("doctorid") + "' AND (schedule.callweek = '" + weekNumber
							+ "' OR schedule.callweek= 'every week') AND schedule.callday ='" + dayOfWeek + "' ";
					// System.out.println(ScheduleQuery);
					Statement st_schedule = con.createStatement();
					ResultSet rs_schedule = st_schedule.executeQuery(ScheduleQuery);
					if (rs_schedule != null) {
						while (rs_schedule.next()) {
							String app_time = null;
							if (rs_schedule.getString("cmortimefrom") != null) {
								app_time = rs_schedule.getString("cmortimefrom");
							} else {
								app_time = rs_schedule.getString("cevetimefrom");
							}
							String add_query = "insert into tourplan(doctorid,date,time,eid,aid) values('"
									+ rs_schedule.getInt("doctorid") + "','" + date + "','" + app_time + "','"
									+ ABMids.getInt("eid") + "','" + ABMids.getInt("aid") + "')";
							// System.out.println(add_query);
							Statement stmt3 = con.createStatement();
							int rs_add = stmt3.executeUpdate(add_query);
							if (rs_add != 0) {
								System.out.println("Data inserted successfully");
								result = "success";
							}
						}
					}
				}
			}
		}
		con.close();
		return result;
	}

	public static String RBMtourPlan() throws Exception {
		String result = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		ResultSet RBMids = con.createStatement().executeQuery("select eid, aid from employee where usertype='RBM'");
		while (RBMids.next()) {
			String Qu = "select doctorid from asigneddoctor where eid='" + RBMids.getInt("eid") + "'";
			// System.out.println(Qu);
			ResultSet rsAssignDoctors = con.createStatement().executeQuery(Qu);

			// System.out.println("dhck");
			while (rsAssignDoctors.next()) {
				for (int day = 1; day <= daysOfMonth; day++) {
					LocalDate date = today.withDayOfMonth(day);
					int dayOfWeek = date.getDayOfWeek().getValue();
					WeekFields weekFields = WeekFields.of(Locale.getDefault());
					int weekNumber = date.get(weekFields.weekOfWeekBasedYear());
					String ScheduleQuery = "SELECT * FROM schedule INNER JOIN doctors ON doctors.`doctorid` = `schedule`.`doctorid` WHERE schedule.doctorid ='"
							+ rsAssignDoctors.getInt("doctorid") + "' AND (schedule.callweek = '" + weekNumber
							+ "' OR schedule.callweek= 'every week') AND schedule.callday ='" + dayOfWeek + "' ";
					// System.out.println(ScheduleQuery);
					Statement st_schedule = con.createStatement();
					ResultSet rs_schedule = st_schedule.executeQuery(ScheduleQuery);
					if (rs_schedule != null) {
						while (rs_schedule.next()) {
							String app_time = null;
							if (rs_schedule.getString("cmortimefrom") != null) {
								app_time = rs_schedule.getString("cmortimefrom");
							} else {
								app_time = rs_schedule.getString("cevetimefrom");
							}
							String add_query = "insert into tourplan(doctorid,date,time,eid,aid) values('"
									+ rs_schedule.getInt("doctorid") + "','" + date + "','" + app_time + "','"
									+ RBMids.getInt("eid") + "','" + RBMids.getInt("aid") + "')";
							// System.out.println(add_query);
							Statement stmt3 = con.createStatement();
							int rs_add = stmt3.executeUpdate(add_query);
							if (rs_add != 0) {
								System.out.println("Data inserted successfully");
								result = "success";
							}
						}
					}
				}
			}

		}
		con.close();
		return result;
	}

}
