<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>티켓 예매_좌석 선택</title>

<style type="text/css">
#topbar {
	text-align: right;
}

</style>

</head>
<body style="background: #ccc">

<div>

<h1>티켓 예매</h1>
<hr>
<p id="topbar">예매 > ${stadium.stadium_name } [${stadium.team_name }] > 예매하기</p>

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

</div>

</body>
</html>