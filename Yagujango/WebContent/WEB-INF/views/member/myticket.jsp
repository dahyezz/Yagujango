<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<script type="text/javascript">
$(document).ready(function() {
	InitializeStaticMenu();
	
	$('#cancleBtn').click(function() {
		
		var reservecode = document.getElementById("cancleBtn");
// 		console.log(reservecode.value);
	
		var reserve_code = reservecode.value;
		
		//전송 폼
		var $form = $("<form>")
				.attr("action", "/mypage/ticket")
				.attr("method","POST")
				.append(
						$("<input>")
							.attr("type","hidden")
							.attr("name", "reserve_code")
							.attr("value",reserve_code)
				);
		$(document.body).append($form);
		$form.submit();
		
	});

});



//////////////////////////네비게이션 바 //////////////////////////
var stmnLEFT = 10; // 오른쪽 여백 
var stmnGAP1 = 0; // 위쪽 여백 
var stmnGAP2 = 200; // 스크롤시 브라우저 위쪽과 떨어지는 거리 
var stmnBASE = 200; // 스크롤 시작위치 
var stmnActivateSpeed = 35; //스크롤을 인식하는 딜레이 (숫자가 클수록 느리게 인식)
var stmnScrollSpeed = 20; //스크롤 속도 (클수록 느림)
var stmnTimer; 

function RefreshStaticMenu() { 
var stmnStartPoint, stmnEndPoint; 
stmnStartPoint = parseInt(document.getElementById('STATICMENU').style.top, 10); 
stmnEndPoint = Math.max(document.documentElement.scrollTop, document.body.scrollTop) + stmnGAP2; 
if (stmnEndPoint < stmnGAP1) stmnEndPoint = stmnGAP1; 
if (stmnStartPoint != stmnEndPoint) { 
stmnScrollAmount = Math.ceil( Math.abs( stmnEndPoint - stmnStartPoint ) / 15 ); 
document.getElementById('STATICMENU').style.top = parseInt(document.getElementById('STATICMENU').style.top, 10) + ( ( stmnEndPoint<stmnStartPoint ) ? -stmnScrollAmount : stmnScrollAmount ) + 'px'; 
stmnRefreshTimer = stmnScrollSpeed; 
}
stmnTimer = setTimeout("RefreshStaticMenu();", stmnActivateSpeed); 
}

function InitializeStaticMenu() {
document.getElementById('STATICMENU').style.right = stmnLEFT + 'px';  //처음에 오른쪽에 위치. left로 바꿔도.
document.getElementById('STATICMENU').style.top = document.body.scrollTop + stmnBASE + 'px'; 
RefreshStaticMenu();
}
</script>



<style type="text/css">
/* 메뉴 네비게이션바 */
#STATICMENU {
	width: 200px;
	margin: 0pt;
	width: 200px;
	padding: 0pt;  
	position: absolute; 
	left: 0px;
	top: 0px;
}

/* 네비게이션바 테이블 */
table {
	border-collapse: collapse;
	border-top: 3px solid black;
	border-bottom: 3px solid black;
	width:auto;
}
.table th, td{
 	border: 1px solid #ddd;
 	padding: 10px;
 	text-align:center;
}
.table th:hover{
	background: #D5D5D5;
}
.table th:first-child, td:first-child{
 	border-left: 0;
}
.table th:last-child, td:last-child{
 	border-right: 0;
}
/* 네비게이션바 테이블 */

/* 하이퍼링크 밑줄 제거 */
a { text-decoration:none; color:#000000 }


.myticket {
	margin: 0 auto 0 250px;
}

</style>

<div id="STATICMENU">
	<table class="table statictable">
		<tr>
			<th><a href="/mypage/ticket" >예매 확인/취소</a></th>
		</tr>
		<tr>
			<th><a href="/member/my1to1">내 1:1 문의 내역 확인</a></th>
		</tr>
		<tr>
			<th><a href="/member/modify">회원 정보 수정</a></th>
		</tr>
	</table>
</div>

<div class="myticket">
<h1>예매 확인/취소</h1>
<hr>

<p>예매 티켓 정보</p>
<table>
	<tr>
		<td>예매 번호</td>
		<td></td>
		<td>티켓명</td>
		<td></td>
	</tr>
	<tr>
		<td>관람일시</td>
		<td></td>
		<td>장소</td>
		<td></td>
	</tr>
	<tr>
		<td>좌석</td>
		<td></td>
		<td>티켓 수령 방법</td>
		<td></td>
	</tr>
	<tr>
		<td>취소 가능일</td>
		<td></td>
		<td>취소 가능 여부</td>
		<td></td>
	</tr>
	<tr>
		<td>예매자</td>
		<td></td>
		<td>예매일</td>
		<td></td>
	</tr>
	<tr>
		<td>결제수단</td>
		<td></td>
		<td>현재상태</td>
		<td></td>
	</tr>
</table>

<p>예매취소</p>
<table>
	<tr>
		<th>예매번호</th>
		<th>티켓명</th>
		<th>취소가능일</th>
		<th>취소 가능 여부</th>
		<th>예매 취소</th>
	</tr>
	<tr>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td><button id="cancleBtn" value="201906211061">취소</button></td>
	</tr>
</table>

<p>티켓 예매 내역</p>
<table>
	<tr>
		<th>예매번호</th>
		<th>티켓명</th>
		<th>관람일시</th>
		<th>매수</th>
		<th>좌석번호</th>
		<th>상태</th>
	</tr>
	<tr>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
	</tr>	
</table>

<br><br><br><br>
</div>

<c:import url="/WEB-INF/views/layout/footer.jsp" />