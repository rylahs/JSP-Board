<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DAO.UserDBBean" %>
<%@ page import="DTO.User" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="user" class="DTO.User" scope="page"/>
	<jsp:setProperty name="user" property="userID" />
	<jsp:setProperty name="user" property="userPassword" />
	<jsp:setProperty name="user" property="userName" />
	<jsp:setProperty name="user" property="userGender" />
	<jsp:setProperty name="user" property="userEmail" />


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
		if (userID != null)	{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp"); // 메인으로 보내기
			script.println("</script>");
		}
		if (user.getUserID() == null || user.getUserID().equals("")
		|| user.getUserPassword() == null || user.getUserPassword().equals("")
		|| user.getUserName() == null || user.getUserName().equals("")
		|| user.getUserGender() == null || user.getUserGender().equals("")
		|| user.getUserEmail() == null || user.getUserEmail().equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력 안된 사항이 있습니다.')");
			script.println("history.back()"); // 이전 페이지로 돌려보내기
			script.println("</script>");
		} else {
			UserDBBean userDAO = UserDBBean.getInstance(); 
			// Result
			// 1 : Success
			// 0 : Password MisMatch
			// -1 : ID not Found
			// -2 : DB Error
			int result = userDAO.join(user); 
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()"); // 이전 페이지로 돌려보내기
				script.println("</script>");
			}
			else {
				// 세션
				session.setAttribute("userID", user.getUserID());
				
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
		}
			


			
	%>
	
</body>
</html>