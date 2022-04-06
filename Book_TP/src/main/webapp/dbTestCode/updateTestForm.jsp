<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Query</title>
</head>
<body>
	<h2>user Table Data Update</h2>
	
	<form method="post" action="updateTestPro.jsp">
		아이디 : <input type="text" name="userID" maxlength="20"> <br>
		패스워드 : <input type="password" name="userPassword" maxlength="20"> <br>
		이름 : <input type="text" name="userName" maxlength="20"> <br>
		<input type="submit" value="입력 완료">
		
	
	</form>
</body>
</html>