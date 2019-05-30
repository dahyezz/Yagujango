<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>

<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	$("#btnIdfind").click(function(){
		
		//전달할 데이터를 변수에 담기
		var username=$("#username").val();
		var email=$("#email").val();
		
		$.ajax({
			type:"post",	//HTTP 요청 메소드를 지정
			url:"/member/idFind_ok.jsp",	//Ajax 통신 요청 URL
			data:{	//요청 파라미터
				"username":username,
				"email":email
			},
			dataType:"json",	//응답 데이터 처리 방식(데이터 형식)
			success:function(data){	//요청 성공 시 호출될 콜백 함수
				console.log("성공");
				console.log(data);
				
				$("#result").html(data);
			},
			error:function(){	//요청 실패 시 호출될 콜백 함수
				console.log("실패");
			}
		});
		
	});
});
</script>

</head>
<body>

<div>
<form action="/member/idFind" method="post">
	<label for="username">이름</label><br>
	<input type="text" id="username" name="username" /><br>
	<label for="email">이메일</label><br>
	<input type="email" id="email" name="email" /><br><br>
	
	<button id="btnIdfind">아이디 찾기</button>
</form>
</div>

<div id="result"></div>

</body>
</html>