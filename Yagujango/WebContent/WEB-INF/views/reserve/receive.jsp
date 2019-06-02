<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>티켓 예매_수령방법 선택</title>

<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>

<script type="text/javascript">
	function receive() {
		alert("작동!")
 		$('#selectreceive').submit();
	}

</script>

<style type="text/css">
#topbar {
	margin:30px;
	text-align: right;
}

#receive {
	margin-left:30px;
	margin-top:43px;
	margin-bottom:100px;
	padding:20px;
	width:40%;
	height:150px;
	background:white;
	border: 1px solid #D5D5D5;
	border-radius: 5px;
	float:left;
}

table {
	margin-right:100px;
	margin-top:10px;
 	border-collapse: collapse;
	border-top: 3px solid black;
	border-bottom: 3px solid black;
	width:300px;
	float:right;
}
.table th{
  	border: 1px solid #ddd;
 	padding: 10px;
 	text-align:center;
 	background:#EAEAEA;
}
.table td{
	font-size:12px;
 	border: 1px solid #ddd; 
 	padding: 10px;
 	text-align:center;
 	background:#D5D5D5;
}
.table th :first-child, td:first-child{
 	border-left: 0;
}
.table th :last-child, td:last-child{
 	border-right: 0;
}

a { text-decoration:none }
</style>

</head>
<body style="background: #D5D5D5;">



<h1>티켓 예매</h1>
<hr>
<p id="topbar">예매 > ${stadium.stadium_name } [${stadium.team_name }] > 예매하기</p>


<div id="receive">
	<form id="selectreceive" name="aa" action="/reserve/payment?match_code=${match.match_code }" method="get">
  	<h3>수령 방법</h3><br>
	  	<label id='bacode'><input type='radio' name='receive' id='bacode' value='bacode' />바코드발급</label><p>
	  	<label id='place'><input type='radio' name='receive' id='place' value='place' />현장발권</label>
	</form>
</div>

<strong><font size="5em">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;My 예매정보</font></strong>
<!-- <h3>My 예매정보</h3> -->
<table class="table" style="text-align:center;">
	<tr>
		<th>일시</th>
		<td><fmt:formatDate value="${match.match_date }" pattern="yyyy-MM-dd (E요일)"/></td>
	</tr>
	<tr>
		<th>선택좌석</th>
		<td>${seatinfo.seat_block }블럭 ${seatinfo.seat_number }번</td>
	</tr>
	<tr>
		<th>티켓금액</th>
		<td>${seatinfo.price }원</td>
	</tr>
	<tr>
		<th>수수료</th>
		<td>0원</td>
	</tr>
	<tr>
		<th>취소기한</th>
		
		<fmt:formatDate value="${match.match_date }" var="currentDate" pattern="yyyyMMdd"/> <!-- 현재 날짜 '-'뺀 형식으로 바꾸기  -->
		<fmt:formatDate value="${match.match_date }" var="day" pattern="dd"/>
		<fmt:parseNumber value="${currentDate + 7 }" var="numberDate" integerOnly="true"/> <!-- 현재날짜 숫자로 바꿔 +7  -->
		
		<fmt:parseDate value="${numberDate }" var="endDate" pattern="yyyyMMdd"/> <!-- 숫자로 바꾼 날짜를 날짜형식으로 변환 -->

		<td><fmt:formatDate value="${endDate }" pattern="yyyy-MM-dd (E요일)"/></td> <!-- 원래 형식으로 변환 -->
	</tr>
</table>
<table class="table">
	<tr>
		<th>총 결제금액</th>
		<th>${seatinfo.price }원</th>
	</tr>
</table>
<div style="float:right; margin-top:50px; margin-right:100px;">
	<label><a href="/reserve/seat?match_code=${match.match_code }">◁PREV</a></label>&nbsp;&nbsp;&nbsp;
<%-- 	<label><a href="/reserve/payment?match_code=${match.match_code }" onclick="receive()">NEXT▷</a></label> --%>
	<button onclick="receive()">NEXT▷</button>
</div>

</body>
</html>