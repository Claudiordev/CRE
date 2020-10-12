<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	import="javax.persistence.Query"
	import="java.util.*"
	import="rumos.cre.database.Access"
	import="rumos.cre.entities.*"
	import="rumos.cre.web.Login"
	import="java.math.BigDecimal"
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
			Access access = Login.getAccess();
			
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
			
			Query q = access.getEm().createNativeQuery("SELECT * from produto;");
			List<Object[]> produtos = q.getResultList();
			
	%>
	
	<div class="topnav">
  		<a class="active" href="/CREFinal">Home</a>
  		
  		<!-- If Administrator, Can access Categories Page -->
  			<%if(role.equals("Administrador")) { %>
  				<a href="/CREFinal/categorias.jsp">Categorias</a>
  			<%} %>
  			
  		<a href="#">Sobre</a>
	</div>
	
	<div class="title">
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
			<th>Nome</th> <th>Descrição</th> <th>Preço</th> <th>Categoria</th> <th>Ações</th>
		</tr>
	
	<%
	
		for (Object[] produto : produtos) {
			//Fetch id value from Query, stored in index 0
			int pID = Integer.parseInt(produto[0].toString());
			
			//Create Produto Object
			Produto p = access.getEm().find(Produto.class, pID);
			
			//Refresh Entity
			access.getEm().refresh(p);
			
			//Fetch Data
			String produtoName = p.getNome();
			String produtoDescription = p.getDescricao();
			double produtoPrice = p.getPreco();
			Categoria produtoCategoria = p.getCategoria();
		
		//Generate object for each produto raw object
	%>
		
		<!--  Row -->
			<tr>
				<td><%=produtoName%></td> <td><%=produtoDescription%></td> <td><%=produtoPrice%></td> <td><%=p.getCategoria().getNome()%></td>
				
				<!--  //Generate Edit button if Administrator of the System or Owner of the Product -->
 				<%if (role.equals("Administrador") || p.getEmpregado().equals(ep)) { %>
					<td><button onclick="return showModal(<%=pID%>,'<%=produtoName%>','<%=produtoDescription%>','<%=produtoCategoria.getId()%>','<%=produtoCategoria.getNome()%>','<%=produtoPrice%>');">Editar</button></td>
 				<% } %> 
			</tr>
	
	<%
			}
	%>
	</table>
	</div>
	<!-- Table of Products END -->
	
	<!--  Add Product Button -->
	<div>
		<button onclick="document.getElementById('addProduct').style.display='block'">Adicionar</button>
	</div>
	<!--  Add Product Button -->
	
	<!--  Modal Edit Product START -->
	<div id="editProduct" class="w3-modal">
		<div class="w3-modal-content block-modal">
			<div class="w3-container">
			
			<span onclick="document.getElementById('editProduct').style.display='none'" class="w3-button w3-display-topright">&times;</span>
			<h3>Editar Produto</h3>
			
			<form method="post" action="Edit">
				<div>
					<input hidden type="text" name="productID" id="dbID"/>
				</div>
			
				<div>
					<label>Nome:</label> <input name="productName" id="NomeEdit"/>
				</div>
				
				<div>
					<label>Descrição:</label> <textarea name="productDescription" style="resize:none;" id="DescriptionEdit"></textarea>
				</div>
				
				<div>
				
					<label>Categoria:</label>
						<select id="categorySelect" name="productCategory">
						<!-- Category Search -->
							<%
								List<Object[]> categorias = access.getEm().createNativeQuery("SELECT * from categoria;").getResultList();
								for (Object[] categoria: categorias) {
									int id = Integer.parseInt(categoria[0].toString());
									
									//Categoria object
									Categoria c = access.getEm().find(Categoria.class, id);
							%>
							<option value="<%=c.getId()%>"><%=c.getNome()%></option>
							<% } %>
						</select>
				</div>
				
				<div>
					<label>Preço:</label> <input id="PriceEdit" name="productPrice" type="number"/>
				</div>
				
				<!--  Confirm Button -->
				<div>
					<input type="submit" class="confirmButton" value="Salvar"/>
				</div>
			</form>
			
			</div>
		</div>
	</div>
	
	<!-- Modal Edit Product END -->
	
	
	
	<!--  Modal Add Product START -->
	<div id="addProduct" class="w3-modal">
		<div class="w3-modal-content block-modal">
			<div class="w3-container">
			
			<span onclick="document.getElementById('addProduct').style.display='none'" class="w3-button w3-display-topright">&times;</span>
			<h3>Adicionar Produto</h3>
			
			<form method="post" action="New">
				<div>
					<input hidden type="text" name="userID" id="userID" value="<%=userID%>"/>
				</div>
			
				<div>
					<label>Nome:</label> <input name="productName" id="NomeEdit"/>
				</div>
				
				<div>
					<label>Descrição:</label> <textarea name="productDescription" style="resize:none;" id="DescriptionEdit"></textarea>
				</div>
				
				<div>
				
					<label>Categoria:</label>
						<select id="categorySelect" name="productCategory">
						<!-- Category Search -->
							<%
								for (Object[] categoria: categorias) {
									int id = Integer.parseInt(categoria[0].toString());
									
									//Categoria object
									Categoria c = access.getEm().find(Categoria.class, id);
							%>
							<!--  Set Option value and Display text -->
							<option value="<%=c.getId()%>"><%=c.getNome()%></option>
							<% } %>
						</select>
				</div>
				
				<div>
					<label>Preço:</label> <input name="productPrice" step=".01" type="number" value="0.0"/>
				</div>
				
				<!--  Confirm Button -->
				<div>
					<input type="submit" class="confirmButton" value="Confirmar"/>
				</div>
			</form>
			
			</div>
		</div>
	</div>
	<!--  Modal Add Product END -->
	
	
<script>
/*
 * Show Modal and set Values within Modal
 */
function showModal(id,name,description,categoriaID,categoriaNome,price) {
	document.getElementById('editProduct').style.display='block';
	
	//Set value of ID Field
	document.getElementById('dbID').value = id;
	
	//Set value of Name Field
	document.getElementById('NomeEdit').value = name;
	
	//Set value of Description Field
	document.getElementById('DescriptionEdit').value = description;
	
	//Set value of Price
	document.getElementById('PriceEdit').value = price;
	
	/*
		Remove duplicate category value and add already choosen as default
	*/
	var selectobject = document.getElementById("categorySelect");
		for (var i=0; i<selectobject.length; i++) {
    		if (selectobject.options[i].value == categoriaID)
        		selectobject.remove(i);
		}

	var option = new Option(categoriaNome,categoriaID,true,true);
	selectobject.add(option);
		
	//Avoid refresh on button click
	return false;
}
</script>

<% 
		//Else Closure
		} %>

</body>
</html>