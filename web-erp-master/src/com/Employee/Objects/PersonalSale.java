package com.Employee.Objects;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.model.C3P0DataSource;

public class PersonalSale {

	public static List<String> TmSale(int id) throws SQLException {
		Connection con = C3P0DataSource.getInstance().getConnection();
		LocalDate today = LocalDate.now();
		String totalSale = "";
		String year_month = "";
		for (int i = 0; i < 12; i++) {
			LocalDate earlierMonth = today.minusMonths(i);
			int month = earlierMonth.getMonthValue();
			int year = earlierMonth.getYear();
			year_month = year_month + earlierMonth.getMonth() + "-" + year + ",";
			String Query = "SELECT * FROM orders WHERE eid='" + id + "' AND MONTH(ordertime) ='" + month
					+ "' AND YEAR(ordertime) = '" + year + "'";
			ResultSet rs = con.createStatement().executeQuery(Query);
			System.out.println(Query);
			if (rs.next()) {
				totalSale = totalSale + rs.getDouble("totalAmt") + ",";
			} else {
				totalSale = totalSale + "0" + ",";
			}
		}
		totalSale = totalSale.substring(0, totalSale.length() - 1);
		year_month = year_month.substring(0, year_month.length() - 1);
		List<String> returnList = new ArrayList<String>();
		returnList.add(year_month);
		returnList.add(totalSale);
		con.close();
		return returnList;
	}

	public static List<String> ABMTeamSale(int id) throws Exception {
		Connection con = C3P0DataSource.getInstance().getConnection();
		LocalDate today = LocalDate.now();
		String totalSale = "";
		String year_month = "";
		String getTM = "select eid from employee where assignedauth ='" + id + "'";
		for (int i = 0; i < 12; i++) {
			LocalDate earlierMonth = today.minusMonths(i);
			int month = earlierMonth.getMonthValue();
			int year = earlierMonth.getYear();
			year_month = year_month + earlierMonth.getMonth() + "-" + year + ",";
			double totalamt = 0;
			ResultSet rs = con.createStatement().executeQuery(getTM);
			while (rs.next()) {
				String Query = "SELECT * FROM orders WHERE eid='" + rs.getInt("eid") + "' AND MONTH(ordertime) ='"
						+ month + "' AND YEAR(ordertime) = '" + year + "'";
				ResultSet rs_data = con.createStatement().executeQuery(Query);
				System.out.println("Query 2" + Query);
				if (rs_data.next()) {
					totalamt = totalamt + rs_data.getDouble("totalAmt");
				} else {
					totalamt = totalamt + 0;
				}
			}
			totalSale = totalSale + totalamt + ",";
		}
		System.out.println(totalSale);
		if (totalSale != "" && year_month != "") {
			totalSale = totalSale.substring(0, totalSale.length() - 1);
			year_month = year_month.substring(0, year_month.length() - 1);
		}
		List<String> returnList = new ArrayList<String>();
		returnList.add(year_month);
		returnList.add(totalSale);
		con.close();
		return returnList;
	}

	public static List<String> RBMTeamSale(int id) throws Exception {
		Connection con = C3P0DataSource.getInstance().getConnection();
		LocalDate today = LocalDate.now();
		String totalSale = "";
		String year_month = "";
		String getTM = "select eid from employee where assignedauth ='" + id + "'";
		for (int i = 0; i < 12; i++) {
			LocalDate earlierMonth = today.minusMonths(i);
			int month = earlierMonth.getMonthValue();
			int year = earlierMonth.getYear();
			year_month = year_month + earlierMonth.getMonth() + "-" + year + ",";
			double totalamt = 0;
			ResultSet rsAbm = con.createStatement().executeQuery(getTM);
			while (rsAbm.next()) {
				double TmSale = 0;
				ResultSet rs = con.createStatement()
						.executeQuery("select eid from employee where assignedauth ='" + rsAbm.getInt("eid") + "'");
				while (rs.next()) {
					String Query = "SELECT * FROM orders WHERE eid='" + rs.getInt("eid") + "' AND MONTH(ordertime) ='"
							+ month + "' AND YEAR(ordertime) = '" + year + "'";
					ResultSet rs_data = con.createStatement().executeQuery(Query);
					System.out.println("Query 3" + Query);
					if (rs_data.next()) {
						TmSale = TmSale + rs_data.getDouble("totalAmt");
					} else {
						TmSale = TmSale + 0;
					}
				}
				totalamt = totalamt + TmSale;
			}
			totalSale = totalSale + totalamt + ",";
		}
		System.out.println(totalSale);
		if (totalSale != "" && year_month != "") {
			totalSale = totalSale.substring(0, totalSale.length() - 1);
			year_month = year_month.substring(0, year_month.length() - 1);
		}
		List<String> returnList = new ArrayList<String>();
		returnList.add(year_month);
		returnList.add(totalSale);
		con.close();
		return returnList;
	}

	public static List<String> BUTeamSale(int id) throws Exception {

		Connection con = C3P0DataSource.getInstance().getConnection();
		LocalDate today = LocalDate.now();
		String totalSale = "";
		String year_month = "";
		String getRBM = "select eid from employee where assignedauth ='" + id + "'";
		for (int i = 0; i < 12; i++) {
			LocalDate earlierMonth = today.minusMonths(i);
			int month = earlierMonth.getMonthValue();
			int year = earlierMonth.getYear();
			year_month = year_month + earlierMonth.getMonth() + "-" + year + ",";
			double totalamt = 0;
			ResultSet rsRbm = con.createStatement().executeQuery(getRBM);
			while (rsRbm.next()) {
				double Abmsale = 0;
				ResultSet rsAbm = con.createStatement()
						.executeQuery("select eid from employee where assignedauth ='" + rsRbm.getInt("eid") + "'");
				while (rsAbm.next()) {
					double TmSale = 0;
					ResultSet rs = con.createStatement()
							.executeQuery("select eid from employee where assignedauth ='" + rsAbm.getInt("eid") + "'");
					while (rs.next()) {
						String Query = "SELECT * FROM orders WHERE eid='" + rs.getInt("eid")
								+ "' AND MONTH(ordertime) ='" + month + "' AND YEAR(ordertime) = '" + year + "'";
						ResultSet rs_data = con.createStatement().executeQuery(Query);
						System.out.println("Query 4" + Query);
						if (rs_data.next()) {
							TmSale = TmSale + rs_data.getDouble("totalAmt");
						} else {
							TmSale = TmSale + 0;
						}
					}
					Abmsale = Abmsale + TmSale;
				}
				totalamt = totalamt + Abmsale;
			}
			totalSale = totalSale + totalamt + ",";
		}
		System.out.println(totalSale);
		if (totalSale != "" && year_month != "") {
			totalSale = totalSale.substring(0, totalSale.length() - 1);
			year_month = year_month.substring(0, year_month.length() - 1);
		}
		List<String> returnList = new ArrayList<String>();
		returnList.add(year_month);
		returnList.add(totalSale);
		con.close();
		return returnList;
	}

}
