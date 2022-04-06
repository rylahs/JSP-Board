<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DAO.UserDBBean" %>
<%@ page import="DTO.User" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="user" class="DTO.User" scope="page"/>
	<jsp:setProperty name="user" property="userID" />
	<jsp:setProperty name="user" property="userPassword" />
	
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null)	{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요')");
			script.println("location.href = 'login.jsp'"); // 메인으로 보내기
			script.println("</script>");
		} 
		UserDBBean userDAO = UserDBBean.getInstance();
		// Result
		// 1 : Success
		// 0 : Password MisMatch
		// -1 : ID not Found
		// -2 : DB Error
		String curUserID = request.getParameter("userID");
		String curUserPassword = request.getParameter("userPassword");
		
		int result = userDAO.login(curUserID, curUserPassword);
		
		if (result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 맞지 않습니다.')");
			script.println("location.href = 'userDelete.jsp'");
			script.println("</script>");
		} else if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('아이디가 맞지 않습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		} else if (result == -2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 아이디 입니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		} else if (result == 1) {
			int quitResult = userDAO.delete(curUserID);
			if (quitResult == 1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('회원 탈퇴에 성공했습니다. 지금까지 이용해주셔서 감사합니다.')");
				script.println("location.href = 'main.jsp'"); 
				script.println("</script>");
				session.invalidate();
			} else if (quitResult == 0) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('삭제에 실패했습니다.')");
				script.println("location.href = 'main.jsp'"); 
				script.println("</script>");
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('데이터 베이스 에러입니다.')");
				script.println("location.href = 'main.jsp'"); 
				script.println("</script>");
			}
				
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 페이지 입니다.')");
			script.println("location.href = 'main.jsp'"); // 메인으로 보내기
			script.println("</script>");	
		}
			
	%>
	
	
	
</body>
</html>