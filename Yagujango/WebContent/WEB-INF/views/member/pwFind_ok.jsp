<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div>
<c:if test="${empty pwFind }">
	이름과 이메일과 아이디가 일치하는 비밀번호가 없습니다.
</c:if>

<c:if test="${pwFind }">
	사용자의 비밀번호는 ${userpw } 입니다.
</c:if>
</div> 