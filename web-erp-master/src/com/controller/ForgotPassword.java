package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model.C3P0DataSource;

/**
 * Servlet implementation class ForgotPassword
 */
@WebServlet("/ForgotPassword")
public class ForgotPassword extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String epass = request.getParameter("password");
		System.out.println("Control here");
		Connection conn;
		try {
			conn = C3P0DataSource.getInstance().getConnection();
			Statement stm = conn.createStatement();
			// int insertpassword = stm.executeUpdate("insert into employee(upass) values
			// ('" + epass + "')");

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// ithe to updte hoil n mg susess houn index jump krn

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		String email = request.getParameter("email");

		String epass = request.getParameter("password");
		System.out.println(epass);

		String from = "ravindrapatil.alceatechnologies@gmail.com";

		String pass = "ravi6596";
		String message = (String) request.getAttribute("errorMessage");

		String host = "smtp.gmail.com";
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");
		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {

			@Override

			protected PasswordAuthentication getPasswordAuthentication() {

				return new PasswordAuthentication("ravindrapatil.alceatechnologies@gmail.com", "ravi6596");

			}

		});

		try {
			Random r = new Random();
			// St user_id="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"+r.nextInt(99999);
			// String user_id=("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ",+99999);
			int len = 20;
			String ALPHA_NUM = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
			StringBuffer sb = new StringBuffer(len);
			for (int i = 0; i < len; i++) {
				int ndx = (int) (Math.random() * ALPHA_NUM.length());
				sb.append(ALPHA_NUM.charAt(ndx));
			}
			System.out.println(sb);

			Connection con = C3P0DataSource.getInstance().getConnection();
			Statement stmt = con.createStatement();
			Statement st = con.createStatement();

			// First use delete query here....
			int del = stmt.executeUpdate("delete from password_resets where email='" + email + "'");
			int insertFlag = st
					.executeUpdate("insert into password_resets(email,token) values ('" + email + "','" + sb + "')");

			MimeMessage msg = new MimeMessage(mailSession);

			msg.setFrom(new InternetAddress(from));

			msg.addRecipient(Message.RecipientType.TO,

					new InternetAddress(email));
			msg.setSubject("Forgot Password");
			msg.setText(
					"Kindly click on link given below to reset the password.\n\n Click here to reset Password: http://localhost:8080/cms/ForgotPassword.jsp?action=set_password&token="
							+ sb + "&email=" + email);

			Transport.send(msg);
			response.sendRedirect("ForgotPassword.jsp?action=token_sent");
			con.close();
		} catch (Exception e) {

			// out.println("Error....");

		}

	}

}
