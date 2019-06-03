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
$(document).ready(function() {

	var selectseat = [];
	
	//체크 박스 선택시
	$("input:checkbox").on('click', function(){
		var lists = [];
		$("input:checkbox[name='seat']:checked").each(function(i){
			lists.push($(this).val());
			
		});
		

		selectseat = lists;
// 		console.log(lists)
		var layout = document.getElementById("result");
		layout.innerHTML = selectseat;
// 		console.log(map);

	});
	
// 	$("#selectsuccess").click(function(){
// 		var $form = $("<form>")
// 		.attr("action","/reserve/seat")
// 		.attr("method", "POST")
// 		.append(
// 				$("<input>")
// 						.attr("type", "hidden")
// 						.attr("name", "selectseat")
// 						.attr("value", selectseat)
// 		);
// 		$(document.body).append($form);
// 		$form.submit();
// 	})


});

function select() {
	//전송 폼
// 		var $form = $("<form>")
// 				.attr("action","/reserve/seat")
// 				.attr("method", "POST")
// 				.append(
// 						$("<input>")
// 								.attr("type", "hidden")
// 								.attr("name", "selectseat")
// 								.attr("value", selectseat)
// 				);
// 		$(document.body).append($form);
// 		$form.submit();
}

</script>

<style type="text/css">
#topbar {
	text-align: right;
	margin: 0;
}
.seatBtn {
	margin: 10px;
	padding: 0;
	width: 600px;
	height: 400px;
	float: left;
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

</style>

</head>
<body style="background: #D5D5D5">



<h1>티켓 예매</h1>
<hr>
<p id="topbar">예매 > ${stadium.stadium_name } [${stadium.team_name }] > 예매하기</p>
<%-- <p>${match.hometeam_name } vs ${match.awayteam_name } ${match.match_date }</p> --%>

<div class="seatBtn">
<!-- 좌석 버튼 만들어 주는 곳 -->
<c:forEach items="${seatBlock }" var="i">
	<c:forEach items="${seatNumber }" var="j">
			<input type="checkbox" name="seat" id="seatId" value="${i }블럭 ${j }석"  />
	</c:forEach>
	<br>
</c:forEach>





<!-- disabled 되게 -->
<c:forEach items="${seatAvailable }" var="i">
	<script>
		var select = eval("document.selectform");
		var checked = document.getElementsByName("seat");
		
		console.log("0--");
		for(var i=0; i<select.seat.length; i++){
// 			if(checked[i].value == ${i.seat_block}${i.seat_number}){
// 				checked[i].disabled = true;
// 			}
			console.log(checked[i].value);
		}
	</script>
</c:forEach>
 
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
	<label><a id="selectsuccess" href="/reserve/receive?match_code=${match.match_code }" >NEXT▷</a></label>
</div>

</body>
</html>