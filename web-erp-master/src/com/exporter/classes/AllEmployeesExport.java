package com.exporter.classes;

import java.sql.Connection;
import java.sql.ResultSet;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.model.C3P0DataSource;

public class AllEmployeesExport {
	public static HSSFWorkbook ExportEmp(String query) throws Exception {

		Connection connect = C3P0DataSource.getInstance().getConnection();
		ResultSet rs_exp = connect.createStatement().executeQuery(query);

		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet spreadsheet = workbook.createSheet("report db");

		HSSFRow row = spreadsheet.createRow(1);
		HSSFCell cell;
		cell = row.createCell(1);
		cell.setCellValue("Employee Id");
		cell = row.createCell(2);
		cell.setCellValue("Employee Name");
		cell = row.createCell(3);
		cell.setCellValue("Username");
		cell = row.createCell(4);
		cell.setCellValue("");
		cell = row.createCell(5);
		cell.setCellValue("Assigned Authority");
		cell = row.createCell(6);
		cell.setCellValue("Usertype");
		cell = row.createCell(7);
		cell.setCellValue("Gender");
		cell = row.createCell(8);
		cell.setCellValue("Present Address");
		cell = row.createCell(9);
		cell.setCellValue("Permanent Address");
		cell = row.createCell(10);
		cell.setCellValue("Mobile No.");
		cell = row.createCell(11);
		cell.setCellValue("Emergency Contact");
		cell = row.createCell(12);
		cell.setCellValue("Email Address");
		cell = row.createCell(13);
		cell.setCellValue("Bank Details");
		cell = row.createCell(14);
		cell.setCellValue("Pan Card");
		cell = row.createCell(15);
		cell.setCellValue("Aadhar Card no.");
		cell = row.createCell(16);
		cell.setCellValue("Dob");
		cell = row.createCell(17);
		cell.setCellValue("DoJ");
		cell = row.createCell(18);
		cell.setCellValue("Area");
		cell = row.createCell(19);
		cell.setCellValue("License No.");
		cell = row.createCell(20);
		cell.setCellValue("Education");
		cell = row.createCell(21);
		cell.setCellValue("Age");
		cell = row.createCell(22);
		cell.setCellValue("Insurance Covered");
		cell = row.createCell(23);
		cell.setCellValue("Employee Type");
		cell = row.createCell(24);
		cell.setCellValue("Status");

		int i = 2;

		while (rs_exp.next()) {
			ResultSet area_rs = connect.createStatement()
					.executeQuery("select areaname from area where aid ='" + rs_exp.getInt("aid") + "'");
			String areaname = null;
			String auth_name = null;
			if (area_rs.next()) {
				areaname = area_rs.getString("areaname");
			}
			area_rs = connect.createStatement()
					.executeQuery("select name from employee where eid='" + rs_exp.getInt("eid") + "'");
			if (area_rs.next()) {
				auth_name = area_rs.getString("name");
			}

			row = spreadsheet.createRow(i);
			cell = row.createCell(1);
			cell.setCellValue(rs_exp.getInt("eid"));
			cell = row.createCell(2);
			cell.setCellValue(rs_exp.getString("name"));
			cell = row.createCell(3);
			cell.setCellValue(rs_exp.getString("uname"));
			cell = row.createCell(4);
			cell.setCellValue(rs_exp.getString("upass"));
			cell = row.createCell(5);
			cell.setCellValue(auth_name);
			cell = row.createCell(6);
			cell.setCellValue(rs_exp.getString("usertype"));
			cell = row.createCell(7);
			cell.setCellValue(rs_exp.getString("gender"));
			cell = row.createCell(8);
			cell.setCellValue(rs_exp.getString("presentaddress"));
			cell = row.createCell(9);
			cell.setCellValue(rs_exp.getString("permanentaddress"));
			cell = row.createCell(10);
			cell.setCellValue(rs_exp.getDouble("mobile"));
			cell = row.createCell(11);
			cell.setCellValue(rs_exp.getDouble("emergencycontact"));
			cell = row.createCell(12);
			cell.setCellValue(rs_exp.getString("email"));
			cell = row.createCell(13);
			cell.setCellValue(rs_exp.getString("bankdetails"));
			cell = row.createCell(14);
			cell.setCellValue(rs_exp.getString("pan"));
			cell = row.createCell(15);
			cell.setCellValue(rs_exp.getString("aadhar"));
			cell = row.createCell(16);
			cell.setCellValue(rs_exp.getString("dob"));
			cell = row.createCell(17);
			cell.setCellValue(rs_exp.getString("doj"));
			cell = row.createCell(18);
			cell.setCellValue(areaname);
			cell = row.createCell(19);
			cell.setCellValue(rs_exp.getString("licenseno"));
			cell = row.createCell(20);
			cell.setCellValue(rs_exp.getString("education"));
			cell = row.createCell(21);
			cell.setCellValue(rs_exp.getInt("age"));
			cell = row.createCell(22);
			cell.setCellValue(rs_exp.getString("insurancecovered"));
			cell = row.createCell(23);
			cell.setCellValue(rs_exp.getString("emptype"));
			cell = row.createCell(24);
			cell.setCellValue(rs_exp.getString("isactive"));

			i++;
		}

		connect.close();

		/*
		 * FileOutputStream out = new FileOutputStream(new
		 * File("G:\\AllEmployees"+Math.random()+".xls")); workbook.write(out);
		 * out.close(); System.out.println("exceldatabase.xlsx written successfully");
		 */
		return workbook;
	}
}
