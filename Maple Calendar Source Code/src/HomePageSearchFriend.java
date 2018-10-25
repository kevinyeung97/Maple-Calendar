

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashSet;


@WebServlet("/HomePageSearchFriend")
public class HomePageSearchFriend extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public HomePageSearchFriend() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
														System.out.println("");
														System.out.println("got into HomePgSearchFriend servlet doGet");
														System.out.println("");
		
		String currUserName = request.getParameter("currUserName");
		String currUserEmail = request.getParameter("currUserEmail");
		String currUserImage = request.getParameter("currUserEmail");
		
		String clickedName = request.getParameter("clickedName");
		String clickedEmail = request.getParameter("clickedEmail");
		String clickedImage = request.getParameter("clickedImage");
		
										
														System.out.println("HomePgSearchFriend currUserName: " + currUserName);
														System.out.println("HomePgSearchFriend currUserEmail: " + currUserEmail);	
														System.out.println("HomePgSearchFriend currUserImage: " + currUserImage);
														
														System.out.println("HomePgSearchFriend clickedName: " + clickedName);	
														System.out.println("HomePgSearchFriend clickedEmail: " + clickedEmail);	
														System.out.println("HomePgSearchFriend clickedImage: " + clickedImage);	
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		
		
		HashSet<String> peopleUserFollows = new HashSet<String>(); 
		String servletIsFollowing = "";
		
					ArrayList<String> eventNames = new ArrayList<String>();
					ArrayList<String> eventDates = new ArrayList<String>();
					ArrayList<String> eventTimes = new ArrayList<String>();
		
		
		try {
			Class.forName("com.mysql.jdbc.Driver");	
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Assignment3?user=root&password=karenkelly&useSSL=false");
			
			st = conn.createStatement();

			String sql = "SELECT * FROM Relationships WHERE email = '" + currUserEmail + "'";
											System.out.println("");
											System.out.println("entered sql command: " + sql);
			ResultSet newRS = st.executeQuery(sql);
											if(newRS.first() == false) {
												System.out.println("RS is empty, currUser does not follow clickedUser");
											}
			
			newRS.beforeFirst();		//moves cursor to allow while loop to pick up first entry
			
			while(newRS.next()) {	
				String tempEmail = newRS.getString("followings");
				peopleUserFollows.add(tempEmail);
											System.out.println("added: " + tempEmail);
			}	
			
					     for (String temp : peopleUserFollows) {
					         System.out.println("emails inside set: " + temp);
					      }
			
			if(peopleUserFollows.contains(clickedEmail)) {		//currently signed in user follows the clickedUser
			servletIsFollowing = "true";
							System.out.println("servletIsFollowing is set to: " + servletIsFollowing);
			}
			else {
			servletIsFollowing = "false";
							System.out.println("servletIsFollowing is set to: " + servletIsFollowing);
			}
			
			
			
			String sql2 = "SELECT * FROM UserEvents WHERE email = '" + clickedEmail + "'";
			System.out.println("");
			System.out.println("entered sql2 command: " + sql2);
			rs = st.executeQuery(sql2);	
			
			rs.beforeFirst();		//moves cursor to allow while loop to pick up first entry
			
			while(rs.next()) {	
			String tempEventName = rs.getString("eventName");
			String tempEventDate = rs.getString("eventDate");
			String tempEventTime = rs.getString("eventTime");
			
			eventNames.add(tempEventName);
			eventDates.add(tempEventDate);
			eventTimes.add(tempEventTime);
			}
			
									System.out.println("eventNames: " + eventNames);
									System.out.println("eventDates: " + eventDates);
									System.out.println("eventTimes: " + eventTimes);
			
			Gson gson = new Gson();
			String eventNamesJSONString = gson.toJson(eventNames);
			String eventDatesJSONString = gson.toJson(eventDates);
			String eventTimesJSONString = gson.toJson(eventTimes);
			
			eventNamesJSONString = eventNamesJSONString.substring(1, eventNamesJSONString.length()-1);
			eventDatesJSONString = eventDatesJSONString.substring(1, eventDatesJSONString.length()-1);
			eventTimesJSONString = eventTimesJSONString.substring(1, eventTimesJSONString.length()-1);
			
			eventNamesJSONString = eventNamesJSONString.replace("\"", "");
			eventDatesJSONString = eventDatesJSONString.replace("\"", "");
			eventDatesJSONString = eventDatesJSONString.replaceAll(", ","Z"); //dates have comma in them, easier parsing if took out comma for now and add back in later
			eventDatesJSONString = eventDatesJSONString.replaceAll(",", "|");
			eventDatesJSONString = eventDatesJSONString.replaceAll("Z", ", ");
			eventTimesJSONString = eventTimesJSONString.replace("\"", "");
			
									System.out.println("");
									System.out.println("eventNamesJSONString: " + eventNamesJSONString);
									System.out.println("eventDatesJSONString: " + eventDatesJSONString);
									System.out.println("eventTimesJSONString: " + eventTimesJSONString);
			
									
							
			HttpSession session6 = request.getSession();
			session6.setAttribute("servletIsFollowing", servletIsFollowing);
			
			session6.setAttribute("clickedName10", clickedName);
			session6.setAttribute("clickedImageURL10", clickedImage);
			session6.setAttribute("clickedEmail10", clickedEmail);
			
						session6.setAttribute("currUserEmail", currUserEmail);
						session6.setAttribute("currUserName", currUserName);
						session6.setAttribute("currUserImage", currUserImage);
			
			session6.setAttribute("sessionEventNamesJSONString", eventNamesJSONString);
			session6.setAttribute("sessionEventDatesJSONString", eventDatesJSONString);								
			session6.setAttribute("sessionEventTimesJSONString", eventTimesJSONString);	
			
			session6.setAttribute("numEvents", eventNames.size());
			session6.setAttribute("eventNamesAL", eventNames);
			session6.setAttribute("eventDatesAL", eventDates);
			session6.setAttribute("eventTimesAL", eventTimes);
			
			
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
