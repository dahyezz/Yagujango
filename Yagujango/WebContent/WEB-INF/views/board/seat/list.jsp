<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.tablediv {
	padding: 0 5% 0 5%;
}
table {
	width: 100%;
	border-collapse: collapse;
    text-align: center;
    line-height: 1.5;
}
table thead {
	padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #369;
    border-bottom: 3px solid #036;
}

.content {
	text-align:left;
}
.search {
	display:block;
	text-align:center; 
	background:#CCC;
	padding:0 0 0 35px;
	font-size:18px;
	color:#5e5e5e;
	font-weight:bold;
	line-height: 50px;
	cursor:pointer;
	box-sizing: content-box;
	margin: 10px 0; !important
}

</style>
</head>
<body>
<c:import url="/WEB-INF/views/layout/header.jsp" />
<script type="text/javascript">
$(document).ready(function() {
	$("#btnWrite").click(function() {
		location.href="/board/seat/write";
	})
});
//맨 위 체크박스 클릭시 모두 체크/해제
function allChk(obj){
    var chkObj = document.getElementsByName("rowCheck");
    var rowCnt = chkObj.length - 1;//rowCheck의길이 : 10
    var check = obj.checked;
    if (check) {﻿
        for (var i=0; i<=rowCnt; i++){
         if(chkObj[i].type == "checkbox")
             chkObj[i].checked = true; 
        }
    } else {
        for (var i=0; i<=rowCnt; i++) {
         if(chkObj[i].type == "checkbox"){
             chkObj[i].checked = false; 
         }
        }
    }
} 

function checklist(){
	var memberchk = document.getElementsByName("rowCheck");
	var rowCnt = memberchk.length - 1;//rowCheck의길이 : 10
	var boardno = ""
	var indexid = false;
	for(i=0; i<=rowCnt; i++){
		if(memberchk[i].checked){
			if(indexid){
			     boardno = boardno + ',';
			}
			boardno = boardno + memberchk[i].value;
			indexid = true;
		}
	}

	var agree = confirm("삭제 하시겠습니까?");
	if(agree){
		//<form action="/board/listdelete" method="get">
		//	<input name=boardlist value=boardno>
		//</form>을 body에 추가한다
		//
		$f = ($("<form>")
				.attr("action", "/board/free/listdelete")
				.attr("method", "get")
			).append(
			$("<input>")
				.attr("name", "boardnolist")
				.val(boardno)
		).appendTo( $(document.body) );
		//form submit
		$f.submit();
	}
}

</script>

<div class="wrap">
<div class="tablediv">
<table>
<thead>
	<tr>
		<c:if test="${usernick eq '관리자'}">
		<th><input id="allCheck" type="checkbox" onclick="allChk(this);"/></th>
		</c:if>
		<th style="width: 10%;"></th>
		<th style="width: 45%;">제목</th>
		<th style="width: 15%;">작성자</th>
		<th style="width: 10%;">조회수</th>
		<th style="width: 20%;">작성일</th>
	</tr>
</thead>
<tbody>
<c:forEach items="${board_seatlist}" var="i">
	
		<tr>
			<c:if test="${usernick eq '관리자'}">
			<td><input name="rowCheck" type="checkbox" value="${i.boardno}" /></td>
			</c:if>
			<td>
				<c:if test="${i.fileurl ne null }">
				<img src="${i.fileurl}" style="width:100px;height:70px;"/>
				</c:if>
				<c:if test="${i.fileurl eq null }">
				<img src="http://localhost:8088/upload/default.jpg" style="width:100px;height:70px;"/>
				</c:if>
			</td>
			<td class="content">${i.stadium_name} 구장 ${i.seat_block }열 ${i.seat_number }번 좌석</td>
			<td>${i.writer }</td>
			<td>${i.hit }</td>
			<td>${i.writtendate }</td>
		</tr>

</c:forEach>
</tbody>
</table>
<c:if test="${usernick eq '관리자'}">
<button type="button" id="btnlistDelete" class="btn btn-primary" onclick="checklist();">체크 삭제</button>
</c:if>
</div>
<div class="paging">


</div>
<div class="search">
<form action="/board/free/list" method="get">
		<select name="name">
				<option value="title">제목</option>
				<option value="content">본문</option>
				<option value="writer">작성자</option>
		</select>
		<input type="text"  name="keyword" placeholder="검색어를 입력해주세요." >
	
	 	<button>검색</button>
	
</form>
</div>
<button id="btnWrite">글 쓰기</button>
</div>
<c:import url="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>
</body>
</html>