<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>티켓 예매_좌석 선택</title>

<script type="text/javascript">
// function checkReserve(){
// 	console.log("dhsk")
// 	//그 seat_code가 ticket에 있는 seat_code면 disabled
// 	//아니면 그냥 둠
	
// // 	for(int i=0; i<ticket.size; i++){
// // 		if(i.seat_code == seat_code)
			
// // 	}
// }
</script>

<style type="text/css">
#topbar {
	text-align: right;
}

</style>

</head>
<body style="background: #ccc">



<h1>티켓 예매</h1>
<hr>
<p id="topbar">예매 > ${stadium.stadium_name } [${stadium.team_name }] > 예매하기</p>


<div>

<!-- 좌석 버튼 만들어 주는 곳 -->
<c:forEach items="${seatBlock }" var="i">
	<c:forEach items="${seatNumber }" var="j">
			<input type="checkbox" name="seat" value="${i }${j }" />
	</c:forEach>
</c:forEach>

<!-- disabled 되게 -->
<!-- 
<c:forEach items="${seat }" var="i">
	<script>
		var checked = document.getElmentsByName("seat");
		
		for(var i=0; i<seat.length; i++){
			if(checked[i].value == ${i.seat_block}${i.seat_number}){
				checked[i].disabled = false;
			}
		}
		
	</script>
</c:forEach>
 -->

</div>

<table>
	<tr>
		<th>홈팀</th>
		<th>어웨이</th>
		<th>경기일</th>
	</tr>
	<tr>
		<th>${match.hometeam_name }</th>
		<th>${match.awayteam_name }</th>
		<th>${match.match_date }</th>
	</tr>
</table>

<label><a href="/reserve/receive?match_code=${match.match_code }">NEXT</a></label>

</body>
</html>