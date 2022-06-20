package com.exporter.classes;

import java.sql.Connection;
import java.sql.ResultSet;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.model.C3P0DataSource;

public class AllProductsExport {
	public static HSSFWorkbook Export_product(String query) throws Exception {
		Connection connect = C3P0DataSource.getInstance().getConnection();
		ResultSet rs_exp = connect.createStatement().executeQuery(query);

		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet spreadsheet = workbook.createSheet("report db");

		HSSFRow row = spreadsheet.createRow(1);
		HSSFCell cell;
		cell = row.createCell(1);
		cell.setCellValue("Product Id");
		cell = row.createCell(2);
		cell.setCellValue("Product Name");
		cell = row.createCell(3);
		cell.setCellValue("Product Type");
		cell = row.createCell(4);
		cell.setCellValue("Specification");
		cell = row.createCell(5);
		cell.setCellValue("Packaging");
		cell = row.createCell(6);
		cell.setCellValue("MRP");
		cell = row.createCell(7);
		cell.setCellValue("PTR");
		cell = row.createCell(8);
		cell.setCellValue("PTS");
		cell = row.createCell(9);
		cell.setCellValue("GST");
		cell = row.createCell(10);
		cell.setCellValue("Scheme");
		cell = row.createCell(11);
		cell.setCellValue("Product Group");
		cell = row.createCell(12);
		cell.setCellValue("Detailing Story");
		cell = row.createCell(13);
		cell.setCellValue("Composition");

		int i = 2;

		while (rs_exp.next()) {

			row = spreadsheet.createRow(i);
			cell = row.createCell(1);
			cell.setCellValue(rs_exp.getInt("pid"));
			cell = row.createCell(2);
			cell.setCellValue(rs_exp.getString("pname"));
			cell = row.createCell(3);
			cell.setCellValue(rs_exp.getString("ptype"));
			cell = row.createCell(4);
			cell.setCellValue(rs_exp.getString("specification"));
			cell = row.createCell(5);
			cell.setCellValue(rs_exp.getString("packaging"));
			cell = row.createCell(6);
			cell.setCellValue(rs_exp.getFloat("mrp"));
			cell = row.createCell(7);
			cell.setCellValue(rs_exp.getString("ptr"));
			cell = row.createCell(8);
			cell.setCellValue(rs_exp.getString("pts"));
			cell = row.createCell(9);
			cell.setCellValue(rs_exp.getFloat("gst"));
			cell = row.createCell(10);
			cell.setCellValue(rs_exp.getString("scheme"));
			cell = row.createCell(11);
			cell.setCellValue(rs_exp.getString("pgroup"));
			cell = row.createCell(12);
			cell.setCellValue(rs_exp.getString("detailingstory"));
			cell = row.createCell(13);
			cell.setCellValue(rs_exp.getString("composition"));

			i++;
		}
		connect.close();
		return workbook;
	}
}
