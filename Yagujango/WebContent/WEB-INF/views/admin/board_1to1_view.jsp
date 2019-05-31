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
	//삭제버튼동작
	$("#btnDelete").click(function() {
 		$(location).attr("href","/admin/delete?boardno=${viewBoard.boardno}");
	});
	
});
</script>


<h1 class="pull-left">1:1 문의내역 확인</h1>
<hr>

<div class="clearfix"></div>

<table class="table table-bordered">

<tr>
<td class="info">접수번호</td><td clospan="3">${viewBoard.boardno}</td>
</tr>

<tr>
<td class="info">아이디</td><td>${viewBoard.writer_userid}</td>
</tr>

<tr>
<td class="info">작성일</td><td clospan="3">${viewBoard.writtendate}</td>
</tr>

<tr>
<td class="info">제목</td><td clospan="3">${viewBoard.title}</td>
</tr>

<tr><td class="info">본문</td></tr>
<tr><td clospan="4">${viewBoard.content}</td></tr>

</table>

<div class="text-center">
<button id="btnBoardList" class="btn btn-list">회원리스트</button>
<button id="btnDelte" class="btn btn-danger">삭제</button>

</div>

<c:import url="/WEB-INF/views/layout/footer.jsp"/>