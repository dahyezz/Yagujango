<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp"/>
<script type="text/javascript">
$(document).ready(function() {
	InitializeStaticMenu();
});

////////////////////////// 네비게이션 바 //////////////////////////
var stmnLEFT = 10; // 오른쪽 여백 
var stmnGAP1 = 0; // 위쪽 여백 
var stmnGAP2 = 250; // 스크롤시 브라우저 위쪽과 떨어지는 거리 
var stmnBASE = 200; // 스크롤 시작위치 
var stmnActivateSpeed = 35; //스크롤을 인식하는 딜레이 (숫자가 클수록 느리게 인식)
var stmnScrollSpeed = 20; //스크롤 속도 (클수록 느림)
var stmnTimer; 

function RefreshStaticMenu() { 
var stmnStartPoint, stmnEndPoint; 
stmnStartPoint = parseInt(document.getElementById('STATICMENU').style.top, 10); 
stmnEndPoint = Math.max(document.documentElement.scrollTop, document.body.scrollTop) + stmnGAP2; 
	if (stmnEndPoint < stmnGAP1) stmnEndPoint = stmnGAP1; 
	if (stmnStartPoint != stmnEndPoint) { 
		stmnScrollAmount = Math.ceil( Math.abs( stmnEndPoint - stmnStartPoint ) / 15 ); 
		document.getElementById('STATICMENU').style.top = parseInt(document.getElementById('STATICMENU').style.top, 10) + ( ( stmnEndPoint<stmnStartPoint ) ? -stmnScrollAmount : stmnScrollAmount ) + 'px'; 
		stmnRefreshTimer = stmnScrollSpeed; 
	}
	stmnTimer = setTimeout("RefreshStaticMenu();", stmnActivateSpeed); 
}

function InitializeStaticMenu() {
	document.getElementById('STATICMENU').style.right = stmnLEFT + 'px';  //처음에 오른쪽에 위치. left로 바꿔도.
	document.getElementById('STATICMENU').style.top = document.body.scrollTop + stmnBASE + 'px'; 
	RefreshStaticMenu();
}


</script>

<style type="text/css">
/* 메뉴 네비게이션바 */

#STATICMENU {
	width: 200px;
	margin: 0pt;
	width: 200px;
	padding: 0pt;  
	position: absolute; 
	left: 50px;
	top: 0px;
}

/* 네비게이션바 테이블 */
table {
	border-collapse: collapse;
	border-top: 3px solid black;
	border-bottom: 3px solid black;
	width:auto;
}
.table th, td{
 	border: 1px solid #ddd;
 	padding: 10px;
 	text-align:center;
}
.e{
	width:100%;
}
th{
	background-color : #d9e1e8;
	color : #282c37;
}
.table th:hover{
	background: #D5D5D5;
}
.table th:first-child, td:first-child{
 	border-left: 0;
}
.table th:last-child, td:last-child{
 	border-right: 0;
}
.statictable{
	font-size: 13px;
 	color: #ccc; 
}
.boardlist	{
	border-collapse: collapse;
	border-top: 3px solid black;
	border-bottom: 3px solid black;
	width:80%;
}
/* 네비게이션바 테이블 */

.reservestep {
	margin: 0 5% 5% 230px;
	width: 80%;
	text-align: left;
/* 	height: 60%; */
}
/* 하이퍼링크 밑줄 제거 */
a { text-decoration:none; color: black; }

.howto {
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 300;
	font-size: 20px;
}

.cancle li {
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 300;
	font-size: 15px;
}

</style>

<div id="STATICMENU">
	<table class="table statictable">
		<c:forEach items="${list }" var="i">
			<tr>
				<th><a href="/reserve/list?stadium_code=${i.stadium_code }" >${i.stadium_name } [${i.team_name }]</a></th>
			</tr>
		</c:forEach>
			
			<tr>
				<th><a href="/admin/list">회원</a></th>
			</tr>
			
			<tr>
				<th><a href="/admin/blacklist">블랙리스트 </a></th>
			</tr>
			
			<tr>
				<th><a href="/admin/board_1to1">1:1문의확인</a></th>
			</tr>
			
			<tr>
				<th><a href="/answer/list">1:1답변확인</a></th>
			</tr>
	</table>
</div>

<div class="reservestep">
<!-- <h1 style="font-family: 'Nanum Gothic', sans-serif; font-weight: 700;"></h1> -->
<!-- <hr width="130px" align="left"> -->

<script type="text/javascript">
$(document).ready(function() {
	
	//답변하기
	$("#btnUpdate").click(function() {
  		$(location).attr("href","/admin/board_1to1_write?boardno=${viewBoard.boardno}");
	});
	
});
</script>


<h1>1:1 문의내역 확인</h1>

<table class="table table-striped table-hover table-condensed boardlist">
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
<%-- 		<c:if test="${not empty answerBoard.boardno }"> --%>
<!-- 			<td>처리</td> -->
<%-- 		</c:if> --%>
<%-- 		<c:if test="${empty answerBoard.boardno }"> --%>
<!-- 			<td>미처리</td> -->
<%-- 		</c:if> --%>
		<c:set value="1" var="st"/>
		
		<c:forEach items="${untreatedList }" var="i">
			<c:if test="${st == '1' && i.boardno eq b.boardno }">
				<c:set value="false" var="status" />
				<c:set value="2" var="st"/>
			</c:if>
			<c:if test="${st == '1' && i.boardno ne b.boardno }">
				<c:set value="true" var="status" />
			</c:if>
		</c:forEach>
		<c:if test="${!status && not empty untreatedList}"><td><img class="btn-img" src="/img/admin/q_1.gif"></td></c:if>
		<c:if test="${empty untreatedList }"><td><img class="btn-img" src="/img/admin/a_1.gif"></td></c:if>
		<c:if test="${status }"><td><img class="btn-img" src="/img/admin/a_1.gif"></td></c:if>
		
<!-- 		질문목록에는 boardno가 있는데 답변목록에는 질문목록에 해당하는 boardno가 없는상황 -->
		<!-- 미처리상태 -->

<%-- 		<td><c:if test="${empty answerBoard.boardno}"> --%>
<!-- <!-- 		<strong>미처리</strong><br> -->
<%-- 		<button onclick="location.href='/admin/board_1to1_write?boardno=${b.boardno}'">미처리</button> --%>
<%-- 		</c:if></td> --%>
		
<%-- 		<td><c:if test="${b.boardno eq answerBoard.boardno}"> --%>
<!-- <!-- 	<strong>미처리</strong><br> -->
<!-- 		<button onclick="location.href='/answer/list';">처리</button> -->
<%-- 		</c:if></td> --%>


		<td><fmt:formatDate value="${b.writtendate }" pattern="yyyy-MM-dd" /></td>

	</tr>
</c:forEach>
</table>
</div>

<div class="paging">
<c:import url="/WEB-INF/views/layout/admin_boardlist.jsp" />

</div>

<c:import url="/WEB-INF/views/layout/footer.jsp"/>