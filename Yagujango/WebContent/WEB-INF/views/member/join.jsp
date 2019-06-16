<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<style type="text/css">
.join-form{
	background-color : #eeeff1;
 	border-radius: 5px; 
	margin-left: auto; 
 	margin-right: auto; 
 	width: 60%; 
	text-align:center;
 	height: 500px; 
/* 	padding: 20px; */
 	margin-top:50px; 
 	margin-bottom: 150px; 
 	padding: 5px 0 5px 0;
}
.body{
	margin-top:50px;
	margin-left:30px;
	color:#eeeff1;
	font-size:10pt;
	margin-bottom:150px; 
}
.join{
	margin-top:30px;
	border-collapse:collapse;
	font-size:20pt;
	margin-left:auto;
	margin-right:auto;
}
.join:th,td{
	margin-top:10px;
	padding-left:20px;
	text-align:left;
	background-position:left;
	border-bottom:#eeeee solid 1px;	
}
.btn-join2{
	margin-left:100px;
	margin-right:50px;
	margin-top:50px;
	background-color:  #0080ff;
	border:0;
	color:white;
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
	border-bottom-left-radius: 5px;
	border-bottom-right-radius: 5px;
	padding: 15px;
	
}
.btn-join2:hover{
    color:white;
    background-color: #0080ff;
    border: 1px solid #0080ff;
}

</style>

<script type="text/javascript">
function inputCheck(){
	
	var join=document.joinForm;
	
	if(join.userid.value==""){
		alert("아이디를 입력해주세요");
		join.userid.focus();
		return false;
	}
	if(join.idUncheck.value!="idCheck"){
		alert("아이디 중복체크를 해주세요");
		return false;
	}
	if(join.userpw.value==""){
		alert("비밀번호를 입력해주세요");
		join.userpw.focus();
		return false;
	}
	if(join.userpw.value!=join.userpwCheck.value){
		alert("비밀번호를 동일하게 입력해주세요");
		join.userpwCheck.focus();
		return false;
	}
	if(join.usernick.value==""){
		alert("닉네임을 입력해주세요");
		join.usernick.focus();
		return false;
	}
	if(join.username.value==""){
		alert("이름을 입력해주세요");
		join.useriname.focus();
		return false;
	}
	if(join.birth.value==""){
		alert("생년월일을 입력해주세요");
		join.birth.focus();
		return false;
	}
	if(join.phone.value==""){
		alert("핸드폰번호를 입력해주세요");
		join.phone.focus();
		return false;
	}
	if(join.email.value==""){
		alert("이메일을 입력해주세요");
		join.email.focus();
		return false;
	}
}

function openIdCheck(){
	window.name="parentForm";
	window.open("/member/idOverlap","아이디 중복 확인","width=300, height=300, left=600, top=200");
}

//아이디 입력창에 값 입력시 hidden에 idUncheck를 세팅
//아이디 중복체크 후 다시 아이디 창이 새로운 아이디를 입력했을 때 다시 중복체크를 하도록 한다
function inputIdCheck(){
	document.joinForm.idUncheck.value="idUncheck";
}

</script>


<h1>회원가입</h1>

<body>

<div class="join-form">
<form action="/member/join" method="post" name="joinForm" onsubmit="return inputCheck()">
	<table class="join" >
	<tr><th>아이디
<!-- </tr> -->
<!-- 	<tr> -->
		<td><input type="text" name="userid" onkeydown="inputIdCheck()"/></td>
			<!-- onkeydown이벤트 : 사용자가 중복체크를 하고 난 뒤 아이디 입력란에 사용 가능한 아이디를 지우고
				새로운 아이디를 입력했을 경우 대처하기 위한 이벤트. 중복체크가 되지 않은것으로 처리 -->
		<td><input type=button onclick="openIdCheck()" value="아이디 중복 체크"/>
			<input type="hidden" name="idUncheck" value="idUncheck"></td>
			<!-- value가 idUnckeck이면 중복체크를 하지 않은것 -->
	</tr>
	
	<tr><th>비밀번호
		<td><input type="password" name="userpw" /></td>
		<td>
<!-- 		<img src="/img/pwLock.png" width="50px" height="50px"> -->
		<!--<c:choose>
			<c:when test="${param.sel eq 1 }">1을 선택하셨습니다</c:when>
			<c:when test="${param.sel eq 2 }">2을 선택하셨습니다</c:when>
			<c:when test="${param.sel eq 3 }">3을 선택하셨습니다</c:when>
		</c:choose> -->
		</td>
	</tr>	
	
	<tr><th>비밀번호확인
		<td><input type="password" name="userpwCheck" /></td>
		<td>
<!-- 		<img src="/img/pwCheck.png" width="50px" height="50px"/> -->
		</td>
	</tr>
	
	<tr><th>닉네임
		<td><input type="text" name="usernick" /></td>
	</tr>
	
	<tr><th>이름
		<td><input type="text" name="username" /></td>
	</tr>
	
	<tr><th>생년월일
		<td><input type="Date" name="birth" /></td>
	</tr>
	
	<tr><th>성별
		<td>
		<select name="gender">
			<option value="M" selected>남자</option>
			<option value="F">여자</option>
		</select>
		</td>
	</tr>
	
	<tr><th>핸드폰번호
<!-- 	<td><span>"-"을 넣어서 입력해 주세요</span></td></tr> -->
		<td><input type="text" name="phone" placeholder="-을 넣어서 입력해 주세요."/></td>
	</tr>
	
	<tr><th>이메일
		<td><input type="email" name="email" placeholder="@email.com"/></td>
	</tr>
	
	<tr><th>마이팀
		<td>
		<select name="myteam">
			<option value="0" selected>없음</option>
			<option value="KIA">KIA 타이거즈</option>
			<option value="KT">KT 위즈</option>
			<option value="LG">LG 트윈스</option>
			<option value="NC">NC 다이노스</option>
			<option value="SK">SK 와이번스</option>
			<option value="두산">두산 베어스</option>
			<option value="롯데">롯데 자이언츠</option>
			<option value="삼성">삼성 라이온즈</option>
			<option value="키움">키움 히어로즈</option>
			<option value="한화">한화 이글스</option>
		</select>
		</td>
	</tr>
	<tr>
		<td colspan="2"><input type="submit" value="회원가입" class="btn btn-join2"></td>
	</tr>
	</table>
	
</form>
</div>
</body>


<c:import url="/WEB-INF/views/layout/footer.jsp" />