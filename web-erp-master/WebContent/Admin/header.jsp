<%@page import="com.model.C3P0DataSource"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.controller.object.SessionObject"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
	
	
	String rootpath = request.getContextPath() + "/";
	session = request.getSession(false);
	String uname = null;
	String usertype = null;
	int id = 0;
	String pathInfo = request.getServletPath();
	pathInfo = pathInfo.substring(1, pathInfo.length());

	if (session != null) {
		uname = (String) session.getAttribute("uname");
		usertype = (String) session.getAttribute("usertype");
	}

	String session_result = SessionObject.session_admin(uname, usertype);

	if (session_result.equals("true")) {
		id = (Integer) session.getAttribute("id");
	} else {
		HttpSession session_path = request.getSession();
		session_path.setAttribute("pathName", pathInfo);
		response.sendRedirect(rootpath + "index.jsp");
		return;
	}
%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>Navodian Life Science</title>
<!-- Tell the browser to be responsive to screen width -->
<base href=" <%=rootpath%>">


<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">

<link rel="shortcut icon" type="image/png"
	href="dist/img/Title-Logo.png" />
<link rel="stylesheet"
	href="bower_components/bootstrap/dist/css/bootstrap.css">

<link rel="stylesheet"
	href="bower_components/bootstrap/dist/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="bower_components/font-awesome/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet"
	href="bower_components/Ionicons/css/ionicons.min.css">
<!-- daterange picker -->
<link rel="stylesheet"
	href="bower_components/bootstrap-daterangepicker/daterangepicker.css">
<!-- bootstrap datepicker -->
<link rel="stylesheet"
	href="bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
<!-- iCheck for checkboxes and radio inputs -->
<link rel="stylesheet" href="plugins/iCheck/all.css">
<!-- Bootstrap Color Picker -->
<link rel="stylesheet"
	href="bower_components/bootstrap-colorpicker/dist/css/bootstrap-colorpicker.min.css">
<!-- Bootstrap time Picker -->
<link rel="stylesheet"
	href="plugins/timepicker/bootstrap-timepicker.min.css">
<!-- Select2 -->
<link rel="stylesheet"
	href="bower_components/select2/dist/css/select2.min.css">

<link rel="stylesheet" href="bower_components/chart.js/Chart.min.css">

<!-- Theme style -->
<link rel="stylesheet" href="dist/css/AdminLTE.min.css">

<!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet" href="dist/css/skins/skin-blue.min.css">
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->

<link rel="stylesheet"
	href="bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">




<!-- Google Font -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">


<link rel="stylesheet" href="dist/css/karsanApp.css">
<!-- customized Styles -->
<!-- <link rel="stylesheet" type="text/css" href="../css/app_style.css"> -->





