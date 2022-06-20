package com.exporter.classes;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.model.C3P0DataSource;

public class AllDoctorExport {
	public static HSSFWorkbook Export_doctor(String query) throws SQLException, Exception {
		Connection connect = C3P0DataSource.getInstance().getConnection();
		ResultSet rs_exp = connect.createStatement().executeQuery(query);

		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet spreadsheet = workbook.createSheet("report db");

		HSSFRow row = spreadsheet.createRow(1);
		HSSFCell cell;
		cell = row.createCell(1);
		cell.setCellValue("Doctorid");
		cell = row.createCell(2);
		cell.setCellValue("Name");
		cell = row.createCell(3);
		cell.setCellValue("Gender");
		cell = row.createCell(4);
		cell.setCellValue("DoB");
		cell = row.createCell(5);
		cell.setCellValue("DoA");
		cell = row.createCell(6);
		cell.setCellValue("Area");
		cell = row.createCell(7);
		cell.setCellValue("Address");
		cell = row.createCell(8);
		cell.setCellValue("Clinic Phone");
		cell = row.createCell(9);
		cell.setCellValue("Mobile No.");
		cell = row.createCell(10);
		cell.setCellValue("Degree");
		cell = row.createCell(11);
		cell.setCellValue("Speciallity");
		cell = row.createCell(12);
		cell.setCellValue("clinic time morning from");
		cell = row.createCell(13);
		cell.setCellValue("clinic time morning to");
		cell = row.createCell(14);
		cell.setCellValue("clinic time evening from");
		cell = row.createCell(15);
		cell.setCellValue("clinic time evening from");
		cell = row.createCell(16);
		cell.setCellValue("grade");
		cell = row.createCell(17);
		cell.setCellValue("Status");

		int i = 2;

		while (rs_exp.next()) {
			ResultSet area_rs = connect.createStatement()
					.executeQuery("select areaname from area where aid ='" + rs_exp.getInt("aid") + "'");
			String areaname = null;
			if (area_rs.next()) {
				areaname = area_rs.getString("areaname");
			}

			row = spreadsheet.createRow(i);
			cell = row.createCell(1);
			cell.setCellValue(rs_exp.getInt("doctorid"));
			cell = row.createCell(2);
			cell.setCellValue(rs_exp.getString("name"));
			cell = row.createCell(3);
			cell.setCellValue(rs_exp.getString("gender"));
			cell = row.createCell(4);
			cell.setCellValue(rs_exp.getString("dob"));
			cell = row.createCell(5);
			cell.setCellValue(rs_exp.getString("doa"));
			cell = row.createCell(6);
			cell.setCellValue(areaname);
			cell = row.createCell(7);
			cell.setCellValue(rs_exp.getString("address"));
			cell = row.createCell(8);
			cell.setCellValue(rs_exp.getDouble("clinicphone"));
			cell = row.createCell(9);
			cell.setCellValue(rs_exp.getDouble("mobile"));
			cell = row.createCell(10);
			cell.setCellValue(rs_exp.getString("degree"));
			cell = row.createCell(11);
			cell.setCellValue(rs_exp.getString("speciality"));
			cell = row.createCell(12);
			cell.setCellValue(rs_exp.getString("mortimefrom"));
			cell = row.createCell(13);
			cell.setCellValue(rs_exp.getString("mortimeto"));
			cell = row.createCell(14);
			cell.setCellValue(rs_exp.getString("evetimefrom"));
			cell = row.createCell(15);
			cell.setCellValue(rs_exp.getString("evetimeto"));
			cell = row.createCell(16);
			cell.setCellValue(rs_exp.getString("grade"));
			cell = row.createCell(17);
			cell.setCellValue(rs_exp.getString("activepassive"));

			i++;
		}
		connect.close();

		return workbook;
	}
}
