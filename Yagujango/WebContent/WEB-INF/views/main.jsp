<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Yagujango</title>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&display=swap&subset=korean" rel="stylesheet">

<style type="text/css">


#main {
	color: #5050FF;
	font-family: "Nanum Gothic", sans-serif;
	font-weight: 800;
	font-size: 40px;
	text-align: center;
}


</style>
</head>
<body>


<div id="headerDiv">
	<p id="main">야구장고</p>
</div>

<hr>

<c:if test="${empty login }">
	<strong>로그인이 필요합니다</strong><br>
	<button onclick="location.href='/member/login';">로그인</button>
	<button onclick="location.href='/member/join';">회원가입</button>
</c:if>

<c:if test="${login }">
	${userid }님, 접속을 환영합니다.
	<button onclick="location.href='/member/logout';">로그아웃</button>
</c:if>

</body>
</html>
