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

<script type="text/javascript">
var selectseat = [];
var seat;
var seat_block;
var seat_number;
$(document).ready(function() {
	
	var layout = document.getElementById("result");
	
// 	//마우스 오버시 좌석정보 보이기
// 	$("input:checkbox").mouseover(function() {
// // 		console.log("mouseover"); //TEST
// 		var obj = $(this);
// 		var tX = (obj.position().left);
// 		var tY = (obj.position().top);
// // 		console.log(tX)
// // 		console.log(tY)
	
// 		if($(this).find(".box_layer").length>0) {
// 			if($(this).find(".box_layer").css("display") == "none" ){
// 				$(this).find(".box_layer").css({
// 					"top" : tY
// 					, "left" : tX
// 					, "position" : "absolute"
// 				}).show();
// 			}
// 		} else {
// 			$(this).append("<div class='box_layer'>test</div>");
// 			$(this).find(".box_layer").css({
// 				"top" : tY
// 				, "left" : tX
// 				, "position" : "absolute"

// 			}).show();
// 		}
		
		
		
// 	});
	
// 	$("input:checkbox").mouseout(function() {
// 		$(this).find(".box_layer").css("display", "none");
// // 		console.log("out")
// 	});

	//체크 박스 선택시
	$("input:checkbox").on('click', function(){
		
		if($(this).prop('checked')){
			selectseat.push($(this).val());
			seat = $(this).val();
		
			var seatArray = seat.split("_");
			seat_block = seatArray[0];
			seat_number = seatArray[1];
			
			layout.innerHTML += "<p id="+seat+" style='margin: 0; padding: 0;'>"+seat_block+"블럭 "+seat_number+"석</p>";
			
			// 스타일 지정하기 위해서 class 추가
			$(this).addClass("selected");
			
		} else {
// 			console.log("체크해제") //TEST
			seat = $(this).val(); //체크 해제된 좌석
			$(this).removeClass("selected");
			$(this).addClass("unselected");
			
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

function view(opt){
	if(opt){
// 		console.log("000")
		
	}else
		view.style.display = "none";
}

</script>

<style type="text/css">
#topbar {
	text-align: right;
	margin: 0;
}
.seatBtn {
	overflow: scroll;

	margin: 0 10px;
	padding: 0;
	width: 600px;
	height: 450px;
	float: left;
}

.seatUpper {
	padding: 0;
	margin: 0;
	width: 600px;
	height: 60px;
	background-color: green;
	float: left;
}

#ground {
	margin: 0;
	padding: 0;
	font-size: 30px;
	color: white;
	text-align: center;
	
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

a {
	text-decoration: none;
}

/* .selected { */
/* 	display: inline-block; */
/* 	border: 2px solid #ccc; */
/* 	cursur: pointer; */
/* 	background-color: blue;; */
/* } */

input[type=checkbox]{
	display: none;
}

input[type=checkbox] + label{
	display: inline-block;
/* 	cursor: point; */
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
	
	margin-left: 10px;
	position: absolute;
	left: 0;
	bottom: 1px;
	background-color: #64A0FF;
	border-radius: 1px;
	box-shadow: inset 0px 1px 1px 0px rgba(0,0,0,3), 0px 1px 0px 0px rgba(255,255,255,0);
}

input[type=checkbox]:disabled + label:before {
	box-shadow: 0 0 #ab3c3c;
	background-color: gray;
	background-position: center;
	background-size: cover;
	text-indent: -9999px;
	top: 1px;
}

input[type=checkbox]:checked + label:before {
	content: "o";
	text-shadow: 1px 1px 1px rgba(0,0,0,2);
	font-size: 13px;
	font-weight: 800;
	color: #fff;
	background-color: black;
	text-align: center;
	line-height: 10px;
}
/* 레이어 말풍선 스타일 적용  */
.btn_view {
	font-weight: normal !important;
}
.box_layer {
	position: absolute;
	width: 350px;
	height: 150px;
	overflow: auto;
	background: #eaeaea;
	right: 0px;
	top: 0px;
	z-index: 999;
	border: 2px solid #ccc;
	-webkit-border-radius: 10px
	
}

.tt {
	position: relative;
}

.tt-text {
	visibility: hidden;
	width: 200px;
	background-color: #ccc;
	color: yellow;
	text-align: center;
	border-radius: 10px;
	padding: 10px 5px;
	position: absolute;
	z-index: 1;
	top: 200%;
	left: 50%;
	margin-left: -105px;
}

.tt:mouseover .tt-text {
 	visibility: visible; 
}

.tt .tt-text::after {
	content: "";
	position: absolute;
	bottom: 100%;
	left: 50%;
	margin-left: -10px;
	border-left: 10px;
	border-style: solid;
	border-color: transparent transparent Indigo transparent;
}

</style>

</head>
<body style="background: #D5D5D5">



<h1>티켓 예매</h1>
<hr>
<p id="topbar">예매 > ${stadium.stadium_name } [${stadium.team_name }] > 예매하기</p>

<!-- 좌석 버튼 만들어 주는 곳 -->
<div class="seatBtn">
<div class="seatUpper">
	<p id="ground" >GROUND</p>
</div>

<div style="background: white;">
<c:forEach items="${allSeat }" var="i">
	
	<input type="checkbox" name="seatChk" id="seatId_${i.seat_code }" value="${i.seat_block }_${i.seat_number }" />
	<label for="seatId_${i.seat_code }"></label>
<%-- 		<span id="view" style="cursor: hand;">${i.seat_block }블럭 ${i.seat_number }석</span> --%>
	<c:if test="${i.seat_number eq 100 }"><br></c:if>
	
</c:forEach>

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
		<h3>남은 좌석</h3>
				<p>A블럭 ${seatCount[0] }석</p>
				<p>B블럭 ${seatCount[1] }석</p>
				<p>C블럭 ${seatCount[2] }석</p>
				<p>D블럭 ${seatCount[3] }석</p>
				<p>E블럭 ${seatCount[4] }석</p>	
	</div>
	
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