package com.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.model.C3P0DataSource;

/**
 * Servlet implementation class Upload_Doc
 */
@WebServlet("/Upload_Doc")
@MultipartConfig(fileSizeThreshold = 1024 * 70, // 100kb
		maxFileSize = 1024 * 70, // 70KB
		maxRequestSize = 1024 * 250) // 250KB

public class Upload_Doc extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Upload_Doc() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("Hereee456");
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		try {
			System.out.println("Hereee123");
			Connection con = C3P0DataSource.getInstance().getConnection();
			InputStream profile_photo = null;
			InputStream pan = null;
			InputStream aadhar = null;
			System.out.println("Hereee");
			String submit = request.getParameter("submit");
			System.out.println("Heyy");
			System.out.println(submit);
			if (submit.equals("Upload")) {
				int eid = Integer.parseInt(request.getParameter("eid"));
				Part profile_photo1 = request.getPart("profile_photo");
				Part Pan1 = request.getPart("pan");
				Part aadhar1 = request.getPart("aadhar");
				if (profile_photo1 != null && Pan1 != null && aadhar1 != null) {
					profile_photo = profile_photo1.getInputStream();
					pan = Pan1.getInputStream();
					aadhar = aadhar1.getInputStream();
				}

				String insertQuery = "insert into emp_docs(profile_photo,pan,aadhar,eid) values(?, ?, ?, ?)";
				PreparedStatement pt = con.prepareStatement(insertQuery);
				pt.setBlob(1, profile_photo);
				pt.setBlob(2, pan);
				pt.setBlob(3, aadhar);
				pt.setInt(4, eid);

				int row = pt.executeUpdate();
				if (row != 0) {
					String msg = "success";
					response.sendRedirect("Admin/addemployee.jsp?response=" + msg);
				} else {
					String msg = "fail";
					response.sendRedirect("Admin/doc_upload.jsp?response=" + msg);
				}
			}
			if (submit.equals("Download")) {
				Blob image = null;
				byte[] imgData = null;
				String getData = "select * from emp_docs where eid = '14'";
				PreparedStatement pstm = con.prepareStatement(getData);
				ResultSet rs = pstm.executeQuery();
				if (rs.next()) {
					image = rs.getBlob(1);
					imgData = image.getBytes(1, (int) image.length());
				}
				response.setContentType("image/jpg");
				// OutputStream o = response.getOutputStream();
				/*
				 * out.write(imgData); o.flush(); o.close();
				 */
			}
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
