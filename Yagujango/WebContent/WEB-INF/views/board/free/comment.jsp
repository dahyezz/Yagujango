<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<table>
	<tr class="info">
		<td>작성자</td>
		<td colspan="5">내용</td>
		<td>작성일</td>
		<td></td>
	</tr>
	<c:forEach var="j" items="${comment}">
	<tr>
		<td>${j.writer}</td>
		<td colspan="5">${j.content }</td>
		<td>${j.writtendate}</td>
		<c:if test="${j.writer eq usernick }">
		<td data-commentno="${j.commentno }"><a class="deleteanchor">삭제</a></td>
		</c:if>
	</tr>
	</c:forEach>
</table>