<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<c:import url="/WEB-INF/views/layout/header.jsp" />

<script type="text/javascript">
$(document).ready(function() {
	InitializeStaticMenu();
	

// 	var match_date = document.getElementById("matchdate").value;
	var match_date = document.getElementsByName("matchdate");
	var c = document.getElementsByName("cancledate");
	var possible = document.getElementsByName("canclepossible");
	
	var now = new Date();
	
	for(var i=0; i<match_date.length; i++){
		var cancle_date = parse(match_date[i].value)
// 		console.log(match_date[i].value)
		
		cancle_date.setHours(cancle_date.getHours()-3);
		var cancle = getFormatDate(cancle_date);
		
		c[i].innerHTML += cancle;
		
		
		if(cancle_date >= now)
			possible[i].innerHTML = "가능"
		else
			possible[i].innerHTML = "불가"

// 		if(cancle_date <= now)
// 			document.getElementById("canclepossible").innerHTML = "가능"
// 		else
// 			document.getElementById("canclepossible").innerHTML = "불가"
	}
	
	
	var possible = document.getElementsByName("canclepossible");
	for(var i=0; i<possible.length; i++){
	}	
	
// 	if(cancle_date >= now)
// 		document.getElementById("canclepossible").innerHTML = "가능"
// 	else
// 		document.getElementById("canclepossible").innerHTML = "불가"
	
	
});

function parse(str){
	var y = str.substr(0,4);
	var m = str.substr(4,2);
	var d = str.substr(6,2);
	var h = str.substr(9,2);
	var mi = str.substr(12,2);

	return new Date(y,m-1,d,h,mi);
	
}

function getFormatDate(cancle_date){

	var hours = cancle_date.getHours();
	var mi = cancle_date.getMinutes();

	return hours + ':' + mi;
	
}



//////////////////////////네비게이션 바 //////////////////////////
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

/* 하이퍼링크 밑줄 제거 */
#STATICMENU a { text-decoration:none; color:#000000 }


.myticket {
	margin: 0 5% 0 250px;
}

#cancledate {
	color: #0080ff;
	font-size: 13px;
}

a {
	color: #0080ff;
}


td[name="cancledate"]{
	color: #0080ff;
	font-size: 13px;
}

.reserve1 th{
	background:#D9E1E8;
}

.reserve2 th{
	background:#D9E1E8;
}


.reserv1 th, td{
	font-size: 15px;
	text-align: center;
	border:1px solid #ccc;
	border-collapse:collapse; /* 각각의 셀들의 테두리가 겹치는 부분을 하나의 선으로 합침 */
}

.reserve1 table{
	width: 100%;
	font-family: "Nanum Gothic", sans-serif; 
}

.reserve2 table{
	width: 100%;
	font-family: "Nanum Gothic", sans-serif; 
}

.reserv2 th, td{
	font-size: 13px;
	text-align: center;
	border:1px solid #ccc;
	border-collapse:collapse; /* 각각의 셀들의 테두리가 겹치는 부분을 하나의 선으로 합침 */
}

.myticket h1 {
	font-family: 'Do Hyeon', sans-serif;
	font-weight: 400;
}

.myticket h3 p {
	font-family: 'Gothic A1', sans-serif;
}

