<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="login.css">
<title>Rumos CRE</title>
</head>

<body>

	<!-- Login Form, passed through post method to Servlet Login.java -->
	<div class="login">
		<form action="Login" method="post">
			Introduza um login: <input type="text" name="uname"/> <br>
			Introduza uma password: <input type="password" name="pass"/> <br>
			<input type="submit" value="login"/>
		</form>
	</div>

</body>
</html>