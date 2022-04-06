<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert Record</title>
</head>
<body>
	<h2>user 테이블에 레코드 추가</h2>
	
	<form method="post" action="insertTestPro.jsp">
		아이디 : <input type="text" name="userID" maxlength="20"> <br>
		패스워드 : <input type="password" name="userPassword" maxlength="20"> <br>
		이름 : <input type="text" name="userName" maxlength="20"> <br>
		성별 : <input type="text" name="userGender" maxlength="20"> <br>
		E-mail : <input type="text" name="userEmail" maxlength="50"> <br>
		<input type="submit" value="입력 완료">
	</form>
</body>
</html>