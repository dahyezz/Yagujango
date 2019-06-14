<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>

<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>

<style type="text/css">
.login-form{
	background-color : #eeeff1;
	border-radius: 5px;
	margin-left: auto;
	margin-right: auto;
	width: 300px;
	height: 260px;
	padding: 20px;

}
.text-field {
  border: 15px solid #ffffff;
  border-radius: 5px;
  font-size: 15px;
  margin: 10px 0 0 0;
  width: 260px;
  height: 15px;
  margin-left:5px;

}
.btn-submit{
  font-size: 15px;
  background-color: #0080ff;
  border-radius: 5px;
  border: 10px solid #0080ff;
  width: 260px;
  height: 40px;
  margin: 30px 0 40px 0;
  margin-left: 20px;
  
/*   margin: 15px 0 25px 0; */
}
.find{
	text-align:center;
	margin-top:50px;
	margin-left:110px;

}
</style>
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

function idFind(){
	var username=document.getElementById("username").value;
	var email=document.getElementById("email").value;
	console.log(username);
	if(!username){
		alert("이름을 입력하지 않았습니다");
		return false;
	} else if(!email){
		alert("이메일을 입력하지 않았습니다");
		return false;
	} else{
		var param="username="+username+"&email="+email;
		httpRequest=getXMLHttpRequest();
		httpRequest.onreadystatechange=callback;
		httpRequest.open("POST","/member/idFind",true);
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
<div class="login-form">
<form action="/member/idFind" method="post">
	<label for="username">이름</label><br>
	<input type="text" id="username" name="username" class="text-field" placeholder="이름"/><br>
	<label for="email">이메일</label><br>
	<input type="text" id="email" name="email" class="text-field" placeholder="이메일@naver.com"/><br><br>
	
	
	<input type="button" class="find" value="아이디 찾기" onclick="idFind()"/>
</form>
<br>
<div id="result"></div> 
</div>
</body>
</html>