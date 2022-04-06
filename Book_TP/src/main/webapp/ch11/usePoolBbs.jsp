<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "javax.naming.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Connection Pool을 사용한 테이블의 레코드들을 화면에 표시하기</title>
</head>
<body>
	<h3>Connection Pool을 사용한 테이블의 레코드들을 화면에 표시하기</h3>
	<table border="1">
		<tr>
			<td width="100">글 번호</td>
			<td width="150">제목</td>
			<td width="100">작성자</td>
			<td width="250">작성일자</td>
			<td width="500">내용</td>
			<td width="100">삭제유무</td>
			<td width="100">조회</td>
		</tr>
		
		<%
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				Context initCtx = new InitialContext();
				Context envCtx = (Context)initCtx.lookup("java:comp/env");
				DataSource ds = (DataSource)envCtx.lookup("jdbc/book_tp");
				conn = ds.getConnection();
				
				String sql = "select * from bbs order by bbsID desc";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					int bbsID = rs.getInt("bbsID");
					String bbsTitle = rs.getString("bbsTitle");
					String userID = rs.getString("userID");
					Timestamp bbsDate = rs.getTimestamp("bbsDate");
					String bbsContent = rs.getString("bbsContent");
					int bbsAvailable = rs.getInt("bbsAvailable");
					int bbsViewCount = rs.getInt("bbsViewCount");
			%>
			
			<tr>
				<td width="100"><%=bbsID %></td>
				<td width="250"><%=bbsTitle %></td>
				<td width="100"><%=userID %></td>
				<td width="200"><%=bbsDate.toString() %></td>
				<td width="500"><%=bbsContent %></td>
				<td width="100"><%=bbsAvailable %></td>
				<td width="100"><%=bbsViewCount %></td>
			</tr>
			<%
				}
			} catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				if (rs != null)
					try { rs.close(); } catch (SQLException e) {}
				if (pstmt != null)
					try { pstmt.close(); } catch (SQLException e) {}
				if (conn != null)
					try { conn.close(); } catch (SQLException e) {}
			}
			%>
			

	</table>
</body>
</html>