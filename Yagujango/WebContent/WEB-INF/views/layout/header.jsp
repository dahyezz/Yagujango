<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Yagujango</title>

<link rel="shortcut icon" type="image/x-icon" href="/img/main/logo.png" />

<!-- jQuery 2.2.4 -->
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>

<!-- font url -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&display=swap&subset=korean" rel="stylesheet">

<script type="text/javascript">
$(document).ready(function() {
	
	$(".zeta-menu li").hover(function(){
		$('ul:first',this).show();
	}, function(){
		$('ul:first',this).hide();
	});
	
	$(".zeta-menu>li:has(ul)>a").each( function() {
		$(this).html( $(this).html()+' &or;' );
	});
	
	$(".zeta-menu ul li:has(ul)")
		.find("a:first")
		.append("<p style='float:right;margin:-3px'>&#9656;</p>");

});



</script>

<style type="text/css">
#logo{
    width: 40px;
    height: 40px;
}
.headerDiv {
	font-family: "Nanum Gothic", sans-serif;
	font-weight: 800;
	font-size: 40px;
	text-align: center;
	margin: 20px;
}
.headerDiv a {
	text-decoration: none !important;
	color: #5050FF;
}

body { 
	margin: 0;
}
.zeta-menu-bar {
	text-align: center;
	background:  #9baec8;
	display: inline-block;
	width: 100%;
 	position:relative;z-index:2
}
.zeta-menu { 
	margin: 0;
	padding: 0;
}
.zeta-menu li {
	float: left;
	list-style:none;
	position: relative;
	width: 20%;
}
.zeta-menu li:hover { background: white; }
.zeta-menu li:hover>a { color:  #0080ff; }
.zeta-menu a {
	color: white;
	font-family: "Nanum Gothic", sans-serif;
	display: block;
	padding: 10px 20px;
	text-decoration: none;
}
.zeta-menu ul {
	background: #9baec8;
	border: 1px solid silver;
	display: none;
	padding: 0;
	position: absolute;
	left: 0;	
	top: 100%;
	width: 100%;
	float: center;
}
.zeta-menu ul li { float: none; width: auto;}
.zeta-menu ul li:hover { background: white; }
.zeta-menu ul li:hover a { color: #0080ff; }
.zeta-menu ul a { color: white; }
.zeta-menu ul ul { left: 100%; top: 0; }
.zeta-menu ul ul li {float:left; margin-right:10px;}

/* 상단 로그인/회원가입버튼 */
.loginstatus {
	text-align: right;
	margin: 10px;
}
.loginstatus a {
	font-family: "Nanum Gothic", sans-serif;
	color: #282c37;
	text-decoration: none !important;
}

</style>

</head>
<body>

<div class="loginstatus">
	<c:if test="${userid eq 'admin' }">
		<div style="float: left;"><a href="/admin/list">관리자</a></div>
	</c:if>

	<c:if test="${login }">
		<a href="/member/logout">로그아웃</a>&nbsp;&nbsp;
		<a href="/mypage/main">회원정보</a>	
	</c:if>
	<c:if test="${empty login }">
		<a href="/member/login">로그인</a>&nbsp;&nbsp;
		<a href="/member/joinTerms">회원가입</a>	
	</c:if>
</div>

<div class="headerDiv">
	<img src="/img/main/logo.png" id="logo">
	<a href="/main">야구장고</a>
</div>

<div class='zeta-menu-bar'>
  <ul class="zeta-menu">
    <li><a href="#">예매하기</a>
      <ul>
    		<li><a href="/reserve/list?stadium_code=1">KIA</a></li>
    		<li><a href="/reserve/list?stadium_code=2">KT</a></li>
    		<li><a href="/reserve/list?stadium_code=3">LG</a></li>
	    	<li><a href="/reserve/list?stadium_code=4">NC</a></li>
		    <li><a href="/reserve/list?stadium_code=5">SK</a></li>
		    <li><a href="/reserve/list?stadium_code=6">두산</a></li>
		    <li><a href="/reserve/list?stadium_code=7">롯데</a></li>
		    <li><a href="/reserve/list?stadium_code=8">삼성</a></li>
		    <li><a href="/reserve/list?stadium_code=9">키움</a></li>
		    <li><a href="/reserve/list?stadium_code=10">한화</a></li>
		    <li><a href="/reserve/inform">예매안내</a></li>
      </ul>
     </li>
    <li><a href="/board/seat/list">좌석뷰 게시판</a></li>
    <li><a href="/board/free/list">자유 게시판</a></li>
    <li><a href="/board/faq/faqlist">문의 게시판</a></li> 
    <li><a href="/mypage/main">마이페이지</a>
    	<ul>
    		<li><a href="/mypage/main">예매 확인/취소</a></li>
    		<li><a href="/member/modify">회원 정보 수정</a></li>
	    	<li><a href="/member/my1to1">나의 1:1 문의 내역</a></li>
      </ul>
    </li> 
  </ul>
</div>
