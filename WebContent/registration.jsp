<html>
<head>
<meta charset="utf-8">
<title>NPSS-Registration</title>
<style type="text/css">
body {
	background-color: #f4f4f4;
	color: #5a5656;
	font-family: 'Open Sans', Arial, Helvetica, sans-serif;
	font-size: 16px;
	line-height: 1.5em;
}

a {
	text-decoration: none;
}

h1 {
	font-size: 1em;
}

h1,p {
	margin-bottom: 10px;
}

strong {
	font-weight: bold;
}

.uppercase {
	text-transform: uppercase;
}

/* ---------- register ---------- */
#register {
	margin: 50px auto;
	width: 300px;
}

form fieldset input[type="text"],input[type="password"],input[type="email"]
	{
	background-color: #e5e5e5;
	border: none;
	border-radius: 3px;
	-moz-border-radius: 3px;
	-webkit-border-radius: 3px;
	color: #5a5656;
	font-family: 'Open Sans', Arial, Helvetica, sans-serif;
	font-size: 14px;
	height: 50px;
	outline: none;
	padding: 0px 10px;
	width: 280px;
	-webkit-appearance: none;
}

form fieldset input[type="submit"] {
	background-color: #008dde;
	border: none;
	border-radius: 3px;
	-moz-border-radius: 3px;
	-webkit-border-radius: 3px;
	color: #f4f4f4;
	cursor: pointer;
	font-family: 'Open Sans', Arial, Helvetica, sans-serif;
	height: 50px;
	text-transform: uppercase;
	width: 300px;
	-webkit-appearance: none;
}

form fieldset a {
	color: #5a5656;
	font-size: 10px;
}

form fieldset a:hover {
	text-decoration: underline;
}

.btn-round {
	background-color: #5a5656;
	border-radius: 50%;
	-moz-border-radius: 50%;
	-webkit-border-radius: 50%;
	color: #f4f4f4;
	display: block;
	font-size: 12px;
	height: 50px;
	line-height: 50px;
	margin: 30px 125px;
	text-align: center;
	text-transform: uppercase;
	width: 50px;
}
</style>
<script>
/*Validate form for vaidating the registration  */
	function validateForm() {
		var username = document.registerform.username.value;
		var fullname = document.registerform.fullname.value;
		var email = document.registerform.email.value;
		var password = document.registerform.password.value;
		if (fullname == "" || fullname == null) {
			alert("Please enter fullname");
			return false
		} else if (username == "" || username == null) {
			alert("Please enter Username");
			return false;
		} else if (email == "" || email == null) {
			alert("Please enter email");
			return false
		} else if (password == "" || password == null) {
			alert("Please enter Password");
			return false
		} else {
			return true;
		}

	}
</script>

</head>
<body>
	<div id="register">
		<h1>
			<strong>Registration</strong>
		</h1>
		<form name="registerform" onSubmit="return validateForm();"
			action="register" method="post">
			<fieldset>
				<label>Fullname</label> <input type="text" name="fullname"
					placeholder="fullname"><br /> <label>Username</label> <input
					type="text" name="username" placeholder="username"><br />
				<label>Email</label> <input type="email" name="email"
					placeholder="email"><br /> <label>Password</label> <input
					type="password" name="password" placeholder="password"><br />
				<p>
					<input type="submit" value="Signup" />
				</p>
			</fieldset>
		</form>

	</div>
	<!-- end login -->
</body>
</html>