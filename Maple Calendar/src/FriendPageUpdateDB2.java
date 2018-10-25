

import java.io.IOException;
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

@WebServlet("/FriendPageUpdateDB2")
public class FriendPageUpdateDB2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public FriendPageUpdateDB2() {
        super();

    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
												System.out.println("");
												System.out.println("got into FriendPgUpDB2 servlet doGet");
		
		String clickedName = (String)request.getSession(false).getAttribute("clickedName10");
		String clickedEmail = (String)request.getSession(false).getAttribute("clickedEmail10");
		
		String currUserName = (String)request.getSession(false).getAttribute("currUserName");
		String currUserEmail = (String)request.getSession(false).getAttribute("currUserEmail");
		
													System.out.println("FriendPgUPDB clickedName: " + clickedName);
													System.out.println("FriendPgUPDB clickedEmail: " + clickedEmail);
													System.out.println("FriendPgUPDB currUserName: " + currUserName);
													System.out.println("FriendPgUPDB currUserEmail: " + currUserEmail);
		
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");	
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Assignment3?user=root&password=karenkelly&useSSL=false");
			
			st = conn.createStatement();
			
			String sql = "DELETE FROM Relationships WHERE email = '" + currUserEmail + "' AND followings = '" + clickedEmail+ "';" ;
																System.out.println("");
																System.out.println("FPUpDBentered sql command: " + sql);
			st.executeUpdate(sql);
			
			
			
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
