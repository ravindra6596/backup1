<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
<%
    	session = request.getSession();
    	String path = (String) session.getAttribute("pathName");
    	String msg = null;
    	msg = request.getParameter("res");
    	
    	String action = request.getParameter("action");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Karsan Healthcare</title>
<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<!-- Bootstrap 3.3.7 -->
<link rel="stylesheet"
	href="bower_components/bootstrap/dist/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="bower_components/font-awesome/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet"
	href="bower_components/Ionicons/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="dist/css/AdminLTE.min.css">
<!-- iCheck -->
<link rel="stylesheet" href="plugins/iCheck/square/blue.css">

<link rel="stylesheet" href="dist/css/karsanApp.css">
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

<!-- Google Font -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>
<body class="hold-transition login-page">
	<div class="row">
		<div class="col-md-6">
			<div>
				<img src="dist/img/karsan-logo.png"  class="karsan-logo">
			</div>
		</div>
		<div class="col-md-6">
			<div class="login-box">
		<div class="login-logo">
			<a href="<%=request.getContextPath()%>"><b>Karsan Health Care</b></a>
		</div>
		<!-- /.login-logo -->
		<div class="login-box-body">
			<p class="login-box-msg"></p>
			<% if(msg != null)
	{
		out.println("<p style='color:red;'>Wrong Username or Password..Please Enter Valid Credentials.</p>");
	} %>
	
	<% 
	if(action.equals("send_token")){
		%>
		<form
				action="/cms/ForgotPassword"
				method="post">
				<input type="hidden" name="urlpath" value="<%= path %>">
				<div class="form-group has-feedback">
					<input type="email" class="form-control login_input" placeholder="Email Id"
						name="email"> <span
						class="glyphicon glyphicon-envelope form-control-feedback" style="font-size:20px;"></span>
				</div> 
				
				<div class="row">
					
					<!-- /.col -->
					<div class="col-xs-4">
						<button type="submit" class="btn btn-primary btn-block btn-flat"
							name="send" value="send mail">Send</button>
					</div>
					<!-- /.col -->
				</div>
			</form>
		<%
	}else if(action.equals("token_sent")){
		%>
		<p>Token has been sent </p>
		<%
	}else if(action.equals("set_password")){
		%>
		<form	action="/cms/ForgotPassword"
				method="POST">
				
				<div class="form-group has-feedback">
					<input type="password" class="form-control login_input" placeholder="Password"
						name="password"> <span
						class="glyphicon glyphicon-lock form-control-feedback" style="font-size:20px;"></span>
				</div> 
				<div class="form-group has-feedback">
					<input type="password" class="form-control login_input" placeholder="Confirm Password"
						name="confirmpassword"> <span
						class="glyphicon glyphicon-lock form-control-feedback" style="font-size:20px;"></span>
				</div>
				
				<div class="row">
					
					<!-- /.col -->
					<div class="col-xs-4">
						<button type="submit" class="btn btn-primary btn-block btn-flat"
							name="save" value="save">Save</button>
					</div>
					<!-- /.col -->
				</div>
		
		</form>
		<%
	}
	%>
	
		</div>
		<!-- /.login-box-body -->
	</div>
	<!-- /.login-box -->
		</div>
	</div>
	

	<!-- jQuery 3 -->
	<script src="bower_components/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap 3.3.7 -->
	<script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
	<!-- iCheck -->
	<script src="plugins/iCheck/icheck.min.js"></script>
	<script>
  $(function () {
    $('input').iCheck({
      checkboxClass: 'icheckbox_square-blue',
      radioClass: 'iradio_square-blue',
      increaseArea: '20%' /* optional */
    });
  });
</script>
</body>
</html>
