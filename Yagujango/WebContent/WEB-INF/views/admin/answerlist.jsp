<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp"/>

<script type="text/javascript">
$(document).ready(function() {
	
	//글쓰기 버튼 누르면 이동
	$("#btnList").click(function() {
 		$(location).attr("href","/admin/board_1to1");
	});
	
});
</script>


<h1>답변완료목록</h1>
<hr>

<button id="btnList" class="btn btn-list">1:1문의목록</button>

<table class="table table-striped table-hover table-condensed">
<thead>
	<tr>
		<th style="width: 10%;">NO.</th>
		<th style="width: 10%;">접수번호</th>
		<th style="width: 10%;">회원아이디</th>		
		<th style="width: 30%;">답변내용</th>
 		<th style="width: 10%;">문의날짜</th>


	</tr>
</thead>
<c:forEach items="${alist}" var="a">

	<tr>
		<td>${a.answerno }</td>
		<td>${a.boardno }</td>
		<td>${a.writer_userid }</td>
		<td><a href="/answer/view?answerno=${a.answerno}">${a.content }</a></td>	
		<td><fmt:formatDate value="${a.writtendate }" pattern="yyyy-MM-dd" /></td>

	</tr>
</c:forEach>
</table>


<c:import url="/WEB-INF/views/layout/footer.jsp"/>