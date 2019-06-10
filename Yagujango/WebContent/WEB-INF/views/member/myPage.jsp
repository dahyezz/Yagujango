<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<style type="text/css">


</style>

<h1>마이페이지</h1>
<hr>

<div id="background">

<div id="teamLogo">
<c:choose>
	<c:when test="${param.sel eq 1 }"><img src="/img/teamLogo/kia"/></c:when>
	<c:when test="${param.sel eq 2 }"><img src="/img/teamLogo/kt"/></c:when>
	<c:when test="${param.sel eq 3 }"><img src="/img/teamLogo/lg"/></c:when>
	<c:when test="${param.sel eq 3 }"><img src="/img/teamLogo/nc"/></c:when>
	<c:when test="${param.sel eq 3 }"><img src="/img/teamLogo/sk"/></c:when>
	<c:when test="${param.sel eq 3 }"><img src="/img/teamLogo/doosan"/></c:when>
	<c:when test="${param.sel eq 3 }"><img src="/img/teamLogo/lotte"/></c:when>
	<c:when test="${param.sel eq 3 }"><img src="/img/teamLogo/samsung"/></c:when>
	<c:when test="${param.sel eq 3 }"><img src="/img/teamLogo/kiwoom"/></c:when>
	<c:when test="${param.sel eq 3 }"><img src="/img/teamLogo/hanwha"/></c:when>
</c:choose>
</div>

<div>
	<table>
	<tr>
		<td>아이디 : </td>
		<td>${userid }</td>
	</tr>
	<tr>
		<td>닉네임 : </td>
		<td>${usernick }</td>
	</tr>
	<tr>
		<td>마이팀 : </td>
		<td>
			<c:if test="${myteam eq 0 }"><a href="/mypage/modify"></a></c:if>
			<c:if test="${myteam eq 0 }">${myteam }</c:if>
		</td>
	</tr>
	</table>
</div>
</div>

<c:import url="/WEB-INF/views/layout/footer.jsp" />