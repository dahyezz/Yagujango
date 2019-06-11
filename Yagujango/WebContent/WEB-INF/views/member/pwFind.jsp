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

var httpRequest = null;

//httpRequest 객체 생성
function getXMLHttpRequest(){
 var httpRequest = null;

 if(window.ActiveXObject){
     try{
         httpRequest = new ActiveXObject("Msxml2.XMLHTTP");    
     } catch(e) {
         try{
             httpRequest = new ActiveXObject("Microsoft.XMLHTTP");
         } catch (e2) { httpRequest = null; }
     }
 }
 else if(window.XMLHttpRequest){
     httpRequest = new window.XMLHttpRequest();
 }
 return httpRequest;    
}

function pwFind(){
	var username=document.getElementById("username").value;
	var email=document.getElementById("email").value;
	var userid=document.getElementById("userid").value;
	
	if(!username){
		alert("이름을 입력하지 않았습니다");
		return false;
	} else if(!email){
		alert("이메일을 입력하지 않았습니다");
		return false;
	} else if(!userid){
		alert("아이디를 입력하지 않았습니다");
		return false;
	} else{
		var param="username="+username+"&email="+email+"&userid="+userid;
		httpRequest=getXMLHttpRequest();
		httpRequest.onreadystatechange=callback;
		httpRequest.open("POST","/member/pwFind",true);
		httpRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		httpRequest.send(param);
	}
}

function callback(){
	if(httpRequest.readyState==4){
		var resultText=httpRequest.responseText;
		
		document.getElementById("result").innerHTML=resultText;
	}
}
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
	
	<input type="button" value="비밀번호 찾기" onclick="pwFind()"/>
</form>

<div id="result"></div> 

</body>
</html>