<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<style type="text/css">

.OneToOneListBody{
	padding: 0 5% 0 5%;
}

.OneToOneList {
    clear: both;
    border-top: 3px solid #000000;
    border-bottom: 3px solid #000000;
    
    padding-right: 162px;
    padding-left: 155px;
    padding-top: 30px;
    padding-bottom: 30px;
}

.text-center { 
	font-size: 18px;
	width: 100%; 
	text-align:center;
}

.ListTop {
	background: #d9e1e8;
}


</style>
<div class="OneToOneListBody">
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
						<td><a href="/member/my1to1view?boardno=${oto.boardno}">${oto.title }</a></td>
						<td>${oto.writer_userid }</td>
						<c:set value="1" var="st"/>
							<c:forEach items="${untreatedList }" var="i">
								<c:if test="${st == '1' && i.boardno eq oto.boardno }">
									<c:set value="false" var="status" />
									<c:set value="2" var="st"/>
								</c:if>
								<c:if test="${st == '1' && i.boardno ne oto.boardno }">
									<c:set value="true" var="status" />
								</c:if>
							</c:forEach>
						<c:if test="${!status && not empty untreatedList}"><td>미처리</td></c:if>
						<c:if test="${empty untreatedList }"><td>처리</td></c:if>
						<c:if test="${status }"><td>처리</td></c:if>
						<td><fmt:formatDate value="${oto.writtendate }" pattern="yyyy-MM-dd" /></td>
						
					</tr>	
				</c:forEach>
			</thead> 
		</table>
	</div>
</div>
<c:import url="/WEB-INF/views/layout/footer.jsp" />
