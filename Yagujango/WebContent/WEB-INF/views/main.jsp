<%@page import="java.util.List"%>
<%@page import="dto.Stadium"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<div>

<c:forEach items="${matchList }" var="i">
	<table>

		<tr>
			<td>${i.match_date }</td>
			<td>${i.hometeam_name } : ${i.awayteam_name }</td>
		</tr>
	</table>
</c:forEach>

</div>

<!-- <video src="https://sports.news.naver.com/kbaseball/vod/index.nhn?id=549175&category=kbo&gameId=20190609LGHH02019&date=20190609&listType=game"></video> -->

<c:import url="/WEB-INF/views/layout/footer.jsp" />
