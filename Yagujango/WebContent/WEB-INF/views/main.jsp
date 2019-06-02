<%@page import="java.util.List"%>
<%@page import="dto.Stadium"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />


<c:if test="${empty login }">
	<strong>로그인이 필요합니다</strong><br>
<!-- 	<button onclick="location.href='/member/login';">로그인</button> -->
<!-- 	<button onclick="location.href='/member/join';">회원가입</button> -->
</c:if>

<c:if test="${login }">
	${userid }님, 접속을 환영합니다.
<!-- 	<button onclick="location.href='/member/logout';">로그아웃</button> -->
</c:if>

<!-- 아래 br들은 나중에 메인 완성되면 삭제 예정 -->
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

<c:import url="/WEB-INF/views/layout/footer.jsp" />
