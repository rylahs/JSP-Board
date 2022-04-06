<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="DAO.UserDBBean" %>
<%@ page import="DTO.User" %>

<% request.setCharacterEncoding("UTF-8"); %>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<%
		String userID = null;
		User currentUser = new User();
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
		currentUser = userDAO.getUser(userID);
		
		if (!userID.equals(currentUser.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'login.jsp'"); // 메인으로 보내기
			script.println("</script>");
		}
		else {
			if (request.getParameter("userID") == null || request.getParameter("userID").equals("") 
				|| request.getParameter("userPassword") == null || request.getParameter("userPassword").equals("")
				|| request.getParameter("userName") == null || request.getParameter("userName").equals("")
				|| request.getParameter("userGender") == null || request.getParameter("userGender").equals("")
				|| request.getParameter("userEmail") == null || request.getParameter("userEmail").equals("")) {
				
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력 안된 사항이 있습니다.')");
				script.println("history.back()"); // 이전 페이지로 돌려보내기
				script.println("</script>");
			} else {
				// Result
				// 1 : Success
				// 0 : Password MisMatch
				// -1 : ID not Found
				// -2 : DB Error
				
				if (request.getParameter("userPassword") != null) {
					currentUser.setUserPassword(request.getParameter("userPassword"));
				}
				if (request.getParameter("userName") != null) {
					currentUser.setUserName(request.getParameter("userName"));
				}
				if (request.getParameter("userGender") != null) {
					currentUser.setUserGender(request.getParameter("userGender"));
				}
				if (request.getParameter("userEmail") != null) {
					currentUser.setUserEmail(request.getParameter("userEmail"));
				}
				
				
				int result = userDAO.update(currentUser); 
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('회원 정보 수정이 실패헀습니다.')");
					script.println("history.back()"); // 이전 페이지로 돌려보내기
					script.println("</script>");
				}
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'main.jsp'");
					script.println("</script>");
				}
			}
	
		}
	%>
</body>
</html>