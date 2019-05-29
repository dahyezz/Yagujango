<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class ="container">
<h1>게시판 - VIEW</h1>
<hr>

<div class="wrap">
<table class="table table-striped table-hover table-condensed">
<tbody>
	<tr>
		<td class="info">글번호</td>
		<td colspan="3">${board.boardno }</td>
	</tr>
	<tr>
		<td class="info">제목</td>
		<td colspan="3">${board.title }</td>
	</tr>
	<tr>
		<td class="info">아이디</td>
		<td>${board.writer }</td>
		<td class="info">닉네임</td>
		<td>[추후 추가]</td>
	</tr>
	<tr>
		<td class="info">조회수</td>
		<td>${board.hit }</td>
		<td class="info">추천수</td>
		<td id="recommend">${recommendcnt}</td>
	</tr>
	<tr>
		<td class="info">작성일</td>
		<td colspan="3">${board.writtendate }</td>
	</tr>
	<tr>
		<td class="info" colspan="4">본문</td>
	</tr>
	<tr>
		<td colspan="4">${board.content }</td>
	</tr>
</tbody>
</table>


<div class="text-center">	
<button id="btnList" class="btn btn-primary">목록</button>
<c:if test="${userid eq board.writer && login eq true}">
<button id="btnUpdate" class="btn btn-primary">수정</button>
<button id="btnDelete" class="btn btn-primary">삭제</button>
</c:if>
</div>
</div>
</div>
</body>
</html>