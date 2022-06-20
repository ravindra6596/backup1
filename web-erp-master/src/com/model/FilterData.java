package com.model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

public class FilterData {
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static ResultSet filter(Map map, String query1) throws SQLException {

		String whr = "(";
		String cquery = null;

		Set s = map.entrySet();
		Iterator it = s.iterator();
		while (it.hasNext()) {
			Map.Entry<String, String[]> entry = (Map.Entry<String, String[]>) it.next();
			String key = entry.getKey();
			String[] value = entry.getValue();

			if (value[0] != "") {
				if (key.equals("date")) {
					String date = daterange(value);
					whr = whr + date + " OR ";
				} else {

					if (value.length > 1) {
						for (int i = 0; i < value.length; i++) {
							whr = whr + "" + key + "='" + value[i] + "' OR ";
						}
					} else {
						whr = whr + key + "='" + value[0] + "' OR ";
					}

				}
				whr = whr.substring(0, whr.length() - 4) + ") AND (";
			} else {

			}
		}
		query1 = query1 + whr.substring(0, whr.length() - 28);
		System.out.println(query1);
		cquery = query1;
		Connection con = C3P0DataSource.getInstance().getConnection();
		ResultSet rs = con.createStatement().executeQuery(query1);
		return rs;
	}

	public static String daterange(String[] value) {
		String str = Arrays.toString(value);
		str = str.replace("[", "").replace("]", "");
		String[] dates = str.split(" - ");
		String date1 = dates[0];
		String date2 = dates[1];

		String date = "DATE BETWEEN '" + date1 + "' AND '" + date2 + "'";
		return date;
	}
}
