package com.exporter.classes;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.json.JsonArray;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.json.JSONException;
import org.json.JSONObject;

import com.controller.object.GetDataBrandTrend;

/**
 * Servlet implementation class Exporter
 */
@WebServlet("/Exporter")
public class Exporter extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Exporter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
		String export = request.getParameter("export");
		
		String msg = null;
		System.out.println("export "+export);
		//System.out.println("query "+query);
		if(export.equalsIgnoreCase("export_alldoctors")) {
			String query = request.getParameter("query");
			if(query != null) {
				try {
					response.setContentType("application/vnd.ms-excel");
		            response.setHeader("Content-Disposition", "attachment; filename=AllDoctors"+Math.random()+".xls");
		            HSSFWorkbook workbook = AllDoctorExport.Export_doctor(query);
		            workbook.write(response.getOutputStream());
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}else if(export.equalsIgnoreCase("export_allEmployees")) {
			String query = request.getParameter("query");
			if(query != null) {
				try {
					response.setContentType("application/vnd.ms-excel");
		            response.setHeader("Content-Disposition", "attachment; filename=AllEmployee"+Math.random()+".xls");
		            HSSFWorkbook workbook = AllEmployeesExport.ExportEmp(query);
		            workbook.write(response.getOutputStream());
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}else if(export.equalsIgnoreCase("export_allProducts")) {
			String query = request.getParameter("query");
			if(query != null) {
				try {
					response.setContentType("application/vnd.ms-excel");
		            response.setHeader("Content-Disposition", "attachment; filename=AllProducts"+Math.random()+".xls");
		            HSSFWorkbook workbook = AllProductsExport.Export_product(query);
		            workbook.write(response.getOutputStream());
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}else if(export.equalsIgnoreCase("export_allStockiest")) {
			String query = request.getParameter("query");
			if(query != null) {
				try {
					response.setContentType("application/vnd.ms-excel");
		            response.setHeader("Content-Disposition", "attachment; filename=AllStockiest"+Math.random()+".xls");
		            HSSFWorkbook workbook = AllStockiestExport.Export_stockiest(query);
		            workbook.write(response.getOutputStream());
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		else if(export.equalsIgnoreCase("export_allCampaign")) {
			String query = request.getParameter("query");
			if(query != null) {
				try {
					response.setContentType("application/vnd.ms-excel");
		            response.setHeader("Content-Disposition", "attachment; filename=All Campaigns"+Math.random()+".xls");
		            HSSFWorkbook workbook = AllCampExport.Export_camp(query);
		            workbook.write(response.getOutputStream());
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		/*else if(export.equalsIgnoreCase("export_BrandTrend")) {
			String json = request.getParameter("jsonobject");
			Map<String, String[]> list = request.getParameterMap();
			try {
				JSONObject jsonobj = new JSONObject(json);
				response.setContentType("application/vnd.ms-excel");
	            response.setHeader("Content-Disposition", "attachment; filename=BrandTrend.xls");
				HSSFWorkbook workbook = GetDataBrandTrend.getData(jsonobj, list);
				workbook.write(response.getOutputStream());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}*/
	}

}
