<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- font url -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&display=swap&subset=korean" rel="stylesheet">

<script type="text/javascript">

var popupX = (window.screen.width / 2) - (500/2);
var popupY = (window.screen.height / 2) - (400/2);

function popup_terms(){

	window.open('http://localhost:8088/popup_terms','이용약관','width=500, height=400, left='+popupX+', top='+popupY);

}

function popup_personal(){
	window.open("http://localhost:8088/popup_personal","개인정보취급방침", "width=500, height=400, left="+popupX + ", top="+popupY);
}
</script>

<style type="text/css">
.allfooter {
	float: center;
	width: 100%;
	height: 189px;
    background-color: #d9e1e8;
	text-align: center;
}
.footername {
	float: left;

 	margin: 0 0 0 15%;
	width: 15%;
	height: 150px;

}
.footername p {
	color: #0080ff;
	font-family: 'Do Hyeon', sans-serif;
	font-weight: 800;
	font-size: 30px;
	text-align: center;
}

.policy {
	float: left;
	width: 15%;
	height: 150px;
 	margin: 20px auto; 
 	text-align: left;
}
.policy a {
	text-decoration: none;
	color: #282c37;
	font-size: 14px;
	font-family: "Nanum Gothic", sans-serif;
	font-weight: 600; 
}

.info {
	float: left;
	text-align: left;
	
 	margin:20px 10% 20px 20px; 
 	width: 40%;
}
.info p {
	margin: 0;
	padding: 0;
	font-family: 'Nanum Gothic', sans-serif;
}
td,p{
    color: #282c37;        
}

</style>

<hr>

<div class="allfooter">
<div class="footername">
	<p>야구장고</p>
</div>

<div class="policy">
	<a href="" onclick="popup_terms()">이용약관</a><br>
	<a href="" onclick="popup_personal()">개인정보취급방침</a><br>
</div>

<div class="info">
	<p>서울시 강남구 테헤란로 14길 남도빌딩 2층 야구장고</p>
	<p>사업자등록번호 : 851-87-00622 대표번호 : 1544-9970 </p>
	<p>통신판매업신고 강남 02549호</p>
	<p style="font-size: 10px">Copyright © 1982-2019 YAGUJANGO All Rights Reserved.</p>
</div>
</div>

</body>
</html>