package com.Employee.Objects;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.model.C3P0DataSource;

public class GetData {


	public static ResultSet Products() throws SQLException {
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement state = con.createStatement();
		ResultSet products = state.executeQuery("SELECT * FROM product");
		con.close();
		return products;
	}

	public static String pname(int pid) throws SQLException {
		System.out.println("getdata pid " + pid);
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement state = con.createStatement();
		ResultSet rs = state.executeQuery("select pname from product where pid = '" + pid + "'");
		String pname = null;
		while (rs.next()) {
			pname = rs.getString("pname");
		}
		con.close();
		return pname;
	}

	public static String emp_name(int eid) throws SQLException {
		String emp_name = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement state = con.createStatement();
		ResultSet rs = state.executeQuery("select name from employee where eid='" + eid + "'");
		if (rs.next()) {
			emp_name = rs.getString("name");
		}
		con.close();
		return emp_name;
	}

	public static ResultSet Tms(int eid, String usertype) throws SQLException {
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement state = con.createStatement();
		ResultSet rs = null;
		if (usertype.equalsIgnoreCase("tm")) {
			String query = "SELECT eid, name FROM employee where usertype = 'tm'";
			rs = state.executeQuery(query);
		}
		con.close();
		return rs;
	}

	public static ResultSet Doctors() throws SQLException {
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement state = con.createStatement();
		ResultSet doctors = state.executeQuery("SELECT * FROM doctors");
		con.close();
		return doctors;
	}

	public static String detail_doctor_data(String id, String req) {
		String sql = "select * from doctors where " + req + " ='" + id + "'";

		return null;
	}

	public static ResultSet samples(int eid) throws SQLException {
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement state = con.createStatement();
		String query = "SELECT `sample_products`.`pid`, `sample_products`.`sample_quantity`, product.`pname` FROM samples INNER JOIN sample_products ON sample_products.`sampleid` = samples.`sampleid` INNER JOIN product ON product.`pid`= `sample_products`.`pid` WHERE samples.`eid`='"
				+ eid + "'";
		ResultSet rs = state.executeQuery(query);
		con.close();
		return rs;
	}

	public static ResultSet Area() throws SQLException {
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement state = con.createStatement();
		String query = "SELECT haid, headquarter from headquarters";
		ResultSet rs = state.executeQuery(query);
		con.close();
		return rs;
	}

	public static String district_name(int daid) throws SQLException {
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement state = con.createStatement();
		ResultSet rs = state.executeQuery("select district from districts where daid = '" + daid + "'");
		String areaname = null;
		if (rs.next()) {
			areaname = rs.getString("district");
		}
		con.close();
		return areaname;
	}

	public static String area_name(int haid) throws SQLException {
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement state = con.createStatement();
		ResultSet rs = state.executeQuery("select headquarter from headquarters where haid = '" + haid + "'");
		String areaname = null;
		if (rs.next()) {
			areaname = rs.getString("headquarter");
		}
		con.close();
		return areaname;
	}

	public static ResultSet Admin_Emp() throws SQLException {
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement state = con.createStatement();
		String query = "SELECT eid, name FROM employee where usertype = 'tm'";
		ResultSet rs = state.executeQuery(query);
		con.close();
		return rs;
	}

	public static ResultSet Stockiest() throws Exception {
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement state = con.createStatement();
		String sql = "Select sid, name from stockiest";
		ResultSet rs = state.executeQuery(sql);
		con.close();
		return rs;
	}

	public static int count(String data) throws SQLException {
		String sql = "SELECT COUNT(*) AS COUNT FROM " + data;
		Connection con = C3P0DataSource.getInstance().getConnection();
		ResultSet rs = con.createStatement().executeQuery(sql);
		int count = 0;
		if (rs.next()) {
			count = rs.getInt("count");
		}
		con.close();
		return count;
	}

	public static ResultSet Areafiltered_doc(int eid) throws SQLException {
		String sql1 = "select aid from employee where eid='" + eid + "'";
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement state = con.createStatement();
		ResultSet rsAid = state.executeQuery(sql1);
		int aid = 0;
		if (rsAid.next()) {
			aid = rsAid.getInt("aid");
		}
		String sql2 = "select * from doctors where aid = '" + aid + "'";
		ResultSet rs = state.executeQuery(sql2);
		con.close();
		return rs;
	}

	public static ResultSet PurchaseOrders(int eid) throws SQLException {
		String sql = "select * from orders inner join employee on employee.eid = orders.eid where orders.eid='" + eid
				+ "'";
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement state = con.createStatement();
		ResultSet rs = state.executeQuery(sql);
		con.close();
		return rs;
	}

	public static ResultSet Headquarter() throws SQLException {
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement state = con.createStatement();
		ResultSet rs = state.executeQuery("select * from headquarter");
		con.close();
		return rs;
	}

	public static ResultSet get_expenses(int eid) throws SQLException {
		ResultSet rs = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement st = con.createStatement();
		rs = st.executeQuery(
				"select * from other_expenses inner join employee on employee.eid = other_expenses.eid where other_expenses.eid ='"
						+ eid + "' order by mail_status");
		con.close();
		return rs;
	}

	public static ResultSet TourPlans_currentMonth(int id) throws SQLException {
		ResultSet rs = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		String GetTourPlan = "SELECT tourplan.`date`,tourplan.tourid ,tourplan.`time`,district.`areaname`,tourplan.status ,doctors.grade , doctors.`name` AS doctorname, employee.`name` AS empname, `doctors`.`mobile` FROM tourplan INNER JOIN doctors ON doctors.`doctorid`= tourplan.doctorid INNER JOIN employee ON employee.`eid`= tourplan.`eid` INNER JOIN district ON district.`aid`=tourplan.`aid` WHERE MONTH(tourplan.date) = MONTH(CURRENT_DATE()) AND YEAR(tourplan.date) = YEAR(CURRENT_DATE()) AND tourplan.eid ='"
				+ id + "' order by status asc";
		rs = con.createStatement().executeQuery(GetTourPlan);
		con.close();
		return rs;
	}

	public static ResultSet TourPlan_all(int id) throws SQLException {
		ResultSet rs = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement st = con.createStatement();
		String get_all_tours = "SELECT tourplan.`date`,tourplan.tourid ,tourplan.`time`,district.`areaname`,tourplan.status ,doctors.grade , doctors.`name` AS doctorname, employee.`name` AS empname, `doctors`.`mobile` FROM tourplan INNER JOIN doctors ON doctors.`doctorid`= tourplan.doctorid INNER JOIN employee ON employee.`eid`= tourplan.`eid` INNER JOIN district ON district.`aid`=tourplan.`aid` WHERE tourplan.eid ='"
				+ id + "'";
		rs = st.executeQuery(get_all_tours);
		con.close();
		return rs;
	}

	public static ResultSet AllEmployees() throws SQLException {
		ResultSet rs = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement st = con.createStatement();
		rs = st.executeQuery("select * from employee");
		con.close();
		return rs;
	}

	public static ResultSet TourplanDr(int eid) throws SQLException {
		ResultSet rs = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement st = con.createStatement();
		rs = st.executeQuery("select * from tourplan where eid= '" + eid + "' ");
		con.close();
		return rs;
	}
}
