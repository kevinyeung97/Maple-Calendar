

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/addEventUpdateDB")
public class addEventUpdateDB extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public addEventUpdateDB() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
													System.out.println("");
													System.out.println("got into FriendPgUpDB servlet doGet");
		
		String currUserEmail = request.getParameter("currUserEmail");
		String eventName = request.getParameter("eventName");
		String eventDate = request.getParameter("eventDate");
		String eventTime = request.getParameter("eventTime");
		
		eventTime = LocalTime.parse(eventTime).format(DateTimeFormatter.ofPattern("h:mm a"));
		
		String [] tempDateArray = new String[5];
		
		eventDate = eventDate.substring(0, 10);
														System.out.println("eventDate1: " + eventDate);
		tempDateArray = eventDate.split("-");		//yr , month, day
		if(tempDateArray[1].equals("01")) {
			tempDateArray[1] = "January";
		}
		if(tempDateArray[1].equals("02")) {
			tempDateArray[1] = "February";
		}
		if(tempDateArray[1].equals("03")) {
			tempDateArray[1] = "March";
		}
		if(tempDateArray[1].equals("04")) {
			tempDateArray[1] = "April";
		}
		if(tempDateArray[1].equals("05")) {
			tempDateArray[1] = "May";
		}
		if(tempDateArray[1].equals("06")) {
			tempDateArray[1] = "June";
		}
		if(tempDateArray[1].equals("07")) {
			tempDateArray[1] = "July";
		}
		if(tempDateArray[1].equals("08")) {
			tempDateArray[1] = "August";
		}
		if(tempDateArray[1].equals("09")) {
			tempDateArray[1] = "September";
		}
		if(tempDateArray[1].equals("10")) {
			tempDateArray[1] = "October";
		}
		if(tempDateArray[1].equals("11")) {
			tempDateArray[1] = "November";
		}
		if(tempDateArray[1].equals("12")) {
			tempDateArray[1] = "December";
		}
		
		eventDate = "";
		eventDate = tempDateArray[1] + " " + tempDateArray[2] + ", " + tempDateArray[0];

												System.out.println("");
												System.out.println("eventDate: " + eventDate);
												System.out.println("");
		
													System.out.println("addEventUpDB currUserEmail: " + currUserEmail);
													System.out.println("addEventUpDB eventName: " + eventName);
													System.out.println("addEventUpDB eventDate: " + eventDate);
													System.out.println("addEventUpDB eventTime: " + eventTime);
		
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");	
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Assignment3?user=root&password=karenkelly&useSSL=false");
			
			st = conn.createStatement();
			
		//INSERT INTO Relationships (email, followings) VALUES ('kevinyeung97@gmail.com', 'kevinyeung96@gmail.com');
			
			String sql = "INSERT INTO UserEvents (email, eventName, eventDate, eventTime) VALUES ('" + currUserEmail + "', '" + eventName + "', '" + eventDate+ "', '" + eventTime + "');" ;
																System.out.println("");
																System.out.println("addEventUpDB sql command: " + sql);
			st.executeUpdate(sql);
			
		} catch(SQLException sqle) {
			System.out.println("sqle1: " + sqle.getMessage());
		} catch(ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		}  finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(st != null) {
					st.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch(SQLException sqle2) {
				System.out.println("sqle2 closing conn: " + sqle2.getMessage());
			}
		}
		
		
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
