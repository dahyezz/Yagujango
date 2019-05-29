<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp"/>

<script type="text/javascript">
$(document).ready(function() {
	
	//글쓰기 버튼 누르면 이동
	$("#btnList").click(function() {
		location.href="";
	});
	
});
</script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의내역 확인</title>
</head>
<body>

<h1>1:1 문의내역 확인</h1>
<hr>

<button id="List" class="btn btn-list">회원리스트</button>

<table class="table table-striped table-hover table-condensed">
<thead>
	<tr>
		<th style="width: 10%;">접수번호</th>
		<th style="width: 10%;">아이디</th>
		<th style="width: 30%;">제목</th>		
		<th style="width: 10%;">문의일시</th>
		<th style="width: 10%;">처리유무</th>


	</tr>
</thead>
<c:forEach items="${mlist}" var="m">
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



<c:import url="/WEB-INF/views/layout/footer.jsp"/>