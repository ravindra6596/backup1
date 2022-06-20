
package com.Employee.Objects;

import java.sql.Connection;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.model.C3P0DataSource;

public class Dashboard {
	static LocalDate now = LocalDate.now();
	static LocalDate earlier = now.plusDays(3); // 2015-10-24
	static LocalDate firstDate = now.withDayOfMonth(1);

	public static List<String> AbmCalendarData() throws Exception {
		Connection con = C3P0DataSource.getInstance().getConnection();

		List<String> doctor_name = new ArrayList<String>();
		List<String> day = new ArrayList<String>();
		List<String> calendarData = new ArrayList<String>();
		ResultSet rs_birthday = con.createStatement()
				.executeQuery("SELECT NAME, dob FROM doctors WHERE (dob BETWEEN '" + now + "' AND '" + earlier + "')");
		while (rs_birthday.next()) {
			doctor_name.add(rs_birthday.getString("name"));
			day.add(rs_birthday.getString("dob"));
		}
		ResultSet rs_anniversary = con.createStatement()
				.executeQuery("SELECT NAME,doa FROM doctors WHERE (doa BETWEEN '" + now + "' AND '" + earlier + "') ");
		while (rs_anniversary.next()) {
			String anni_cdata = "{\"title\" : \"" + rs_anniversary.getString("name") + "\" , \"start\" : \""
					+ rs_anniversary.getString("doa")
					+ "\", \"backgroundColor\" : \"#f39c12\" , \"borderColor\" :\"#f39c12\"}";
			calendarData.add(anni_cdata);
		}

		for (int i = 0; i < doctor_name.size(); i++) {
			for (int j = 0; j < day.size(); j++) {
				if (i == j) {
					String cdata = "{\"title\" : \"" + doctor_name.get(i) + "\" , \"start\" : \"" + day.get(j) + "\"}";
					calendarData.add(cdata);
				}
			}
		}
		con.close();
		return calendarData;
	}

