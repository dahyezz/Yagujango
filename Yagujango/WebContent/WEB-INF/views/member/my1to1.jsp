<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<style type="text/css">


.OneToOneList {
    clear: both;
    border-top: 3px solid #000000;
    border-bottom: 3px solid #000000;
}

.text-center { 
	font-size: 18px;
	width: 100%; 
	text-align:center;
}

.ListTop {
	background: #CCC;
}


</style>

<table class="t1">
	<tr>
		<th style="font-size: 45px;">내 1:1문의내역</th>
		<th style="font-size: 13px; padding-top: 20px;">
		</th>
	</tr>
</table>

<div>
	<div class="OneToOneList">
		<table class="text-center">
			<thead>
				<tr class="ListTop">
					<th style="width: 10%;">글번호</th>
					<th style="width: 45%;">제목</th>
					<th style="width: 15%;">작성자</th>
					<th style="width: 10%;">처리여부</th>
					<th style="width: 20%;">작성일</th>
				</tr> 
			</thead>
			 
			<thead>
				<c:forEach items="${OneToOneList}" var="oto">
					<tr>
						<td class="content"><a href="/member/my1to1view?boardno=${oto.boardno}">${oto.boardno}</a><br></td>
						<td>${oto.title }</td>
						<td>${oto.usernick }</td>
						<td>${oto.writer_comment }</td>
						<td><fmt:formatDate value="${oto.writtendate }" pattern="yyyy-MM-dd" /></td>
						<br>
					</tr>	
				</c:forEach>
			</thead> 
		</table>
	</div>
</div>

<c:import url="/WEB-INF/views/layout/footer.jsp" />
