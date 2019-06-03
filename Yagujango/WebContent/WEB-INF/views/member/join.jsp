<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<style type="text/css">
th{
	text-align: left;
}

</style>

<h1>회원가입</h1>
<hr>

<form action="/member/join" method="post">
	<table>
	<tr><th>아이디</th></tr>
	<tr>
		<td><input type="text" name="userid" /></td>
		<td><button>아이디 중복 확인</button></td>
	</tr>
	
	<tr><th>비밀번호</th></tr>
	<tr>
		<td><input type="password" name="userpw" /></td>
		<td>lock</td>
	</tr>	
	
	<tr><th>비밀번호확인</th></tr>
	<tr>
		<td><input type="password" name="userpwCheck" /></td>
		<td>lock</td>
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
		<td><input type="text" name="birth" /></td>
	</tr>
	
	<tr><th>성별</th></tr>
	<tr>
		<td><input type="text" name="gender" /></td>
	</tr>
	
	<tr><th>핸드폰번호</th></tr>
	<tr>
		<td><input type="text" name="phone" /></td>
	</tr>
	
	<tr><th>이메일</th></tr>
	<tr>
		<td><input type="text" name="email" /></td>
	</tr>
	
	<tr><th>마이팀</th></tr>
	<tr>
		<td><input type="text" name="myteam" /></td>
	</tr>
	
	<tr>
		<td><button>회원가입</button></td>
	</tr>
	</table>
</form>


<c:import url="/WEB-INF/views/layout/footer.jsp" />