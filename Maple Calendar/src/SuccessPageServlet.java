

import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

/**
 * Servlet implementation class SuccessPageServlet
 */
@WebServlet("/SuccessPageServlet")
public class SuccessPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SuccessPageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String eventTitle = request.getParameter("eventTitle");
    	String startDate = request.getParameter("startDate");
    	String endDate = request.getParameter("endDate");
    	String startTime = request.getParameter("startTime");
    	String endTime = request.getParameter("endTime");
    	
		    	System.out.println("eventTitle passed into servlet: " + eventTitle);
		    	System.out.println("startDate passed into servlet: " + startDate);
		    	System.out.println("starTime passed into servlet: " + startTime);
		    	
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	Date dateStart = new Date(0);
    	Date dateEnd = new Date(0);
    	
    	String dateStartStr = dateStart.toString();
    	String dateEndStr = dateEnd.toString();
    	
    	
    	
    	try {
        	dateStart = sdf.parse(startDate);
            dateEnd = sdf.parse(endDate);
    	} catch (java.text.ParseException e) {
			e.printStackTrace();
			dateStartStr = "";
			dateEndStr = "";
		}
    	

    	SimpleDateFormat sdf2 = new SimpleDateFormat("HH:mm");
    	Date timeStart = new Date(0);
    	Date timeEnd = new Date(0);
    	
    	String timeStartStr = timeStart.toString();
    	String timeEndStr = timeEnd.toString();
    	
    	
    	try {
        	timeStart = sdf2.parse(startTime);
            timeEnd = sdf2.parse(endTime);
    	} catch (java.text.ParseException e) {
			e.printStackTrace();
			timeStartStr = "";
			timeEndStr = "";
		}
    	
    	String next = "/successPage.jsp";
    	
    	
    	if(eventTitle == "") {
    		request.setAttribute("title_err", "Please enter a valid title");
    		System.out.println("trigger empty eventTitle");
    		next = "/homePage.jsp";
    	}
    	
    	
    	if (dateStart.after(dateEnd) || dateStartStr == "") { //start Date is after end Date
    		request.setAttribute("date_err", "Please enter a valid start/end date");
    		next = "/homePage.jsp";
    	}
    	
    	if (dateEnd.before(dateStart) || dateEndStr == "") { //end Date is before start Date
    		request.setAttribute("date_err", "Please enter valid start/end date");
    		next = "/homePage.jsp";
    	}
    	
    	
    	if (timeStart.after(timeEnd) || timeStartStr == "") { //start Time is after end Time
    		request.setAttribute("time_err", "Please enter valid start/end time");
    		next = "/homePage.jsp";
    	}
    	
    	if (timeEnd.before(timeStart) || timeEndStr ==  "") { //end Time is before start Time
    		request.setAttribute("time_err", "Please enter valid start/end time");
    		next = "/homePage.jsp";
    	}
    		
    	
    
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(next);
		
    	try {
    		dispatch.forward(request,response);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
    }




}
