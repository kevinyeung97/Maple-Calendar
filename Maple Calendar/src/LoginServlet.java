

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		System.out.println("Got into doGet function");
		
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String imageURL = request.getParameter("imageURL");
		String email = request.getParameter("email");
		
				System.out.println("id: " + id);
				System.out.println("name: " + name);
				System.out.println("imageURL: " + imageURL);
				System.out.println("email: " + email);
				System.out.println("");
		
	    
//        RequestDispatcher dispatch = getServletContext().getRequestDispatcher("http://localhost:8080/Assignment2/LoggedInPage.jsp");
//      
//    	try {
//    		dispatch.forward(request,response);
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} catch (ServletException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
         
		HttpSession session = request.getSession();
		session.setAttribute("sessionID", id);
		session.setAttribute("sessionName", name);
		session.setAttribute("sessionEmail", email);
		session.setAttribute("sessionImageURL", imageURL);
		
		session.setAttribute("servletCurrUserEmail", email);
		session.setAttribute("servletCurrUserName", name);
		session.setAttribute("servletCurrUserImage", imageURL);
		
		  
			
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
