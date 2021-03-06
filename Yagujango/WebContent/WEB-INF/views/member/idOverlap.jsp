<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복 확인</title>

<script type="text/javascript">
var httpRequest = null;

// httpRequest 객체 생성
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

function getIdValue(){
	document.getElementById("userid").value=opener.document.joinForm.userid.value;
	//부모창(회원가입화면)의 값 가져오기서 중복체크 화면의 아이디 입력란에 세팅
}

function idOverlap(){
	var userid=document.getElementById("userid").value;

	if(!userid){
		alert("아이디를 입력하지 않았습니다");
		return false;
	} 
/* 	else if((userid<"0" || userid>"9") && (userid<"A" || userid>"Z") && (userid<"a" || userid>"z")){
		alert("한글 및 특수문자는 아이디로 사용하실 수 없습니다");
		return false;
	} */
	else{
		var param="userid="+userid;
		httpRequest=getXMLHttpRequest();
		httpRequest.onreadystatechange=callback;
		httpRequest.open("POST","/member/idOverlap",true);
		httpRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		httpRequest.send(param);
	}
}

function callback(){
	if(httpRequest.readyState==4){
		var resultText=httpRequest.responseText;
		
		if(resultText==0){
			document.getElementById("result").innerHTML="사용할 수 없는 아이디입니다";
			document.getElementById("cancleBtn").style.visibility='visible';
            document.getElementById("useBtn").style.visibility='hidden';
		} else if(resultText==1){
			document.getElementById("result").innerHTML="사용 가능한 아이디 입니다";
			document.getElementById("cancleBtn").style.visibility='hidden';
            document.getElementById("useBtn").style.visibility='visible';
		}
	}
}

//사용하기 클릭 시 부모창으로 아이디 값 전달
function sendIdValue(){
	//중복 체크를 했다는 결과를 전달
	opener.document.joinForm.idUncheck.value="idCheck";
	
	//회원가입 화면에 id값 전달
	opener.document.joinForm.userid.value=document.getElementById("userid").value;
	
	//값 전달 후 중복체크 창을 닫는다
	if(opener!=null){
		opener.idCheck=null;
		self.close();
	}
}

</script>

<style type="text/css">
.idOverlap{
	background-color : #eeeff1;
	margin:-7px;
	padding:15px 0 30px 15px;
}

.idOverlap input[type="text"]{
	width:260px;
	height:30px;
	border-radius: 5px;
	border:1.5px solid #ccc;
	font-size:20px;
	padding-left:10px;
}

.idOverlap input[type="button"]{
	margin:15px 0 20px 60px;
	width:145px;
	background-color:#0080ff;
	border:#0080ff;
	color:white;
	font-size:15px;
	font-weight:bold;
	border-radius: 5px;
	padding: 10px;
	cursor:pointer;
}

#result{
	height:40px;
	font-weight:bold;
	color:#0080ff;
	text-align:center;
}

.idOverlap button{
	margin:10px 0 0 20px;
	width:100px;
	background-color:#0080ff;
	border:#0080ff;
	color:white;
	font-size:15px;
	font-weight:bold;
	border-radius: 5px;
	padding: 10px;
	cursor:pointer;
}
</style>

</head>
<body onload="getIdValue()"> <!-- 화면이 열리면 getIdValue() 호출 -->

<div class="idOverlap">

	<form action="member/idOverlap" method="post" id="idCheck">
		<input type="text" name="userid" id="userid"/>
		<input type="button" value="아이디 중복 체크" onclick="idOverlap()"/>
	</form>
	
	<div id="result"></div>
	
	<button id="cancleBtn" onclick="window.close()">취소</button>
	<button id="useBtn" onclick="sendIdValue()">사용하기</button>
</div>

</body>
</html>