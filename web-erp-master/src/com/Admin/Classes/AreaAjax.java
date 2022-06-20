package com.Admin.Classes;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import org.json.JSONObject;

import com.model.C3P0DataSource;

public class AreaAjax {

	public static JSONObject area(String hq) throws Exception {
		System.out.println("inside class=" + hq);
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement state = con.createStatement();

		int hid = Integer.parseInt(hq);
		String sql = "select * from district where hid = '" + hid + "'";
		ResultSet rs = state.executeQuery(sql);
		ArrayList<String> areaname = new ArrayList<>();
		ArrayList<Integer> aid = new ArrayList<>();

		while (rs.next()) {
			areaname.add(rs.getString("areaname"));
			aid.add(rs.getInt("aid"));
		}

		JSONObject json_area = new JSONObject();
		json_area.put("areaname", areaname);
		json_area.put("aid", aid);
		con.close();
		return json_area;
	}
}
