<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
    	session = request.getSession();
    	String path = (String) session.getAttribute("pathName");
    	String msg = null;
    	msg = request.getParameter("res");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel = "icon" href =  "dist/img/Title-Logo.png" type = "image/x-icon"> 
<title>Navodian Life Science</title>
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
				<img src="dist/img/Navodian-logo.webp"  class="karsan-logo">
			</div>
		</div>
		<div class="col-md-6">
			<div class="login-box">
		<div class="login-logo">
			<a href="<%=request.getContextPath()%>"><b>Navodian Life Science</b></a>
		</div>
		<!-- /.login-logo -->
		<div class="login-box-body">
			<p class="login-box-msg"></p>
			<% if(msg != null)
	{
		out.println("<p style='color:red;'>Wrong Username or Password..Please Enter Valid Credentials.</p>");
	} %>

			<form
				action="LoginController"
				method="post">
				<input type="hidden" name="urlpath" value="<%= path %>">
				<div class="form-group has-feedback">
					<input type="email" class="form-control login_input" autocomplete="off" placeholder="Username" name="uname">
					<span class="glyphicon glyphicon-user form-control-feedback"></span>
				</div>
				<div class="form-group has-feedback">
					<input type="password" class="form-control login_input" placeholder="Password" name="upass">
					<span class="glyphicon glyphicon-lock form-control-feedback"></span>
				</div>
				<div class="row">
					<div class="col-xs-8">
						<div class="checkbox icheck">
							<label> <input type="checkbox"> Remember Me </label>
						</div>
					</div>
					<!-- /.col -->
					<div class="col-xs-4">
						<button type="submit" class="btn btn-primary btn-block btn-flat" name="login" value="Log In">Log In</button>
					</div>
					<!-- /.col -->
				</div>
			</form>
			<a href="ForgotPassword.jsp?action=send_token">I forgot my password</a><br>
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
