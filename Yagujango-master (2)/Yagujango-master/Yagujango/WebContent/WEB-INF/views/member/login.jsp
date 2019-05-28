<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>로그인 페이지</h1>
<form action="/member/login" method="post">
	<label>아이디 : <input type="text" name="userid" /></label><br>
	<label>비밀번호 : <input type="password" name="userpw" /></label><br><br>
	<a href="/member/idfind">아이디 찾기</a>&nbsp;
	<a href="/member/pwfind">비밀번호 찾기</a>&nbsp;
	<a href="/member/joininfo">회원가입</a><br><br>
	
	<button>로그인</button>
</form>

</body>
</html>