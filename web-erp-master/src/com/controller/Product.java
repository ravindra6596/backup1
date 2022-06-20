package com.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

import com.model.C3P0DataSource;

/**
 * Servlet implementation class productController
 */
@WebServlet("/productController")
public class Product extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		try {
			String submit = request.getParameter("submit");
			PrintWriter out = response.getWriter();

			PreparedStatement ps1 = null;
			Connection con = C3P0DataSource.getInstance().getConnection();
			Statement st1 = con.createStatement();
			String msg = null;

			if (submit != null && submit.equals("UPDATE")) {
				update_product(request, response);
			} else if (submit != null && submit.equals("ADD")) {
				add_product(request, response);
			} else if (submit != null && submit.equals("DELETE")) {
				delete_product(request, response);
			} else {
				upload_product_pic(request, response);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void add_product(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, Exception, ServletException {

		PreparedStatement ps1 = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		String msg = null;

		String pname = request.getParameter("pname");
		String type = request.getParameter("ptype");
		String specification = request.getParameter("specification");
		String ptr1 = request.getParameter("ptr");
		String mrp1 = request.getParameter("mrp");
		String pts1 = request.getParameter("pts");
		String gst1 = request.getParameter("gst");
		Float ptr = Float.parseFloat(ptr1);
		Float mrp = Float.parseFloat(mrp1);
		String packaging = request.getParameter("packaging");
		Float pts = Float.parseFloat(pts1);
		Float gst = Float.parseFloat(gst1);
		String group = request.getParameter("pgroup");
		String detail = request.getParameter("detailingstory");
		String composition = request.getParameter("composition");
		InputStream prod_photo = null;
		// Part prod_photo=request.getPart("prod_pic");
		String insertQuery = "INSERT INTO product(pname,ptype,specification,packaging,mrp,ptr,pts,gst,pgroup,detailingstory,composition) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
		ps1 = con.prepareStatement(insertQuery);
		ps1.setString(1, pname);
		ps1.setString(2, type);
		ps1.setString(3, specification);
		ps1.setString(4, packaging);
		ps1.setFloat(5, mrp);
		ps1.setFloat(6, ptr);
		ps1.setFloat(7, pts);
		ps1.setFloat(8, gst);
		ps1.setString(9, group);
		ps1.setString(10, detail);
		ps1.setString(11, composition);

		int insertFlag = ps1.executeUpdate();
		if (insertFlag != 0) {
			msg = "success";
			response.sendRedirect("Admin/addproduct.jsp?response=" + msg);
		} else {
			msg = "fail";
			response.sendRedirect("Admin/addproduct.jsp?response=" + msg);
		}
		con.close();
	}

	protected void update_product(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, Exception, ServletException {

		PreparedStatement ps1 = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement st1 = con.createStatement();
		String msg = null;
		String pname = request.getParameter("pname");
		String type = request.getParameter("ptype");
		String specification = request.getParameter("specification");
		String ptr1 = request.getParameter("ptr");
		String mrp1 = request.getParameter("mrp");
		String pts1 = request.getParameter("pts");
		String gst1 = request.getParameter("gst");
		Float ptr = Float.parseFloat(ptr1);
		Float mrp = Float.parseFloat(mrp1);
		String packaging = request.getParameter("packaging");
		Float pts = Float.parseFloat(pts1);
		Float gst = Float.parseFloat(gst1);
		String group = request.getParameter("pgroup");
		String detail = request.getParameter("detailingstory");
		String composition = request.getParameter("composition");
		int id = Integer.parseInt(request.getParameter("pid"));

		String updateQuery = "UPDATE product SET pname = ?, ptype = ?, specification = ?, packaging = ?, mrp=?, ptr = ?, pts = ?, gst = ?, pgroup = ?, detailingstory = ?, composition = ? WHERE pid = "
				+ id + "";

		ps1 = con.prepareStatement(updateQuery);
		ps1.setString(1, pname);
		ps1.setString(2, type);
		ps1.setString(3, specification);
		ps1.setString(4, packaging);
		ps1.setFloat(5, mrp);
		ps1.setFloat(6, ptr);
		ps1.setFloat(7, pts);
		ps1.setFloat(8, gst);
		ps1.setString(9, group);
		ps1.setString(10, detail);
		ps1.setString(11, composition);

		int updateFlag = ps1.executeUpdate();
		if (updateFlag != 0) {
			msg = "success";
			response.sendRedirect("Admin/singleproduct.jsp?id=" + id + "&response=" + msg);
		} else {
			msg = "fail";
			response.sendRedirect("Admin/singleproduct.jsp?id=" + id + "&response=" + msg);
		}
		con.close();
	}

	protected void delete_product(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {

		PreparedStatement ps1 = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		Statement st1 = con.createStatement();
		String msg = null;
		String f = request.getParameter("flag");

		int id = Integer.parseInt(request.getParameter("pid"));
		try {
			int deleteFlag = st1.executeUpdate("delete from product where pid = '" + id + "' ");
			// ps1=con.prepareStatement(deleteQuery);

			// ps1.setInt(1, id);
			// int deleteFlag = ps1.executeUpdate();
			msg = null;
			if (deleteFlag != 0) {
				System.out.println("Deleted successfully");
				msg = "success";
				response.sendRedirect("Admin/productmgm.jsp?response=" + msg);
				System.out.println(msg);
			} else {
				msg = "fail";
				response.sendRedirect("Admin/productmgm.jsp?response=" + msg);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		con.close();
	}

	protected void upload_product_pic(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PreparedStatement ps1 = null;
		Connection con = C3P0DataSource.getInstance().getConnection();
		InputStream prod_photo = null;
		int id = 0;

		try {
			List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory())
					.parseRequest(new ServletRequestContext(request));
			for (FileItem item : items) {
				if (item.isFormField() && item.getFieldName().equals("pid")) {
					id = Integer.parseInt(item.getString());
				} else {
					prod_photo = item.getInputStream();
				}
			}

			if (prod_photo != null) {
				String insertQuery = "UPDATE product SET prod_pic = ? WHERE pid = " + id;
				ps1 = con.prepareStatement(insertQuery);
				ps1.setBlob(1, prod_photo);

				int updateFlag = ps1.executeUpdate();
				if (updateFlag != 0) {
					response.sendRedirect("Admin/singleproduct.jsp?id=" + id + "&response=success");
				} else {
					response.sendRedirect("Admin/singleproduct.jsp?id=" + id + "&response=fail");
				}
			} else {
				response.sendRedirect("Admin/singleproduct.jsp");
			}
		} catch (FileUploadException e) {
			throw new ServletException("Cannot parse multipart request.", e);
		}
		con.close();
	}
}
