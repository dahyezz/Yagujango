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
<!-- 결제 API  -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<!-- 폰트 -->
<link href="https://fonts.googleapis.com/css?family=Electrolize|Nanum+Gothic:400,700,800&display=swap" rel="stylesheet">

<script type="text/javascript">
var popclose = false;
var IMP = window.IMP;
IMP.init('imp11074492');

function cancle() {
		
	var deleteparam = "delete";
	var ticket_code = "${ticketcode }"
	var count = "${count }"
	var message = confirm("결제를 취소하시겠습니까?");
	
	if(message == true){
// 		var deleteparam = $('#deleteseat').submit();
		
		$.ajax({
			type: "POST",
			data: {"deleteparam":deleteparam, "ticket_code":ticket_code, "count":count},
			url: "/reserve/payment",
			success: function (data) {
			     window.close();
			     
			 }, error: function (jqXHR, textStatus, errorThrown) {
			   alert(error);
			}
		});
		
	} else {
		return false;
	}

}
	
function payment() {

	var message = confirm("결제 하시겠습니까?");
	
	if(message == true){
		
		var payVal_btn = document.getElementsByName("payment");
		var payVal;
		
		for(var i=0; i<2; i++){
			if(payVal_btn[i].checked==true){
				payVal = payVal_btn[i].value;
			}
		}
		
		var email = document.getElementsByName("email");
		var name = document.getElementsByName("username");
		console.log(email[0].value);
		console.log(name[0].value);

		if(payVal == '신용카드'){
			
				IMP.request_pay({
				pg : 'inicis', // version 1.1.0부터 지원.
				pay_method : 'card',
				merchant_uid : 'merchant_' + new Date().getTime(),
				name : '[2019 신한은행 MY CAR KBO 리그]',
				amount : 100,
				buyer_email : email[0].value,
				buyer_name : name[0].value,
				buyer_tel : '010-1234-5678',
				buyer_addr : '서울특별시 강남구 삼성동',
				buyer_postcode : '123-456',
// 				m_redirect_url : 'https://localhost:8088/mypage/main'
				company : '(주)야구장고'
				
				}, function(rsp) {
			 	if ( rsp.success ) {

			 	window.close();
			 	var insertparam = $('#selectpayment').submit();
				
					$.ajax({
						type: "GET",
						data: insertparam,
						url: "/mypage/main",
						success: function (data) {
						     window.close();
						
						 }, error: function (jqXHR, textStatus, errorThrown) {
						   alert(error);
						}
					});
				
				 } else {
				     var msg = '결제에 실패하였습니다.';
				     msg += '에러내용 : ' + rsp.error_msg;
				 } //if end
	//	 		 alert(msg);
				}); //
		}
			
		if(payVal == '무통장입금'){
			var insertparam = $('#selectpayment').submit();
// 			document.getElementById('#account').submit();
			var accountparam = $('#account').submit();
			
			$.ajax({
				type: "GET",
				data: insertparam,
				url: "/mypage/main",
				success: function (data) {
				     window.close();
				
				 }, error: function (jqXHR, textStatus, errorThrown) {
				   alert(error);
				}
			});
			
		}
		
	} else {
		return false;
	}
	
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
	margin-top:65px;
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
/* 	float:right; */
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

#cancleBtn, #payBtn {
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
	border-bottom-left-radius: 5px;
	border-bottom-right-radius: 5px;
	margin-right:-4px;
	border: 1px solid white;
	background-color: white;
	color: black;
	padding: 5px;

}

#cancleBtn:hover, #payBtn:hover{
    color:white;
    background-color: skyblue;
    border: 1px solid skyblue;
}

</style>

</head>
<body style="background: #D5D5D5;" onUnload="xConfirm()">



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
  		<c:forEach items="${ticketinfo }" var="i" varStatus="status">
			<input type="hidden" name="ticket_code" id="ticket_code" value="${i.ticket_code }"/>
		</c:forEach>
  		<c:forEach items="${seatinfo }" var="i" varStatus="status">
			<input type="hidden" name="price" id="price" value="${i.price }"/>
		</c:forEach>
		 <input type="hidden" name="ticketparam" id="ticketparam" value="${ticketcode }"/>
  		<input type="hidden" name="match_date" id="match_date" value="${match.match_date }"/>
  		<input type="hidden" name="receive" id="receive" value="${receive }"/>
  		<input type="hidden" name="match_code" id="match_code" value="${match.match_code }"/>
  		<input type="hidden" name="email" id="email" value="${member.email }"/>
  		<input type="hidden" name="username" id="username" value="${member.username }"/>
  		<input type="hidden" name="bank" id="bank" value="신한은행"/>
		<input type="hidden" name="account_number" id="account_number" value="123456-00-789001"/>
		<c:set var = "total" value ="0"/>
		<c:forEach items="${seatinfo }" var="i" varStatus="status">
		<c:set var = "total" value="${total + i.price }"/>
		</c:forEach>
		<input type="hidden" name="pay" id="pay" value="${total }"/>
	  	<label id='cash'><input type='radio' name='payment' id='cash' value='무통장입금'/>무통장 입금</label><p>
	  	<label id='card'><input type='radio' name='payment' id='card' value='신용카드' />신용 카드</label>
	  	
	</form>
</div>

<form id="deleteseat" name="deleteseat" action="/reserve/payment" method="post">
		<input type="hidden" name="deleteparam" id="deleteparam" value="delete"/>
  	  	<input type="hidden" name="ticket_code" id="ticket_code" value="${ticketcode }"/>
		<input type="hidden" name="count" id="count" value="${count }"/>
</form>

<br><strong><font size="5em">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;My 예매정보</font></strong>
<!-- <h3>My 예매정보</h3> -->
<div style="float:right;">
	<table class="table" style="text-align:center;">
		<tr>
			<th>일시</th>
			<td id="matchdate"></td>
		</tr>
		<tr>
			<th>선택좌석</th>
			<td>
				<div style="overflow:auto; max-height:80px;">
					<c:forEach items="${seatinfo }" var="i">
						${i.seat_block }블럭 ${i.seat_number }석<br>
					</c:forEach>
				</div>
			</td>
		</tr>
		<tr>
			<th>티켓금액</th>
			<td>
				<c:set var = "total" value ="0"/>
				<c:forEach items="${seatinfo }" var="i" varStatus="status">
					<c:set var = "total" value="${total + i.price }"/>
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
				<c:set var = "total" value="${total + i.price }"/>
			</c:forEach>
			${total }원
			</th>
		</tr>
	</table>
</div>

<div style="float:right; margin-top:30px; margin-left:300px; margin-right:100px;">
	<label><button id="cancleBtn" name="cnacleBtn" onclick="cancle()">결제취소</button></label>&nbsp;&nbsp;&nbsp;
	<label><button id="payBtn" name="payBtn" onclick="payment()">결제하기</button></label>
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

var matchdate = new Date("${formatdate }");
var canceldate = new Date("${formatdate }");
canceldate.setHours(canceldate.getHours() - 3); 
console.log(canceldate.format("yyyy-MM-dd HH:mm"));
document.getElementById('matchdate').innerHTML=matchdate.format("yyyy년 MM월 dd일 (E요일)<br>HH:mm");
document.getElementById('canceldate').innerHTML=canceldate.format("yyyy년 MM월 dd일 (E요일)<br>HH:mm");

</script>

</html>