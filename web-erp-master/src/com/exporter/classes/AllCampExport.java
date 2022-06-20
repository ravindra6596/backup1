package com.exporter.classes;

import java.sql.Connection;
import java.sql.ResultSet;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.model.C3P0DataSource;

public class AllCampExport {
	public static HSSFWorkbook Export_camp(String query) throws Exception {
		Connection connect = C3P0DataSource.getInstance().getConnection();
		ResultSet rs_exp = connect.createStatement().executeQuery(query);
		
		HSSFWorkbook workbook = new HSSFWorkbook(); 
	    HSSFSheet spreadsheet = workbook.createSheet("report db");
	    
	    HSSFRow row = spreadsheet.createRow(1);
	    HSSFCell cell;
	    cell = row.createCell(1);
	    cell.setCellValue("Campaign Id");
	    cell = row.createCell(2);
	    cell.setCellValue("Campaign Name");
	    cell = row.createCell(3);
	    cell.setCellValue("Start Date");
	    cell = row.createCell(4);
	    cell.setCellValue("End Date");
	    cell = row.createCell(5);
	    cell.setCellValue("Campaign Value");
	    cell = row.createCell(6);
	    cell.setCellValue("Status");
	    cell = row.createCell(7);
	    cell.setCellValue("Colour Code");
	    
int i = 2;
	    
	    while(rs_exp.next()) {
    		row = spreadsheet.createRow(i);
    		cell = row.createCell(1);
	        cell.setCellValue(rs_exp.getInt("cid"));
	        cell = row.createCell(2);
	        cell.setCellValue(rs_exp.getString("cname"));
	        cell = row.createCell(3);
	        cell.setCellValue(rs_exp.getString("startdate"));
	        cell = row.createCell(4);
	        cell.setCellValue(rs_exp.getString("enddate"));
	        cell = row.createCell(5);
	        cell.setCellValue(rs_exp.getString("campaignvalue"));
	        cell = row.createCell(6);
	        cell.setCellValue(rs_exp.getString("status"));
	        cell = row.createCell(7);
	        cell.setCellValue(rs_exp.getString("color"));
	        	        
	        i++;
    	}
    	connect.close();
    	return workbook;
	}
}
