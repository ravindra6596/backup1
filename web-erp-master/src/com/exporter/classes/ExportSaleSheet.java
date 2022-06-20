package com.exporter.classes;

import java.io.File;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;

import com.model.C3P0DataSource;

public class ExportSaleSheet {

	public static int export_sale(int eid, int aid) throws Exception {
		Connection con = C3P0DataSource.getInstance().getConnection();
		ResultSet subarea = con.createStatement().executeQuery(
				"select said, subareaname,area.areaname from subarea inner join area on area.aid = subarea.aid where area.aid='"
						+ aid + "'");
		List<String> subareaname = new ArrayList<String>();

		String areaname = null;
		while (subarea.next()) {
			subareaname.add(subarea.getString("subareaname"));
			areaname = subarea.getString("areaname");
		}

		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet spreadsheet = workbook.createSheet("report db");

		HSSFFont headerFont = workbook.createFont();
		headerFont.setBoldweight((short) HSSFFont.BOLDWEIGHT_BOLD);
		headerFont.setFontHeightInPoints((short) 10);
		headerFont.setColor(IndexedColors.BLACK.getIndex());

		// Create a CellStyle with the font
		CellStyle headerCellStyle = workbook.createCellStyle();
		headerCellStyle.setFillBackgroundColor(HSSFColor.BLUE.index);
		headerCellStyle.setFont(headerFont);
		spreadsheet.autoSizeColumn(1000000);
		headerCellStyle.setAlignment(CellStyle.ALIGN_CENTER);

		CellStyle allign = workbook.createCellStyle();
		allign.setAlignment(CellStyle.ALIGN_CENTER);
		/*
		 * CellStyle borders = workbook.createCellStyle();
		 * borders.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		 * borders.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		 * borders.setBorderRight(HSSFCellStyle.BORDER_THIN);
		 * borders.setBorderTop(HSSFCellStyle.BORDER_THIN);
		 */

		ResultSet rsProducts = con.createStatement().executeQuery("select pname from product");
		HSSFRow row = spreadsheet.createRow(1);
		HSSFCell cell;

		cell = row.createCell(1);
		cell.setCellValue("SR NO");
		cell.setCellStyle(headerCellStyle);
		// cell.setCellStyle(borders);
		cell = row.createCell(2);
		cell.setCellValue("DOCTOR");
		cell.setCellStyle(headerCellStyle);
		// cell.setCellStyle(borders);
		cell = row.createCell(3);
		cell.setCellValue("DEGREE");
		cell.setCellStyle(headerCellStyle);
		// cell.setCellStyle(borders);
		int colCount = 4;
		while (rsProducts.next()) {
			cell = row.createCell(colCount);
			cell.setCellValue(rsProducts.getString("pname"));
			cell.setCellStyle(headerCellStyle);
			// cell.setCellStyle(borders);
			colCount++;
		}

		int i = 2;
		int srno = 1;
		ResultSet rsDoctor = con.createStatement()
				.executeQuery("select name, degree from doctors where aid='" + aid + "'");
		while (rsDoctor.next()) {
			row = spreadsheet.createRow(i);
			cell = row.createCell(1);
			cell.setCellValue(srno);
			cell.setCellStyle(allign);
			cell = row.createCell(2);
			cell.setCellValue(rsDoctor.getString("name"));
			cell.setCellStyle(allign);
			cell = row.createCell(3);
			cell.setCellValue(rsDoctor.getString("degree"));
			cell.setCellStyle(allign);
			i++;
			srno++;
		}
		FileOutputStream out = new FileOutputStream(new File("G:\\SaleReport" + Math.random() + ".xls"));
		workbook.write(out);
		out.close();
		System.out.println("exceldatabase.xlsx written successfully");
		con.close();
		return 0;
	}
}