	public static List<String> productTarget(int eid) throws Exception {
		Connection con = C3P0DataSource.getInstance().getConnection();
		ResultSet rs = null;
		List<String> productName = new ArrayList<String>();
		List<Integer> Target = new ArrayList<Integer>();
		List<Integer> acheived = new ArrayList<Integer>();
		int i = 1;
		rs = con.createStatement().executeQuery("select eid from employee where assignedauth ='" + eid + "'");
		while (rs.next()) {
			String Q1 = "SELECT product.`pname`,targetproducts.`target` FROM targetproducts INNER JOIN product ON product.`pid`= targetproducts.`pid` INNER JOIN individualtarget ON individualtarget.`individualid`=targetproducts.`individualid` WHERE ('"
					+ now
					+ "' BETWEEN individualtarget.`datefrom` AND individualtarget.`dateto`) AND (individualtarget.`eid`='"
					+ rs.getInt("eid") + "')";
			ResultSet rsProductData = con.createStatement().executeQuery(Q1);
			if (i == 1) {
				while (rsProductData.next()) {
					String pname = rsProductData.getString("pname");
					int target = rsProductData.getInt("target");
					productName.add(pname);
					Target.add(target);
					String acheivedtarget = "SELECT pname, quantity FROM placeorder INNER JOIN orders ON orders.`orderid`=placeorder.`orderid` WHERE (DATE(orders.ordertime) BETWEEN '"
							+ firstDate + "' AND '" + now + "') AND (orders.`eid`='" + rs.getInt("eid")
							+ "') AND (placeorder.`pname` ='" + rsProductData.getString("pname") + "')";
					ResultSet rs_acheived = con.createStatement().executeQuery(acheivedtarget);
					while (rs_acheived.next()) {
						acheived.add(rs_acheived.getInt("quantity"));
					}
				}
			} else {
				while (rsProductData.next()) {
					String pname = rsProductData.getString("pname");
					int target = rsProductData.getInt("target");
					if (productName.contains(pname)) {
						int index = productName.indexOf(pname);
						int value = Target.get(index);
						value = value + target;
						Target.set(index, value);
						String acheivedtarget = "SELECT pname, quantity FROM placeorder INNER JOIN orders ON orders.`orderid`=placeorder.`orderid` WHERE (DATE(orders.ordertime) BETWEEN '"
								+ firstDate + "' AND '" + now + "') AND (orders.`eid`='" + rs.getInt("eid")
								+ "') AND (placeorder.`pname` ='" + rsProductData.getString("pname") + "')";
						ResultSet rs_acheived = con.createStatement().executeQuery(acheivedtarget);
						while (rs_acheived.next()) {
							int acheived_value = acheived.get(index);
							acheived_value = acheived_value + rs_acheived.getInt("quantity");
							acheived.set(index, acheived_value);
						}
					} else {
						productName.add(pname);
						Target.add(target);
						String acheivedtarget = "SELECT pname, quantity FROM placeorder INNER JOIN orders ON orders.`orderid`=placeorder.`orderid` WHERE (DATE(orders.ordertime) BETWEEN '"
								+ firstDate + "' AND '" + now + "') AND (orders.`eid`='" + rs.getInt("eid")
								+ "') AND (placeorder.`pname` ='" + rsProductData.getString("pname") + "')";
						ResultSet rs_acheived = con.createStatement().executeQuery(acheivedtarget);
						while (rs_acheived.next()) {
							acheived.add(rs_acheived.getInt("quantity"));
						}
					}
				}
			}
			i++;
		}
		System.out.println("acheieved=" + acheived);
		String product = "";
		String target = "";
		String acheived_target = "";
		for (int j = 0; j < productName.size(); j++) {
			product = product + productName.get(j) + ",";
			target = target + Target.get(j) + ",";
		}
		for (int k = 0; k < acheived.size(); k++) {
			acheived_target = acheived_target + acheived.get(k) + ",";
		}
		if (product != "" && target != "" && acheived_target != "") {
			product = product.substring(0, product.length() - 1);
			target = target.substring(0, target.length() - 1);
			acheived_target = acheived_target.substring(0, acheived_target.length() - 1);
		}
		List<String> returnlist = new ArrayList<String>();
		returnlist.add(product);
		returnlist.add(target);
		returnlist.add(acheived_target);
		con.close();
		return returnlist;
	}

