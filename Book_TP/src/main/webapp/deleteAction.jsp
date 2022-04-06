<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DAO.BbsDBBean" %>
<%@ page import="DTO.Bbs" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="bbs" class="DTO.Bbs" scope="page"/>
	<jsp:setProperty name="bbs" property="bbsTitle" />
	<jsp:setProperty name="bbs" property="bbsContent" />
	


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
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));	
		}
		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'"); // 메인으로 보내기
			script.println("</script>");
		}
		BbsDBBean bbsDAO = BbsDBBean.getInstance();
		bbs = bbsDAO.getBbs(bbsID);
		
		if (!userID.equals(bbs.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bbs.jsp'"); // 메인으로 보내기
			script.println("</script>");
		}
		else {
			int result = bbsDAO.delete(bbsID);
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 삭제가 실패헀습니다.')");
				script.println("history.back()"); // 이전 페이지로 돌려보내기
				script.println("</script>");
			}
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'bbs.jsp'");
				script.println("</script>");
			}

		}
					


			
	%>
	
</body>
</html>