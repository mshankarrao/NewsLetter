<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>NPSS-News</title>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css"
	rel="stylesheet">
<link href="fileinput.css" media="all" rel="stylesheet"
	type="text/css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="fileinput.js" type="text/javascript"></script>
<script type="text/javascript">
/*Uploading the file to the database  */
	function startUpload() {
		var fileInput = document.getElementById("fileInput");

		if (fileInput.files.length == 0) {
			alert("Please choose a file");
			return;
		}

		var progressBar = document.getElementById("progressBar");
		var xhr = new XMLHttpRequest();

		xhr.upload.onprogress = function(e) {
			var percentComplete = (e.loaded / e.total) * 100;
			progressBar.value = percentComplete;
		};

		xhr.onload = function() {
			if (xhr.status == 200) {
				alert("Sucess! Upload completed");
			} else {
				alert("Error! Upload failed");
			}
		};
		xhr.onerror = function() {
			alert("Error! Upload failed. Can not connect to server.");
		};
		progressBar.value = 0;
		xhr.open("POST", "FileUploader", true);
		xhr.setRequestHeader("Content-Type", fileInput.files[0].type);
		xhr.send(fileInput.files[0]);
	}
</script>
</head>
<body>
	<div class="container kv-main">
	<br/>
	<br/>
	<br/>
	<br/>
	<h1 align="center">Upload the File in PDF format</h1>
		<input id="fileInput" class="file" type="file">
		<button class="btn btn-primary" onclick="startUpload();">Upload</button>
		<a href="homeNPSS.jsp"><button class="btn btn-default">Home</button></a>
		<progress id="progressBar" max="100" value="0"></progress>
	</div>
</body>
</html>