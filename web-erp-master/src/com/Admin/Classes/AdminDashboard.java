package com.Admin.Classes;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;

import com.model.C3P0DataSource;

public class AdminDashboard {
	static LocalDate today = LocalDate.now();
	
	

	public static String GetTodaysTourPlan() throws Exception {
		String result = "[";
		String getTours = "SELECT e.`name` AS empname , d.`name` AS dname , t.`time`, t.`status`, h.`headquarter` FROM tourplan t INNER JOIN employee e ON e.`eid`= t.`eid` INNER JOIN doctors d ON d.`doctorid`= t.`doctorid` LEFT JOIN headquarters h ON d.haid = h.haid WHERE t.`date`='"
				+ today + "'";
		
		try (Connection con = C3P0DataSource.getInstance().getConnection();) {
			
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(getTours);
			
			while(rs.next()) {
				result += "{\"status\":\"" + rs.getString("status") + "\" , \"empname\": \"" + rs.getString("empname") + "\" , \"dname\": \"" + rs.getString("dname") + "\" , \"time\": \""+ rs.getTime("time") +"\" , \"headquarter\": \"" + rs.getString("headquarter") + "\"}";
				System.out.println(result);
			}
			
			con.close();
	      
	    } catch (SQLException e) {
	    	System.err.println("SQLState: " +((SQLException)e).getSQLState());
            System.err.println("Error Code: " +((SQLException)e).getErrorCode());
            System.err.println("Message: " + e.getMessage());
	    }
		
		result += "]";
		System.out.println(result);
		return result;

	}

	public static String Leaves() throws SQLException {
		
		String result = "[";
		String GetLeave = "SELECT * FROM leavemgm INNER JOIN employee ON employee.`eid` = leavemgm.`eid` WHERE '"
				+ today + "' BETWEEN leavemgm.`fromdate` AND leavemgm.`todate` AND leavemgm.`status`='Approved'";
		
		try (Connection con = C3P0DataSource.getInstance().getConnection();) {
			
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(GetLeave);
			
			while(rs.next()) {
				result += "{\"status\":\"" + rs.getString("status") + "\" , \"name\": \"" + rs.getString("name") + "\" , \"leavetype\": \"" + rs.getString("leavetype") + "\"}";
				System.out.println(result);
			}
			result += "]";
			con.close();
	    } catch (SQLException e) {
	    	System.err.println("SQLState: " +((SQLException)e).getSQLState());
            System.err.println("Error Code: " +((SQLException)e).getErrorCode());
            System.err.println("Message: " + e.getMessage());
	    }
		
		result += "]";
		return result;
	}

	public static JSONObject SaleGraph() throws SQLException, JSONException {

		// LocalDate now = LocalDate.now();
		ArrayList<Integer> years = new ArrayList<Integer>();
		ArrayList<String> monthyear = new ArrayList<String>();
		HashMap<String, Float> totalamt = new HashMap<>();
		HashMap<String, Float> targets = new HashMap<>();
		ArrayList<Integer> months = new ArrayList<Integer>();
		float totalSale = 0;
		float totalTarget = 0;
		JSONObject json = new JSONObject();
		LocalDate firstMonth = today.minusMonths(12);
		for (int i = 0; i < 12; i++) {
			LocalDate earlier = firstMonth.plusMonths(i); // 2015-10-24
			int month = earlier.getMonthValue(); // java.time.Month = OCTOBER
			int year = earlier.getYear();
			monthyear.add(year + "-" + month);
			months.add(month);
			years.add(year);
		}

		String sale_query = "SELECT DATE_FORMAT(orderdate, '%Y-%c') AS month, SUM(totalAmt) as total FROM orders WHERE orderdate <= NOW() and orderdate >= Date_add(Now(),interval - 12 month) GROUP BY DATE_FORMAT(orderdate, '%m-%Y')";
		Connection con = C3P0DataSource.getInstance().getConnection();
		ResultSet saleRS = con.createStatement().executeQuery(sale_query);
		while (saleRS.next()) {
			if (saleRS.getString("total") == "NULL") {
				totalamt.put(saleRS.getString("month"), 0.0f);
				totalSale = totalSale + 0;
			} else {
				totalamt.put(saleRS.getString("month"), saleRS.getFloat("total"));
				totalSale = totalSale + saleRS.getFloat("total");
			}
		}

		String target_query = "SELECT DATE_FORMAT(month, '%Y-%c') AS month, SUM(amount) as target FROM target WHERE month <= NOW() and month >= Date_add(Now(),interval - 12 month) GROUP BY DATE_FORMAT(month, '%m-%Y')";
		
		ResultSet targetRS = con.createStatement().executeQuery(target_query);
		while (targetRS.next()) {
			if (targetRS.getString("target") == "NULL") {
				targets.put(targetRS.getString("month"), 0.0f);
				totalTarget = totalTarget + 0;
			} else {
				targets.put(targetRS.getString("month"), targetRS.getFloat("target"));
				totalTarget = totalTarget + targetRS.getFloat("target");
			}

		}

		float total_avg = totalSale / totalamt.size();

		ArrayList<String> cdataArray = new ArrayList<String>();
		for (int i = 0; i < monthyear.size(); i++) {
			Float amt = totalamt.getOrDefault(monthyear.get(i), 0.0f);
			Float tar = targets.getOrDefault(monthyear.get(i), 0.0f);
			String cdate = "{\"y\":\"" + monthyear.get(i) + "\" , \"item1\": " + amt + " , \"item2\": " + tar + "}";
			cdataArray.add(cdate);
		}

		json.put("cdataArray", cdataArray);
		json.put("total_sale", totalSale);
		json.put("total_avg", total_avg);
		con.close();
		return json;
	}

}
