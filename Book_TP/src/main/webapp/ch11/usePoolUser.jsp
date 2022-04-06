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
			<td width="100">ID</td>
			<td width="150">비밀번호</td>
			<td width="100">이름</td>
			<td width="50">성별</td>
			<td width="250">이메일</td>
		</tr>
		
		<%
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				int cnt = 1;
				Context initCtx = new InitialContext();
				Context envCtx = (Context)initCtx.lookup("java:comp/env");
				DataSource ds = (DataSource)envCtx.lookup("jdbc/book_tp");
				conn = ds.getConnection();
				
				String sql = "select * from user";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					String userID = rs.getString("userID");
					String userPassword = rs.getString("userPassword");
					String userName = rs.getString("userName");
					String userGender = rs.getString("userGender");
					String userEmail = rs.getString("userEmail");
					
			%>
			
			<tr>
				<td width="100"><%=userID %></td>
				<td width="150"><%=userPassword %></td>
				<td width="100"><%=userName %></td>
				<td width="50"><%=userGender %></td>
				<td width="250"><%=userEmail %></td>

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