<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>

<script type="text/javascript">
// reserve 페이지에서만 네비게이션바 작동
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


function selectSeat(matchcode){
	window.open("http://localhost:8088/reserve/seat?match_code="+matchcode,"예매", "width=1000, height=650");
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
/* 네비게이션바 테이블 */

/* match 테이블 */
.matchtable {
	border-collapse: collapse;
	border-top: 3px solid black;
	border-bottom: 3px solid black;
	width: 80%;
}
.matchtable th, td{
 	border: 1px solid #ddd;
 	padding: 10px;
 	text-align:center;
}
.matchtable th:hover{
	background: #D5D5D5;
}
.matchtable th:first-child, td:first-child{
 	border-left: 0;
}
.matchtable th:last-child, td:last-child{
 	border-right: 0;
}
/* match 테이블 */

.matchList {
	text-align:left;
	padding: 0;
	width: 90%;
	margin: 0 10% 10% 250px;
}
.statictable{
	font-size: 13px;
 	color: #ccc; 
}
/* 하이퍼링크 밑줄 제거 */

a { text-decoration:none; color:#000000 }

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


<!-- 구장별 경기목록 -->
<div id="matchList" class="matchList">

<!-- 5월  -->
<c:set value="1" var="month"/> <!-- 테이블 위 '월'을 한번만 출력하기 위한 변수 -->
	<table class="matchtable" style="text-align:center;">
		<tr>
			<th>일시</th>
			<th>경기(홈 vs 원정)</th>
			<th>장소</th>
			<th>예매</th>
		</tr>
		<c:forEach items="${matchList }" var="i">
			<c:if test="${i.match_date >= '2019-05-01' && i.match_date < '2019-06-01'}">
				<c:if test="${month == '1'}">
					<u><h1><fmt:formatDate value="${i.match_date}" pattern="M월"/></h1></u>
				</c:if> <!-- 't'가 1일경우만 출력(반복출력 방지)  -->
				<tr>
					<td>${i.match_date }</td>
					<td>${i.hometeam_name } vs ${i.awayteam_name }</td>
					<c:forEach items="${list }" var="j">
						<c:if test="${j.stadium_code eq i.hometeam_code }">
							<td>${j.stadium_name }</td>
						</c:if>
					</c:forEach>
					<td><input type ="button" value="예매하기" onClick="selectSeat(${i.match_code})"/></td>
				</tr>
				<input type="hidden" value ="${month = 2}"/> <!-- hidden으로 't'값 바꾸기 (화면에 출력안되게)-->
			</c:if>
		</c:forEach>
	</table>
	<br><br><br><br>
	
	
	
<!-- 6월  -->
<c:set value="1" var="month"/> <!-- 테이블 위 '월'을 한번만 출력하기 위한 변수 -->
	<table class="matchtable" style="text-align:center;">
		<tr>
			<th>일시</th>
			<th>경기(홈 vs 원정)</th>
			<th>장소</th>
			<th>예매</th>
		</tr>
		<c:forEach items="${matchList }" var="i">
			<c:if test="${i.match_date >= '2019-06-01' && i.match_date < '2019-07-01'}">
				<c:if test="${month == '1'}">
					<u><h1><fmt:formatDate value="${i.match_date}" pattern="M월"/></h1></u>
				</c:if> <!-- 't'가 1일경우만 출력(반복출력 방지)  -->
				<tr>
					<td>${i.match_date }</td>
					<td>${i.hometeam_name } vs ${i.awayteam_name }</td>
					<c:forEach items="${list }" var="j">
						<c:if test="${j.stadium_code eq i.hometeam_code }">
							<td>${j.stadium_name }</td>
						</c:if>
					</c:forEach>
					<td><input type="button" value="예매하기" onClick="selectSeat(${i.match_code})"/></td>
				</tr>
				<input type="hidden" value ="${month = 2}"/> <!-- hidden으로 't'값 바꾸기 (화면에 출력안되게)-->
			</c:if>
		</c:forEach>
	</table>
	<br><br><br><br>
	
	
	
<!-- 7월  -->
<c:set value="1" var="month"/> <!-- 테이블 위 '월'을 한번만 출력하기 위한 변수 -->
	<table class="matchtable" style="text-align:center;">
		<tr>
			<th>일시</th>
			<th>경기(홈 vs 원정)</th>
			<th>장소</th>
			<th>예매</th>
		</tr>
		<c:forEach items="${matchList }" var="i">
			<c:if test="${i.match_date >= '2019-07-01' && i.match_date < '2019-08-01'}">
				<c:if test="${month == '1'}">
					<u><h1><fmt:formatDate value="${i.match_date}" pattern="M월"/></h1></u>
				</c:if> <!-- 't'가 1일경우만 출력(반복출력 방지)  -->
				<tr>
					<td>${i.match_date }</td>
					<td>${i.hometeam_name } vs ${i.awayteam_name }</td>
					<c:forEach items="${list }" var="j">
						<c:if test="${j.stadium_code eq i.hometeam_code }">
							<td>${j.stadium_name }</td>
						</c:if>
					</c:forEach>
					<td><input type ="button" value="예매하기" onClick="selectSeat(${i.match_code})"/></td>
				</tr>
				<input type="hidden" value ="${month = 2}"/> <!-- hidden으로 't'값 바꾸기 (화면에 출력안되게)-->
			</c:if>
		</c:forEach>
	</table>
	<br><br><br><br>
	
	
	
	<!-- 8월 -->
	<input type="hidden" value ="${month = 1}"/>
	<table class="matchtable" style="text-align:center;">
		<tr>
			<th>일시</th>
			<th>경기(홈 vs 원정)</th>
			<th>장소</th>
			<th>예매</th>
		</tr>
		<c:forEach items="${matchList }" var="i">
			<c:if test="${i.match_date >= '2019-08-01' && i.match_date < '2019-09-01'}">
				<c:if test="${month == '1'}">
					<u><h1><fmt:formatDate value="${i.match_date}" pattern="M월"/></h1></u>
				</c:if> <!-- 't'가 1일경우만 출력(반복출력 방지)  -->
				<tr>
					<td>${i.match_date }</td>
					<td>${i.hometeam_name } vs ${i.awayteam_name }</td>
					<c:forEach items="${list }" var="j">
						<c:if test="${j.stadium_code eq i.hometeam_code }">
							<td>${j.stadium_name }</td>
						</c:if>
					</c:forEach>
					<td><input type ="button" value="예매하기" onClick="selectSeat(${i.match_code})"/></td>
				</tr>
				<input type="hidden" value ="${month = 2}"/> <!-- hidden으로 't'값 바꾸기 (화면에 출력안되게)-->
			</c:if>
		</c:forEach>
	</table>
	<br><br><br><br>
	
	
	
	<!-- 9월 -->
	<input type="hidden" value ="${month = 1}"/>
	<table class="matchtable" style="text-align:center;">
		<tr>
			<th>일시</th>
			<th>경기(홈 vs 원정)</th>
			<th>장소</th>
			<th>예매</th>
		</tr>
		<c:forEach items="${matchList }" var="i">
			<c:if test="${i.match_date >= '2019-09-01' && i.match_date < '2019-10-01'}">
				<c:if test="${month == '1'}">
					<u><h1><fmt:formatDate value="${i.match_date}" pattern="M월"/></h1></u>
				</c:if> <!-- 't'가 1일경우만 출력(반복출력 방지)  -->
				<tr>
					<td>${i.match_date }</td>
					<td>${i.hometeam_name } vs ${i.awayteam_name }</td>
					<c:forEach items="${list }" var="j">
						<c:if test="${j.stadium_code eq i.hometeam_code }">
							<td>${j.stadium_name }</td>
						</c:if>
					</c:forEach>
					<td><input type ="button" value="예매하기" onClick="selectSeat(${i.match_code})"/></td>
				</tr>
				<input type="hidden" value ="${month = 2}"/> <!-- hidden으로 't'값 바꾸기 (화면에 출력안되게)-->
			</c:if>
		</c:forEach>
	</table>
</div>

<c:import url="/WEB-INF/views/layout/footer.jsp" />