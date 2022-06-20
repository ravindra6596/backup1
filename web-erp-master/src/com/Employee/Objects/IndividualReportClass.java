package com.Employee.Objects;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.model.C3P0DataSource;

public class IndividualReportClass {

	static Connection con = null;
	static {
		con = C3P0DataSource.getInstance().getConnection();
	}

	public static JSONObject gettarget_report(int targetid) throws SQLException, JSONException {
		ArrayList<String> pid = new ArrayList<String>();
		ArrayList<Integer> target = new ArrayList<Integer>();
		ArrayList<Integer> acheived_target = new ArrayList<Integer>();
		double totalAcheivedValue = 0;
		double total_targetValue = 0;
		int target_sum = 0;
		int achieved_sum = 0;
		double total = 0;
		int eid = 0;
		String pidQuery = "SELECT * FROM targetproducts INNER JOIN individualtarget ON individualtarget.`individualid`=targetproducts.`individualid` WHERE `individualtarget`.`individualid`= '"
				+ targetid + "'";
		System.out.println(pidQuery);

		Statement stmt1 = con.createStatement();
		ResultSet rs_pid = stmt1.executeQuery(pidQuery);
		while (rs_pid.next()) {
			String date1 = rs_pid.getString("datefrom");
			date1 = date1.replace("-", "");
			eid = rs_pid.getInt("eid");
			Statement stmt3 = con.createStatement();
			ResultSet rs_pname = stmt3
					.executeQuery("select pname, pts from product where pid='" + rs_pid.getInt("pid") + "'");
			while (rs_pname.next()) {
				pid.add(rs_pname.getString("pname"));
				String orderQty = "SELECT pname, quantity FROM placeorder INNER JOIN orders ON orders.`orderid`=placeorder.`orderid` WHERE (orders.eid='"
						+ eid + "') AND (pname='" + rs_pname.getString("pname")
						+ "') AND (EXTRACT(YEAR_MONTH FROM orders.`ordertime`) ='" + date1 + "')";
				Statement stmt4 = con.createStatement();
				ResultSet rs_achieved = stmt4.executeQuery(orderQty);
				if (rs_achieved.next() == false) {
					acheived_target.add(0);
				} else {
					do {
						acheived_target.add(rs_achieved.getInt("quantity"));
						achieved_sum = achieved_sum + rs_achieved.getInt("quantity");
						totalAcheivedValue = totalAcheivedValue
								+ (rs_achieved.getInt("quantity") * rs_pname.getFloat("pts"));
					} while (rs_achieved.next());
				}
				total_targetValue = total_targetValue + (rs_pid.getInt("target") * rs_pname.getFloat("pts"));
			}
			target.add(rs_pid.getInt("target"));
			target_sum = target_sum + rs_pid.getInt("target");
		}
		System.out.println("acheived_sum=" + achieved_sum + " targetsum=" + target_sum);
		if (target_sum != 0 && achieved_sum != 0) {
			total = (achieved_sum / target_sum) * 100;
		}

		System.out.println("total=" + total);

		JSONObject json_target = new JSONObject();
		json_target.put("pid", pid);
		json_target.put("target", target);
		json_target.put("eid", eid);
		json_target.put("achieved_target", acheived_target);
		json_target.put("target_sum", target_sum);
		json_target.put("total_target_value", total_targetValue);
		json_target.put("achieved_sum", achieved_sum);
		json_target.put("total_achieved_sum", achieved_sum);
		json_target.put("total", total);
		System.out.println("jsnreturn: " + json_target);
		con.close();
		return json_target;

	}

	public static ResultSet TargetList(int eid) throws SQLException {
		String sql = "SELECT * FROM individualtarget WHERE eid ='" + eid + "'";
		Statement state = con.createStatement();
		ResultSet rs = state.executeQuery(sql);
		con.close();
		return rs;
	}

	public static JSONObject Own_target(String usertype, int eid, String date) throws SQLException, JSONException {
		ResultSet rs = null;
		Statement state = con.createStatement();
		ArrayList<String> pid = new ArrayList<String>();
		ArrayList<Integer> target = new ArrayList<Integer>();
		ArrayList<Integer> acheived_target = new ArrayList<Integer>();
		int target_sum = 0;
		int achieved_sum = 0;
		double total = 0;
		double totalAcheivedValue = 0;
		double total_targetValue = 0;

		ResultSet rs_tm = GetData.Tms(eid, usertype);
		String sql1 = "select * from `individualtarget` where datefrom = '" + date + "' and (";
		String where = "";
		while (rs_tm.next()) {
			where = where + "eid= '" + rs_tm.getInt("eid") + "' OR ";
		}
		where = where.substring(0, where.length() - 4) + ")";
		sql1 = sql1 + where;
		ResultSet rs_targets = state.executeQuery(sql1);
		while (rs_targets.next()) {
			JSONObject json = new JSONObject();
			json = gettarget_report(rs_targets.getInt("individualid"));
			JSONArray json_pid = json.getJSONArray("pid");
			JSONArray json_target = json.getJSONArray("target");
			JSONArray json_acheived_target = json.getJSONArray("achieved_target");
			for (int i = 0; i < json_pid.length(); i++) {
				if (pid.contains(json_pid.get(i))) {
					int index = pid.indexOf(json_pid.get(i));
					int target_add = target.get(index) + json_target.getInt(i);
					target.remove(index);
					target.add(index, target_add);
					int achieved_add = acheived_target.get(index) + json_acheived_target.getInt(i);
					acheived_target.remove(index);
					acheived_target.add(index, achieved_add);
				} else {
					pid.add(json_pid.getString(i));
					target.add(json_target.getInt(i));
					acheived_target.add(json_acheived_target.getInt(i));
				}
			}
			target_sum = target_sum + json.getInt("target_sum");
			total_targetValue = total_targetValue + json.getDouble("total_target_value");
			achieved_sum = achieved_sum + json.getInt("achieved_sum");
			totalAcheivedValue = totalAcheivedValue + json.getDouble("total_achieved_sum");
			total = total + json.getDouble("total");
		}
		JSONObject json_all = new JSONObject();
		json_all.put("pid", pid);
		json_all.put("target", target);
		// json_all.put("eid", eid);
		json_all.put("achieved_target", acheived_target);
		json_all.put("target_sum", target_sum);
		json_all.put("total_target_value", total_targetValue);
		json_all.put("achieved_sum", achieved_sum);
		json_all.put("total_achieved_sum", achieved_sum);
		json_all.put("total", total);
		con.close();
		return json_all;
	}

}
