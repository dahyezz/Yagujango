<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp"/>

<script type="text/javascript">
$(document).ready(function() {
	
	//글쓰기 버튼 누르면 이동
	$("#btnList").click(function() {
 		$(location).attr("href","/admin/list");
	});
	
	//답변리스트
	$("#btnaList").click(function() {
 		$(location).attr("href","/answer/list");
	});
	
});
</script>


<h1>1:1 문의내역 확인</h1>
<hr>

<button id="btnList" class="btn btn-list">회원리스트</button>
<button id="btnaList" class="btn btn-list">답변완료목록</button>

<table class="table table-striped table-hover table-condensed">
<thead>
	<tr>
		<th style="width: 10%;">접수번호</th>
		<th style="width: 10%;">아이디</th>
		<th style="width: 30%;">제목</th>		
		<th style="width: 10%;">문의일시</th>
 		<th style="width: 10%;">처리유무</th>
 		<th style="width: 10%;">문의날짜</th>


	</tr>
</thead>
<c:forEach items="${blist}" var="b">

	<tr>
		<td>${b.boardno }</td>
		<td>${b.writer_userid }</td>
		<td><a href="/admin/board_1to1view?boardno=${b.boardno}">${b.title }</a></td>
		<td>${b.writtendate }</td>		
<%-- 		<td>${b.writer_comment }</td> --%>
<!-- 		질문목록에는 boardno가 있는데 답변목록에는 질문목록에 해당하는 boardno가 없는상황 -->
		<!-- 미처리상태 -->
		<td><c:if test="${not b.writer_comment }">
<!-- 		<strong>미처리</strong><br> -->
		<button onclick='location.href="/member/login";'>미처리</button>
		</c:if></td>

		<td><fmt:formatDate value="${b.writtendate }" pattern="yyyy-MM-dd" /></td>

	</tr>
</c:forEach>
</table>


<c:import url="/WEB-INF/views/layout/footer.jsp"/>