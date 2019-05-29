<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF//views/layout/header.jsp" />


<style type="text/css">
table {
	border-collapse: collapse;
	border-top: 3px solid black;
	border-bottom: 3px solid black;
	width:70%;
}
.table th, td{
 	border: 1px solid #ddd;
 	padding: 10px;
 	text-align:center;
}
.table th:first-child, td:first-child{
 	border-left: 0;
}
.table th:last-child, td:last-child{
 	border-right: 0;
}

</style>

</head>
<body>
<table class="table">
	<tr>
	<th>일시</th>
	<th>경기(홈 vs 원정)</th>
	<th>장소</th>
	<th>예매</th>
	</tr>
</table>


<c:import url="/WEB-INF/views/layout/footer.jsp" />