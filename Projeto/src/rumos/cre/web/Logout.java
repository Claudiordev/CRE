package rumos.cre.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Logout
 */
@WebServlet("/Logout")
public class Logout extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * On logout action, invalidate the session and get back to login page 
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		//Remove the username attribute
		session.removeAttribute("username");
		session.removeAttribute("userid");

		//Remove the restant values from the session such as name and surname
		session.invalidate();
		
		response.sendRedirect("index.jsp");
	}


}
