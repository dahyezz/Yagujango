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


.OneToOneListBody{
/* 	padding: 0 5% 0 5%; */
	margin: 0 5% 0 250px;
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


<div class="OneToOneListBody">
	<h1>내 1:1 문의 내역 확인</h1>
	<hr>
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
