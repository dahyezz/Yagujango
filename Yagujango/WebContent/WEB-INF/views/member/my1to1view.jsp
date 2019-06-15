<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<script type="text/javascript">
$(document).ready(function() {
	InitializeStaticMenu();
});


//////////////////////////네비게이션 바 //////////////////////////
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
#STATICMENU table {
	border-collapse: collapse;
	border-top: 3px solid black;
	border-bottom: 3px solid black;
	width:auto;
}
#STATICMENU .table th, td{
 	border: 1px solid #ddd;
 	padding: 10px;
 	text-align:center;
}
#STATICMENU .table th:hover{
	background: #D5D5D5;
}
#STATICMENU .table th:first-child, td:first-child{
 	border-left: 0;
}
#STATICMENU .table th:last-child, td:last-child{
 	border-right: 0;
}
/* 네비게이션바 테이블 */

/* 하이퍼링크 밑줄 제거 */
a { text-decoration:none; color:#000000 }


table thead {
	padding: 10px;
    border-top: 2px solid #000;
    border-bottom: 2px solid #000;
}					
.button-center {
	text-align: center;
}
.tablediv {
	padding: 0 5% 0 5%;
}
.contentdiv{
	padding: 0 10% 0 10%;
}
table{
	width: 100%;
	border-collapse: collapse;
    text-align: center;
    line-height: 1.5;
}
.viewinfo {
	background:#ccc;
}
h1{
	color:#000;
	font:bold 12px tahoma;
	font-size: 32px;
}
hr{
	color: "black";
	border-style: inset;
	border-width: 1px;
}
.wrap{
	padding:0 5% 0 5%;
	border-collapse: collapse;
}
.contentdiv{
	width:100%;
} 
img {
	max-width: 100%;
}


</style>


<div id="STATICMENU">
	<table class="table statictable">
		<tr>
			<th><a href="/mypage/main" >예매 확인/취소</a></th>
		</tr>
		<tr>
			<th><a href="/member/my1to1">내 1:1 문의 내역 확인</a></th>
		</tr>
		<tr>
			<th><a href="/member/modify">회원 정보 수정</a></th>
		</tr>
	</table>
</div>

<div class ="wrap">

<h1>1:1문의 내역</h1>
<hr>


<table>
<thead>
	<tr>
		<td style="width:33%;text-align:left;">&nbsp;&nbsp;${my1to1view.boardno }</td>
		<td style="width:34%;">${my1to1view.title }</td>
		<td style="width:33%;text-align:right;"> 작성자: ${my1to1view.writer_userid}&nbsp;&nbsp;</td>
	</tr>
</thead>
<tbody>

	<tr>
		<td colspan="3" style="text-align:right;">작성일:
		<fmt:formatDate value="${my1to1view.writtendate }" pattern="yyyy-MM-dd" />
		</td>
	</tr>
</tbody> 
</table>
<div class="contentdiv">
${my1to1view.content }
</div>
</div>








<c:import url="/WEB-INF/views/layout/footer.jsp" />