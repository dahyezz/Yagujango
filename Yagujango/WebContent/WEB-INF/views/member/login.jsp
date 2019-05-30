<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>

<script type="text/javascript">
function idFindPopup(){
	window.open('/member/idFind','아이디 찾기','width=300, height=300, left=600, top=200');
}

function pwFindPopup(){
	window.open('/member/pwFind','비밀번호 찾기','width=300, height=300, left=600, top=200');
}
</script> 


<h1>로그인 페이지</h1>
<form action="/member/login" method="post">
	<label>아이디 : <input type="text" name="userid" /></label><br>
	<label>비밀번호 : <input type="password" name="userpw" /></label><br><br>
	<button>로그인</button>
</form>

<a href="javascript:idFindPopup();">아이디 찾기</a>
<a href="javascript:pwFindPopup();">비밀번호 찾기</a>
<a href="/member/join">회원가입</a>

<c:import url="/WEB-INF/views/layout/footer.jsp" />