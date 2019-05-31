<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div>
<c:if test="${empty idFind }">
	이름과 이메일이 일치하는 아이디가 없습니다.
</c:if>

<c:if test="${idFind }">
	사용자의 아이디는 ${userid } 입니다.
</c:if>
</div> 