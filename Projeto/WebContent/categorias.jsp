<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	import="javax.persistence.Query"
	import="java.util.*"
	import="rumos.cre.database.Access"
	import="rumos.cre.entities.*"
	import="rumos.cre.web.Login"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Rumos CRE</title>

<!-- Page CSS -->
<link rel="stylesheet" href="index.css">

<!-- W3 Schools Modal CSS Script -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!-- W3 Schools Modal CSS Script -->
</head>
<body>

	<%
		
		//If Username Label of HttpSession is null, go back to login.jsp
		if (session.getAttribute("username") == null){
			response.sendRedirect("login.jsp");
		} else {
			//Access to DB
			Access access = new Access();
			
			//User ID
			int userID = Integer.parseInt(session.getAttribute("userid").toString());
			
			//Empregado object
			Empregado ep = access.getEm().find(Empregado.class, userID);
			
			//User Name
			String name = ep.getNome();
			
			//User Surname
			String surname = ep.getApelido();
			
			//User Role
			String role = ep.getRole().getNome();
			
			Query q = access.getEm().createNativeQuery("SELECT * from categoria;");
			List<Object[]> categorias = q.getResultList();
			
	%>
	
	<div class="topnav">
  		<a href="/CREFinal">Home</a>
  		<a class="active" href="/CREFinal/categorias.jsp">Categorias</a>
  		<a href="#">Sobre</a>
	</div>
	
	<div class="title">
		<!-- Display name and surname -->
		Bem-Vindo <%=name%> <%=surname%>
	</div>
	
	<!-- Logout Button START -->
	<form  class="logoutButton" action="Logout">
		<input type="submit" value="logout" />
	</form>
	<!-- Logout Button END -->
	
	
	<!-- Table of Products START -->
	<div>
	<table class="table">
		<!--  Title -->
		<tr>
			<th>Nome</th> <th>Subcategoria</th>
		</tr>
	
	<%
	
		for (Object[] categoria : categorias) {
			int pID = Integer.parseInt(categoria[0].toString());
			
			//Create and Instanciate Produto Object
			Categoria c = access.getEm().find(Categoria.class, pID);
			
			//Refresh Every Entity Found within the loop
			access.getEm().refresh(c);
			
			//Fetch Data from Object
			String categoriaName = c.getNome();
			int categoriaSubCategoriaID = c.getSubcategoria().getId();
			String categoriaSubCategoriaNome = c.getSubcategoria().getNome();
			
	%>
		
		<!--  Show Values, Row -->
			<tr>
				<td><%=categoriaName%></td> <td><%=categoriaSubCategoriaNome%></td>
			</tr>
	<% } %>
	</table>
	</div>
	<!-- Table of Products END -->
	
	
<script>
/*
 * Show Modal JavaScript Function,
 * Return false to avoid refresh on button click;
 */
function showModal(id,name,subcategoria,subcategoriaID) {
	document.getElementById('editCategory').style.display='block';
		
	return false;
}
</script>

<% 
		//Else Closure
		} %>

</body>
</html>