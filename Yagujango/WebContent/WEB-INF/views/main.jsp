<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<c:import url="/WEB-INF/views/layout/header.jsp" />

<style type="text/css">

div[class^="day_"]{
	width: 200px;
	margin: 0;
	float: left;
	
}


</style>

<c:set var="now" value="<%=new java.util.Date() %>" /><!-- 오늘날짜 -->
<c:set var="today"><fmt:formatDate value="${now }" pattern="yyyy/MM/dd"/></c:set>
<c:set var="tom" value="<%=new java.util.Date(new java.util.Date().getTime() + 1000 * 60 * 60 * 24 * 1) %>" />
<c:set var="tomorrow"><fmt:formatDate value="${tom }" pattern="yyyy/MM/dd"/></c:set>
<c:set var="aft" value="<%=new java.util.Date(new java.util.Date().getTime() + 1000 * 60 * 60 * 24 * 2) %>" />
<c:set var="aftertomorrow"><fmt:formatDate value="${aft }" pattern="yyyy/MM/dd"/></c:set>

<div class="day_first">
<c:set value="1" var="day"/>
<c:forEach items="${matchList }" var="i">
	<c:set var="checkdate" ><fmt:formatDate value="${i.match_date }" pattern="yyyy/MM/dd" /></c:set>
	<c:if test="${checkdate  eq today}">
		<c:if test="${day == '1' }">
			<h5><fmt:formatDate value="${i.match_date }" pattern="MM월 dd일 (E)"/></h5>
		</c:if>
		<table>
			<tr>
				<td><fmt:formatDate value="${i.match_date }" pattern="HH:mm"/>
				<td>${i.hometeam_name }</td>
				<td>:</td>
				<td>${i.awayteam_name }</td>
			</tr>
		</table>
		<c:set value="2" var="day" /> 
	</c:if>

</c:forEach>

</div>

<div class="day_second">
<c:set value="1" var="day"/>
<c:forEach items="${matchList }" var="i">
	<c:set var="checkdate" ><fmt:formatDate value="${i.match_date }" pattern="yyyy/MM/dd" /></c:set>
	<c:if test="${checkdate  eq tomorrow}">
		<c:if test="${day == '1' }">
			<h5><fmt:formatDate value="${i.match_date }" pattern="MM월 dd일 (E)"/></h5>
		</c:if>
		<table>
			<tr>
				<td><fmt:formatDate value="${i.match_date }" pattern="HH:mm"/>
				<td>${i.hometeam_name }</td>
				<td>:</td>
				<td>${i.awayteam_name }</td>
			</tr>
		</table>
		<c:set value="2" var="day" /> 
	</c:if>

</c:forEach>

</div>

<div class="day_third">
<c:set value="1" var="day"/>
<c:forEach items="${matchList }" var="i">
	<c:set var="checkdate" ><fmt:formatDate value="${i.match_date }" pattern="yyyy/MM/dd" /></c:set>
	<c:if test="${checkdate  eq aftertomorrow}">
		<c:if test="${day == '1' }">
			<h5><fmt:formatDate value="${i.match_date }" pattern="MM월 dd일 (E)"/></h5>
		</c:if>
		<table>
			<tr>
				<td><fmt:formatDate value="${i.match_date }" pattern="HH:mm"/>
				<td>${i.hometeam_name }</td>
				<td>:</td>
				<td>${i.awayteam_name }</td>
			</tr>
		</table>
		<c:set value="2" var="day" /> 
	</c:if>

</c:forEach>

</div>

<div class="rank">
	<h5>2019 정규리그순위</h5>
	<table>
		<tr>
			<td>1</td>
			<td>SK</td>
		</tr>
		<tr>
			<td>2</td>
			<td>두산</td>
		</tr>
		<tr>
			<td>3</td>
			<td>LG</td>
		</tr>
		<tr>
			<td>4</td>
			<td>키움</td>
		</tr>
		<tr>
			<td>5</td>
			<td>NC</td>
		</tr>
		<tr>
			<td>6</td>
			<td>한화</td>
		</tr>
		<tr>
			<td>6</td>
			<td>삼성</td>
		</tr>
		<tr>
			<td>8</td>
			<td>KT</td>
		</tr>
		<tr>
			<td>9</td>
			<td>KIA</td>
		</tr>
		<tr>
			<td>10</td>
			<td>롯데</td>
		</tr>
	</table>
</div>


<br>
<h3>전체 H/L</h3>
<iframe title="[전체HL] '터커 3타점' KIA, 삼성을 제물로 3연패 탈출" width="320" height="180" src="https://play-tv.kakao.com/embed/player/cliplink/399334495?service=daum_sports"></iframe>
<iframe title="[전체HL] '좀처럼 깨지지 않았던 균형' 12회 연장 접전 끝에 무승부" width="320" height="180" src="https://play-tv.kakao.com/embed/player/cliplink/399304223?service=daum_sports"></iframe>
<iframe title="[전체HL] '김태균 쐐기포+정우람 세이브' 한화, 두산 꺾고 연패 탈출" width="320" height="180" src="https://play-tv.kakao.com/embed/player/cliplink/399304366?service=daum_sports"></iframe>
<iframe title="[전체HL] '김하성 맹타-불펜 호투' 키움, NC에 짜릿한 역전승 " width="320" height="180" src="https://play-tv.kakao.com/embed/player/cliplink/399304293?service=daum_sports" ></iframe>
<iframe title="[전체HL] '21안타 폭발' SK, 압도적인 타력으로 KT 4연승 저지" width="320" height="180" src="https://play-tv.kakao.com/embed/player/cliplink/399302694?service=daum_sports" ></iframe>

<c:import url="/WEB-INF/views/layout/footer.jsp" />


