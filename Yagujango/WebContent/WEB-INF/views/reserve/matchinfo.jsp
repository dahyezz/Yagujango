<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF//views/layout/header.jsp" />

<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700|Noto+Sans+KR:300,400&display=swap" rel="stylesheet">

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
</style>

<div id="STATICMENU">
	<table class="table statictable">
		<c:forEach items="${list }" var="i">
			<tr>
				<th><a href="/reserve/list?stadium_code=${i.stadium_code }" >${i.stadium_name } [${i.team_name }]</a></th>
			</tr>
		</c:forEach>
			<tr>
				<th><a href="/reserve/inform">예매 안내</a></th>
			</tr>
	</table>
</div>

<div class="reservestep">
<h1 style="font-family: 'Nanum Gothic', sans-serif; font-weight: 700;">예매 안내</h1>
<hr width="130px" align="left">


<p class="howto">1. 예매할 좌석을 선택한다</p>
<img src="/img/selectseat.PNG" width="90%">

<br><br><p class="howto">2. 수령방법과 예매 정보 확인</p>
<img src="/img/receive.PNG" width="90%">

<br><br><p class="howto">3. 결제방법과 예매 정보 확인</p>
<img src="/img/payment.PNG" width="90%">


<div class="cancle">
	<h3 style="font-family: 'Nanum Gothic', sans-serif; font-weight: 700;">티켓취소안내</h3>
	<ul>
		<li>예매한 티켓 전체 취소, 혹은 신용카드 결제 시 부분 취소가 가능합니다.<br>단, 일부 상품의 경우도 부분취소가 불가합니다.</li>
	</ul>
	<ul>
		<li>예매 당일 자정까지 취소하실 경우는 예매수수료도 환불되며, 취소수수료가 부과되지 않습니다. <br>그 이후에 취소하실 경우는 예매수수료가 환불되지 않으며, 취소수수료는 정책에 따라 부과됩니다.</li>
	</ul>
	<ul>
		<li>일부 경기의 경우 상황에 따라 일괄 취소 건이 발생할 수있으며, 일괄 취소 시에는 취소 수수료가 부과되지 않습니다.</li>
	</ul>
	<ul>
		<li>티켓의 날짜/시간/좌석 등급/좌석 위치 변경은 불가합니다. 자세한 안내가 필요할 경우 고객센터를 이용해주세요.</li>
	</ul>
	

</div>

</div>

<c:import url="/WEB-INF/views/layout/footer.jsp" />