	public static List<String> RBMproductData(int eid) throws Exception {
		Connection con = C3P0DataSource.getInstance().getConnection();
		ResultSet rs = null;
		List<Integer> eids = new ArrayList<Integer>();
		List<String> productName = new ArrayList<String>();
		List<Integer> Target = new ArrayList<Integer>();
		List<Integer> acheived = new ArrayList<Integer>();
		rs = con.createStatement().executeQuery("select eid from employee where assignedauth='" + eid + "'");
		while (rs.next()) {
			ResultSet rs_eid = con.createStatement()
					.executeQuery("select eid from employee where assignedauth='" + rs.getInt("eid") + "'");
			while (rs_eid.next()) {
				eids.add(rs_eid.getInt("eid"));
			}
		}
		System.out.println(eids);
		for (int i = 0; i < eids.size(); i++) {
			String Q1 = "SELECT product.`pname`,targetproducts.`target` FROM targetproducts INNER JOIN product ON product.`pid`= targetproducts.`pid` INNER JOIN individualtarget ON individualtarget.`individualid`=targetproducts.`individualid` WHERE ('"
					+ now
					+ "' BETWEEN individualtarget.`datefrom` AND individualtarget.`dateto`) AND (individualtarget.`eid`='"
					+ eids.get(i) + "')";
			ResultSet rsProductData = con.createStatement().executeQuery(Q1);
			if (i == 0) {
				while (rsProductData.next()) {
					String pname = rsProductData.getString("pname");
					int target = rsProductData.getInt("target");
					productName.add(pname);
					Target.add(target);
					String acheivedtarget = "SELECT pname, quantity FROM placeorder INNER JOIN orders ON orders.`orderid`=placeorder.`orderid` WHERE (DATE(orders.ordertime) BETWEEN '"
							+ firstDate + "' AND '" + now + "') AND (orders.`eid`='" + eids.get(i)
							+ "') AND (placeorder.`pname` ='" + rsProductData.getString("pname") + "')";
					ResultSet rs_acheived = con.createStatement().executeQuery(acheivedtarget);
					while (rs_acheived.next()) {
						acheived.add(rs_acheived.getInt("quantity"));
					}
				}
			} else {
				while (rsProductData.next()) {
					String pname = rsProductData.getString("pname");
					int target = rsProductData.getInt("target");
					if (productName.contains(pname)) {
						int index = productName.indexOf(pname);
						int value = Target.get(index);
						value = value + target;
						Target.set(index, value);
						String acheivedtarget = "SELECT pname, quantity FROM placeorder INNER JOIN orders ON orders.`orderid`=placeorder.`orderid` WHERE (DATE(orders.ordertime) BETWEEN '"
								+ firstDate + "' AND '" + now + "') AND (orders.`eid`='" + eids.get(i)
								+ "') AND (placeorder.`pname` ='" + rsProductData.getString("pname") + "')";
						ResultSet rs_acheived = con.createStatement().executeQuery(acheivedtarget);
						while (rs_acheived.next()) {
							int acheived_value = acheived.get(index);
							acheived_value = acheived_value + rs_acheived.getInt("quantity");
							acheived.set(index, acheived_value);
						}
					} else {
						productName.add(pname);
						Target.add(target);
						String acheivedtarget = "SELECT pname, quantity FROM placeorder INNER JOIN orders ON orders.`orderid`=placeorder.`orderid` WHERE (DATE(orders.ordertime) BETWEEN '"
								+ firstDate + "' AND '" + now + "') AND (orders.`eid`='" + eids.get(i)
								+ "') AND (placeorder.`pname` ='" + rsProductData.getString("pname") + "')";
						ResultSet rs_acheived = con.createStatement().executeQuery(acheivedtarget);
						while (rs_acheived.next()) {
							acheived.add(rs_acheived.getInt("quantity"));
						}
					}
				}
			}
		}
		System.out.println("acheieved=" + acheived);
		String product = "";
		String target = "";
		String acheived_target = "";
		for (int j = 0; j < productName.size(); j++) {
			product = product + productName.get(j) + ",";
			target = target + Target.get(j) + ",";
		}
		for (int k = 0; k < acheived.size(); k++) {
			acheived_target = acheived_target + acheived.get(k) + ",";
		}
		if (product != "" && target != "" && acheived_target != "") {
			product = product.substring(0, product.length() - 1);
			target = target.substring(0, target.length() - 1);
			acheived_target = acheived_target.substring(0, acheived_target.length() - 1);
		}
		List<String> returnlist = new ArrayList<String>();
		returnlist.add(product);
		returnlist.add(target);
		returnlist.add(acheived_target);
		con.close();
		return returnlist;
	}

