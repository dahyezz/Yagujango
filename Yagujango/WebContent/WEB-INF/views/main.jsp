<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<!--bootstrap-->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

<link href="/css/jquery.bxslider.min.css" rel="stylesheet" />
<script src="/js/jquery.bxslider.min.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	$('.bxslider').bxSlider({
// 		auto: true,
		speed: 500,
		pause: 10000,
		mode: 'horizontal'
// 		pager: true
	});
});
</script>

<style type="text/css">

.club{
    text-align: center;
    margin-left: 5%;
    margin-right: 5%;
    margin: auto;
}

.threematch {
	width: 78%;
	height: 280px;
    margin-left: 5%;
    margin-right: 5%;
    margin: auto;
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
	color: #282c37;

}
div[class^="day_"] table {
	text-align: center;
    background-color: #d9e1e8;
    margin: auto;
    height: 230px;
    width: 250px;

}

div[class^="day_"] td {
	font-family: "Nanum Gothic", sans-serif;
	font-weight: 400;
	color: #282c37;
}


.rank {
	font-family: "Nanum Gothic", sans-serif;
	font-weight: 400;
	
	width: 130px;
	border: 1px solid #9baec8;
	text-align: center;
	margin-top: 10px;
	float: right;
}

.rank h5 {
	color: #282c37;
	font-family: "Nanum Gothic", sans-serif;
	font-weight: 700;
	font-size: 15px;
	text-align: center;
	margin: 10px 0 ;
}

.img{
    width: 15px;
    height: 15px;
}
.img2{
    width: 50px;
    height: 50px;
}

.highlight { 
	width: 80%; 
 	position: relative; 
 	text-align: center; 
 	display: block; 
 	margin: 20px auto;
}

.highlight p { 
 	font-family: "Nanum Gothic", sans-serif; 
 	font-weight: 700;
 	font-size: 20px; 
 	text-align: left; 
} 	

a{
	text-decoration: none !important;
}


</style>

<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
  <ol class="carousel-indicators">
    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
  </ol>
  <div class="carousel-inner">
    <div class="carousel-item active"class="carousel">
      <a href="https://allstar.koreabaseball.com/" target="_blank"><img src="/img/main/allstar1.png" class="d-block w-100" alt="..." ></a>
    </div>
    <div class="carousel-item">
      <a href="https://allstar.koreabaseball.com/" target="_blank"><img src="/img/main/carousel2.png" class="d-block w-100" alt="..."class="carousel"></a>
    </div>
    <div class="carousel-item">
      <img src="/img/main/carousel1.png" class="d-block w-100" alt="..."class="carousel">
    </div>
  </div>
  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>


<div class="club">
    <a href="https://www.tigers.co.kr/mainSeasonOn.asp" target="_blank"><img src="/img/main/ki1.png"></a>
    <a href="https://www.doosanbears.com/" target="_blank"><img src="/img/main/do2.png"></a>
    <a href="https://www.lgtwins.com/service/html.ncd?view=/pc_twins/twins_main/twins_main" target="_blank"><img src="/img/main/lg2.png"></a>
    <a href="http://www.ktwiz.co.kr/sports/site/baseball/main.do" target="_blank"><img src="/img/main/kt2.png"></a>
    <a href="http://www.hanwhaeagles.co.kr/html/main/main.asp" target="_blank"><img src="/img/main/han2.png"></a>
    <a href="http://www.skwyverns.com/Wyverns/main.asp" target="_blank"><img src="/img/main/sk1.png"></a>
    <a href="http://www.heroesbaseball.co.kr/index.do" target="_blank"><img src="/img/main/hi2.png"></a>
    <a href="http://www.ncdinos.com/main/index" target="_blank"><img src="/img/main/nc2.png"></a>
    <a href="http://www.samsunglions.com/" target="_blank"><img src="/img/main/sam2.png"></a>
    <a href="http://www.giantsclub.com/html/" target="_blank"><img src="/img/main/ro2.png"></a>
</div>

<c:set var="now" value="<%=new java.util.Date() %>" /><!-- 오늘날짜 -->
<c:set var="today"><fmt:formatDate value="${now }" pattern="yyyy/MM/dd"/></c:set>
<c:set var="tom" value="<%=new java.util.Date(new java.util.Date().getTime() + 1000 * 60 * 60 * 24 * 1) %>" /><!-- 1일 뒤 -->
<c:set var="tomorrow"><fmt:formatDate value="${tom }" pattern="yyyy/MM/dd"/></c:set>
<c:set var="aft" value="<%=new java.util.Date(new java.util.Date().getTime() + 1000 * 60 * 60 * 24 * 2) %>" /><!-- 2일 뒤 -->
<c:set var="aftertomorrow"><fmt:formatDate value="${aft }" pattern="yyyy/MM/dd"/></c:set>
<c:set var="tdaft" value="<%=new java.util.Date(new java.util.Date().getTime() + 1000 * 60 * 60 * 24 * 3) %>" /><!-- 3일 뒤 -->
<c:set var="tdaftertomorrow"><fmt:formatDate value="${tdaft }" pattern="yyyy/MM/dd"/></c:set>


