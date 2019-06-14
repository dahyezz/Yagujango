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
 	width:auto%;
}

.th{
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
.infok{
	text-align : center;
/* 	margin : 20px 10% 20px 20px; */
	width:20%; 
}
.btn-button{
	background-color: white;
	border:0;
	align:center;
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
	//목록버튼동작
	$("#btnBoardList").click(function() {
 		$(location).attr("href","/answer/list");
	});
	
	//수정하기
	$("#btnUpdate").click(function() {
  		$(location).attr("href","/answer/update?answerno=${answerBoard.answerno}");
	});
	//삭제버튼동작
	$("#btnDelete").click(function() {
 		$(location).attr("href","/answer/delete?answerno=${answerBoard.answerno}");
	});
	
});
</script>

<div class = "container">
<h1>답변확인</h1>

<div class="wrap"></div>

<div class="wrap">
<table class="table table-bordered">
<tbody>
	<tr>
		<td class="infok">NO.</td>
		<td colspan="3">${answerBoard.answerno}</td>
	</tr>
	<tr>
		<td class="infok">접수번호</td>
		<td colspan="3">${answerBoard.boardno}</td>
	</tr>
	
	<tr>
		<td class="infok">회원아이디</td>
		<td>${answerBoard.writer_userid}</td>
	</tr>
	
		<tr>
		<td class="infok">문의내용</td>
		<td colspan="3">${viewcontent}</td>
	</tr>

	<tr>
		<td class="infok">답변내용</td>
		<td colspan="3">${answerBoard.content}</td>
	</tr>
	
	<tr>
		<td class="infok">작성일</td>
		<td colspan="3">${viewdate}</td>
	</tr>
	</tbody>
</table>
</div>
<div class="text-center">
<button id="btnBoardList" class="btn btn-button"><img class="btn-img" src="/img/admin/btn_list.gif"></button>
<button id="btnUpdate" class="btn btn-button"><img class="btn-img" src="/img/admin/btn_modify.gif"></button>
<button id="btnDelete" class="btn btn-button"><img class="btn-img" src="/img/admin/btn_delete.gif"></button>
</div>
</div>
</div>
<c:import url="/WEB-INF/views/layout/footer.jsp"/>