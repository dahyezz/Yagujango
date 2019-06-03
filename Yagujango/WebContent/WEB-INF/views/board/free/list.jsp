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
	padding: 0 5% 0 5%;
}
table {
	width: 100%;
	border-collapse: collapse;
    text-align: center;
    line-height: 1.5;
}
table thead {
	padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #369;
    border-bottom: 3px solid #036;
}
table .notice {
	background:#ccc;
}
.content {
	text-align:left;
}
.search {
	display:block;
	text-align:center; 
	background:#CCC;
	padding:0 0 0 35px;
	font-size:18px;
	color:#5e5e5e;
	font-weight:bold;
	line-height: 50px;
	cursor:pointer;
	box-sizing: content-box;
	margin: 10px 0; !important
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

<div class="wrap">
<div class="tablediv">
<table>
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
	<c:if test="${i.tag eq '공지' }">
		<tr class="notice">
			<td><a href="/board/free/list?name=tag&keyword=${i.tag}">공지</a></td>
			<td class="content"><a href="/board/free/view?tag=${i.tag}&boardno=${i.boardno}"  >${i.title }</a></td>	
			<td>${i.writer }</td>
			<td>${i.hit }</td>
			<td><fmt:formatDate value="${i.writtendate }" pattern="yyyy-MM-dd" /></td>
		<tr>
	</c:if>
	<c:if test="${i.tag ne '공지' }">
		<tr>
			<td>${i.boardno }</td>
			<td class="content">
			<a href="/board/free/list?name=tag&keyword=${i.tag}"  >[${i.tag}]</a>
			<a href="/board/free/view?tag=${i.tag}&boardno=${i.boardno}"  >${i.title }</a>
			</td>
			<td>${i.writer }</td>
			<td>${i.hit }</td>
			<td><fmt:formatDate value="${i.writtendate }" pattern="yyyy-MM-dd" /></td>
		</tr>
	</c:if>
		
</c:forEach>
</tbody>
</table>
</div>
<div class="paging">
<c:import url="/WEB-INF/views/layout/free_paging.jsp" />

</div>
<div class="search">
<form action="/board/free/list" method="get">
		<select name="name">
				<option value="title">제목</option>
				<option value="content">본문</option>
				<option value="writer">작성자</option>
		</select>
		<input type="text"  name="keyword" placeholder="검색어를 입력해주세요." >
	
	 	<button>검색</button>
	
</form>
</div>
<button id="btnWrite">글 쓰기</button>
</div>
<c:import url="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>