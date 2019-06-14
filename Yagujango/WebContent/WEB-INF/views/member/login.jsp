<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>

<style type="text/css">
.login-form{
	background-color : #eeeff1;
	border-radius: 5px;
	margin-left: auto;
	margin-right: auto;
	width: 300px;
	height: 260px;
	padding: 20px;
	margin-top:150px;
	margin-bottom:150px;
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
.login-info{
	text-align:center;

}
/* 하이퍼링크 밑줄 제거 */
a { text-decoration:none; color: black; }

</style>
<script type="text/javascript">
function idFindPopup(){
	window.open('/member/idFind','아이디 찾기','width=300, height=300, left=600, top=200');
}

function pwFindPopup(){
	window.open('/member/pwFind','비밀번호 찾기','width=300, height=300, left=600, top=200');
}
</script> 
<div class="login-form">
<form action="/member/login" method="post">
	<label><input type="text" name="userid" class="text-field" placeholder="아이디"/></label><br>
	<label><input type="password" name="userpw" class="text-field" placeholder="비밀번호"/></label><br><br>
	<button class="btn-submit">로그인</button>
</form>

<div class="login-info a">
<a href="javascript:idFindPopup();">아이디 찾기  </a>
<a href="javascript:pwFindPopup();">비밀번호 찾기 </a>
<a href="/member/joinTerms">회원가입</a>
</div>
</div>

<c:import url="/WEB-INF/views/layout/footer.jsp" />