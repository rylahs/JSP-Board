package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import DTO.Bbs;


public class BbsDBBean {
	private static BbsDBBean instance = new BbsDBBean();
	public static BbsDBBean getInstance() {
		return instance;
	}	
	
	public BbsDBBean() {}
	
	private Connection getConnection()
			throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/book_tp");
		return ds.getConnection();
	}
	
	// 날짜를 얻어내는데 사용
	public String getDate() 
			throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT NOW()";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				return rs.getString(1);
			}
			
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch (SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
			if (conn != null) try { conn.close(); } catch (SQLException ex) {}
		}
		return ""; // DB Error
	}
	
	
	// 다음 작성될 글 번호
	public int getNext() 
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT bbsID FROM bbs WHERE bbsAvailable = 1 ORDER BY bbsID DESC";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫 게시물
			
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch (SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
			if (conn != null) try { conn.close(); } catch (SQLException ex) {}
		}
		return -1; // DB Error
	}
	
	// 글 작성
	public int write(String bbsTitle, String userID, String bbsContent) 
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "INSERT INTO bbs(bbsTitle, userID, bbsDate, bbsContent, bbsAvailable) "
				+ "VALUES(?, ?, ?, ?, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, userID);
			pstmt.setString(3, getDate());
			pstmt.setString(4, bbsContent);
			pstmt.setInt(5, 1);
			return pstmt.executeUpdate();
			
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch (SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
			if (conn != null) try { conn.close(); } catch (SQLException ex) {}
		}
		return -1;
	}
	
	// getArticleCount : 전체 유효 게시물 수 반환
	public int getArticleCount() 
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT COUNT(*) FROM bbs WHERE bbsAvailable = 1";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				return rs.getInt(1);
			}
			return 1; // 첫 게시물
			
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch (SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
			if (conn != null) try { conn.close(); } catch (SQLException ex) {}
		}
		return -1; // DB Error
	}
	
	
	// 글 목록 불러오기
	public ArrayList<Bbs> getList(int pageNumber, int count) 
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM BBS WHERE bbsAvailable = 1 ORDER BY bbsID DESC LIMIT ?, ?";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * count);
			pstmt.setInt(2, count);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setBbsViewCount(rs.getInt(7));
				list.add(bbs);
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch (SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
			if (conn != null) try { conn.close(); } catch (SQLException ex) {}
		}
		return list;
	}
	
	
	public int getArticleSearchCount(String searchCategory,String searchString) 
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT COUNT(*) FROM bbs where bbsAvailable = 1 AND " + searchCategory + " LIKE ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + searchString + "%");
			System.out.println("카테고리 : " + searchCategory);
			System.out.println("검색어 : " + searchString);
			System.out.println("SQL : " + SQL);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				System.out.println("검색 숫자 : " + rs.getInt(1));
				return rs.getInt(1);
			}
			return 1; // 첫 게시물
			
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch (SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
			if (conn != null) try { conn.close(); } catch (SQLException ex) {}
		}
		return -1; // DB Error
	}
	
	// 글 목록 불러오기
		public ArrayList<Bbs> getListString(int pageNumber, int count, String searchCategory, String searchString) 
				throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String SQL = "SELECT * FROM BBS WHERE " + searchCategory + " LIKE ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT ?, ?";
			ArrayList<Bbs> list = new ArrayList<Bbs>();
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(SQL);				
				pstmt.setString(1, "%" + searchString.toString() + "%");
				pstmt.setInt(2, (pageNumber - 1) * count);
				pstmt.setInt(3, count);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					Bbs bbs = new Bbs();
					bbs.setBbsID(rs.getInt(1));
					bbs.setBbsTitle(rs.getString(2));
					bbs.setUserID(rs.getString(3));
					bbs.setBbsDate(rs.getString(4));
					bbs.setBbsContent(rs.getString(5));
					bbs.setBbsAvailable(rs.getInt(6));
					bbs.setBbsViewCount(rs.getInt(7));
					list.add(bbs);
				}
			} catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				if (rs != null) try { rs.close(); } catch (SQLException ex) {}
				if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
				if (conn != null) try { conn.close(); } catch (SQLException ex) {}
			}
			return list;
		}
	
	
	
	public boolean nextPage(int pageNumber) 
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 5";
		try {
//			System.out.println("GETNEXT() : " + getNext());
//			System.out.println("PAGENUMBER - 1 : " + (pageNumber - 1));
//			System.out.println("SQL INNER NUMBEr : " + (getNext() - (pageNumber - 1) * 5));
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 5);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch (SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
			if (conn != null) try { conn.close(); } catch (SQLException ex) {}
		}
		
		return false;

	}
	
	public Bbs getBbs(int bbsID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setBbsViewCount(rs.getInt(7));
				return bbs;
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch (SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
			if (conn != null) try { conn.close(); } catch (SQLException ex) {}
		}
		
		return null;
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent)
			throws Exception {
//		System.out.println("BBSID : " + bbsID);
//		System.out.println("BBSTITLE :" + bbsTitle);
//		System.out.println("BBSCONTENT\n" + bbsContent);
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? where bbsID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
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
	
	public int delete (int bbsID) 
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "UPDATE BBS SET bbsAvailable = 0 where bbsID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
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
	
	public int updateViewCnt (int bbsID, int currentViewCnt) 
			throws Exception {
//		System.out.println("뷰 카운트 : " + currentViewCnt);
		currentViewCnt++;
//		System.out.println("뷰 카운트 after : " + currentViewCnt);
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String SQL = "UPDATE BBS SET bbsViewCount = ? where bbsID = ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);			
			pstmt.setInt(1, currentViewCnt);
			pstmt.setInt(2, bbsID);
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
