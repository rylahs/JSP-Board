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
		} else {
			if (bbs.getBbsTitle() == null || bbs.getBbsTitle().equals("") 
					|| bbs.getBbsContent() == null || bbs.getBbsContent().equals("")) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('입력 안된 사항이 있습니다.')");
						script.println("history.back()"); // 이전 페이지로 돌려보내기
						script.println("</script>");
					} else {
						BbsDBBean bbsDAO = BbsDBBean.getInstance();
						// Result
						// 1 : Success
						// 0 : Password MisMatch
						// -1 : ID not Found
						// -2 : DB Error
						int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent()); 
						if (result == -1) {
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('글쓰기에 실패헀습니다.')");
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
	
		}
					


			
	%>
	
</body>
</html>