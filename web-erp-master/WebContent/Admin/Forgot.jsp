<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Properties" %>
<%@page import="javax.mail.internet.*" %>
<%@page import="javax.mail.*" %>
<%@page import="java.util.Random"%>
<%@page import="javax.mail.Authenticator " %>
<%@page import=" javax.mail.Message" %>
<%@page import=" javax.mail.MessagingException" %>
<%@page import="javax.mail.PasswordAuthentication " %>
<%@page import="javax.mail.Session " %>
<%@page import=" javax.mail.Transport" %>
<%@page import="javax.mail.internet.InternetAddress " %>
<%@page import="javax.mail.internet.MimeMessage" %>
<%@page import="java.security.SecureRandom" %>
<
    <%
	String email=request.getParameter("email");
	
	String from = "ravindrapatil.alceatechnologies@gmail.com";

    String pass = "ravi6596";
	String message = (String)request.getAttribute("errorMessage");

    
	String host = "smtp.gmail.com";
	Properties props = new Properties();
	props.put("mail.smtp.host", "smtp.gmail.com");
	props.put("mail.smtp.starttls.enable","true");
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
	
	try
	{	
		Random r=new Random();
		//St user_id="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"+r.nextInt(99999);
		//String user_id=("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ",+99999);
		int len = 20;
		String ALPHA_NUM = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		StringBuffer sb = new StringBuffer(len);
		for (int i = 0; i < len; i++) {
			int ndx = (int) (Math.random() * ALPHA_NUM.length());
			sb.append(ALPHA_NUM.charAt(ndx));
		}
		//return sb.toString();	
out.println(sb);
		

		/* MimeMessage msg = new MimeMessage(mailSession);
        
       	msg.setFrom(new InternetAddress(from));

       	msg.addRecipient(Message.RecipientType.TO,

        new InternetAddress(email));
        msg.setSubject("Forgot Password");
        msg.setText("\nYour new Password:\t"+sb);
	    Transport.send(msg); */
      	
	}
	catch(Exception e)
	{
		out.println(e);
		//out.println("Error....");
		
	}
	
	%>
 	<%-- <script type="text/javascript">
    var msg = "<%=message%>";
    alert("Mail Sent Successfully!!!");
   	window.location = '../index.jsp';
</script> --%>