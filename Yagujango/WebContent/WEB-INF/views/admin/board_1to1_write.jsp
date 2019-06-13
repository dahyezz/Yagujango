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
var stmnGAP2 = 200; // 스크롤시 브라우저 위쪽과 떨어지는 거리 
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
	left: 0px;
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

th{
	background-color : #d9e1e8;
	color : #282c37;
}
.table th:hover{
	background: #D5D5D5;
}
.table th:first-child, td:first-child{
 	border-left: 0;
 	background-color:#d9e1e8;
}
.table th:last-child, td:last-child{
 	border-right: 0;
}
.statictable{
	font-size: 13px;
 	color: #ccc; 
}
/* 네비게이션바 테이블 */

.reservestep {
	margin: 0 5% 5% 270px;
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
.infok{
	text-align : center;
/* 	margin : 20px 10% 20px 20px; */
	width:20%; 

}


</style>

<div id="STATICMENU">
	<table class="table statictable">
<%-- 		<c:forEach items="${list }" var="i"> --%>
<!-- 			<tr> -->
<%-- 				<th><a href="/reserve/list?stadium_code=${i.stadium_code }" >${i.stadium_name } [${i.team_name }]</a></th> --%>
<!-- 			</tr> -->
<%-- 		</c:forEach> --%>
			
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
<h1 style="font-family: 'Nanum Gothic', sans-serif; font-weight: 700;"></h1>
<hr width="130px" align="left">

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

<!-- <style type="text/css"> -->
<!-- /* #content { */ -->
<!-- /* 	width: 100%; */ -->
<!-- /* } */ -->
<!-- </style> -->

<div class="container">

<h1>1:1 문의 답변작성</h1>


<div class="wrap"></div>


<input type="hidden" name="email" id="email" value="${viewBoard.writer_email }"/>


<div>
<form action="/admin/board_1to1_write" method="post">
<input type="hidden" name="boardno" value="${viewBoard.boardno}" />
<input type="hidden" name="email" id="email" value="${viewBoard.writer_email }"/>
<input type="hidden" name="title" id="title" value="${viewBoard.title }" />

<table class="table table-bordered">
	<tr><td class="infok">접수번호</td><td>${viewBoard.boardno}</td></tr>
	
	<tr><td class="infok">아이디</td><td>${viewBoard.writer_userid}</td></tr>
	
	<tr><td class="infok">이메일</td><td colspan="3">${viewBoard.writer_email}</td></tr>
	  	
<%-- <tr><td class="info">제목</td><td><input type="text" name="title" style="width:100%" value="${viewBoard.title }"/></td></tr>
 --%>
	<tr><td class="infok">문의내용</td>
<td colspan="3">${viewBoard.content }
	</td>
	
	<tr><td class="infok">답변작성</td>
	<td colspan="3"><textarea id="content" name="content" rows="10" cols="100" placeholder="---답변작성---"></textarea>
	</td></tr>
	
	
	
</table>
</form>
</div>

<div class="text-center">	
	<button type="button" id="btnWrite" class="btn btn-info">작성</button>
	<button type="button" id="btnCancel" class="btn btn-danger">취소</button>
</div>
</div>
</div>
<c:import url="/WEB-INF/views/layout/footer.jsp"/>