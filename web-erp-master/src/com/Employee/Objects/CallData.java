package com.Employee.Objects;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.model.C3P0DataSource;

public class CallData {
	public static List<Double> CallAverage(int id) throws Exception {
		Connection con = C3P0DataSource.getInstance().getConnection();
		int working_days = WorkingDaysCount.workingDays();
		int holidays = WorkingDaysCount.getHolidays();
		working_days = working_days - holidays;

		ResultSet rs = null;
		Statement st = con.createStatement();

		rs = st.executeQuery("select eid from employee where assignedauth = '" + id + "'");
		double call_count = 0;
		double visited_call = 0;
		List<Double> data = new ArrayList<>();
		while (rs.next()) {
			data = WorkingDaysCount.CallCount(rs.getInt("eid"));
			if (call_count == 0 && visited_call == 0) {
				call_count = data.get(0);
				visited_call = data.get(1);
			} else {
				call_count = call_count + data.get(0);
				visited_call = visited_call + data.get(1);
			}
		}

		double call_avg = visited_call / working_days;
		List<Double> callData = new ArrayList<Double>();
		callData.add(call_count);
		callData.add(visited_call);
		callData.add(call_avg);
		con.close();
		return callData;
	}

	public static List<Double> RBMCallAverage(int id) throws Exception {
		Connection con = C3P0DataSource.getInstance().getConnection();
		int working_days = WorkingDaysCount.workingDays();
		int holidays = WorkingDaysCount.getHolidays();
		working_days = working_days - holidays;

		ArrayList<Integer> eids = new ArrayList<>();
		ResultSet rs = null;
		Statement st = con.createStatement();
		rs = st.executeQuery("select eid from employee where assignedauth='" + id + "'");
		while (rs.next()) {
			eids.add(rs.getInt("eid"));
			ResultSet rs_tm = con.createStatement()
					.executeQuery("select eid from employee where assignedauth ='" + rs.getInt("eid") + "'");
			while (rs_tm.next()) {
				eids.add(rs_tm.getInt("eid"));
			}
		}
		double call_count = 0;
		double visited_call = 0;
		List<Double> data = new ArrayList<>();
		for (int eid = 0; eid < eids.size(); eid++) {
			data = WorkingDaysCount.CallCount(eids.get(eid));
			if (call_count == 0 && visited_call == 0) {
				call_count = data.get(0);
				visited_call = data.get(1);
			} else {
				call_count = call_count + data.get(0);
				visited_call = visited_call + data.get(1);
			}
		}
		double call_avg = visited_call / working_days;
		List<Double> callData = new ArrayList<Double>();
		callData.add(call_count);
		callData.add(visited_call);
		callData.add(call_avg);
		con.close();
		return callData;
	}

	public static List<Double> BUCallAverage(int id) throws Exception {
		Connection con = C3P0DataSource.getInstance().getConnection();
		int working_days = WorkingDaysCount.workingDays();
		int holidays = WorkingDaysCount.getHolidays();
		working_days = working_days - holidays;

		ArrayList<Integer> eids = new ArrayList<>();
		ResultSet rs = null;
		Statement st = con.createStatement();
		rs = st.executeQuery("select eid from employee where assignedauth='" + id + "'");
		while (rs.next()) {
			eids.add(rs.getInt("eid"));
			ResultSet rs_abm = con.createStatement()
					.executeQuery("select eid from employee where assignedauth ='" + rs.getInt("eid") + "'");
			while (rs_abm.next()) {
				eids.add(rs_abm.getInt("eid"));
				ResultSet rs_tm = con.createStatement()
						.executeQuery("select eid from employee where assignedauth ='" + rs_abm.getInt("eid") + "'");
				while (rs_tm.next()) {
					eids.add(rs_tm.getInt("eid"));
				}
			}
		}

		double call_count = 0;
		double visited_call = 0;
		List<Double> data = new ArrayList<>();
		for (int eid = 0; eid < eids.size(); eid++) {
			data = WorkingDaysCount.CallCount(eids.get(eid));
			if (call_count == 0 && visited_call == 0) {
				call_count = data.get(0);
				visited_call = data.get(1);
			} else {
				call_count = call_count + data.get(0);
				visited_call = visited_call + data.get(1);
			}
		}
		double call_avg = visited_call / working_days;
		List<Double> callData = new ArrayList<Double>();
		callData.add(call_count);
		callData.add(visited_call);
		callData.add(call_avg);
		con.close();
		return callData;
	}
}