	public static List<String> BUProductData(int eid) throws Exception {
		Connection con = C3P0DataSource.getInstance().getConnection();
		List<Integer> eids = new ArrayList<Integer>();
		List<String> productName = new ArrayList<String>();
		List<Integer> Target = new ArrayList<Integer>();
		List<Integer> acheived = new ArrayList<Integer>();
		ResultSet rs = null;
		rs = con.createStatement().executeQuery("select eid from employee where assignedauth='" + eid + "'");
		while (rs.next()) {
			ResultSet rs_eid = con.createStatement()
					.executeQuery("select eid from employee where assignedauth='" + rs.getInt("eid") + "'");
			while (rs_eid.next()) {
				ResultSet rs_eid2 = con.createStatement()
						.executeQuery("select eid from employee where assignedauth='" + rs_eid.getInt("eid") + "'");
				eids.add(rs_eid.getInt("eid"));
			}
		}
		System.out.println(eids);
		for (int i = 0; i < eids.size(); i++) {
			String Q1 = "SELECT product.`pname`,targetproducts.`target` FROM targetproducts INNER JOIN product ON product.`pid`= targetproducts.`pid` INNER JOIN individualtarget ON individualtarget.`individualid`=targetproducts.`individualid` WHERE ('"
					+ now
					+ "' BETWEEN individualtarget.`datefrom` AND individualtarget.`dateto`) AND (individualtarget.`eid`='"
					+ eids.get(i) + "')";
			ResultSet rsProductData = con.createStatement().executeQuery(Q1);
			if (i == 0) {
				while (rsProductData.next()) {
					String pname = rsProductData.getString("pname");
					int target = rsProductData.getInt("target");
					productName.add(pname);
					Target.add(target);
					String acheivedtarget = "SELECT pname, quantity FROM placeorder INNER JOIN orders ON orders.`orderid`=placeorder.`orderid` WHERE (DATE(orders.ordertime) BETWEEN '"
							+ firstDate + "' AND '" + now + "') AND (orders.`eid`='" + eids.get(i)
							+ "') AND (placeorder.`pname` ='" + rsProductData.getString("pname") + "')";
					ResultSet rs_acheived = con.createStatement().executeQuery(acheivedtarget);
					while (rs_acheived.next()) {
						acheived.add(rs_acheived.getInt("quantity"));
					}
				}
			} else {
				while (rsProductData.next()) {
					String pname = rsProductData.getString("pname");
					int target = rsProductData.getInt("target");
					if (productName.contains(pname)) {
						int index = productName.indexOf(pname);
						int value = Target.get(index);
						value = value + target;
						Target.set(index, value);
						String acheivedtarget = "SELECT pname, quantity FROM placeorder INNER JOIN orders ON orders.`orderid`=placeorder.`orderid` WHERE (DATE(orders.ordertime) BETWEEN '"
								+ firstDate + "' AND '" + now + "') AND (orders.`eid`='" + eids.get(i)
								+ "') AND (placeorder.`pname` ='" + rsProductData.getString("pname") + "')";
						ResultSet rs_acheived = con.createStatement().executeQuery(acheivedtarget);
						while (rs_acheived.next()) {
							int acheived_value = acheived.get(index);
							acheived_value = acheived_value + rs_acheived.getInt("quantity");
							acheived.set(index, acheived_value);
						}
					} else {
						productName.add(pname);
						Target.add(target);
						String acheivedtarget = "SELECT pname, quantity FROM placeorder INNER JOIN orders ON orders.`orderid`=placeorder.`orderid` WHERE (DATE(orders.ordertime) BETWEEN '"
								+ firstDate + "' AND '" + now + "') AND (orders.`eid`='" + eids.get(i)
								+ "') AND (placeorder.`pname` ='" + rsProductData.getString("pname") + "')";
						ResultSet rs_acheived = con.createStatement().executeQuery(acheivedtarget);
						while (rs_acheived.next()) {
							acheived.add(rs_acheived.getInt("quantity"));
						}
					}
				}
			}
		}
		System.out.println("acheieved=" + acheived);
		String product = "";
		String target = "";
		String acheived_target = "";
		for (int j = 0; j < productName.size(); j++) {
			product = product + productName.get(j) + ",";
			target = target + Target.get(j) + ",";
		}
		for (int k = 0; k < acheived.size(); k++) {
			acheived_target = acheived_target + acheived.get(k) + ",";
		}
		if (product != "" && target != "" && acheived_target != "") {
			product = product.substring(0, product.length() - 1);
			target = target.substring(0, target.length() - 1);
			acheived_target = acheived_target.substring(0, acheived_target.length() - 1);
		}
		List<String> returnlist = new ArrayList<String>();
		returnlist.add(product);
		returnlist.add(target);
		returnlist.add(acheived_target);
		con.close();
		return returnlist;
	}
}
