<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />


<script type="text/javascript">
$(document).ready(function() {
	InitializeStaticMenu();

	var myteamVal = document.getElementById("myteamVal");
// 	console.log(myteamVal.value);
	
	$("#myteam").val(myteamVal.value).attr("selected","selected");
	
	$('#leaveBtn').click(function() {
		
		var message = confirm("정말 탈퇴하시겠습니까?");
		if(message == true){
// 			alert("탈퇴되었습니다");
			location.href="/member/leave";
		} else {
			return false;
		}
		
	});
	
});

function inputCheck(){
	
	var modify = document.modifyForm;

	if(modify.userpw.value==""){
		alert("비밀번호를 입력해주세요");
		modify.userpw.focus();
		return false;
	}
	if(modify.userpw.value!=modify.userpwCheck.value){
		alert("비밀번호를 동일하게 입력해주세요");
		modify.userpwCheck.focus();
		return false;
	}
	if(modify.usernick.value==""){
		alert("닉네임을 입력해주세요");
		modify.usernick.focus();
		return false;
	}

	if(modify.phone.value==""){
		alert("핸드폰번호를 입력해주세요");
		modify.phone.focus();
		return false;
	}
	if(modify.email.value==""){
		alert("이메일을 입력해주세요");
		modify.email.focus();
		return false;
	}
}


//////////////////////////네비게이션 바 //////////////////////////
var stmnLEFT = 10; // 오른쪽 여백 
var stmnGAP1 = 0; // 위쪽 여백 
var stmnGAP2 = 200; // 스크롤시 브라우저 위쪽과 떨어지는 거리 
var stmnBASE = 200; // 스크롤 시작위치 
var stmnActivateSpeed = 35; //스크롤을 인식하는 딜레이 (숫자가 클수록 느리게 인식)
var stmnScrollSpeed = 20; //스크롤 속도 (클수록 느림)
var stmnTimer; 

function RefreshStaticMenu() { 
var stmnStartPoint, stmnEndPoint; 
stmnStartPoint = parseInt(document.getElementById('STATICMENU').style.top, 10); 
stmnEndPoint = Math.max(document.documentElement.scrollTop, document.body.scrollTop) + stmnGAP2; 
if (stmnEndPoint < stmnGAP1) stmnEndPoint = stmnGAP1; 
if (stmnStartPoint != stmnEndPoint) { 
stmnScrollAmount = Math.ceil( Math.abs( stmnEndPoint - stmnStartPoint ) / 15 ); 
document.getElementById('STATICMENU').style.top = parseInt(document.getElementById('STATICMENU').style.top, 10) + ( ( stmnEndPoint<stmnStartPoint ) ? -stmnScrollAmount : stmnScrollAmount ) + 'px'; 
stmnRefreshTimer = stmnScrollSpeed; 
}
stmnTimer = setTimeout("RefreshStaticMenu();", stmnActivateSpeed); 
}

function InitializeStaticMenu() {
document.getElementById('STATICMENU').style.right = stmnLEFT + 'px';  //처음에 오른쪽에 위치. left로 바꿔도.
document.getElementById('STATICMENU').style.top = document.body.scrollTop + stmnBASE + 'px'; 
RefreshStaticMenu();
}

</script>

<style type="text/css">
/* 메뉴 네비게이션바 */
#STATICMENU {
	width: 200px;
	margin: 0pt;
	width: 200px;
	padding: 0pt;  
	position: absolute; 
	left: 0px;
	top: 0px;
}

/* 네비게이션바 테이블 */
table {
	border-collapse: collapse;
	border-top: 3px solid black;
	border-bottom: 3px solid black;
	width:auto;
}
.table th, td{
 	border: 1px solid #ddd;
 	padding: 10px;
 	text-align:center;
}
.table th:hover{
	background: #D5D5D5;
}
.table th:first-child, td:first-child{
 	border-left: 0;
}
.table th:last-child, td:last-child{
 	border-right: 0;
}
/* 네비게이션바 테이블 */

/* 하이퍼링크 밑줄 제거 */
a { text-decoration:none; color:#000000 }


/* th{ */
/* /* 	text-align: left; */ */
/* /* 	font-size: 30px; */ */
/* } */

/* table { */
/* 	text-align: center; */
/* } */

#notChange {
	background-color: #ccc;
}

.modify {
	margin: 0 auto 0 250px;
}
</style>


<div id="STATICMENU">
	<table class="table statictable">
		<tr>
			<th><a href="/mypage/main" >예매 확인/취소</a></th>
		</tr>
		<tr>
			<th><a href="/member/my1to1">내 1:1 문의 내역 확인</a></th>
		</tr>
		<tr>
			<th><a href="/member/modify">회원 정보 수정</a></th>
		</tr>
	</table>
</div>

<div class="modify">
<h1>회원정보 수정</h1>
<hr>


<input type="hidden" id="myteamVal" value="${member.myteam }" />
			
<form action="/member/modify" method="post" name="modifyForm" onsubmit="return inputCheck()">
	<table>
		<tr>
			<td>아이디</td>
			<td><input type="text" name="userid" id="notChange" value="${member.userid }" readonly/></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="userpw" /></td>
		</tr>
		<tr>
			<td>비밀번호 확인</td>
			<td><input type="password" name="userpwCheck" /></td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td><input type="text" name="usernick" value="${member.usernick }" /></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><input type="text" name="username" id="notChange" value="${member.username }" readonly /></td>
		</tr>
		<tr>
			<td>생년월일</td>
			<td><input type="Date" name="birth" id="notChange" value="${member.birth }" readonly /></td>
		</tr>
		<tr>
			<td>성별</td>
			<td><input type="text" name="gender" id="notChange" value="${member.gender }" readonly /></td>
		</tr>
		<tr>
			<td>핸드폰번호</td>
			<td><input type="text" name="phone" value="${member.phone }"/></td>
			<td><p>"-"를 넣어서 입력하세요.</p></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><input type="email" name="email" value="${member.email }" /></td>
		</tr>
		<tr>
			<td>마이팀</td>
			<td><select name="myteam" id="myteam">
				<option value="0">없음</option>
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
			</select></td>
		</tr>
	</table>
	<input type="submit" value="회원정보수정">
</form>

<input type="button" id="leaveBtn" value="회원탈퇴">
</div>

<c:import url="/WEB-INF/views/layout/footer.jsp" />


