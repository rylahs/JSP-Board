<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>

<title>JSP</title>
</head>
<body>
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
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li class="active"><a href="join.jsp">회원가입</a></li>
					</ul>
					
				</li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-5">
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="joinAction.jsp">
					<h3 style="text-align:center;">회원가입</h3>
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
										<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">비밀번호&nbsp;&nbsp;&nbsp; </th>
								<td>
									<div class="form-group">
										<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">이름 </th>
								<td>
									<div class="form-group">
										<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20">
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">성별 </th>
								<td>
									<div class="form-group">
										<div class="btn-group" data-toggle="buttons">
											<label class="btn btn-primary active">
												<input type="radio" name="userGender" autocomplete="off" value="남성" checked>남성
											</label>
											<label class="btn btn-primary">
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
										<input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="28">
									</div>
								</td>
							</tr>
						</tbody>
					</table>
					<input type="submit" class="btn btn-primary form-control" value="회원가입">
				</form>
				
	</div>
	
</body>
</html>