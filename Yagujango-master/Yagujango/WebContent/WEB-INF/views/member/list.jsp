<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script type="text/javascript">
$(document).ready(function() {
	
	//글쓰기 버튼 누르면 이동
	$("#btnList").click(function() {
		location.href="/board/mem_blacklist";
	});
	
});
</script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원목록</title>
</head>
<body>

<h1>회원</h1>
<hr>

<button id="btnList" class="btn btn-blacklist">블랙리스트</button>

<table class="table table-striped table-hover table-condensed">
<thead>
	<tr>
		<th style="width: 5%;">번호</th>
		<th style="width: 10%;">아이디</th>
		<th style="width: 10%;">비밀번호</th>		
		<th style="width: 10%;">이름</th>
		<th style="width: 10%;">닉네임</th>
		<th style="width: 10%;">생년월일</th>
		<th style="width: 10%;">성별</th>
		<th style="width: 10%;">번호</th>
		<th style="width: 10%;">이메일</th>
		<th style="width: 5%;">경고횟수</th>
		<th style="width: 15%;">마이팀</th>
	</tr>
</thead>
<c:forEach items="${list}" var="m">
	<tr>
		<td>${m.userno }</td>
		<td>${m.userid }</td>
		<td>${m.userpw }</td>
		<td>${m.username }</td>
		<td>${m.usernick }</td>
		<td><fmt:formatDate value="${m.birth }" pattern="yyyy-MM-dd" /></td>
		<td>${m.gender }</td>
		<td>${m.phone }</td>
		<td>${m.email }</td>
		<td>${m.penalty }</td>
		<td>${m.myteam }</td>

	</tr>
</c:forEach>
</table>

</body>
</html>