</head>
<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->
<body class="hold-transition skin-blue sidebar-mini fixed">
	<div class="wrapper">

		<!-- Main Header -->
		<header class="main-header">

			<!-- Logo -->
			<a href="<%=request.getContextPath()%>/Admin/admindashboard.jsp"
				class="logo"> <!-- mini logo for sidebar mini 50x50 pixels --> <span
				class="logo-mini"><b>N</b>LS</span> <!-- logo for regular state and mobile devices -->
				<span class="logo-lg"><b>Admin </b>Dashboard</span>
			</a>

			<!-- Header Navbar -->
			<nav class="navbar navbar-static-top" role="navigation">
				<!-- Sidebar toggle button-->
				<a href="#" class="sidebar-toggle" data-toggle="push-menu"
					role="button"> <span class="sr-only">Toggle navigation</span>
				</a>
				<!-- Navbar Right Menu -->
				<div class="navbar-custom-menu">
					<ul class="nav navbar-nav">
						<!-- Messages: style can be found in dropdown.less-->
						<!-- <li class="dropdown messages-menu">
            Menu toggle button
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-envelope-o"></i>
              <span class="label label-success">4</span>
            </a>
            <ul class="dropdown-menu">
              <li class="header">You have 4 messages</li>
              <li>
                inner menu: contains the messages
                <ul class="menu">
                  <li>start message
                    <a href="#">
                      
                      Message title and timestamp
                      <h4>
                        Support Team
                        <small><i class="fa fa-clock-o"></i> 5 mins</small>
                      </h4>
                      The message
                      <p>Why not buy a new awesome theme?</p>
                    </a>
                  </li>
                  end message
                </ul>
                /.menu
              </li>
              <li class="footer"><a href="#">See All Messages</a></li>
            </ul>
          </li> -->
						<!-- /.messages-menu -->

						<!-- User Account Menu -->
						<li class="dropdown user user-menu">
							<!-- Menu Toggle Button --> <a href="#" class="dropdown-toggle"
							data-toggle="dropdown"> <!-- The user image in the navbar-->
								<!-- <img src="../dist/img/user2-160x160.jpg" class="user-image" alt="User Image"> -->
								<!-- hidden-xs hides the username on small devices so only the image appears. -->
								<span class="hidden-xs"><%=uname%></span>
						</a>
							<ul class="dropdown-menu">
								<!-- The user image in the menu -->
								<li class="user-header"><img
									src="dist/img/user2-160x160.jpg" class="img-circle"
									alt="User Image">

									<p>
										<%=uname%>
										<!-- <small>Member since Nov. 2012</small> -->
									</p></li>

								<!-- Menu Footer-->
								<li class="user-footer">
									<div class="pull-left">
										<!-- <a href="#" class="btn btn-default btn-flat">Profile</a> -->
									</div>
									<div class="pull-right">
										<a href="<%=rootpath%>/LoginController?login=logout"
											class="btn btn-default btn-flat">Sign out</a>
									</div>
								</li>
							</ul>
						</li>
						<!-- Control Sidebar Toggle Button -->

					</ul>
				</div>
			</nav>
		</header>
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar">

			<!-- sidebar: style can be found in sidebar.less -->
			<section class="sidebar">

				<!-- Sidebar Menu -->
				<ul class="sidebar-menu" data-widget="tree">

					<!-- Optionally, you can add icons to the links -->
					<li class=""><a href="Admin/admindashboard.jsp"><i
							class="fa fa-dashboard"></i> <span>Dashboard</span></a></li>
					<li class="treeview"><a href="#"><i
							class="fa fa-sticky-note-o"></i> <span>Analysis Reports</span> <span
							class="pull-right-container"> <i
								class="fa fa-angle-left pull-right"></i>
						</span> </a>
						<ul class="treeview-menu">
							<!--             <li><a href="expensesheet.jsp">Expense Sheet</a></li> -->
							<li><a href="Admin/employeeMonthWiseReport.jsp">Employee
									Report</a></li>
							<li><a href="Admin/brandTrend.jsp">Month-wise
									Product-wise Sale Report</a></li>
							<li><a href="Admin/productsale.jsp">Doctor wise Sale</a></li>
							<!--                <li><a href="campiagnSale.jsp">Campaign Sale</a></li> -->
							<li><a href="Admin/report.jsp">Report</a></li>
							<li><a href="Admin/individualtargetreport.jsp">Individual
									Target Report</a></li>
						</ul></li>
					<li class="header"></li>
					<li class="treeview"><a href="#"><i class="fa fa-user"></i>
							<span>Employee Management</span> <span
							class="pull-right-container"> <i
								class="fa fa-angle-left pull-right"></i>
						</span> </a>
						<ul class="treeview-menu">
							<li><a href="Admin/addemployee.jsp">Add New</a></li>
							<li><a href="Admin/Employeemgm.jsp">All Employees</a></li>
						</ul></li>

					<li class=""><a href="Admin/multipletarget.jsp"><i
							class="fa fa-line-chart"></i> <span>Target Management</span></a></li>
					<li class="treeview"><a href="#"><i class="fa fa-home"></i>
							<span>Area Management</span> <span class="pull-right-container">
								<i class="fa fa-angle-left pull-right"></i>
						</span> </a>
						<ul class="treeview-menu">
							<li><a href="Admin/regions.jsp">All Regions</a></li>
							<li><a href="Admin/districts.jsp">All Districts</a></li>
							<li><a href="Admin/headquarters.jsp">All Headquarters</a></li>
						</ul></li>

					<li class="treeview"><a href="#"><i class="fa fa-medkit"></i>
							<span>Product Management</span> <span
							class="pull-right-container"> <i
								class="fa fa-angle-left pull-right"></i>
						</span> </a>
						<ul class="treeview-menu">
							<li><a href="Admin/addproduct.jsp">Add New</a></li>
							<li><a href="Admin/productmgm.jsp">All Products</a></li>
						</ul></li>

					<li class="treeview"><a href="#"><i
							class="fa fa-stethoscope"></i> <span>Doctor Management</span> <span
							class="pull-right-container"> <i
								class="fa fa-angle-left pull-right"></i>
						</span> </a>
						<ul class="treeview-menu">
							<li><a href="Admin/addnewdoctor.jsp">Add New</a></li>
							<li><a href="Admin/alldoctors.jsp">All Doctors</a></li>
						</ul></li>
					<li class="treeview"><a href="#"><i
							class="fa fa-ambulance"></i> <span>Stockiest Management</span> <span
							class="pull-right-container"> <i
								class="fa fa-angle-left pull-right"></i>
						</span> </a>
						<ul class="treeview-menu">
							<li><a href="Admin/AddStockiest.jsp">Add New</a></li>
							<li><a href="Admin/allstockiest.jsp">All Stockiests</a></li>
						</ul></li>


					<li class="treeview"><a href="#"><i
							class="fa fa-university"></i> <span>Chemist Management</span> <span
							class="pull-right-container"> <i
								class="fa fa-angle-left pull-right"></i>
						</span> </a>
						<ul class="treeview-menu">
							<li><a href="Admin/addchemist.jsp">Add New</a></li>
							<li><a href="Admin/allchemist.jsp">All Chemists</a></li>
						</ul></li>


					<li class=""><a href="Admin/allLeaves.jsp"><i
							class="fa fa-calendar"></i> <span>Leave Management</span></a></li>
					<li class="treeview"><a href="#"><i class="fa  fa-users"></i>
							<span>Tour management</span> <span class="pull-right-container">
								<i class="fa fa-angle-left pull-right"></i>
						</span> </a>
						<ul class="treeview-menu">
							<li><a href="Admin/manualtourplan.jsp">Add Manual Tour
									Plan</a></li>
							<li><a href="Admin/alltours.jsp">All Tours</a></li>

						</ul></li>
					<li class=""><a href="Admin/holidays.jsp"><i
							class="fa fa-calendar-times-o"></i> <span>Holidays
								Management</span></a></li>
					<li class=""><a href="Admin/allorders.jsp"><i
							class="fa fa-shopping-cart"></i> <span>Orders Management</span></a></li>
					<li class=""><a href="Admin/allreturnorders.jsp"><i
							class="fa fa-refresh"></i> <span>Orders Type </span></a></li>
					<li class=""><a href="Admin/useractivity.jsp"><i
							class="fa fa-motorcycle"></i> <span>User Activity</span></a></li>
				</ul>
			</section>
		</aside>

		<div class="content-wrapper">