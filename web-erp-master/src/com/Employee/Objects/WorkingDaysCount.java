package com.Employee.Objects;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import com.model.C3P0DataSource;

public class WorkingDaysCount {
	static LocalDate today = LocalDate.now();
	static LocalDate firstDate = today.withDayOfMonth(1);

	public static int workingDays() {

		int year = today.getYear();
		int month = today.lengthOfMonth();

		Calendar calendar = Calendar.getInstance();

		// Note that month is 0-based in calendar, bizarrely.
		calendar.set(year, month - 1, 1);
		int daysInMonth = today.getDayOfMonth();
		int count = 0;
		for (int day = 1; day <= daysInMonth; day++) {
			calendar.set(year, month - 1, day);
			int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
			if (dayOfWeek == Calendar.SUNDAY) {
				count++;
			}
		}
		int workingDays = daysInMonth - count;
		return workingDays;
	}

	public static int getHolidays() throws Exception {
		Connection con = C3P0DataSource.getInstance().getConnection();
		String query = "SELECT COUNT(*) as count FROM holidays WHERE DATE BETWEEN '" + firstDate + "' AND '" + today
				+ "'";
		ResultSet rs = con.createStatement().executeQuery(query);
		int holiday_count = 0;
		while (rs.next()) {
			holiday_count = rs.getInt("count");
		}
		System.out.println(query);
		con.close();
		return holiday_count;
	}

	public static List<Double> CallCount(int id) throws Exception {
		Connection con = C3P0DataSource.getInstance().getConnection();
		String total_calls = "SELECT COUNT(*) as count FROM tourplan WHERE (DATE BETWEEN '" + firstDate + "' AND '"
				+ today + "') AND eid='" + id + "'";
		ResultSet rs = null;
		rs = con.createStatement().executeQuery(total_calls);
		double callCount = 0;
		double visitedCalls = 0;
		while (rs.next()) {
			callCount = rs.getInt("count");
		}
		String visitedCount = "SELECT COUNT(*) as count FROM tourplan WHERE (DATE BETWEEN '" + firstDate + "' AND '"
				+ today + "') AND eid='" + id + "' AND STATUS='visited'";
		rs = con.createStatement().executeQuery(visitedCount);

		while (rs.next()) {
			visitedCalls = rs.getInt("count");
		}
		int workingDays = workingDays();
		int holidays = getHolidays();
		workingDays = workingDays - holidays;
		double call_avg = (double) visitedCalls / workingDays;
		System.out.println(call_avg);
		List<Double> callData = new ArrayList<Double>();
		callData.add(callCount);
		callData.add(visitedCalls);
		callData.add(call_avg);
		con.close();
		return callData;
	}

	public static List<Double> EmployeeReport_CallCount(int id, String date) throws Exception {
		date = date.replace("-", "");
		Connection con = C3P0DataSource.getInstance().getConnection();
		String total_calls = "SELECT COUNT(*) as count FROM tourplan WHERE (EXTRACT(YEAR_MONTH FROM DATE) ='" + date
				+ "') AND eid='" + id + "'";
		ResultSet rs = null;
		rs = con.createStatement().executeQuery(total_calls);
		double callCount = 0;
		double visitedCalls = 0;
		while (rs.next()) {
			callCount = rs.getInt("count");
		}
		String visitedCount = "SELECT COUNT(*) as count FROM tourplan WHERE (EXTRACT(YEAR_MONTH FROM DATE) ='" + date
				+ "') AND eid='" + id + "' AND STATUS='visited'";
		rs = con.createStatement().executeQuery(visitedCount);

		while (rs.next()) {
			visitedCalls = rs.getInt("count");
		}
		int workingDays = workingDays();
		int holidays = getHolidays();
		workingDays = workingDays - holidays;
		double call_avg = (double) visitedCalls / workingDays;
		System.out.println(call_avg);
		List<Double> callData = new ArrayList<Double>();
		callData.add(callCount);
		callData.add(visitedCalls);
		callData.add(call_avg);
		con.close();
		return callData;
	}

	public static ResultSet MissedDrList(int eid) throws SQLException {
		ResultSet resultSet = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement st = con.createStatement();
		String Query = "SELECT `doctors`.`name` AS doctor_name , `tourplan`.`date`, area.`areaname` FROM tourplan INNER JOIN doctors ON `doctors`.`doctorid`= tourplan.`doctorid` INNER JOIN area ON area.`aid`= tourplan.`aid` WHERE status= 'notvisited' AND  MONTH(DATE) = MONTH(CURRENT_DATE()) AND YEAR(DATE) = YEAR(CURRENT_DATE()) AND eid ='"
				+ eid + "'";
		System.out.println(Query);
		resultSet = st.executeQuery(Query);
		con.close();
		return resultSet;
	}

}
