<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp"/>

<script type="text/javascript">
$(document).ready(function() {
	//작성버튼 동작
	$("#btnUpdate").click(function() {
		$("form").submit();
	});
	//취소버튼동작
	$("#btnCancel").click(function() {
 		history.go(-1);
	});
	
});
</script>

<div class = "container">
<h1>답변수정</h1>
<hr>

<div class="wrap"></div>
<hr>

<div class="wrap">
<form action="/answer/update" method="post" method="post">
<input type="hidden" name="answerno" value="${answerBoard.answerno}" />
<table class="table table-striped table-hover table-condensed">
<tbody>
	<tr>
		<td class="info">NO.</td>
		<td colspan="3">${answerBoard.answerno}</td>
	</tr>
	<tr>
		<td class="info">접수번호</td>
		<td colspan="3">${answerBoard.boardno}</td>
	</tr>
	
	<tr>
		<td class="info">회원아이디</td>
		<td>${answerBoard.writer_userid}</td>
	</tr>
	
		<tr>
		<td class="info">문의내용</td>
	</tr>
	<tr>
		<td colspan="4">${viewcontent}</td>
	</tr>

	<tr>
		<td class="info">답변내용</td>
	</tr>
	<tr><td colspan="2">답변작성
		<textarea id="content" name="content" rows="10" cols="100">${answerBoard.content}</textarea>
	</td></tr>
	
	<tr>
		<td class="info">작성일</td>
		<td colspan="3">${viewdate}</td>
	</tr>
	</tbody>
</table>
</form>
</div>
<div class="text-center">
<button id="btnUpdate" class="btn btn-update">수정하기</button>
<button id="btnCancel" class="btn btn-danger">취소</button>
</div>
</div>

<c:import url="/WEB-INF/views/layout/footer.jsp"/>