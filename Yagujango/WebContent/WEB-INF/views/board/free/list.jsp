<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.tablediv {
	
	text-align: center;
	margin-left: auto;
    margin-right: auto;
}

</style>
</head>
<body>
<div class="tablediv">
<table class="table table-striped table-hover table-condensed">
<thead>
	<tr>
		
		<th style="width: 10%;">글번호</th>
		<th style="width: 45%;">제목</th>
		<th style="width: 15%;">작성자</th>
		<th style="width: 10%;">조회수</th>
		<th style="width: 20%;">작성일</th>
	</tr>
</thead>
<tbody>
<c:forEach items="${list}" var="i">
	<tr>
		<td>${i.boardno }</td>
		<td>
			<c:if test="${i.tag eq '공지' }">
			[${i.tag }]${i.title }</a>
			</c:if>
			<c:if test="${i.tag ne '공지' }">
			[${i.tag}]<a href="/board/free/view?boardno=${i.boardno}"  >${i.title }</a>
			</c:if>
		</td>
		<td>${i.writer }</td>
		<td>${i.hit }</td>
		<td><fmt:formatDate value="${i.writtendate }" pattern="yyyy-MM-dd" /></td>
	</tr>
</c:forEach>
</tbody>
</table>
</div>
</body>
</html>