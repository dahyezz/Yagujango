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

}

</style>

</head>
<body>
<c:import url="/WEB-INF/views/layout/header.jsp" />
<script type="text/javascript">
$(document).ready(function() {
	$("#btnWrite").click(function() {
		location.href="/board/free/write";
	})
});
</script>
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
<c:forEach items="${board_freelist}" var="i">
	<tr>
		<c:if test="${i.tag eq '공지' }">
			<td>공지</td>
			<td><a href="/board/free/view?tag=${i.tag}&boardno=${i.boardno}"  >${i.title }</a></td>	
		</c:if>
		<c:if test="${i.tag ne '공지' }">
			<td>${i.boardno }</td>
			<td>
			<a href="/board/free/list?name=tag&keyword=${i.tag}"  >[${i.tag}]</a>
			<a href="/board/free/view?tag=${i.tag}&boardno=${i.boardno}"  >${i.title }</a>
			</td>
		</c:if>
		
		<td>${i.writer }</td>
		<td>${i.hit }</td>
		<td><fmt:formatDate value="${i.writtendate }" pattern="yyyy-MM-dd" /></td>
	</tr>
</c:forEach>
</tbody>
</table>
</div>
<button id="btnWrite">글 쓰기</button>
<c:import url="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>