<div class="threematch">
<!-- <div class="day_first"> -->
<%-- <c:set value="1" var="day"/> --%>
<!-- <table> -->
<%-- 	<c:forEach items="${matchList }" var="i"> --%>
<%-- 	<c:set var="checkdate" ><fmt:formatDate value="${i.match_date }" pattern="yyyy/MM/dd" /></c:set> --%>
<%-- 	<c:if test="${checkdate  eq today}"> --%>
<%-- 		<c:if test="${day == '1' }"> --%>
<%-- 			<h5><fmt:formatDate value="${i.match_date }" pattern="MM월 dd일 (E)"/></h5> --%>
<%-- 		</c:if> --%>
<!-- 			<tr> -->
<%-- 				<td><fmt:formatDate value="${i.match_date }" pattern="HH:mm"/> --%>
<!-- 				<td></td><td></td> -->
<%-- 				<td>${i.hometeam_name }</td> --%>
<!-- 				<td>:</td> -->
<%-- 				<td>${i.awayteam_name }</td> --%>
<!-- 			</tr> -->
		
<%-- 		<c:set value="2" var="day" />  --%>
<%-- 	</c:if> --%>
<%-- </c:forEach> --%>
<!-- </table> -->
<!-- </div> -->

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
	<c:if test="${i.match_code ne 0 }">
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
			<td><img src="/img/rank/sk.png"class="img"></td>
			<td>SK</td>
		</tr>
		<tr>
			<td>2</td>
			<td><img src="/img/rank/do.png" class="img"></td>
			<td>두산</td>
		</tr>
		<tr>
			<td>3</td>
	        <td><img src="/img/rank/lg.png" class="img"></td>
	        <td>LG</td>
	     </tr>
	     <tr>
	        <td>4</td>
	        <td><img src="/img/rank/hi.png" class="img"></td>
	        <td>키움</td>
	     </tr>
	     <tr>
	        <td>5</td>
	        <td><img src="/img/rank/nc.png" class="img"></td>
	        <td>NC</td>
	     </tr>
	     <tr>
	        <td>6</td>
	        <td><img src="/img/rank/kt.png" class="img"></td>
	        <td>KT</td>
	     </tr>
	     <tr>
	        <td>7</td>
	        <td><img src="/img/rank/sam.png" class="img"></td>
	        <td>삼성</td>
	     </tr>
	     <tr>
	        <td>8</td>
	        <td><img src="/img/rank/han.png" class="img"></td>
	        <td>한화</td>
	     </tr>
	     <tr>
	        <td>9</td>
	        <td><img src="/img/rank/ki.png" class="img"></td>
	        <td>KIA</td>
	     </tr>
	     <tr>
	        <td>10</td>
            <td><img src="/img/rank/ro.png" class="img"></td>
			<td>롯데</td>
		</tr>
	</table>
</div>
</div>

<br>
<div class="highlight">
	<p>전체 하이라이트</p>
	<ul class="bxslider">
		<li><iframe title="[전체HL] 'KBO 최초 무안타 타자일순' 두산, LG 상대로 적시타 없이 승리" width="640" height="360" src="https://play-tv.kakao.com/embed/player/cliplink/399450482?service=daum_sports"></iframe></li>
		<li><iframe title="[전체HL] '샌즈 3안타' 키움, 한화 꺾고 스윕 달성" width="640" height="360" src="https://play-tv.kakao.com/embed/player/cliplink/399450392?service=daum_sports"></iframe></li>
		<li><iframe title="[전체HL] '나종덕 홈런-장시환 호투' 롯데, KIA에 2연승" width="640" height="360" src="https://play-tv.kakao.com/embed/player/cliplink/399450060?service=daum_sports"></iframe></li>
		<li><iframe title="[전체HL] '강백호 결승타' KT, 삼성 이틀 연속 제압하며 6위 점프" width="640" height="360" src="https://play-tv.kakao.com/embed/player/cliplink/399449318?service=daum_sports"></iframe></li>
		<li><iframe title="[전체HL] '문승원 호투+나주환 4타점' SK, NC 상대로 스윕 달성" width="640" height="360" src="https://play-tv.kakao.com/embed/player/cliplink/399447538?service=daum_sports"></iframe></li>
	</ul>
	
</div>
<c:import url="/WEB-INF/views/layout/footer.jsp" />


