<!DOCTYPE html>
<%@ page import="java.util.Calendar"%>
<%@ page import="com.mongodb.DBCursor"%>
<%@ page import="com.mobile.npss.*"%>
<%@ page import="java.io.File"%>
<%@ page import="com.mongodb.Mongo"%>
<%@ page import="com.mongodb.DB"%>
<%@ page import="com.mongodb.gridfs.GridFS"%>
<%@ page import="com.mongodb.gridfs.GridFSDBFile"%>
<%@ page import="com.mongodb.gridfs.GridFSInputFile"%>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>NPSS-News</title>

<!-- Bootstrap Core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="css/thumbnail-gallery.css" rel="stylesheet">

</head>

<body>
	<!-- Navigation -->
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="homeNPSS.jsp">NPSS-News</a>

			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li><a href="uploadNewsLetter.jsp">Upload</a></li>
					<li><a href="#">Services</a></li>
					<li><a href="#">Contact</a></li>
				</ul>
			</div>
		</div>

	</nav>

	<!-- Page Content -->
	<div class="container">

		<div class="row">

			<div class="col-lg-12">
				<h1 class="page-header"></h1>
			</div>
			<%
				String[] monthName = { "January", "February", "March", "April",
						"May", "June", "July", "August", "September", "October",
						"November", "December" };
				/* Using the calendar API to get the current time instance */
				Calendar cal = Calendar.getInstance();
				/*Using Mongo API to connect the backend server and getting the instance to 
				access the data  */
				Mongo mongo = new Mongo("localhost", 27017);
				DB db = mongo.getDB("NPSS");

				GridFS gfsPhoto = new GridFS(db, "photo");
				DBCursor cursor = gfsPhoto.getFileList();
				System.out.println(cursor.size());
				int i = 0;
				while (cursor.hasNext()) {
					cursor.next();
					String month = (String) cursor.curr().get("filename");
					GridFSDBFile imageForOutput = gfsPhoto.findOne(month);
					imageForOutput.writeTo(getServletContext().getRealPath(
							month + ".pdf"));
			%>

			<div class="col-lg-3 col-md-4 col-xs-6 thumb">
				<a class="thumbnail" href="<%=month%>.pdf"> <img
					class="img-responsive" src="java_tutorial.PNG" alt="">
					<!--Creating the download function to make it download in the system-->
				</a> <a class="thumbnail" href="<%=month%>.pdf"
					download="<%=month%>.pdf"><button>Download</button> <label><%=monthName[i]%>
						<%=cal.get(Calendar.YEAR)%></label></a>
			</div>
			<%
				i++;
				}
			%>

		</div>

		<hr>

		<!-- Footer -->
		<footer>
			<div class="row">
				<div class="col-lg-12">
					<p>Copyright &copy; NPSS Website 2015</p>
				</div>
			</div>
		</footer>

	</div>

	<!-- jQuery -->
	<script src="js/jquery.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="js/bootstrap.min.js"></script>

</body>

</html>
