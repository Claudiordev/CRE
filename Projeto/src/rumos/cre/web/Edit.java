package rumos.cre.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import rumos.cre.database.Access;
import rumos.cre.entities.Categoria;
import rumos.cre.entities.Produto;

/**
 * Servlet implementation
 * Used on editing Product on WebPage, Entity Produto.java
 */
@WebServlet("/Edit")
public class Edit extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Receive parameters from HTTPServletRequest within Post method,
	 * check if non-null and pass it into the Database;
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Get access to Database Object
		Access access = new Access();
		
		//Get object to answer back to client page;
		PrintWriter out = response.getWriter();
		
		//Get parameters defined in JSP file to be saved into Database
		int productID = Integer.parseInt(request.getParameter("productID"));
		String productName = request.getParameter("productName");
		String productDescription = request.getParameter("productDescription");
		String productPrice = request.getParameter("productPrice");
		Categoria productCategory = access.getEm().find(Categoria.class, Integer.parseInt(request.getParameter("productCategory")));
		
		//Instanciate Product Object
		Produto p = access.getEm().find(Produto.class, productID);
		
		if (!productName.equals("") && !productDescription.equals("") && !productPrice.equals("")) {
		
		/* 
		 * Start transaction, update all values and commit it to the Database and refresh the Entity Object
		 */
		access.getEm().getTransaction().begin();
		p.setNome(productName);
		p.setDescricao(productDescription);
		p.setCategoria(productCategory);
		p.setPreco(Double.parseDouble(productPrice));
		access.getEm().getTransaction().commit();
		access.getEm().refresh(p);
		
		//Reload back to Index Page after complete
		response.sendRedirect("index.jsp");
		} else {
			
			//Send error, non filled inputs and redirect; JavaScript
			out.println("<script type=\"text/javascript\">");
			out.println("alert('Preencha todos os campos e tente novamente!');");
			out.println("location='index.jsp';");
			out.println("</script>");
		}
		
	}

}
