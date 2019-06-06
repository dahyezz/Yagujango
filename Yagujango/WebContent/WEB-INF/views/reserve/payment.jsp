<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>티켓 예매_결제방법 선택</title>

<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>

<script type="text/javascript">
	function cancle() {
		$('#deleteseat').submit();
		alert("결제를 취소하시겠습니까?");
// 		self.close();
	}
	
	function payment() {
		alert("결제 하시겠습니까?")
 		$('#selectpayment').submit();
// 		close();
	}


</script>

<style type="text/css">
#topbar {
	margin:30px;
	text-align: right;
}

#payment {
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


<div id="payment">
	<form id="selectpayment" name="selectpayment" action="/reserve/payment" method="post">
  	<h3>결제 방법</h3><br>
  		<input type="hidden" name="deleteparam" id="deleteparam" value="insert"/>
		<input type="hidden" name="count" id="count" value="${count }"/>
  		<input type="hidden" name="userno" id="userno" value="${memberno }"/>
  		<c:forEach items="${seatinfo }" var="i" varStatus="status">
			<input type="hidden" name="ticket_code" id="ticket_code" value="${i.ticket_code }"/>
	  		<input type="hidden" name="price" id="price" value="${i.price }"/>
		</c:forEach>
		 <input type="hidden" name="ticketparam" id="ticketparam" value="${ticketcode }"/>
  		<input type="hidden" name="match_date" id="match_date" value="${match.match_date }"/>
  		<input type="hidden" name="receive" id="receive" value="${receive }"/>
  		<input type="hidden" name="match_code" id="match_code" value="${match.match_code }"/>
	  	<label id='cash'><input type='radio' name='payment' id='cash' value='무통장입금' />무통장 입금</label><p>
	  	<label id='card'><input type='radio' name='payment' id='card' value='신용카드' />신용 카드</label>
	</form>
</div>

<form id="deleteseat" name="deleteseat" action="/reserve/payment" method="post">
		<input type="hidden" name="deleteparam" id="deleteparam" value="delete"/>
  	  	<input type="hidden" name="ticket_code" id="ticket_code" value="${ticketcode }"/>
		<input type="hidden" name="count" id="count" value="${count }"/>
</form>

<strong><font size="5em">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;My 예매정보</font></strong>
<!-- <h3>My 예매정보</h3> -->
<table class="table" style="text-align:center;">
	<tr>
		<th>일시</th>
		<td><fmt:formatDate value="${match.match_date }" pattern="yyyy-MM-dd (E요일)"/></td>
	</tr>
	<tr>
		<th>선택좌석</th>
		<td>
		<c:forEach items="${seatinfo }" var="i">
			<c:if test="${param.ticket_code <= i.ticket_code}">
				${i.seat_block }블럭 ${i.seat_number }석<br>
			</c:if>
		</c:forEach>
		</td>
	</tr>
	<tr>
		<th>티켓금액</th>
		<td>
		<c:set var = "total" value ="0"/>
		<c:forEach items="${seatinfo }" var="i" varStatus="status">
			<c:if test="${param.ticket_code <= i.ticket_code}">
				<c:set var = "total" value="${total + i.price }"/>
			</c:if>
		</c:forEach>
		${total }원
		</td>
	</tr>
	<tr>
		<th>수수료</th>
		<td>0원</td>
	</tr>
	<tr>
		<th>취소기한</th>
		
		<fmt:formatDate value="${match.match_date }" var="currentDate" pattern="yyyyMMdd"/> <!-- 현재 날짜 '-'뺀 형식으로 바꾸기  -->
		<fmt:parseNumber value="${currentDate + 7 }" var="numberDate" integerOnly="true"/> <!-- 현재날짜 숫자로 바꿔 +7  -->
		
		<fmt:parseDate value="${numberDate }" var="endDate" pattern="yyyyMMdd"/> <!-- 숫자로 바꾼 날짜를 날짜형식으로 변환 -->

		<td><fmt:formatDate value="${endDate }" pattern="yyyy-MM-dd (E요일)"/></td> <!-- 원래 형식으로 변환 -->
		
	</tr>
</table>
<table class="table">
	<tr>
		<th>총 결제금액</th>
		<th>
		<c:set var = "total" value ="0"/>
		<c:forEach items="${seatinfo }" var="i" varStatus="status">
			<c:if test="${param.ticket_code <= i.ticket_code}">
				<c:set var = "total" value="${total + i.price }"/>
			</c:if>
		</c:forEach>
		${total }원
		</th>
	</tr>
</table>
<div style="float:right; margin-top:50px; margin-right:100px;">
	<label><button onclick="cancle()">결제취소</button></label>
	<label><button onclick="payment()">결제하기</button></label>
</div>
</body>
</html>