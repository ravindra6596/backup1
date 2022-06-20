package com.model;

import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;


import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Row;

public class ExcelImport {
	public static String import_excel() throws Exception {
		FileInputStream input = new FileInputStream("G:\\SaleReport0.3189920688424571");
	    POIFSFileSystem fs = new POIFSFileSystem(input);
	    HSSFWorkbook wb = new HSSFWorkbook(fs);
	    
	    List<String> Product = new ArrayList<String>();
	    List<String> Doctor = new ArrayList<String>();
	    int colCount = 0;
	    
	    HSSFSheet sheet = wb.getSheetAt(0);
	    Row row;
        for (int i = 1; i <= sheet.getLastRowNum(); i++) {
        	row = sheet.getRow(i);
        	colCount = row.getLastCellNum();
        }
        System.out.println("Row COunt="+sheet.getLastRowNum());
        System.out.println("col count="+colCount);
		return null;
	}
	
}
