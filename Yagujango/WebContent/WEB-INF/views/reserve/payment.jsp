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

<!-- 폰트 -->
<link href="https://fonts.googleapis.com/css?family=Electrolize|Nanum+Gothic:400,700,800&display=swap" rel="stylesheet">

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
	margin:0;
	text-align: right;
	width: 350px;
	float: right;
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

.image {
	position: relative;
	text-align: center; padding:0; margin: 0;
}

.image .text {
	position: absolute;
	top: -13px;
	left: 150px;
	font-size: 20px;
	font-family: "Nanum Gothic", sans-serif;
	font-weight: 700;
	
}

</style>

</head>
<body style="background: #D5D5D5;">



<h1 style="margin: 20px 0 0 20px;">티켓 예매</h1>
<p id="topbar">예매 > ${stadium.stadium_name } [${stadium.team_name }] > 예매하기</p><br>
<hr>

<div class="image" >
<img src="/img/reserve3.png" width="900px" height="35px">
	<div class="text"><p>좌석선택&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		수령방법/확인&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;결제</p></div>
</div>


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
		<td id="canceldate"></td>
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

<!-- 취소기한 날짜계산  -->
<script type="text/javascript">
Date.prototype.format = function(f) {
	if (!this.valueOf()) return " ";
 
	var weekName = ["일", "월", "화", "수", "목", "금", "토"];
	var d = this;
	 
	return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
		switch ($1) {
			case "yyyy": return d.getFullYear();
			case "yy": return (d.getFullYear() % 1000).zf(2);
			case "MM": return (d.getMonth() + 1).zf(2);
			case "dd": return d.getDate().zf(2);
			case "E": return weekName[d.getDay()];
			case "HH": return d.getHours().zf(2);
			case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
			case "mm": return d.getMinutes().zf(2);
			case "ss": return d.getSeconds().zf(2);
			case "a/p": return d.getHours() < 12 ? "오전" : "오후";
			default: return $1;
		}
	});
};
 
String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
Number.prototype.zf = function(len){return this.toString().zf(len);};
   
var canceldate = new Date("${match.match_date}");
canceldate.setDate(canceldate.getDate() + 7); 
console.log(canceldate.format("yyyy-MM-dd"));
document.getElementById('canceldate').innerHTML=canceldate.format("yyyy-MM-dd (E요일)");

</script>

</html>