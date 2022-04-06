<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="DAO.UserDBBean" %>
<%@ page import="DTO.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>

<title>JSP</title>
</head>
<body>
	<%
		String userID = null;
		User currentUser = new User();
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'"); // 메인으로 보내기
			script.println("</script>");
		}
		else {
			UserDBBean userDAO = UserDBBean.getInstance();
			currentUser = userDAO.getUser(userID);
			
			if (!userID.equals(currentUser.getUserID())) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('권한이 없습니다.')");
				script.println("location.href = 'login.jsp'"); // 메인으로 보내기
				script.println("</script>");
			}
		%>
		<nav class="navbar navbar-default">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collpase-1"
					aria-expanded="false">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="main.jsp">미니 교보문고</a>
			</div>
			<div class="collapse navbar-collapse" id="bs-example-navbar-collpase-1">
				<ul class="nav navbar-nav">
					<li><a href="main.jsp">메인</a></li>
					<li><a href="bbs.jsp">공지사항</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">회원관리<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="userUpdate.jsp">회원정보 수정</a></li>
							<li class="active"><a href="userDelete.jsp">회원 탈퇴</a></li>
							<li><a href="logoutAction.jsp">로그아웃</a></li>
						</ul>
						
					</li>
				</ul>
			</div>
		</nav>
			<div class="container">
			<div class="col-lg-4"></div>
			<div class="col-lg-4">
				<div class="jumbotron" style="padding-top: 20px;">
					<form method="post" action="userDeleteAction.jsp">
						<h3 style="text-align:center;">회원 탈퇴</h3>
						<div class="form-group">
							<input type="text" class="form-control" placeholder="아이디" name="userID" value="<%=currentUser.getUserID()%>" maxlength="20" readonly>
						</div>
						<div class="form-group">
							<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
						</div>
						<input type="submit" class="btn btn-primary form-control" value="회원탈퇴">
					</form>
		</div>
	<%} %>
</body>
</html>