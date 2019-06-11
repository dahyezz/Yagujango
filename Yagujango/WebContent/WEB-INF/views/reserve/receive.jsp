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

<!-- 폰트 -->
<link href="https://fonts.googleapis.com/css?family=Electrolize|Nanum+Gothic:400,700,800&display=swap" rel="stylesheet">

<script type="text/javascript">
	function receive() {
 		$('#selectreceive').submit();
	}

	function seat() {
		$('#selectseat').submit();
	}
</script>

<style type="text/css">
#topbar {
	margin: 0;
	text-align: right;
	width: 350px;
	float: right;
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
/*  	float:right;  */
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
 	vertical-align:middle;
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
<img src="/img/reserve2.PNG" width="900px" height="35px">
	<div class="text"><p>좌석선택&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		수령방법/확인&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;결제</p></div>
</div>


<div id="receive">
	<form id="selectreceive" name="selectreceive" action="/reserve/payment" method="get">
  	<h3>수령 방법</h3><br>
  		<input type="hidden" name="userno" id="userno" value="${memberno.userno }"/>
  		<input type="hidden" name="ticket_code" id="ticket_code" value="${param.ticket_code }"/>
		<input type="hidden" name="count" id="count" value="${param.count }"/>
  		<input type="hidden" name="match_code" id="match_code" value="${match.match_code }"/>
  		<input type="hidden" name="match_date" id="match_date" value="${match.match_date }"/>
	  	<label id='bacode'><input type='radio' name='receive' id='bacode' value='바코드발급' />바코드발급</label><p>
	  	<label id='place'><input type='radio' name='receive' id='place' value='현장발권' />현장발권</label>
	</form>
</div>


<form id="selectseat" name="selectseat" action="/reserve/receive" method="post">
	<input type="hidden" name="match_code" id="match_code" value="${match.match_code }"/>
	<input type="hidden" name="userno" id="userno" value="${memberno.userno }"/>
	<input type="hidden" name="ticket_code" id="ticket_code" value="${param.ticket_code }"/>
	<input type="hidden" name="count" id="count" value="${param.count }"/>
</form>


<strong><font size="5em">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;My 예매정보</font></strong>
<div style="float:right;">
	<table class="table" style="text-align:center;">
		<tr>
			<th>일시</th>
			<td><fmt:formatDate value="${match.match_date }" pattern="yyyy-MM-dd (E요일)"/></td>
		</tr>
		<tr>
			<th>선택좌석</th>
			<td>
				<div style="overflow:auto; max-height:80px;">
					<c:forEach items="${seatinfo }" var="i">
						<c:if test="${param.ticket_code <= i.ticket_code}">
							${i.seat_block }블럭 ${i.seat_number }석<br>
						</c:if>
					</c:forEach>
				</div>
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
</div>

<div style="float:right; margin-left:100px;">
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
</div>
<div style="float:right; margin-top:30px; margin-left:250px; margin-right:100px;">
	<label><button onclick="seat()">◁PREV</button></label>&nbsp;&nbsp;&nbsp;
	<label><button onclick="receive()">NEXT▷</button></label>
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