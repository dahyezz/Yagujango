<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>티켓 예매_좌석 선택</title>

<!-- jQuery 2.2.4 -->
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>

<link href="https://fonts.googleapis.com/css?family=Electrolize|Nanum+Gothic:400,700,800&display=swap" rel="stylesheet">

<script type="text/javascript">
var selectseat = [];
var seat;
var seat_block;
var seat_number;
$(document).ready(function() {
	
	var layout = document.getElementById("result");

	//체크 박스 선택시
	$("input:checkbox").on('click', function(){
		
		if($(this).prop('checked')){
			selectseat.push($(this).val());
			seat = $(this).val();
		
			var seatArray = seat.split("_");
			seat_block = seatArray[0];
			seat_number = seatArray[1];
			
			layout.innerHTML += "<p id="+seat+" style='margin: 0; padding: 0;'>"+seat_block+"블럭 "+seat_number+"석</p>";
			
		} else {
// 			console.log("체크해제") //TEST
			seat = $(this).val(); //체크 해제된 좌석
			
			selectseat.splice($.inArray(seat, selectseat),1); //selectseat에서 해당 좌석 삭제
			
			var deleteseat = document.getElementById(seat);
			deleteseat.remove();
		}
		
	});
	
	$("#selectsuccess").click(function(){
		var $form = $("<form>")
		.attr("action","/reserve/seat")
		.attr("method", "POST")
		.append(
				$("<input>")
						.attr("type", "hidden")
						.attr("name", "selectseat")
						.attr("value", selectseat)
		);
		$(document.body).append($form);
		$form.submit();
	});


});

</script>

<style type="text/css">
#topbar {
	text-align: right;
	margin: 0;
	width: 350px;
	float: right;
}
.seatBtn {
	overflow: scroll;

	margin: 10px;
	padding: 0;
	width: 600px;
	height: 480px;
	float: left;
}

.seatUpper {
	padding: 0;
	margin: 0;
	width: 700px;
	height: 70px;
	background-color: green;
	float: left;
}

#ground:first-child {
	margin: 0;
	padding: 0;
	font-size: 35px;
	color: white;
	text-align: center;	
	
	font-family: 'Electrolize', sans-serif;
	font-weight: 700;
}
#ground:last-child {
	margin: 0;
	padding: 0;
	font-size: 20px;
	color: white;
	text-align: center;
	
	font-family: 'Electrolize', sans-serif;
	font-weight: 700;	
}

.seatInfo {
	width: 350px;
	height: 400px;
	margin: 0;
	float: right;
}

.seatPrice {
	float: left;
	margin: 20px 20px 0;
}
.restSeat {
	float: left;
	margin: 20px 20px 0;
}

.selectSeat {
	float: left;
	margin: 0 20px;
}

#block {

	width: 130px;
	padding: 0;
	margin: 5px;
	float: left;
	position: relative;
	background: white;
}

#blockname {
	text-align: center;
	font-family: "Nanum Gothic", sans-serif;
	font-weight: 700;
	font-size: 20px;
	
	margin: 10px;
}

a {
	text-decoration: none;
}
label {
	cursor: pointer;
}

input[type=checkbox]{
	display: none;
}

input[type=checkbox] + label{
	display: inline-block;
	position: relative;
	width: 15px;
	height: 15px;
	margin: 0;
	padding: 0;
	border: 0 none;	
}

input[type=checkbox] +label:before{
	content: "";
	display: inline-block;
	
	width: 15px;
	height: 15px;
	
	margin-left: 5px;
	margin-right: 5px;
	position: absolute;
	left: 0;
	bottom: 0;
	background-color: #64A0FF;
	border-radius: 1px;
/* 	box-shadow: inset 0px 1px 1px 0px rgba(0,0,0,3), 0px 1px 0px 0px rgba(255,255,255,0); */
}

input[type=checkbox]:disabled + label:before {
	box-shadow: 0 0 #ab3c3c;
	background-color: gray;
	background-position: center;
	background-size: cover;
	text-indent: -9999px;
	top: 0;
}

input[type=checkbox]:checked + label:before {
	content: "ㅇ";
	font-size: 15px;
	font-weight: 800;
	color: #fff;
	background-color: black;
	text-align: center;
	line-height: 15px;
}
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
<body style="background: #D5D5D5">

<h1 style="margin: 20px 0 0 20px;">티켓 예매</h1>
<p id="topbar">예매 > ${stadium.stadium_name } [${stadium.team_name }] > 예매하기</p><br>
<hr>

<div class="image" >
<img src="/img/reserve1.png" width="900px" height="35px">
	<div class="text"><p>좌석선택&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		수령방법/확인&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;결제</p></div>
</div>

<!-- 좌석 버튼 만들어 주는 곳 -->
<div class="seatBtn">

<div class="seatUpper">
	<p id="ground" >GROUND</p>
	<p id="ground" >⇧&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;⇧</p>
</div>

<div style="background: #dcdcdc; width: 700px; float:left; position: relative; ">