.reserve2 p{
	float: right;
	
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

<div class="myticket">
<h1>예매 상세 보기</h1>
<hr>

<h3>예매 티켓 정보</h3>

<c:forEach items="${reserveList }" var="i">
		<c:if test="${i.reserve_code eq reserve_code }">
			<c:set value="${i.ticket_code }" var="ticketcode"/>
		</c:if>
</c:forEach>
<c:forEach items="${ticketList }" var="i">
		<c:if test="${i.ticket_code eq ticketcode }">
			<c:set value="${i.match_code }" var="matchcode"/>
		</c:if>
</c:forEach>
<c:forEach items="${matchList }" var="i">
		<c:if test="${i.match_code eq matchcode }">
			<c:set value="${i.hometeam_code }" var="hometeamcode"/>
		</c:if>
</c:forEach>	
<c:forEach items="${ticketList }" var="i">
		<c:if test="${i.match_code eq matchcode }">
			<c:set value="${i.seat_code }" var="seatcode"/>
		</c:if>
</c:forEach>	

<div class="reserve1">
<input type="hidden" name="ticket_code" />
<table>
	<tr>
		<th>예매 번호</th>
		<td>${reserve_code }</td>
		<th>티켓명</th>
		<td id="teamname">
			<c:set value="1" var="one" />
			<c:forEach items="${matchList }" var="i">
				<c:if test="${one=='1' && i.match_code == matchcode }">
					[2019 신한은행 MY CAR KBO 리그]<br>${i.awayteam_name } vs ${i.hometeam_name }
					<c:set value="2" var="one" />
				</c:if>
			</c:forEach>
		</td>
	</tr>
	<tr>
		<th>관람일시</th>
		<td>
			<c:set value="1" var="one" />
			<c:forEach items="${matchList }" var="i">
				<c:if test="${one=='1' && i.match_code == matchcode }">
					<fmt:formatDate value="${i.match_date }"  pattern="yyyy-MM-dd(E) HH:mm"/>
					<c:set value="2" var="one" />
				</c:if>
			</c:forEach>
		</td>
		<th>장소</th>
		<td>
			<c:set value="1" var="one" />
			<c:forEach items="${stadiumList }" var="i">
				<c:if test="${one=='1' && i.stadium_code == hometeamcode }">
					${i.stadium_name }
					<c:set value="2" var="one" />
				</c:if>
			</c:forEach>		
		</td>
	</tr>
	<tr>
		<th>좌석</th>
		<td>
			<c:set value="1" var="one" />
			<c:forEach items="${ticketList }" var="i" varStatus="tStatus">
				<c:if test="${i.match_code eq matchcode }">
					<c:forEach items="${seatList }" var="j" varStatus="sStatus">
						<c:if test="${tStatus.index eq sStatus.index && i.seat_code eq j.seat_code }">
							${j.seat_block }블럭 ${j.seat_number }석<br>
						</c:if>
					</c:forEach>
					<c:set value="2" var="one" />				
				</c:if>
			</c:forEach>
		</td>
		<th>티켓수령 방법</th>
		<td>
			<c:set value="1" var="one" />
			<c:forEach items="${reserveList }" var="i">
				<c:if test="${one=='1' && i.reserve_code == reserve_code }">
					${i.how_receive }
					<c:set value="2" var="one" />
				</c:if>
			</c:forEach>
		</td>
	</tr>
	<tr>
		<th>취소 가능일</th>
		<td name="cancledate">
			<c:set value="1" var="one" />
			<c:forEach items="${matchList }" var="i">
				<c:if test="${one=='1' && i.match_code == matchcode }">
					<fmt:formatDate var="matchdate" value="${i.match_date }"  pattern="yyyyMMdd HH:mm"/>
					<input type="hidden" id="matchdate" name="matchdate" value="${matchdate }" />
					<fmt:formatDate value="${i.match_date }"  pattern="yyyy.MM.dd "/>
					<c:set value="2" var="one" />
				</c:if>
			</c:forEach>
		</td>
		<th>취소 가능 여부</th>
		<td name="canclepossible"></td>
	</tr>
	<tr>
		<th>예매자</th>
		<td>${member.username }</td>
		<th>예매일</th>
		<td>
			<c:set value="1" var="one" />
			<c:forEach items="${reserveList }" var="i">
				<c:if test="${one=='1' && i.reserve_code == reserve_code }">
					<fmt:formatDate value="${i.payment_date}" pattern="yyyy.MM.dd"/>
					<c:set value="2" var="one" />
				</c:if>
			</c:forEach>
		</td>
	</tr>
	<tr>
		<th>결제수단</th>
		<td>
			<c:set value="1" var="one" />
			<c:forEach items="${reserveList }" var="i">
				<c:if test="${one=='1' && i.reserve_code == reserve_code }">
					${i.payment }
					<c:set value="2" var="one" />
				</c:if>
			</c:forEach>	
		</td>
		<th>현재상태</th>
		<td>예매완료</td>
	</tr>
</table>
</div>
<br>
<div class="reserve2">
<h3>티켓 예매 내역</h3>
<p>예매한 내역이 확인이 안되실 경우 <a href="/board/1:1write">1:1 상담 문의</a>를 이용해주세요.</p>
<!-- <p>기간별 조회 -->
<!-- <button id="term" name="term" value="15" onclick="setTerm()">15일</button> -->
<!-- <button id="term" name="term" value="30" onclick="setTerm()">1개월</button> -->
<!-- <button id="term" name="term" value="60" onclick="setTerm()">2개월</button> -->
<!-- <button id="term" name="term" value="90" onclick="setTerm()">3개월</button> -->
<div id="selectterm">
<table>
	<tr>
		<th>예매번호</th>
		<th>티켓명</th>
		<th>관람일시</th>
		<th>매수</th>
		<th>취소 가능일</th>
		<th>예매 취소</th>
	</tr>
	<c:set value="1" var="one" />
	<c:forEach items="${reservecodeList }" var="i"	varStatus="Istatus">
	
	<!-- setting부분 -->
	<c:forEach items="${reserveList }" var="j">
		<c:if test="${i.reserve_code eq j.reserve_code }">
			<c:set value="${j.ticket_code }" var="each_ticketcode"/>
		</c:if>
	</c:forEach>
	<c:forEach items="${ticketList }" var="j">
		<c:if test="${j.ticket_code eq each_ticketcode }">
			<c:set value="${j.match_code }" var="each_matchcode"/>
		</c:if>
	</c:forEach>
	
		<tr>
			<td><a href="/mypage/ticket?reserve_code=${i.reserve_code }">${i.reserve_code }</a></td>
			<td>
				<c:forEach items="${matchList }" var="m" varStatus="mStatus">
					<c:if test="${Istatus.index eq mStatus.index }">
						[2019 신한은행 MY CAR KBO 리그]<br>${m.hometeam_name } vs ${m.awayteam_name }
					</c:if>
				</c:forEach>
			</td>
			<td>
				<c:set value="1" var="one" />
				<c:forEach items="${matchList }" var="m">
					<c:if test="${one=='1' && m.match_code == each_matchcode }">
						<fmt:formatDate value="${m.match_date }"  pattern="yyyy.MM.dd(E) HH:mm"/>
						<c:set value="2" var="one" />
					</c:if>
				</c:forEach>		
			</td>
			
				<c:set value="0" var="count" />
				<c:forEach items="${ticketList }" var="tc" varStatus="tcStatus">
					<c:if test="${tc.ticket_code eq each_ticketcode }">
						<c:set value="${tcStatus.index }" var="count"/>
					</c:if>
				</c:forEach>

			<td>
				<c:forEach items="${seatCntList }" var="s" varStatus="Sstatus">
					<c:if test="${Istatus.index eq Sstatus.index }">
					${s }장
					</c:if>
				</c:forEach>
			</td>
			<td name="cancledate">
				<c:forEach items="${matchList }" var="m">
					<c:if test="${m.match_code == each_matchcode }">
						<fmt:formatDate var="matchdate" value="${m.match_date }"  pattern="yyyyMMdd HH:mm"/>
						<input type="hidden" id="matchdate" name="matchdate" value="${matchdate }" />
						<fmt:formatDate value="${m.match_date }"  pattern="yyyy.MM.dd "/>
					</c:if>
				</c:forEach>
			</td>
			<td name="canclepossible"><a href="/mypage/cancle?reserve_code=${i.reserve_code }"></a></td>
		</tr>
		<c:set value="2" var="one" />
	</c:forEach>
</table>
</div>
</div>
<br>

</div>

<%-- <c:import url="/WEB-INF/views/layout/mypage_paging.jsp" /> --%>


<c:import url="/WEB-INF/views/layout/footer.jsp" />