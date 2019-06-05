<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp"/>

<script type="text/javascript">
$(document).ready(function() {
	//목록버튼동작
	$("#btnBoardList").click(function() {
 		$(location).attr("href","/answer/list");
	});
	
	//수정하기
	$("#btnUpdate").click(function() {
  		$(location).attr("href","/answer/board_1to1_write?boardno=${viewBoard.boardno}");
	});
	//삭제버튼동작
	$("#btnDelete").click(function() {
 		$(location).attr("href","/admin/delete?boardno=${viewBoard.boardno}");
	});
	
});
</script>

<div class = "container">
<h1>답변확인</h1>
<hr>

<div class="wrap"></div>
<hr>

<div class="wrap">
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
	<tr>
		<td colspan="4">${answerBoard.content}</td>
	</tr>
	
	<tr>
		<td class="info">작성일</td>
		<td colspan="3">${viewBoard.writtendate}</td>
	</tr>
	</tbody>
</table>
</div>
<div class="text-center">
<button id="btnBoardList" class="btn btn-list">1:1문의목록</button>
<button id="btnUpdate" class="btn btn-update">수정하기</button>
<button id="btnDelte" class="btn btn-danger">삭제</button>
</div>
</div>

<c:import url="/WEB-INF/views/layout/footer.jsp"/>