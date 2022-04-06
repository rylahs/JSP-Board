package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import DTO.User;

public class UserDBBean {
	private static UserDBBean instance = new UserDBBean();
	public static UserDBBean getInstance() {
		return instance;
	}

	private UserDBBean() {
		
	}
	
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/book_tp");
		return ds.getConnection();
	}
	
	public int join(User user) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			String sql = "insert into user values (?, ?, ?, ?, ?)";
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null)
				try { pstmt.close(); } catch (SQLException ex) {}
			if (conn != null)
				try { conn.close();	} catch (SQLException ex) {}
		}
		return -1;
	}
	

	public int login(String userId, String userPassword) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbPasswd = "";
		
		try {
			String sql = "Select userPassword from user where userID = ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				dbPasswd = rs.getString("userPassword");
				if (dbPasswd.equals(userPassword)) {
					return 1; // Login Success
				}
				else 
					return 0; // Password Mismatch
			}
			return -1; // ID not Found
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try { rs.close(); } catch (SQLException ex) {}
			if (pstmt != null)
				try { pstmt.close(); } catch (SQLException ex) {}
			if (conn != null)
				try { conn.close();	} catch (SQLException ex) {}
		}
		
		return -2; // DB Error
	}
	
	public User getUser(String userID) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "SELECT * FROM user WHERE USERID='"+userID+"'";
			
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			User loginUser = new User();
			
			if(rs.next()) {
				loginUser.setUserID(rs.getString(1));
				// System.out.println("getUser:user.getUserID" + loginUser.getUserID());
				loginUser.setUserPassword(rs.getString(2));
				loginUser.setUserName(rs.getString(3));
				loginUser.setUserGender(rs.getString(4));
				loginUser.setUserEmail(rs.getString(5));
				return loginUser;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null)
				try { pstmt.close(); } catch (SQLException ex) {}
			if (conn != null)
				try { conn.close();	} catch (SQLException ex) {}
		}
		// System.out.println("return: -1");
		return null;
	}
	
	public int update(User user)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String SQL = "UPDATE user SET userPassword = ?, userName = ?, userGender = ?, userEmail = ? where userID = ?";
			
//			System.out.println(SQL);
//			System.out.println(user.getUserPassword());
//			System.out.println(user.getUserGender());
//			System.out.println(user.getUserName());
//			System.out.println(user.getUserEmail());
//			System.out.println(user.getUserID());
//			
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserPassword());
			pstmt.setString(2, user.getUserName());
			pstmt.setString(3, user.getUserGender());
			pstmt.setString(4, user.getUserEmail());
			pstmt.setString(5, user.getUserID());
			return pstmt.executeUpdate();
			
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch (SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
			if (conn != null) try { conn.close(); } catch (SQLException ex) {}
		}
		return -1; // DB Error
	}
	
	
	public int delete(String userID)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String SQL = "delete from user where userID = ?";
			
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			return pstmt.executeUpdate();
			
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch (SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
			if (conn != null) try { conn.close(); } catch (SQLException ex) {}
		}
		return -1; // DB Error
	}
}
