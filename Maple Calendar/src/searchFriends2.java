

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import com.google.gson.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class searchFriends2
 */
@WebServlet("/searchFriends2")
public class searchFriends2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public searchFriends2() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String searchName = request.getParameter("searchFriendName");
		String searchNameUpper = searchName.toUpperCase();
									System.out.println("searchName: " + searchNameUpper);
									
		String currUserEmail = (String)request.getSession(false).getAttribute("servletCurrUserEmail");
		String currUserName = (String)request.getSession(false).getAttribute("servletCurrUserName");
		String currUserImageURL = (String)request.getSession(false).getAttribute("servletCurrUserImage");
		
									System.out.println("currUserEmail: " + currUserEmail);
									System.out.println("currUserName: " + currUserName);
									System.out.println("currUserImageURL: " + currUserImageURL);

		
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		
		try {
			String [] inputNames = searchNameUpper.split(" ");
			
//									for(int i = 0; i < inputNames.length; i++) {
//										System.out.println("name in array of names index" + i + ": " + inputNames[i]);
//									}
			
			Class.forName("com.mysql.jdbc.Driver");	
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Assignment3?user=root&password=karenkelly&useSSL=false");
			
			st = conn.createStatement();
			
			String rsEmail = new String();
			String rsuserName = new String();
			String rsimageURL = new String();
			
			LinkedHashMap<String, String> queriedNames = new LinkedHashMap<>();
			LinkedHashMap<String, String> queriedImageURLS = new LinkedHashMap<>();
			LinkedHashMap<String, String> queriedEmails = new LinkedHashMap<>();
			
			for(int i = 0; i < inputNames.length; i++) { //Kevin    Yeung
				String sql = "SELECT * FROM Users WHERE userNameUpper LIKE '%" + inputNames[i] + "%';" ;
				ResultSet newRS = st.executeQuery(sql);
				while(newRS.next()) {		//iterate through each resultSet to grab userName/image
					rsuserName = newRS.getString("userName");
					rsimageURL = newRS.getString("imageURL");
					rsEmail = newRS.getString("email");
					if(currUserEmail.equals(rsEmail) == false) {		///filters out users searching for themselves
						queriedNames.put(rsEmail,rsuserName);
						
													System.out.println("");
													System.out.println("currUserEmail: " + currUserEmail);
													System.out.println("rsEmail: " + rsEmail);
													System.out.println("");
													
					}
					if(currUserEmail.equals(rsEmail) == false) {
					//if(queriedNames.containsValue(rsimageURL) == false)
						queriedImageURLS.put(rsEmail,rsimageURL);
					}
					
					if(currUserEmail.equals(rsEmail) == false) {
					//if(queriedNames.containsValue(rsEmail) == false)
						queriedEmails.put(rsEmail,rsEmail);
					}
				}				
			}
									
									Iterator it4 = queriedNames.entrySet().iterator();
									Iterator it5 = queriedImageURLS.entrySet().iterator();
									Iterator it6 = queriedEmails.entrySet().iterator();
									
									while(it4.hasNext()) {
										Map.Entry pair = (Map.Entry)it4.next();
										System.out.println("queriedNames: " + pair.getKey() + " = " + pair.getValue());
									}
									while(it5.hasNext()) {
										Map.Entry pair = (Map.Entry)it5.next();
										System.out.println("queriedImageURLS: " + pair.getKey() + " = " + pair.getValue());
									}
									while(it6.hasNext()) {
										Map.Entry pair = (Map.Entry)it6.next();
										System.out.println("queriedEmails: " + pair.getKey() + " = " + pair.getValue());
									}
									
									
			ArrayList<String> searchedNames = new ArrayList<String>();
			ArrayList<String> searchedImageURLs = new ArrayList<String>();
			ArrayList<String> searchedEmails = new ArrayList<String>();
			
			Iterator it = queriedNames.entrySet().iterator();
			Iterator it2 = queriedImageURLS.entrySet().iterator();
			Iterator it3 = queriedEmails.entrySet().iterator();
			
			while(it.hasNext()) {
				Map.Entry pair = (Map.Entry)it.next();
											System.out.println("searchedName: " + (String) pair.getKey());
				searchedNames.add((String) pair.getValue());
			}		
											System.out.println("searchedName size:" + searchedNames.size());
			while(it2.hasNext()) {
				Map.Entry pair = (Map.Entry)it2.next();
											System.out.println("searchedImageURL: " + (String) pair.getKey());
				searchedImageURLs.add((String) pair.getValue());
			}	
											System.out.println("searchedImageURL size:" + searchedEmails.size());
			while(it3.hasNext()) {
				Map.Entry pair = (Map.Entry)it3.next();
											System.out.println("searchedEmail: " + (String) pair.getKey());
				searchedEmails.add((String) pair.getValue());
			}	
											System.out.println("searchedEmail size:" + searchedEmails.size());
		
		
		Gson gson = new Gson();
		String namesJSONString = gson.toJson(searchedNames);
		String imagesJSONString = gson.toJson(searchedImageURLs);
		String emailsJSONString = gson.toJson(searchedEmails);
		
		namesJSONString = namesJSONString.substring(1, namesJSONString.length()-1);
		imagesJSONString = imagesJSONString.substring(1, imagesJSONString.length()-1);
		emailsJSONString = emailsJSONString.substring(1, emailsJSONString.length()-1);
		
		namesJSONString = namesJSONString.replace("\"", "");
		imagesJSONString = imagesJSONString.replace("\"", "");
		emailsJSONString = emailsJSONString.replace("\"", "");
		
//						System.out.println("namesJSONString: " + namesJSONString);
//						System.out.println("imagesJSONString: " + imagesJSONString);
//						System.out.println("emailsJSONString: " + emailsJSONString);
											
		HttpSession session2 = request.getSession();
		session2.setAttribute("sessionSearchedNames", searchedNames);
		session2.setAttribute("sessionSearchedImageURLs", searchedImageURLs);								
		session2.setAttribute("sessionSearchedEmails", searchedEmails);	
		
		session2.setAttribute("namesJSONString", namesJSONString);
		session2.setAttribute("imagesJSONString", imagesJSONString);
		session2.setAttribute("emailsJSONString", emailsJSONString);	
				
		} catch(SQLException sqle) {
			System.out.println("sqle1: " + sqle.getMessage());
		} catch(ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		} finally {
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
			} catch(SQLException sqle) {
				System.out.println("sqle2 closing conn: " + sqle.getMessage());
			}
		}
		
		response.sendRedirect("searchResultsPage.jsp");    //same as requestDispatcher, but this one doesnt pass the request with it?
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
