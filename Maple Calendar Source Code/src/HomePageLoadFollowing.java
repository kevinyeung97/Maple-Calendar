

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
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;


@WebServlet("/HomePageLoadFollowing")
public class HomePageLoadFollowing extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public HomePageLoadFollowing() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
										System.out.println("");
										System.out.println("got into HomePgLoadFoll servlet doGet");

		String currUserName = request.getParameter("currUserName");
		String currUserEmail = request.getParameter("currUserEmail");
		

												System.out.println("HomePgLoadFoll currUserName: " + currUserName);
												System.out.println("HomePgLoadFoll currUserEmail: " + currUserEmail);
				
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
												
		try {
			Class.forName("com.mysql.jdbc.Driver");	
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Assignment3?user=root&password=karenkelly&useSSL=false");
			
			st = conn.createStatement();
			
			String sql = "SELECT * FROM Relationships WHERE email = '" + currUserEmail + "';" ;
																System.out.println("");
																System.out.println("HPLFollo sql command: " + sql);
			rs = st.executeQuery(sql);
			
			
			rs.beforeFirst();
			
			
			ArrayList<String> peopleUserFollowsEmailsAL = new ArrayList<String> ();
			ArrayList<String> peopleUserFollowsImagesAL = new ArrayList<String> ();
			ArrayList<String> peopleUserFollowsNamesAL = new ArrayList<String> ();
			
			while(rs.next()){
				String tempEmail = rs.getString("followings");
				peopleUserFollowsEmailsAL.add(tempEmail);
			}
																System.out.println("peopleUserFollowsEmailsAL: " + peopleUserFollowsEmailsAL);
			
			for(int i = 0; i < peopleUserFollowsEmailsAL.size(); i++) {
				String sql2 = "SELECT * FROM Users WHERE email = '" + peopleUserFollowsEmailsAL.get(i) + "';";
				
																System.out.println("HPLFollo sql2: " + sql2);
				ResultSet rs2 = st.executeQuery(sql2);
				
				rs2.beforeFirst();
				while(rs2.next()) {
					String tempImage = rs2.getString("imageURL");
					String tempName = rs2.getString("userName");
					peopleUserFollowsImagesAL.add(tempImage);
					peopleUserFollowsNamesAL.add(tempName);
				}
			}
			
																System.out.println("");
																System.out.println("HPLFollo peopleFollow Images AL: " + peopleUserFollowsImagesAL);
																System.out.println("HPLFollo peopleFollow Names AL: " + peopleUserFollowsNamesAL);
			Gson gson = new Gson();
			String emailsJSONString = gson.toJson(peopleUserFollowsEmailsAL);
			String imagesJSONString = gson.toJson(peopleUserFollowsImagesAL);
			String namesJSONString = gson.toJson(peopleUserFollowsNamesAL);
			
			emailsJSONString = emailsJSONString.substring(1, emailsJSONString.length()-1);
			imagesJSONString = imagesJSONString.substring(1, imagesJSONString.length()-1);
			namesJSONString = namesJSONString.substring(1, namesJSONString.length()-1);
			
			emailsJSONString = emailsJSONString.replace("\"", "");
			imagesJSONString = imagesJSONString.replace("\"", "");
			namesJSONString = namesJSONString.replace("\"", "");
			
				
																System.out.println("");
																System.out.println("HomePgLFollo emailsJSONString: " + emailsJSONString);
																System.out.println("HomePgLFollo imagesJSONString: " + imagesJSONString);
																System.out.println("HomePgLFollo namesJSONString: " + namesJSONString);
																System.out.println("numPeople: " + peopleUserFollowsEmailsAL.size());
																
			HttpSession session5 = request.getSession();
			session5.setAttribute("peopleUserFollowsEmailsAL", peopleUserFollowsEmailsAL);
			session5.setAttribute("peopleUserFollowsImagesAL", peopleUserFollowsImagesAL);
			session5.setAttribute("peopleUserFollowsNamesAL", peopleUserFollowsNamesAL);
			session5.setAttribute("numPeople", peopleUserFollowsEmailsAL.size());
			
			session5.setAttribute("emailsJSONString", emailsJSONString);
			session5.setAttribute("imagesJSONString", imagesJSONString);
			session5.setAttribute("namesJSONString", namesJSONString);
			
			
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
