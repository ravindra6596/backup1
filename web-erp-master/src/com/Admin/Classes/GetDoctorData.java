package com.Admin.Classes;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.model.C3P0DataSource;

public class GetDoctorData {
	public static ResultSet doctor_data(int did) throws SQLException {
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement st = con.createStatement();
		ResultSet rs = null;
		String sql_query = "SELECT *,DATE_FORMAT(dob, '%d-%m-%Y') as dobF, DATE_FORMAT(doa, '%d-%m-%Y') as doaF FROM doctors where doctors.doctorid = '"
				+ did + "'";
		rs = st.executeQuery(sql_query);
		System.out.println(sql_query);
		con.close();
		return rs;
	}
}
