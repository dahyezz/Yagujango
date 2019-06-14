<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<link href="jquery.bxslider/jquery.bxslider.css" rel="stylesheet" />
<script src="jquery.bxslider/jquery.bxslider.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	$('.sliderbox').bxslider();
});
</script>

<style type="text/css">

.threematch {
	width: 80%;
	height: 200px;
	margin: 30px 10px 0 10%;
}

div[class^="day_"]{
	width: auto;
	margin: 10px;
	float: left;
	border: 1px solid #9baec8;
	
}

div[class^="day_"] h5 {
	font-family: "Nanum Gothic", sans-serif;
	font-weight: 700;
	font-size: 15px;
	text-align: center;
	margin: 10px 0 ;

}
div[class^="day_"] table {
	text-align: center;
	margin: auto;

}

div[class^="day_"] td {
	font-family: "Nanum Gothic", sans-serif;
	font-weight: 400;
}


.rank {
	font-family: "Nanum Gothic", sans-serif;
	font-weight: 400;
	
	width: 130px;
	border: 1px solid #9baec8;
	text-align: center;
	margin: 0;
	float: right;
}

.rank h5 {
	font-family: "Nanum Gothic", sans-serif;
	font-weight: 700;
	font-size: 15px;
	text-align: center;
	margin: 10px 0 ;
}

/* .highlight { */
/* 	width: 80%; */
/* 	position: relative; */
/* 	text-align: center; */
/* 	display: block; */
	
/* } */

/* .highlight p { */
/* 	font-family: "Nanum Gothic", sans-serif; */
/* 	font-weight: 700; */
/* 	font-size: 20px; */
/* 	text-align: left; */
/* } */

/* .sliderbox { */
/* 	width: 800px; */
/* 	height: 450px; */
/* 	overflow: hidden; */
/* 	margin: 0 auto; */

/* } */

/* #slider { */
/* 	padding: 0; */
/* 	margin: 0; */
/* 	list-style: none; */
/* 	position: relative; */
/* } */

/* #slider li { */
/* 	position: absolute; */
/* } */

</style>

<c:set var="now" value="<%=new java.util.Date() %>" /><!-- 오늘날짜 -->
<c:set var="today"><fmt:formatDate value="${now }" pattern="yyyy/MM/dd"/></c:set>
<c:set var="tom" value="<%=new java.util.Date(new java.util.Date().getTime() + 1000 * 60 * 60 * 24 * 1) %>" /><!-- 1일 뒤 -->
<c:set var="tomorrow"><fmt:formatDate value="${tom }" pattern="yyyy/MM/dd"/></c:set>
<c:set var="aft" value="<%=new java.util.Date(new java.util.Date().getTime() + 1000 * 60 * 60 * 24 * 2) %>" /><!-- 2일 뒤 -->
<c:set var="aftertomorrow"><fmt:formatDate value="${aft }" pattern="yyyy/MM/dd"/></c:set>
<c:set var="tdaft" value="<%=new java.util.Date(new java.util.Date().getTime() + 1000 * 60 * 60 * 24 * 3) %>" /><!-- 3일 뒤 -->
<c:set var="tdaftertomorrow"><fmt:formatDate value="${tdaft }" pattern="yyyy/MM/dd"/></c:set>


<div class="threematch">
<div class="day_first">
<c:set value="1" var="day"/>
<table>
	<c:forEach items="${matchList }" var="i">
	<c:set var="checkdate" ><fmt:formatDate value="${i.match_date }" pattern="yyyy/MM/dd" /></c:set>
	<c:if test="${checkdate  eq today}">
		<c:if test="${day == '1' }">
			<h5><fmt:formatDate value="${i.match_date }" pattern="MM월 dd일 (E)"/></h5>
		</c:if>
			<tr>
				<td><fmt:formatDate value="${i.match_date }" pattern="HH:mm"/>
				<td></td><td></td>
				<td>${i.hometeam_name }</td>
				<td>:</td>
				<td>${i.awayteam_name }</td>
			</tr>
		
		<c:set value="2" var="day" /> 
	</c:if>
</c:forEach>
</table>
</div>

