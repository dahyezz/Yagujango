<%@page import="java.util.List"%>
<%@page import="dto.Stadium"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%	List<Stadium> list = (List)request.getAttribute("st"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Yagujango</title>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&display=swap&subset=korean" rel="stylesheet">
<script type="text/javascript">
$(function(){
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


#main {
	color: #5050FF;
	font-family: "Nanum Gothic", sans-serif;
	font-weight: 800;
	font-size: 40px;
	text-align: center;
}

body { margin: 0; }
.zeta-menu-bar {
	text-align: center;
	background: #8C8C8C;
	display: inline-block;
	width: 100%;
}
.zeta-menu { 
	margin: 0;
	padding: 0;
}
.zeta-menu li {
	float: left;
	list-style:none;
	position: relative;
}
.zeta-menu li:hover { background: white; }
.zeta-menu li:hover>a { color: hotpink; }
.zeta-menu a {
	color: white;
	display: block;
	padding: 10px 20px;
	text-decoration: none;
}
.zeta-menu ul {
	background: #eee;
	border: 1px solid silver;
	display: none;
	padding: 0;
	position: absolute;
	left: 0;
	top: 100%;
	width: 180px;
}
.zeta-menu ul li { float: none; }
.zeta-menu ul li:hover { background: #ddd; }
.zeta-menu ul li:hover a { color: black; }
.zeta-menu ul a { color: black; }
.zeta-menu ul ul { left: 100%; top: 0; }
.zeta-menu ul ul li {float:left; margin-right:10px;}
</style>
</head>
<body>


<div id="headerDiv">
	<p id="main">야구장고</p>
</div>

<div class='zeta-menu-bar'>
  <ul class="zeta-menu">
    <li><a href="#">예약</a>
      <ul>
	      <% for(int i=0; i<list.size(); i++) { %>
	        <li><a href="/reserve/list?stadium_code=<%=list.get(i).getStadium_code() %>"><%=list.get(i).getStadium_name() %></a></li>
		  <% } %>
      </ul>
     </li>
    <li><a href="#">좌석뷰 게시판</a></li>
    <li><a href="#">자유 게시판</a></li>
    <li><a href="#">문의 게시판</a></li> 
    <li><a href="#">마이페이지</a></li> 
  </ul>
</div>

<hr>

<c:if test="${empty login }">
	<strong>로그인이 필요합니다</strong><br>
	<button onclick="location.href='/member/login';">로그인</button>
	<button onclick="location.href='/member/join';">회원가입</button>
</c:if>

<c:if test="${login }">
	${userid }님, 접속을 환영합니다.
	<button onclick="location.href='/member/logout';">로그아웃</button>
</c:if>

</body>
</html>