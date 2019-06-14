<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<script type="text/javascript">
$(document).ready(function(){
	var match = document.getElementById("matchdate").value;

	console.log(match);
	
	var cancleDate=new Date(match);
	console.log(cancleDate);
// 	cancleDate.setHours(cancleDate.getHours()-3);
// 	console.log(cancleDate);
	
	var nowdate = new Date();
	console.log(nowdate.getHours()-3)
	
	var tDate = new Date('2018-07-10 12:30')
	tDate.setHours(tDate.getHours()+6)
	console.log(tDate)
	console.log(tDate.toLocaleString());
	
});
</script>

<style type="text/css">
.myteam div{	/* class가 myteam인 것의 하위요소 중 div요소만 선택 */
	width:600px;
	height:200px;
}
.myteam img{
	width:150px;
	height:150px;
	margin-top:20px;
}
.userInfo table{
	width:300px;
	height:100px;
}
.reservation table, th, td{
	width:700px;
	height:50px;
	text-align: center;
	border:1px solid #ccc;
	border-collapse:collapse; /* 각각의 셀들의 테두리가 겹치는 부분을 하나의 선으로 합침 */
}

</style>

<h1>마이페이지</h1>
<hr>

<div class="myteam">
<c:choose>
	<c:when test="${myteam eq 'KIA' }"><div style="background:#F01E23"><img src="/img/teamLogo/kia.png"/></div></c:when>
	<c:when test="${myteam eq 'KT' }"><div style="background:#000000"><img src="/img/teamLogo/kt.png"/></div></c:when>
	<c:when test="${myteam eq 'LG' }"><div style="background:#C30452"><img src="/img/teamLogo/lg.png"/></div></c:when>
	<c:when test="${myteam eq 'NC' }"><div style="background:#315288"><img src="/img/teamLogo/nc.png"/></div></c:when>
	<c:when test="${myteam eq 'SK' }"><div style="background:#F20017"><img src="/img/teamLogo/sk.png"/></div></c:when>
	<c:when test="${myteam eq '두산' }"><div style="background:#131230"><img src="/img/teamLogo/doosan.png"/></div></c:when>
	<c:when test="${myteam eq '롯데' }"><div style="background:#002856"><img src="/img/teamLogo/lotte.png"/></div></c:when>
	<c:when test="${myteam eq '삼성' }"><div style="background:#074CA1"><img src="/img/teamLogo/samsung.png"/></div></c:when>
	<c:when test="${myteam eq '키움' }"><div style="background:#820024"><img src="/img/teamLogo/kiwoom.png"/></div></c:when>
	<c:when test="${myteam eq '한화' }"><div style="background:#FF6600"><img src="/img/teamLogo/hanwha.png"/></div></c:when>
	<c:otherwise><div style="background:#ccc"><img src="/img/teamLogo/noteam.png"/></div></c:otherwise>
</c:choose>
</div>

<span class="userInfo">
	<table>
	<tr>
		<td>아이디 : </td>
		<td>${userid }</td>
	</tr>
	<tr>
		<td>닉네임 : </td>
		<td>${usernick }</td>
	</tr>
	<tr>
		<td>마이팀 : </td>
		<td>
			<c:if test="${myteam ne '0' }">${myteam }</c:if>
			<c:if test="${myteam eq '0' }"><a href="/mypage/modify">설정하기</a></c:if>
		</td>
	</tr>
	</table>
</span>

<h3>예매 확인/취소</h3>
<hr>
<span>예매번호를 클릭하면 예매 상세내용을 확인 할 수 있습니다.</span><br>
<span>상태를 클릭하면 취소여부와 예매 취소를 할수 있습니다.</span><br>

<div class="reservation">
<table>
<thead>
	<tr>
		<th>예매번호</th>
		<th>티켓명</th>
		<th>관람일시</th>
		<th>매수</th>
		<th>좌석번호</th>
		<th>취소가능일</th>
		<th>상태</th>
	</tr>
</thead>
<c:forEach items="${reservecodeList}" var="i" varStatus="Istatus">
	<tr>
		<td><a href="/mypage/ticket">${i.reserve_code }</a></td>
		<td>
			<c:forEach items="${matchList }" var="m" varStatus="Mstatus">
				<c:if test="${Istatus.index eq Mstatus.index }">
				[2019 신한은행 MY CAR KBO 리그]<br>${m.hometeam_name } vs ${m.awayteam_name }
				</c:if>
			</c:forEach>
		</td>
		<td>
			<c:forEach items="${matchList }" var="m" varStatus="Mstatus">
				<c:if test="${Istatus.index eq Mstatus.index }">
				<fmt:formatDate value="${m.match_date}" pattern="yyyy-MM-dd HH:mm"/></p>
				<input type="hidden" id="matchdate" value="${match.match_date }"/>
				</c:if>
			</c:forEach>
		</td>
		<td></td>
		<td>
			<c:forEach items="${seatList }" var="s" varStatus="Sstatus">
				<c:if test="${Sstatus.index <= seatCountList[Istatus.index] }">
					${s.seat_block }블럭 ${s.seat_number }석
				</c:if>

			</c:forEach>
		</td>
		<td><%-- <fmt:formatDate value="${cancledate}" pattern="yyyy/MM/dd HH:mm"/> --%>
			<!-- <input type="text" id="cancledate"/> --></td>
		<td><a href="/mypage/ticket">취소가능</a></td>
	</tr>
</c:forEach>
</table>
</div>

<c:import url="/WEB-INF/views/layout/mypage_paging.jsp" />

<c:import url="/WEB-INF/views/layout/footer.jsp" />