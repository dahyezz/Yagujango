<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<span style="font-size:12px;">댓글</span>
<table>
	<c:forEach var="j" items="${comment}">
	<tr>
		<td style="width:20%">${j.writer}</td>
		<td style="width:60%;text-align:left;">${j.content }</td>
		<td style="width:10%">${j.writtendate}</td>
		<c:if test="${j.writer eq usernick }">
			<td style="width:10%" data-commentno="${j.commentno }">
				<a class="deleteanchor">삭제</a>
			</td>
		</c:if>
		<c:if test="${j.writer ne usernick }">
			<td style="width:10%"> </td>
		</c:if>
		
	</tr>
	</c:forEach>
</table>