<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>

<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	$("#btnPwfind").click(function(){
		
		//id가 username, email인 객체를 변수에 저장
		var Username=$("#username").val();
		var Email=$("#email").val();
		var Userid=$("#userid").val();
		
		//요청 url
		var url="/member/pwFind_ok.jsp";
		
		//요청파라미터
		var data={username:Username, email:Email, userid:Userid};
		
		//변수의 value가 공백이면 alert창 띄우고 return false를 함
		if(Username ==""){
			alert("이름을 입력하세요");
			return;
		}
		if(Email ==""){
			alert("이메일을 입력하세요");
			return;
		}
		if(Userid ==""){
			alert("아이디를 입력하세요");
			return;
		}
		
		//Ajax 요청 보내기
		$.post(url, data, function(res){
			$("#result").html(res);
		});
	});
});
</script>

</head>
<body>

<form action="/member/pwFind" method="post">
	<label for="username">이름</label><br>
	<input type="text" id="username" name="username" /><br>
	<label for="email">이메일</label><br>
	<input type="text" id="email" name="email" /><br>
	<label for="userid">아이디</label><br>
	<input type="text" id="userid" name="userid" /><br><br>
	
	<button id="btnPwfind">비밀번호 찾기</button>
</form>

<div id="result"></div> 

</body>
</html>