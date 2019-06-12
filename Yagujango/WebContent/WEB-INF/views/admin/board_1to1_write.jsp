<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp"/>

<script type="text/javascript">
$(document).ready(function() {
	
	//답변하기
	$("#btnWrite").click(function() {
		$("form").submit();
		alert("답변완료")
	});
	//취소버튼동작
	$("#btnCancel").click(function() {
 		history.go(-1);
	});
	
});
</script>

<style type="text/css">
#content {
	width: 100%;
}
</style>

<div class="container">

<h1>1:1 문의 답변작성</h1>
<hr>

<div class="wrap"></div>
<hr>

<input type="hidden" name="email" id="email" value="${viewBoard.writer_email }"/>


<div>
<form action="/admin/board_1to1_write" method="post">
<input type="hidden" name="boardno" value="${viewBoard.boardno}" />
<input type="hidden" name="email" id="email" value="${viewBoard.writer_email }"/>
<input type="hidden" name="title" id="title" value="${viewBoard.title }" />

<table class="table table-bordered">
	<tr><td class="info">접수번호</td><td>${viewBoard.boardno}</td></tr>
	
	<tr><td class="info">아이디</td><td>${viewBoard.writer_userid}</td></tr>
	
	<tr><td class="info">이메일</td><td colspan="3">${viewBoard.writer_email}</td></tr>
	  	
<%-- <tr><td class="info">제목</td><td><input type="text" name="title" style="width:100%" value="${viewBoard.title }"/></td></tr>
 --%>
	<tr><td colspan="2">문의내용
	<td colspan="3">${viewBoard.content }
	</td></tr>
	
	<tr><td colspan="2">답변작성
	<textarea id="content" name="content" rows="10" cols="100" placeholder="---답변작성---"></textarea>
	</td></tr>
	
	
	
</table>
</form>
</div>

<div class="text-center">	
	<button type="button" id="btnWrite" class="btn btn-info">작성</button>
	<button type="button" id="btnCancel" class="btn btn-danger">취소</button>
</div>
</div>
<c:import url="/WEB-INF/views/layout/footer.jsp"/>