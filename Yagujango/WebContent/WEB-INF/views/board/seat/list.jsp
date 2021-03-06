<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<style type="text/css">
.wrap a {text-decoration:none}
.wrap a:visited ,a:link{color: black;}
table .content:hover{
	background: #D5D5D5;
}
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
    border-bottom: 3px solid #000;
}

.title {
	text-align:left;
}
.search {
	display:block;
	text-align:center; 
	background:#d9e1e8;
	padding:0 0 0 35px;
	font-size:18px;
	color:#5e5e5e;
	font-weight:bold;
	line-height: 50px;
	cursor:pointer;
	box-sizing: content-box;
	margin: 10px 0; !important
}
.button-right{
	text-align : right;
}

#btnWrite {
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
	border-bottom-left-radius: 5px;
	border-bottom-right-radius: 5px;
	margin-right:10%;
	border: 1px solid black;
	background-color: rgba(0,0,0,0);
	color: black;
	padding: 5px;

}

#btnWrite:hover{
    color:white;
    background-color: #0080ff;
    border: 1px solid #0080ff;
}

</style>

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
				.attr("action", "/board/seat/listdelete")
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
<h1>좌석 뷰 게시판</h1>
<hr>
<table>
<thead>
	<tr>
		<c:if test="${usernick eq '관리자'}">
		<th><input id="allCheck" type="checkbox" onclick="allChk(this);"/></th>
		</c:if>
		<th style="width: 10%;">미리보기</th>
		<th style="width: 45%;">제목</th>
		<th style="width: 15%;">작성자</th>
		<th style="width: 10%;">조회수</th>
		<th style="width: 20%;">작성일</th>
	</tr>
</thead>
<tbody>
<c:forEach items="${board_seatlist}" var="i">
	
		<tr class="content">
			<c:if test="${usernick eq '관리자'}">
			<td><input name="rowCheck" type="checkbox" value="${i.boardno}" /></td>
			</c:if>
			<td>
				<c:if test="${i.fileurl ne null }">
				<img src="${i.fileurl}" style="width:100px;height:70px;"/>
				</c:if>
				<c:if test="${i.fileurl eq null }">
				<img src="http://192.168.30.61:8088/upload/default.jpg" style="width:100px;height:70px;"/>
				</c:if>
			</td>
			<td class="title"><a href="/board/seat/view?boardno=${i.boardno}">
									${i.stadium_name} ${i.seat_block }열 ${i.seat_number }번 좌석
								</a></td>
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
<c:import url="/WEB-INF/views/layout/seat_paging.jsp" />
</div>
<div class="button-right">
<button id="btnWrite">글 쓰기</button>
</div>
<div class="search" >
<form action="/board/seat/list" method="get">
		<input type="hidden" name="name" value="stadium_name">
		<input type="text" name="keyword" placeholder="구장별로 검색하기">
	 	<button id="searchBtn"  style="vertical-align: middle;">검색</button>
</form>
</div>
</div>
<c:import url="/WEB-INF/views/layout/footer.jsp" />
