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
	
	var islogin = <%=session.getAttribute("login") %>

	var date = document.getElementById(reserveBtn);
	console.log(date)
	
	if(!islogin){
		console.log("로그인 아님")
		location.href=("/member/login");
	} else {
		window.open("http://localhost:8088/reserve/seat?match_code="+matchcode,"예매", "width=1000, height=650");
	}
	
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

<body>
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

<!-- 5월  -->
<div id="matchList" class="matchList">
<c:set var="now" value="<%=new java.util.Date()%>" /> <!-- 오늘날짜 -->
<c:set var="today"><fmt:formatDate value="${now }" pattern="yyyy-MM-dd" /></c:set> <!-- 오늘날짜 포맷 -->
<c:set value="1" var="month"/> <!-- 테이블 위 '월'을 한번만 출력하기 위한 변수 -->

<table class="matchtable" style="text-align:center;">
	<c:if test="${today < '2019-06-01' }">
		<tr>
			<th>일시</th>
			<th>경기(홈 vs 원정)</th>
			<th>장소</th>
			<th>예매</th>
		</tr>
	</c:if>
	<c:forEach items="${matchList }" var="i">
		<c:set var="matchdate"><fmt:formatDate value="${i.match_date }" pattern="yyyy-MM-dd" /></c:set>
		<c:if test="${i.match_date >= today && i.match_date < '2019-06-01' && i.match_date > '2019-04-31'}">
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
				<td><input id="reserveBtn" type ="button" value="예매하기" onClick="selectSeat(${i.match_code})"/></td>
			</tr>
			<input type="hidden" value ="${month = 2}"/> <!-- hidden으로 'month'값 바꾸기 (화면에 출력안되게)-->
		</c:if>
	</c:forEach>
</table>
<c:if test="${today < '2019-06-01' }">
	<br><br><br><br>
</c:if>



<!-- 6월  -->
<c:set value="1" var="month"/> <!-- 테이블 위 '월'을 한번만 출력하기 위한 변수 -->
	<table class="matchtable" style="text-align:center;">
		<c:if test="${today < '2019-07-01' }">
			<tr>
				<th>일시</th>
				<th>경기(홈 vs 원정)</th>
				<th>장소</th>
				<th>예매</th>
			</tr>
		</c:if>
		<c:forEach items="${matchList }" var="i">
			<c:if test="${i.match_date >= today && i.match_date < '2019-07-01' && i.match_date > '2019-05-31'}">
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

					<td><input id="reserveBtn" type="button" value="예매하기" onClick="selectSeat(${i.match_code})"/></td>

				</tr>
				<input type="hidden" value ="${month = 2}"/> <!-- hidden으로 'month'값 바꾸기 (화면에 출력안되게)-->
			</c:if>
		</c:forEach>
	</table>
<c:if test="${today < '2019-07-01' }">
	<br><br><br><br>
</c:if>
	
	
	
<!-- 7월  -->
<c:set value="1" var="month"/> <!-- 테이블 위 '월'을 한번만 출력하기 위한 변수 -->
	<table class="matchtable" style="text-align:center;">
		<c:if test="${today < '2019-08-01' }">
			<tr>
				<th>일시</th>
				<th>경기(홈 vs 원정)</th>
				<th>장소</th>
				<th>예매</th>
			</tr>
		</c:if>
		<c:forEach items="${matchList }" var="i">
			<c:if test="${i.match_date >= today && i.match_date < '2019-08-01' && i.match_date > '2019-06-31'}">
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
					<td><input id="reserveBtn" type ="button" value="예매하기" onClick="selectSeat(${i.match_code})"/></td>
				</tr>
				<input type="hidden" value ="${month = 2}"/> <!-- hidden으로 'month'값 바꾸기 (화면에 출력안되게)-->
			</c:if>
		</c:forEach>
	</table>
<c:if test="${today < '2019-08-01' }">
	<br><br><br><br>
</c:if>
	
	
	
