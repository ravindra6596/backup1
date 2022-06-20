package com.Admin.Classes;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.model.C3P0DataSource;

public class Expenses {
	static Connection con = null;
	static {
		con = C3P0DataSource.getInstance().getConnection();
	}

	public static ResultSet Expense_area(int eid, String date) throws SQLException {
		date = date.replace("-", "");
		Statement state1 = con.createStatement();
		String query = "SELECT aid , tourplan.date FROM tourplan WHERE (eid='" + eid
				+ "') AND (EXTRACT(YEAR_MONTH FROM tourplan.date)='" + date + "')";
		ResultSet rsarea = state1.executeQuery(query);
		System.out.println(query);
		con.close();
		return rsarea;
	}

	public static ResultSet Getallowance(int aid) throws SQLException {
		ResultSet rsallow = con.createStatement()
				.executeQuery("SELECT hq,exhq,tour FROM expenses WHERE aid='" + aid + "'");
		con.close();
		return rsallow;
	}

	public static ResultSet ExpenseTotal(int aid) throws SQLException {
		Statement state = con.createStatement();
		ResultSet rstotal = state.executeQuery("Select (hq+exhq+tour) as total from expenses where aid='" + aid + "'");
		con.close();
		return rstotal;
	}

	public static float telephone() throws SQLException {
		Statement state = con.createStatement();
		ResultSet rs_tele = state.executeQuery("Select value from fixed_expenses where fixed_category ='telephone'");
		float telebill = 0;
		while (rs_tele.next()) {
			telebill = rs_tele.getFloat("value");
		}
		con.close();
		return telebill;
	}
}
