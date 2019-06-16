<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<style type="text/css">
.wrap a {text-decoration:none}
.wrap a:visited ,a:link{color: black;}
.watching{
	color:green;
}
.wrap {
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
table .notice {
	background:#d9e1e8;
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
	text-align:right;
}
table .content:hover{
	background: #D5D5D5;
}


#btnWrite {
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
	border-bottom-left-radius: 5px;
	border-bottom-right-radius: 5px;
/* 	margin-right:10%; */
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
		location.href="/board/free/write";
	})
	
	$('.title').each(function(){
		var length = 20;
		if($(this).text().length>=length){
			$(this).text($(this).text().substr(0,length)+'...');
		}
	});
// 현재 보고있는 태그 강조
	var name ="${name}";
	var keyword="${keyword}";
	var number = 0;
	$('.menu').each(function(){
		if(name == "tag" || name == ""){
			if(keyword == $(this).text()){
				$(this).attr("style","color:#0080ff;");
			}else{
				number++;
			}
			if(number == 5){
				$("#default").attr("style","color:#0080ff;");
			}
		}
	});
//
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
<h1>자유게시판</h1>
<hr>
<h2>
<a class="menu" id="default" href="/board/free/list">전체</a>
<a class="menu" href="/board/free/list?name=tag&keyword=공지">공지</a>
<a class="menu" href="/board/free/list?name=tag&keyword=후기">후기</a>
<a class="menu" href="/board/free/list?name=tag&keyword=질문">질문</a>
<a class="menu" href="/board/free/list?name=tag&keyword=잡담">잡담</a>


</h2>

<table>
<thead>
	<tr>
		<c:if test="${usernick eq '관리자'}">
		<th><input id="allCheck" type="checkbox" onclick="allChk(this);"/></th>
		</c:if>
		<th style="width: 10%;">구분</th>
		<th style="width: 45%;">제목</th>
		<th style="width: 15%;">작성자</th>
		<th style="width: 20%;">작성일</th>
		<th style="width: 10%;">조회수</th>
	</tr>
</thead>
<tbody>
<c:forEach items="${board_freelist}" var="i">
	<c:if test="${i.tag eq '공지' }">
		<tr class="notice content">
			<c:if test="${usernick eq '관리자'}"><td></td></c:if>
			<td><a href="/board/free/list?name=tag&keyword=${i.tag}">공지</a></td>
			<td><a href="/board/free/view?tag=${i.tag}&boardno=${i.boardno}"  >${i.title }</a></td>	
			<td>${i.writer }</td>
			<td><fmt:formatDate value="${i.writtendate }" pattern="yyyy-MM-dd" /></td>
			<td>${i.hit }</td>
			
		<tr>
	</c:if>
	<c:if test="${i.tag ne '공지' }">
		<tr class="content">
			<c:if test="${usernick eq '관리자'}">
			<td><input name="rowCheck" type="checkbox" value="${i.boardno}" /></td>
			</c:if>
			<td><a href="/board/free/list?name=tag&keyword=${i.tag}">${i.tag}</a></td>
			<td>
			
			<a class ="title" href="/board/free/view?tag=${i.tag}&boardno=${i.boardno}">
			${i.title }</a>
			
			</td>
			<td>${i.writer }</td>
			<td><fmt:formatDate value="${i.writtendate }" pattern="yyyy-MM-dd" /></td>
			<td>${i.hit }</td>
			
		</tr>
	</c:if>
		
</c:forEach>
</tbody>
</table>
<c:if test="${usernick eq '관리자'}">
<button type="button" id="btnlistDelete" class="btn btn-primary" onclick="checklist();">체크 삭제</button>
</c:if>
</div>
<div class="paging">
<c:import url="/WEB-INF/views/layout/free_paging.jsp" />
<div class="button-right"><button id="btnWrite">글 쓰기</button></div>
</div>

<div class="search">
<form action="/board/free/list" method="get">
		<select name="name"  style="vertical-align: middle;">
				<option value="title">제목</option>
				<option value="content">본문</option>
				<option value="writer">작성자</option>
		</select>
		<input type="text"  name="keyword" placeholder="검색어를 입력해주세요." >
	
	 	<button  style="vertical-align: middle;">검색</button>
	
</form>
</div>
</div>
<c:import url="/WEB-INF/views/layout/footer.jsp" />
