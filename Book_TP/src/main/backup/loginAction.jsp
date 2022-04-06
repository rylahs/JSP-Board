<%@page import="DAO.UserDBBean"%>
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
<link rel="stylesheet" href="css/custom.css">

<title>JSP</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID != null)	{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp"); // 메인으로 보내기
			script.println("</script>");
		}
		UserDBBean userDAO = UserDBBean.getInstance();
		// Result
		// 1 : Success
		// 0 : Password MisMatch
		// -1 : ID not Found
		// -2 : DB Error
		int result = userDAO.login(user.getUserID(), user.getUserPassword()); 
		if (result == 1) {
			// 세션
			session.setAttribute("userID", user.getUserID());
			// 이동
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		else if (result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()"); // 이전 페이지로 돌려보내기
			script.println("</script>");
		}
		else if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()"); // 이전 페이지로 돌려보내기
			script.println("</script>");
		}
		else if (result == -2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()"); // 이전 페이지로 돌려보내기
			script.println("</script>");
		}
			
	%>
	
</body>
</html>