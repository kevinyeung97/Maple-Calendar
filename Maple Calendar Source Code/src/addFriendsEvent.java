

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/addFriendsEvent")
public class addFriendsEvent extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public addFriendsEvent() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
												System.out.println("");
												System.out.println("got into addFrenEvent servlet doGet");
		
		String clickedEventName = request.getParameter("clickedEventName");
		String clickedEventDate = request.getParameter("clickedEventDate");
		String clickedEventTime = request.getParameter("clickedEventTime");
		
		String currUserEmail = request.getParameter("currUserEmail");
		String currUserName = request.getParameter("currUserName");
		String currUserImage = request.getParameter("currUserImage");
		
			
										System.out.println("addFrenEvent clickedEventName: " + clickedEventName);
										System.out.println("addFrenEvent clickedEventDate: " + clickedEventDate);
										System.out.println("addFrenEvent clickedEventTime: " + clickedEventTime);
										
										System.out.println("addFrenEvent currUserEmail: " + currUserEmail);
										System.out.println("addFrenEvent currUserName: " + currUserName);
										System.out.println("addFrenEvent currUserImage: " + currUserImage);
		
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");	
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Assignment3?user=root&password=karenkelly&useSSL=false");
			
			st = conn.createStatement();
			
			
			String sql = "INSERT INTO UserEvents (email, eventName, eventDate, eventTime) VALUES ('" + currUserEmail + "', '" + clickedEventName + "', '" + clickedEventDate+ "', '" + clickedEventTime + "');" ;
																	System.out.println("");
																	System.out.println("addEventUpDB sql command: " + sql);
			st.executeUpdate(sql);
																	
																	
																															
		}catch(SQLException sqle) {
			System.out.println("sqle1: " + sqle.getMessage());
		}catch(ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		}finally {
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
