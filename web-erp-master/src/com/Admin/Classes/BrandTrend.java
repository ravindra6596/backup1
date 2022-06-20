package com.Admin.Classes;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.model.C3P0DataSource;

public class BrandTrend {

	static Connection con = null;
	static {
		con = C3P0DataSource.getInstance().getConnection();
	}

	public static JSONObject GetBrandTrend(String[] months, int year) throws SQLException, JSONException {
		ArrayList<String> plist = new ArrayList<String>();
		ArrayList<String> month = new ArrayList<String>();
		JSONArray plist_json = new JSONArray();
		JSONArray month_json = new JSONArray();
		int procount = 0;
		String whrMonth = "";
		for (int i = 0; i < months.length; i++) {
			month.add(months[i]);
			month_json.put(months[i]);
			whrMonth = whrMonth + "MONTHNAME(orderdate) ='" + months[i] + "' OR ";
		}
		ResultSet rscount = con.createStatement().executeQuery("SELECT COUNT(*) FROM product");
		while (rscount.next()) {
			procount = rscount.getInt(1);
		}
		int[][] list = new int[procount][month.size()];
		ResultSet rspro = con.createStatement().executeQuery("select pid, pname from product");
		while (rspro.next()) {
			plist.add(rspro.getString("pname"));
			plist_json.put(rspro.getString("pname"));
		}
		String get_productMonth = "SELECT pname, quantity, MONTHNAME(orders.orderdate) AS MONTH FROM order_products INNER JOIN orders ON orders.`orderid`=order_products.`orderid` INNER JOIN product ON product.pid = order_products.pid WHERE ";
		get_productMonth = get_productMonth + "(" + whrMonth.substring(0, whrMonth.length() - 3)
				+ ") AND (YEAR(orderdate)='" + year + "')";
		ResultSet rsFinal = con.createStatement().executeQuery(get_productMonth);
		while (rsFinal.next()) {
			int monindex = month.indexOf(rsFinal.getString("month"));
			int proindex = plist.indexOf(rsFinal.getString("pname"));
			if (monindex != -1 && proindex != -1) {
				list[proindex][monindex] = rsFinal.getInt("quantity");
			}
		}
		JSONObject json = new JSONObject();
		json.put("plist", plist_json);
		json.put("months", month_json);
		json.put("procount", procount);
		json.put("list", list);
		con.close();
		return json;
	}
}
