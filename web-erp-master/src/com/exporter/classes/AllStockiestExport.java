package com.exporter.classes;

import java.sql.Connection;
import java.sql.ResultSet;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.model.C3P0DataSource;

public class AllStockiestExport {
	public static HSSFWorkbook Export_stockiest(String query) throws Exception {
		Connection connect = C3P0DataSource.getInstance().getConnection();
		ResultSet rs_exp = connect.createStatement().executeQuery(query);

		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet spreadsheet = workbook.createSheet("report db");

		HSSFRow row = spreadsheet.createRow(1);
		HSSFCell cell;
		cell = row.createCell(1);
		cell.setCellValue("Stockiest Id");
		cell = row.createCell(2);
		cell.setCellValue("Stockiest Name");
		cell = row.createCell(3);
		cell.setCellValue("Address");
		cell = row.createCell(4);
		cell.setCellValue("shoptelephone");
		cell = row.createCell(5);
		cell.setCellValue("Mobile");
		cell = row.createCell(6);
		cell.setCellValue("Email");
		cell = row.createCell(7);
		cell.setCellValue("shopactlicense");
		cell = row.createCell(8);
		cell.setCellValue("druglicense");
		cell = row.createCell(9);
		cell.setCellValue("druglicensevalidity");
		cell = row.createCell(10);
		cell.setCellValue("gst");
		cell = row.createCell(11);
		cell.setCellValue("headquarter");
		cell = row.createCell(12);
		cell.setCellValue("firmconstitution");
		cell = row.createCell(13);
		cell.setCellValue("foodlicense");

		int i = 2;

		while (rs_exp.next()) {

			row = spreadsheet.createRow(i);
			cell = row.createCell(1);
			cell.setCellValue(rs_exp.getInt("sid"));
			cell = row.createCell(2);
			cell.setCellValue(rs_exp.getString("name"));
			cell = row.createCell(3);
			cell.setCellValue(rs_exp.getString("address"));
			cell = row.createCell(4);
			cell.setCellValue(rs_exp.getString("shoptelephone"));
			cell = row.createCell(5);
			cell.setCellValue(rs_exp.getDouble("mobile"));
			cell = row.createCell(6);
			cell.setCellValue(rs_exp.getString("email"));
			cell = row.createCell(7);
			cell.setCellValue(rs_exp.getString("shopactlicense"));
			cell = row.createCell(8);
			cell.setCellValue(rs_exp.getString("druglicense"));
			cell = row.createCell(9);
			cell.setCellValue(rs_exp.getString("druglicensevalidity"));
			cell = row.createCell(10);
			cell.setCellValue(rs_exp.getString("gst"));
			cell = row.createCell(11);
			cell.setCellValue(rs_exp.getString("headquarter"));
			cell = row.createCell(12);
			cell.setCellValue(rs_exp.getString("firmconstitution"));
			cell = row.createCell(13);
			cell.setCellValue(rs_exp.getString("foodlicense"));

			i++;
		}
		connect.close();
		return workbook;
	}
}