<div class="day_second">
<c:set value="1" var="day"/>
<table>
<c:forEach items="${matchList }" var="i">
	<c:set var="checkdate" ><fmt:formatDate value="${i.match_date }" pattern="yyyy/MM/dd" /></c:set>
	<c:if test="${checkdate  eq tomorrow}">
		<c:if test="${day == '1' }">
			<h5><fmt:formatDate value="${i.match_date }" pattern="MM월 dd일 (E)"/></h5>
		</c:if>
			<tr>
				<td><fmt:formatDate value="${i.match_date }" pattern="HH:mm"/>
				<td></td><td></td>
				<td>${i.hometeam_name }</td>
				<td>:</td>
				<td>${i.awayteam_name }</td>
			</tr>
		<c:set value="2" var="day" /> 
	</c:if>
</c:forEach>
</table>
</div>

<div class="day_third">
<c:set value="1" var="day"/>
<table>
<c:forEach items="${matchList }" var="i">
	<c:set var="checkdate" ><fmt:formatDate value="${i.match_date }" pattern="yyyy/MM/dd" /></c:set>
	<c:if test="${checkdate  eq aftertomorrow}">
		<c:if test="${day == '1' }">
			<h5><fmt:formatDate value="${i.match_date }" pattern="MM월 dd일 (E)"/></h5>
		</c:if>
			<tr>
				<td><fmt:formatDate value="${i.match_date }" pattern="HH:mm"/>
				<td></td><td></td>
				<td>${i.hometeam_name }</td>
				<td>:</td>
				<td>${i.awayteam_name }</td>
			</tr>
		<c:set value="2" var="day" /> 
	</c:if>
</c:forEach>
</table>
</div>

<div class="day_fourth">
<c:set value="1" var="day"/>
<table>
<c:forEach items="${matchList }" var="i">
	<c:set var="checkdate" ><fmt:formatDate value="${i.match_date }" pattern="yyyy/MM/dd" /></c:set>
	<c:if test="${checkdate  eq tdaftertomorrow}">
		<c:if test="${day == '1' }">
			<h5><fmt:formatDate value="${i.match_date }" pattern="MM월 dd일 (E)"/></h5>
		</c:if>
			<tr>
				<td><fmt:formatDate value="${i.match_date }" pattern="HH:mm"/>
				<td></td><td></td>
				<td>${i.hometeam_name }</td>
				<td>:</td>
				<td>${i.awayteam_name }</td>
			</tr>
		<c:set value="2" var="day" /> 
	</c:if>
</c:forEach>
</table>
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

</div>





<br>
<div class="highlight" class="sliderbox">
	<p>전체 하이라이트</p>
	<button>왼쪽</button>
	<button>오른쪽</button>
	<ul id="slider">
		<li><iframe title="[전체HL] '터커 3타점' KIA, 삼성을 제물로 3연패 탈출" width="640" height="360" src="https://play-tv.kakao.com/embed/player/cliplink/399366478?service=daum_sports"></iframe></li>
		<li><iframe title="[전체HL] '좀처럼 깨지지 않았던 균형' 12회 연장 접전 끝에 무승부" width="640" height="360" src="https://play-tv.kakao.com/embed/player/cliplink/399304223?service=daum_sports"></iframe></li>
		<li><iframe title="[전체HL] '김태균 쐐기포+정우람 세이브' 한화, 두산 꺾고 연패 탈출" width="640" height="360" src="https://play-tv.kakao.com/embed/player/cliplink/399304366?service=daum_sports"></iframe></li>
		<li><iframe title="[전체HL] '김하성 맹타-불펜 호투' 키움, NC에 짜릿한 역전승 " width="640" height="360" src="https://play-tv.kakao.com/embed/player/cliplink/399304293?service=daum_sports" ></iframe></li>
		<li><iframe title="[전체HL] '21안타 폭발' SK, 압도적인 타력으로 KT 4연승 저지" width="640" height="360" src="https://play-tv.kakao.com/embed/player/cliplink/399302694?service=daum_sports" ></iframe></li>
	</ul>
	
</div>
<c:import url="/WEB-INF/views/layout/footer.jsp" />


