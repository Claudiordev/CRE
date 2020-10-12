package rumos.cre.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.persistence.Query;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import rumos.cre.database.Access;
import rumos.cre.entities.Empregado;
import rumos.cre.entities.Role;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static Access access;
       
	/**
	 * Note: Multiple Accesses throughout the project will generate Entity Errors,
	 * use calling this getter
	 * @return Object of access to Database
	 */
    public static Access getAccess() {
		return access;
	}

    public Login() {
        super();
        //Auto-generated constructor stub
    }

	/**
	 * Get HTTPServlet Post Request from login form, check with Database values, 
	 * if match access to the index page and define uname parameter to get full access within all pages;
	 * If values not match, get back to login page
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		boolean loginState = false;
		
		//Access to the Database
		access = new Access();
		
		//Get parameters defined in JSP file
		String uname = request.getParameter("uname");
		String pass = request.getParameter("pass");
		
		//Get object to answer back
		PrintWriter out = response.getWriter();
		
		//Search for all registered empregados within the table
		Query q = access.getEm().createNativeQuery("SELECT * from empregados;");
		List<Object[]> empregados = q.getResultList();
		 
		for (Object[] a : empregados) {
			int id = (int) a[0]; //Get ID from each row
			
			//Generate object for each empregado
			Empregado e = access.getEm().find(Empregado.class, id);
			//Refresh entity on Login
			access.getEm().refresh(e);
			
			if(uname.equals(e.getLogin()) && pass.equals(e.getPassword())) {
				//Get session object after successful login
				HttpSession session = request.getSession();
				
				//Set attribute of HTTP session username(label) as uname object;
				session.setAttribute("username", uname);
				session.setAttribute("userid", e.getId());
				
				//Redirect to page after login with success: 
				response.sendRedirect("index.jsp");
				
				loginState = true;
				
				break;
			}
		}
		

		if (!loginState) {
			out.println("<script type=\"text/javascript\">");
			out.println("alert('Username ou Password incorrecto, tenta novamente!');");
			out.println("location='login.jsp';");
			out.println("</script>");
		}
		
		
//		//If Login is Correct
//		if(uname.equals("claudio") && pass.equals("12345")) {
//			//Get session object after successful login
//			HttpSession session = request.getSession();
//			//Set attribute of HTTP session username(label) as uname object;
//			session.setAttribute("username", uname);
//			
//			//Redirect to page after login with success: 
//			response.sendRedirect("index.jsp");
//		} else {
//			
//			//In Case it's incorrect, redirect the page and send an alert through JS Script
//			out.println("<script type=\"text/javascript\">");
//			out.println("alert('Username ou Password incorrecta, tenta novamente!');");
//			out.println("location='login.jsp';");
//			out.println("</script>");
//		}
	}
}
