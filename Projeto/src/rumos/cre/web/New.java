package rumos.cre.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.persistence.Query;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import rumos.cre.database.Access;
import rumos.cre.entities.Categoria;

/**
 * Servlet implementation class New
 */
@WebServlet("/New")
public class New extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Get HTTPServlet Post Request from add modal form, if values non null,
	 * add new product with correspondent values to the Database;
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Get access to Database Object
		Access access = new Access();
		
		//Get object to answer back to the browser
		PrintWriter out = response.getWriter();
		
		String productName = request.getParameter("productName");
		String productDescription = request.getParameter("productDescription");
		String productPrice = request.getParameter("productPrice");
		int userID = Integer.parseInt(request.getParameter("userID"));
		Categoria productCategory = access.getEm().find(Categoria.class, Integer.parseInt(request.getParameter("productCategory")));
		
		if (!productName.equals("") && !productDescription.equals("") && !productPrice.equals("")) {
			//Add to Database
			access.getEm().getTransaction().begin();
			Query q = access.getEm().createNativeQuery("INSERT INTO produto (categoria_id, nome, descricao, preco, user_id) VALUES ("+ productCategory.getId() +", '"+ productName +"', '"+ productDescription +"', "+Double.parseDouble(productPrice)+", "+ userID +");");
			q.executeUpdate();
			access.getEm().getTransaction().commit();
			
			//Reload back to Index Page
			response.sendRedirect("index.jsp");
		} else {
			//Throw Error
			out.println("<script type=\"text/javascript\">");
			out.println("alert('Preencha todos os campos e tente novamente!');");
			out.println("location='index.jsp';");
			out.println("</script>");
		}
	}

}
