<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<script type="text/javascript">
function inputCheck(obj){
	if(obj.userid.value==""){
		alert("아이디를 입력해주세요");
		obj.userid.focus();
		return false;
	}
	if(obj.userpw.value==""){
		alert("비밀번호를 입력해주세요");
		obj.userpw.focus();
		return false;
	}
	if(obj.useripwCheck.value==""){
		alert("비밀번호 확인을 입력해주세요");
		obj.userpwCheck.focus();
		return false;
	}
	if(obj.usernick.value==""){
		alert("닉네임을 입력해주세요");
		obj.usernick.focus();
		return false;
	}
	if(obj.username.value==""){
		alert("이름을 입력해주세요");
		obj.useriname.focus();
		return false;
	}
	if(obj.birth.value==""){
		alert("생년월일을 입력해주세요");
		obj.birth.focus();
		return false;
	}
	if(obj.phone.value==""){
		alert("핸드폰번호를 입력해주세요");
		obj.phone.focus();
		return false;
	}
	if(obj.email.value==""){
		alert("이메일을 입력해주세요");
		obj.email.focus();
		return false;
	}
}

$(document).ready(function(){
	
	$("#idOverlap").click(function(){
		if($(idOverlap)){
			alert("사용 가능한 아이디 입니다");
		} else{
			alert("이미 사용중인 아이디 입니다");
			$("#userid").value="";
			$("#userid").focus();
		}
	});
});

</script>

<style type="text/css">
th{
	text-align: left;
	font-size: 30px;
}

</style>

<h1>회원가입</h1>
<hr>

<form action="/member/join" method="post" onsubmit="return inputCheck(this)">
	<table>
	<tr><th>아이디</th></tr>
	<tr>
		<td><input type="text" name="userid" /></td>
		<td><input type=button id="idOverlap" value="아이디 중복 확인"/></td>
	</tr>
	
	<tr><th>비밀번호</th></tr>
	<tr>
		<td><input type="password" name="userpw" /></td>
		<td>
		<img src="/img/pwLock.png" width="50px" height="50px">
		<c:choose>
			<c:when test="${param.sel eq 1 }">1을 선택하셨습니다</c:when>
			<c:when test="${param.sel eq 2 }">2을 선택하셨습니다</c:when>
			<c:when test="${param.sel eq 3 }">3을 선택하셨습니다</c:when>
		</c:choose>
		</td>
	</tr>	
	
	<tr><th>비밀번호확인</th></tr>
	<tr>
		<td><input type="password" name="userpwCheck" /></td>
		<td>
		<img src="/img/pwCheck.png" width="50px" height="50px"/>
		</td>
	</tr>
	
	<tr><th>닉네임</th></tr>
	<tr>
		<td><input type="text" name="usernick" /></td>
	</tr>
	
	<tr><th>이름</th></tr>
	<tr>
		<td><input type="text" name="username" /></td>
	</tr>
	
	<tr><th>생년월일</th></tr>
	<tr>
		<td><input type="Date" name="birth" /></td>
	</tr>
	
	<tr><th>성별</th></tr>
	<tr>
		<td>
		<select name="gender">
			<option value="M" selected>남자</option>
			<option value="F">여자</option>
		</select>
		</td>
	</tr>
	
	<tr><th>핸드폰번호</th></tr>
	<tr><td><span>"-"을 넣어서 입력해 주세요</span></td></tr>
	<tr>
		<td><input type="text" name="phone" /></td>
	</tr>
	
	<tr><th>이메일</th></tr>
	<tr>
		<td><input type="email" name="email" placeholder="@email.com"/></td>
	</tr>
	
	<tr><th>마이팀</th></tr>
	<tr>
		<td>
		<select name="myteam">
			<option value="0" selected>없음</option>
			<option value="">KIA 타이거즈</option>
			<option value="">KT 위즈</option>
			<option value="">LG 트윈스</option>
			<option value="">NC 다이노스</option>
			<option value="">SK 와이번스</option>
			<option value="">두산 베어스</option>
			<option value="">롯데 자이언츠</option>
			<option value="">삼성 라이온즈</option>
			<option value="">키움 히어로즈</option>
			<option value="">한화 이글스</option>
		</select>
		</td>
	</tr>
	
	<tr>
		<td colspan="2"><input type="submit" value="회원가입"></td>
	</tr>
	</table>
</form>


<c:import url="/WEB-INF/views/layout/footer.jsp" />