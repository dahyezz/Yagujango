<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp"/>

<script type="text/javascript">
$(document).ready(function() {
	//목록버튼동작
	$("#btnBoardList").click(function() {
 		$(location).attr("href","/admin/board_1to1");
	});
	
	//답변하기
	$("#btnUpdate").click(function() {
  		$(location).attr("href","/admin/board_1to1_update?boardno=${viewBoard.boardno}");
	});
	//삭제버튼동작
	$("#btnDelete").click(function() {
 		$(location).attr("href","/admin/delete?boardno=${viewBoard.boardno}");
	});
	
});
</script>

<div class = "container">
<h1>1:1 문의내역 확인</h1>
<hr>

<div class="wrap"></div>
<hr>

<div class="wrap">
<table class="table table-striped table-hover table-condensed">
<tbody>
	<tr>
		<td class="info">접수번호</td>
		<td colspan="3">${viewBoard.boardno}</td>
	</tr>
	
	<tr>
		<td class="info">아이디</td>
		<td>${viewBoard.writer_userid}</td>
	</tr>
	
	<tr>
		<td class="info">이메일</td>
		<td colspan="3">${viewBoard.writer_email}</td>
	</tr>

	<tr>
		<td class="info">제목</td>
		<td colspan="3">${viewBoard.title}</td>
	</tr>

	<tr>
		<td class="info">본문</td>
	</tr>
	<tr>
		<td colspan="4">${viewBoard.content}</td>
	</tr>
	
		<tr>
		<td class="info">처리유무</td>
		<td colspan="3">${viewBoard.writer_comment}</td>
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
<button id="btnUpdate" class="btn btn-update">답변하기</button>
<button id="btnDelte" class="btn btn-danger">삭제</button>
</div>
</div>

<c:import url="/WEB-INF/views/layout/footer.jsp"/>