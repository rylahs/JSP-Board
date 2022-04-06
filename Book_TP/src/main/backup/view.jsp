<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="DAO.BbsDBBean" %>
<%@ page import="DTO.Bbs" %>


<jsp:useBean id="bbs" class="DTO.Bbs" scope="page"/>
	<jsp:setProperty name="bbs" property="bbsTitle" />
	<jsp:setProperty name="bbs" property="bbsContent" />
	<jsp:setProperty name="bbs" property="bbsAvailable"/>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>

<title>JSP</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		
		int bbsID = 0;
		
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));	
		}
		
		// 글 목록이 없을 떄
		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'"); // 메인으로 보내기
			script.println("</script>");
		}
		BbsDBBean bbsDAO = BbsDBBean.getInstance();
		bbs = bbsDAO.getBbs(bbsID);
		
		System.out.println(bbsID + "     " + bbs.getBbsAvailable());
		
		// 강제적으로 글 번호로 삭제된 글을 보려 하는 경우
		if (bbs.getBbsAvailable() == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'"); // 메인으로 보내기
			script.println("</script>");
		}
		else {
			bbsDAO.updateViewCnt(bbs.getBbsID(), bbs.getBbsViewCount());
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
				<li class="active"><a href="bbs.jsp">공지사항</a></li>
			</ul>
			<%
				if(userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
					
				</li>
			</ul>
			<%
				} else {
			%>
						<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="userUpdate.jsp">회원정보 수정</a></li>
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
					
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	
	<div class="container">
		<div class="row">
			<table class="table table-hover table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%= bbs.getBbsTitle().replaceAll("&", "&amp;").replaceAll("#", "&#35;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("%", "&#37;").replaceAll("\"", "&quot;").replaceAll("'", "&#39;").replaceAll(" ", "&nbsp;").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%= bbs.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11,13) + ":" + bbs.getBbsDate().substring(14,16) + ":" + bbs.getBbsDate().substring(17,19)%> </td>
					</tr>    
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left">
							<%= bbs.getBbsContent().replaceAll("&", "&amp;").replaceAll("#", "&#35;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("%", "&#37;").replaceAll("\"", "&quot;").replaceAll("'", "&#39;").replaceAll(" ", "&nbsp;").replaceAll("\n", "<br>") %>
						</td>
					</tr>
				</tbody>
			</table>
			<a href="bbs.jsp" class="btn btn-primary">목록</a>
			<%
				if(userID != null && userID.equals(bbs.getUserID())) { // 본인이라면 삭제
			%>
				<a href="update.jsp?bbsID=<%= bbsID%>" class="btn btn-primary">수정</a>
				<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID%>" class="btn btn-primary">삭제</a>
			<%
				}
			%>
			<input type="submit" class="btn btn-primary pull-right" value="글쓰기">

			
			<%
		}
			%>
		</div>
	</div>
	
	
</body>
</html>