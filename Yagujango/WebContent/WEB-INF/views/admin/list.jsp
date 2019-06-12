<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp"/>

<script type="text/javascript">
$(document).ready(function() {
	InitializeStaticMenu();
});

////////////////////////// 네비게이션 바 //////////////////////////
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
.statictable{
	font-size: 13px;
 	color: #ccc; 
}
/* 네비게이션바 테이블 */

.reservestep {
	margin: 0 5% 5% 270px;
	width: 80%;
	text-align: left;
/* 	height: 60%; */
}
/* 하이퍼링크 밑줄 제거 */
a { text-decoration:none; color: black; }

.howto {
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 300;
	font-size: 20px;
}

.cancle li {
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 300;
	font-size: 15px;
}
</style>

<div id="STATICMENU">
	<table class="table statictable">
		<c:forEach items="${list }" var="i">
			<tr>
				<th><a href="/reserve/list?stadium_code=${i.stadium_code }" >${i.stadium_name } [${i.team_name }]</a></th>
			</tr>
		</c:forEach>
			
			<tr>
				<th><a href="/admin/list">회원</a></th>
			</tr>
			
			<tr>
				<th><a href="/admin/blacklist">블랙리스트 </a></th>
			</tr>
			
			<tr>
				<th><a href="/admin/board_1to1">1:1문의확인</a></th>
			</tr>
			
			<tr>
				<th><a href="/answer/list">1:1답변확인</a></th>
			</tr>
	</table>
</div>

<div class="reservestep">
<h1 style="font-family: 'Nanum Gothic', sans-serif; font-weight: 700;"></h1>
<hr width="130px" align="left">


<script type="text/javascript">
$(document).ready(function() {
	
// 	//글쓰기 버튼 누르면 이동
// 	$("#btnList").click(function() {
// 		location.href="/admin/blacklist";
// 	});
	
// 	//글쓰기 버튼 누르면 이동
// 	$("#btnmList").click(function() {
// 		location.href="/admin/board_1to1";
//	});
	
	//글쓰기 버튼 누르면 이동
	$("#btnSearch").click(function() {
 		location.href="/admin/list?keyword="+$("#keyword").val();
	});
	
	// 선택체크 삭제
	$("#btnDelete").click(function() {
		// 선택된 체크박스
		var $checkboxes = $("input:checkbox[name='checkRow']:checked");
		
		//방법2
		// 체크된 대상들을 map으로 만들고 map을 문자열로 만들기
		var map = $checkboxes.map(function() {
			return $(this).val();
		});
		var names = map.get().join(",");
		
	
		// 전송 폼
		var $form = $("<form>")
			.attr("action", "/admin/listDelete")
			.attr("method", "post")
			.append(
				$("<input>")
					.attr("type", "hidden")
					.attr("name", "names")
					.attr("value", names)
			);
		$(document.body).append($form);
		$form.submit();
	
	});
	
	//blacklist update
	$("#btnUpdate").click(function() {
		// 선택된 체크박스
		var $checkboxes = $("input:checkbox[name='checkRow']:checked");
		
		//방법2
		// 체크된 대상들을 map으로 만들고 map을 문자열로 만들기
		var map = $checkboxes.map(function() {
			return $(this).val();
		});
		var names = map.get().join(",");
		
	
		// 전송 폼
		var $form = $("<form>")
			.attr("action", "/admin/penalty")
			.attr("method", "post")
			.append(
				$("<input>")
					.attr("type", "hidden")
					.attr("name", "names")
					.attr("value", names)
			);
		$(document.body).append($form);
		$form.submit();
	
	});
	

	
});

//전체 체크/해제
function checkAll() {
	// checkbox들
	var $checkboxes=$("input:checkbox[name='checkRow']");

	// checkAll 체크상태 (true:전체선택, false:전체해제)
	var check_status = $("#checkAll").is(":checked");
	
	if( check_status ) {
		// 전체 체크박스를 checked로 바꾸기
		$checkboxes.each(function() {
			this.checked = true;	
		});
	} else {
		// 전체 체크박스를 checked 해제하기
		$checkboxes.each(function() {
			this.checked = false;	
		});
	}
}


</script>

<h1>회원</h1>
<hr>

<!-- <button id="btnList" class="btn btn-blacklist">블랙리스트</button> -->
<!-- <button id="btnmList" class="btn btn-blacklist">1:1문의확인</button> -->

<div class="tablediv">
<table class="table table-striped table-hover table-condensed">
<thead>
	<tr>
		<th><input type="checkbox" id="checkAll" onclick="checkAll();" /></th>
		<th style="width: 5%;">번호</th>
		<th style="width: 10%;">아이디</th>
		<th style="width: 10%;">비밀번호</th>		
		<th style="width: 10%;">이름</th>
		<th style="width: 10%;">닉네임</th>
		<th style="width: 10%;">생년월일</th>
		<th style="width: 10%;">성별</th>
		<th style="width: 10%;">번호</th>
		<th style="width: 10%;">이메일</th>
		<th style="width: 5%;">경고</th>
		<th style="width: 15%;">마이팀</th>
	</tr>
</thead>
<c:forEach items="${mlist}" var="m">
	<tr>
		<td><input type="checkbox" name="checkRow" value="${m.userno }" /></td>
		<td>${m.userno }</td>
		<td>${m.userid }</td>
		<td>${m.userpw }</td>
		<td>${m.username }</td>
		<td>${m.usernick }</td>
		<td><fmt:formatDate value="${m.birth }" pattern="yyyy-MM-dd" /></td>
		<td>${m.gender }</td>
		<td>${m.phone }</td>
		<td>${m.email }</td>
		<td>${m.penalty }</td>
		<td>${m.myteam }</td>

	</tr>
</c:forEach>
</table>

<button id="btnDelete" class="btn btn-warning pull-left">삭제</button>
<button id="btnUpdate" class="btn btn-update pull-left">경고</button>

<div class="clearfix"></div>

</div>

<div class="paging">
<c:import url="/WEB-INF/views/layout/admin_list.jsp" />

</div>

<div class="form-inline text-center">
	<input class="form-control" type="text" id="keyword" />
	<button id="btnSearch" class="btn">검색</button>
</div> 

</div>

<c:import url="/WEB-INF/views/layout/footer.jsp"/>