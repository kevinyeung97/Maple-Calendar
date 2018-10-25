

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class searchFriends
 */
@WebServlet("/searchFriends")
public class searchFriends extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public searchFriends() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("Got into doGet function in searchFriends");
		
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String nameUpper = name.toUpperCase();
		String imageURL = request.getParameter("imageURL").trim();
			//imageURL = URLEncoder.encode(imageURL, "UTF-8");	//mySQL doesn't support normal URLs for some reason.??
		String email = request.getParameter("email");
		
				System.out.println("id: " + id);
				System.out.println("name: " + name);
				System.out.println("imageURL: " + imageURL);
				System.out.println("email: " + email);
				
		String numEvents0 = request.getParameter("numEvents");
		int numEvents = Integer.parseInt(numEvents0.trim());
					
		String [] eventNames = new String [numEvents];
		String [] eventDateTimes = new String [numEvents];
		String [] eventDates = new String [numEvents];
		String [] eventTimes = new String [numEvents];
		

		
		for(int i = 0; i < numEvents; i++) {
			eventNames[i] = request.getParameter("eventName" + i);
			eventDateTimes[i] = request.getParameter("eventDateTime" + i); 
				System.out.println("eventDateTimes: " + eventDateTimes[i]);
		}
		
		String tempDate = new String();
		String tempTime = new String();
		for(int i = 0; i < numEvents; i++) {
			String year = eventDateTimes[i].substring(0,4);
			String month = eventDateTimes[i].substring(5,7);
			if(month.equals("01")){
				month = "January";
			}
			if(month.equals("02")){
				month = "February";
			}
			if(month.equals("03")){
				month = "March";
			}
			if(month.equals("04")){
				month = "April";
			}
			if(month.equals("05")){
				month = "May";
			}
			if(month.equals("06")){
				month = "June";
			}
			if(month.equals("07")){
				month = "July";
			}
			if(month.equals("08")){
				month = "August";
			}
			if(month.equals("09")){
				month = "September";
			}
			if(month.equals("10")){
				month = "October";
			}
			if(month.equals("11")){
				month = "November";
			}
			if(month.equals("12")){
				month = "December";
			}
			String day = eventDateTimes[i].substring(8,10);
			tempDate = month + " " + day + ", " + year;
			eventDates[i] = tempDate;
			
			tempTime = eventDateTimes[i].substring(11,16);
			tempTime += " AM";
			
			String hour = eventDateTimes[i].substring(11,13);
			if(hour.equals("12")){
				tempTime = tempTime.replace("AM", "PM");
			}	
			if(hour.equals("13")){
				tempTime = tempTime.replace("13","01");
				tempTime = tempTime.replace("AM", "PM");
			}
			if(hour.equals("14")){
				tempTime = tempTime.replace("14","02");
				tempTime = tempTime.replace("AM", "PM");
			}
			if(hour.equals("15")){
				tempTime = tempTime.replace("15","03");
				tempTime = tempTime.replace("AM", "PM");
			}
			if(hour.equals("16")){
				tempTime = tempTime.replace("16","04");
				tempTime = tempTime.replace("AM", "PM");
			}
			if(hour.equals("17")){
				tempTime = tempTime.replace("17","05");
				tempTime = tempTime.replace("AM", "PM");
			}
			if(hour.equals("18")){
				tempTime = tempTime.replace("18","06");
				tempTime = tempTime.replace("AM", "PM");
			}
			if(hour.equals("19")){
				tempTime = tempTime.replace("19","07");
				tempTime = tempTime.replace("AM", "PM");
			}
			if(hour.equals("20")){
				tempTime = tempTime.replace("20","08");
				tempTime = tempTime.replace("AM", "PM");
			}
			if(hour.equals("21")){
				tempTime = tempTime.replace("21","09");
				tempTime = tempTime.replace("AM", "PM");
			}
			if(hour.equals("22")){
				tempTime = tempTime.replace("22","10");
				tempTime = tempTime.replace("AM", "PM");
			}
			if(hour.equals("23")){
				tempTime = tempTime.replace("23","11");
				tempTime = tempTime.replace("AM", "PM");
			}
			if(hour.equals("00")){
				tempTime = tempTime.replace("00", "12");
			}
			
			eventTimes[i] = tempTime;
			
			if(eventTimes[i].substring(0,1).equals("0")) {
				eventTimes[i] = eventTimes[i].substring(1);
			}
		}
		
		
		
				 
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");	
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Assignment3?user=root&password=karenkelly&useSSL=false");
			
			st = conn.createStatement();
			rs = st.executeQuery("SELECT email FROM Users WHERE email = '" + email + "';");
			
			if(!rs.next()) {
									System.out.println("");
									System.out.println("about to insert new user into db, looking for: " + name);
									System.out.println("imURL: " + imageURL);
				String sql = "INSERT INTO Users (email, userName, userNameUpper, imageURL) " +
			             "VALUES ('" + email + "', '" + name + "', '" + nameUpper + "', '" + imageURL + "');";
									System.out.println("");
									System.out.println("sql: " + sql);
				st.executeUpdate(sql);
			}
			
		
			for(int i = 0; i < numEvents; i++) {
				
				String sql = "INSERT INTO UserEvents (email, eventName, eventDate, eventTime) " +
			             "VALUES ('" + email + "', '" + eventNames[i] + "', '" + eventDates[i] + "', '" + eventTimes[i] + "');";
				
										System.out.println("sql: " + sql);
				
				st.executeUpdate(sql);
				
			}
			
			
			
		
			
			
		} catch(SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
			
		} catch(ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
			
		}
		
				
	} 

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