<!-- A블럭 -->
<c:set value="1" var="b" />
	<div id="block">
	<c:forEach items="${allSeat }" var="i">
		<c:if test="${i.seat_block eq 'A' }">
			<c:if test="${b == '1' }">
				<p id="blockname">${i.seat_block }블럭</p>
				<c:set value="2" var="b"></c:set>
			</c:if>
			<input type="checkbox" name="seatChk" id="seatId_${i.seat_code }" value="${i.seat_block }_${i.seat_number }" />
			<label for="seatId_${i.seat_code }" style="CURSOR:hand;" title="${i.seat_block }블럭 ${i.seat_number }석"></label>
		</c:if>
	</c:forEach>
	</div>
	
<!-- B블럭 -->
<c:set value="1" var="b" />
	<div id="block">
	<c:forEach items="${allSeat }" var="i">
		<c:if test="${i.seat_block eq 'B' }">
			<c:if test="${b == '1' }">
				<p id="blockname">${i.seat_block }블럭</p>
				<c:set value="2" var="b"></c:set>
			</c:if>
			<input type="checkbox" name="seatChk" id="seatId_${i.seat_code }" value="${i.seat_block }_${i.seat_number }" />
			<label for="seatId_${i.seat_code }" style="CURSOR:hand;" title="${i.seat_block }블럭 ${i.seat_number }석"></label>	
		</c:if>
	</c:forEach>
	</div>

<!-- C블럭 -->
<c:set value="1" var="b" />
	<div id="block">
	<c:forEach items="${allSeat }" var="i">
		<c:if test="${i.seat_block eq 'C' }">
			<c:if test="${b == '1' }">
				<p id="blockname">${i.seat_block }블럭</p>
				<c:set value="2" var="b"></c:set>
			</c:if>
			<input type="checkbox" name="seatChk" id="seatId_${i.seat_code }" value="${i.seat_block }_${i.seat_number }"/>
			<label for="seatId_${i.seat_code }" style="CURSOR:hand;" title="${i.seat_block }블럭 ${i.seat_number }석"></label>
		</c:if>
	</c:forEach>
	</div>

<!-- D블럭 -->
<c:set value="1" var="b" />
	<div id="block">
	<c:forEach items="${allSeat }" var="i">
		<c:if test="${i.seat_block eq 'D' }">
			<c:if test="${b == '1' }">
				<p id="blockname">${i.seat_block }블럭</p>
				<c:set value="2" var="b"></c:set>
			</c:if>
			<input type="checkbox" name="seatChk" id="seatId_${i.seat_code }" value="${i.seat_block }_${i.seat_number }" />
			<label for="seatId_${i.seat_code }" style="CURSOR:hand;" title="${i.seat_block }블럭 ${i.seat_number }석"></label>
		</c:if>
	</c:forEach>
	</div>
	
<!-- E블럭 -->
<c:set value="1" var="b" />
	<div id="block">
	<c:forEach items="${allSeat }" var="i">
		<c:if test="${i.seat_block eq 'E' }">
			<c:if test="${b == '1' }">
				<p id="blockname">${i.seat_block }블럭</p>
				<c:set value="2" var="b"></c:set>
			</c:if>
			<input type="checkbox" name="seatChk" id="seatId_${i.seat_code }" value="${i.seat_block }_${i.seat_number }" />
			<label for="seatId_${i.seat_code }" style="CURSOR:hand;" title="${i.seat_block }블럭 ${i.seat_number }석"></label>
		</c:if>
	</c:forEach>
	</div>

<!-- 좌석 disabled  -->
<c:forEach items="${resvdSeatList }" var="i" >
	<c:forEach items="${allSeat }" var="j">
		<c:if test="${i.seat_code eq j.seat_code }">
			<script type="text/javascript">
// 				console.log("${i }")
				var check = document.getElementById("seatId_${j.seat_code }");
				var label = document.getElementsByTagName("label");
// 				console.log(label[${i.seat_code}]);
				check.disabled = true;
 			</script> 
		</c:if>
	</c:forEach>
</c:forEach>
</div>

</div>

<div class="seatInfo">

	<div class="seatPrice">
		<h3>등급별 가격</h3>
			<p>A블럭 - 24,000원</p>
			<p>B블럭 - 21,000원</p>
			<p>C블럭 - 18,000원</p>
			<p>D블럭 - 15,000원</p>
			<p>E블럭 - 12,000원</p>
	</div>
	
	<div class="restSeat">
		<h3>잔여 좌석</h3>
				<p>A블럭 ${seatCount[0] }석</p>
				<p>B블럭 ${seatCount[1] }석</p>
				<p>C블럭 ${seatCount[2] }석</p>
				<p>D블럭 ${seatCount[3] }석</p>
				<p>E블럭 ${seatCount[4] }석</p>	
	</div>
	<hr width="230px" style="margin: 25px 0 0 25px;">
	
	<div class="selectSeat">
		<h3>선택좌석</h3>
			<p id="result">
			</p>
	</div>

</div>

<div style="float: right; margin-top: 50px; margin-right:100px;">
	<label><a id="selectsuccess" >NEXT▷</a></label>	
</div>

</body>
</html>