<!-- 8월 -->
<input type="hidden" value ="${month = 1}"/>
	<table class="matchtable" style="text-align:center;">
		<c:if test="${today < '2019-09-01' }">
			<tr>
				<th>일시</th>
				<th>경기(홈 vs 원정)</th>
				<th>장소</th>
				<th>예매</th>
			</tr>
		</c:if>
		<c:forEach items="${matchList }" var="i">
			<c:if test="${i.match_date >= today && i.match_date < '2019-09-01' && i.match_date > '2019-07-31'}">
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
					<td><input id="reserveBtn" type ="button" value="예매하기" onClick="selectSeat(${i.match_code})"/></td>
				</tr>
				<input type="hidden" value ="${month = 2}"/> <!-- hidden으로 'month'값 바꾸기 (화면에 출력안되게)-->
			</c:if>
		</c:forEach>
	</table>
<c:if test="${today < '2019-09-01' }">
	<br><br><br><br>
</c:if>
	
	
	
<!-- 9월 -->
<input type="hidden" value ="${month = 1}"/>
	<table class="matchtable" style="text-align:center;">
		<c:if test="${today < '2019-10-01' }">
			<tr>
				<th>일시</th>
				<th>경기(홈 vs 원정)</th>
				<th>장소</th>
				<th>예매</th>
			</tr>
		</c:if>
		<c:forEach items="${matchList }" var="i">
			<c:if test="${i.match_date >= today && i.match_date < '2019-10-01' && i.match_date > '2019-08-31'}">
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
					<td><input id="reserveBtn" type="button" value="예매하기" onClick="selectSeat(${i.match_code})"/></td>
				</tr>
				<input type="hidden" value ="${month = 2}"/> <!-- hidden으로 'month'값 바꾸기 (화면에 출력안되게)-->
			</c:if>
		</c:forEach>
	</table>
</div>

<!-- 취소기한 날짜계산  -->
<script type="text/javascript">
Date.prototype.format = function(f) {
	if (!this.valueOf()) return " ";
 
	var weekName = ["일", "월", "화", "수", "목", "금", "토"];
	var d = this;
	 
	return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
		switch ($1) {
			case "yyyy": return d.getFullYear();
			case "yy": return (d.getFullYear() % 1000).zf(2);
			case "MM": return (d.getMonth() + 1).zf(2);
			case "dd": return d.getDate().zf(2);
			case "E": return weekName[d.getDay()];
			case "HH": return d.getHours().zf(2);
			case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
			case "mm": return d.getMinutes().zf(2);
			case "ss": return d.getSeconds().zf(2);
			case "a/p": return d.getHours() < 12 ? "오전" : "오후";
			default: return $1;
		}
	});
};
 
String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
Number.prototype.zf = function(len){return this.toString().zf(len);};

var matchdate = new Array();
<c:forEach items="${matchList}" var="i">
	matchdate.push(new Date("${i.match_date}"));
</c:forEach>

for (var i = 0; i < matchdate.length; i++) {
	matchdate[i].setDate(matchdate[i].getDate() + 7);
// 	matchdate[i].format("yyyy-MM-dd");
	console.log(matchdate[i].format("yyyy-MM-dd"));
}

var todate = new Date();
todate.setDate(todate.getDate() + 7);
console.log(todate);
document.getElementById('todate').innerHTML=todate.format("yyyy-MM-dd");

// var matchdate = new Date("${formatdate }");
// var canceldate = new Date("${formatdate }");
// canceldate.setDate(canceldate.getDate() + 7);
// console.log(canceldate.format("yyyy-MM-dd HH:mm"));
// document.getElementById('matchdate').innerHTML=matchdate.format("yyyy년 MM월 dd일 (E요일)<br>HH:mm");
// document.getElementById('canceldate').innerHTML=canceldate.format("yyyy년 MM월 dd일 (E요일)<br>HH:mm");

</script>

<c:import url="/WEB-INF/views/layout/footer.jsp" />