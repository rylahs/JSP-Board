<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="DAO.UserDBBean" %>
<%@ page import="DTO.User" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>

<title>Insert title here</title>
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
						<li class="active"><a href="userUpdate.jsp">회원정보 수정</a></li>
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
					
				</li>
			</ul>
		</div>
	</nav>
	
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-5">
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="userUpdateAction.jsp">
					<h3 style="text-align:center;">회원정보 수정</h3>
					<table class="table table-condensed">
						<thead>
							<tr>
							<th scope="col"></th>
							<th scope="col"></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th scope="row">아이디 </th>
								<td>
									<div class="form-group">
										<input type="text" class="form-control" placeholder="아이디" name="userID" value="<%=currentUser.getUserID()%>" maxlength="20" readonly>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">비밀번호&nbsp;&nbsp;&nbsp; </th>
								<td>
									<div class="form-group">
										<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20" >
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">이름 </th>
								<td>
									<div class="form-group">
										<input type="text" class="form-control" placeholder="이름" name="userName" value="<%=currentUser.getUserName()%>" maxlength="20">
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">성별 </th>
								<td>
									<div class="form-group">
										<div class="btn-group" data-toggle="buttons">
											<%
												if(currentUser.getUserGender().equals("남성")) {
											%>
											<label class="btn btn-primary active">
											<%
												} else {
											%>
											<label class="btn btn-primary">
											<%
												}
											%>
												<input type="radio" name="userGender" autocomplete="off" value="남성" checked>남성
											</label>
<%
												if(currentUser.getUserGender().equals("여성")) {
											%>
											<label class="btn btn-primary active">
											<%
												} else {
											%>
											<label class="btn btn-primary">
											<%
												}
											%>
												<input type="radio" name="userGender" autocomplete="off" value="여성" checked>여성
											</label>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">E-mail </th>
								<td>
									<div class="form-group" style="text-align: center;">
										<input type="email" class="form-control" placeholder="이메일" name="userEmail" value="<%=currentUser.getUserEmail()%>" maxlength="28">
									</div>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="sumit_type" style="padding-bottom: 10px;">
					<input type="submit" class="btn btn-primary form-control" value="회원 정보 변경">
					</div>
					<input type="button" class="btn btn-primary form-control" value="취소" OnClick="history.back()">
				</form>
			</div>
		<div class="col-lg-4"></div>
	</div>

</body>
</html>