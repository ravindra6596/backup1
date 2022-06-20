package com.controller.object;

import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.json.JSONArray;
import org.json.JSONObject;

public class GetDataBrandTrend {

	public static HSSFWorkbook getData(JSONObject json, Map<String, int[][]> listMap) throws Exception {

		int procount = 0;
		JSONArray plist = json.getJSONArray("plist");
		JSONArray month = json.getJSONArray("months");
		int[][] list = (int[][]) listMap.get("list");
		;
		procount = json.getInt("procount");

		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet spreadsheet = workbook.createSheet("report db");

		HSSFRow row = spreadsheet.createRow(1);
		HSSFCell cell;
		cell = row.createCell(1);
		cell.setCellValue("Products");
		for (int j = 0; j < month.length(); j++) {
			cell = row.createCell(j + 2);
			cell.setCellValue(month.getString(j));
		}
		int row_no = 2;
		for (int i = 0; i < procount; i++) {
			row = spreadsheet.createRow(row_no);
			cell = row.createCell(i + 1);
			cell.setCellValue(plist.getString(i));
			for (int j = 0; j < month.length(); j++) {
				cell = row.createCell(j + 2);
				cell.setCellValue(list[i][j]);
			}
			row_no++;
		}
		return workbook;
	}
}
