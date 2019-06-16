<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />
<script type="text/javascript">
$(document).ready(function() {
	$("#btnDelete").click(function() {
		location.href="/board/free/delete?boardno=${board.boardno}&tag=${board.tag}";
	})
	$("#btnList").click(function() {
		location.href="/board/free/list";
	})
	$("#btnUpdate").click(function() {
		$(location).attr("href", "/board/free/update?boardno=${board.boardno }&tag=${board.tag}");
	});
	$("#btncommentinsert").click(function(){
		var boardno = ${board.boardno};
		var content = $("#commentcontent").val();
		console.log(boardno);
		console.log(content);
		if(content !=null){
			$.ajax({
				url : "/board/free/comment/insert",
				type : "POST",
				dataType: "html",
				data : {"boardno":boardno,
						"content":content},
		  		success: function(res){
		  			console.log(res);
		  			$("#commentdiv").html(res);
					$("#commentcontent").val("");
				} 
				, error: function(res){
					console.log("hi");
				}
				
			});		
		}else if(content ==null ){
			alert("실패");
		}
	})
	
	/*  
	*	.deleteanchor에 이벤트를 걸면 페이지 load 시에 이벤트 등록,
	*	새로 생기는(insert한) .deleteanchor에는 이벤트가 등록되지 않는다
	*	변하지않는 parent에 on 이벤트를 걸어주어야함
	*/
	$("#commentdiv").on("click", ".deleteanchor", function(){
		var commentno = $(this).parent().attr('data-commentno');
		var boardno = ${board.boardno};
		var agree = confirm("삭제 하시겠습니까?");
		if(agree){
			$.ajax({
				url : "/board/free/comment/delete",
				type : "POST",
				dataType: "html",
				data : {"boardno":boardno,
						"commentno":commentno},
	  			success: function(res){
	  				$("#commentdiv").html(res);
				},
				 error: function(res){
					
				}
			});	
		}
	})
	
	
});

</script>
<style type="text/css">	

table thead {
	padding: 10px;
    border-top: 2px solid #282c37;
}			
table tbody {
	padding: 10px;
    border-bottom: 2px solid #282c37;
}					
.button-center {
	text-align: center;
}
.tablediv {
	padding: 0 5% 0 5%;
}
.contentdiv{
	padding: 0 10% 0 10%;
}
table{
	width: 100%;
	border-collapse: collapse;
    text-align: center;
    line-height: 1.5;
}
.viewinfo {
	background:#ccc;
}
h1{
	color:#000;
	font:bold 12px tahoma;
	font-size: 32px;
}
hr{
	color: "black";
	border-style: inset;
	border-width: 1px;
}
.wrap{
	padding:0 5% 0 5%;
	border-collapse: collapse;
}
.commentinsertdiv{
	padding: 0 10% 0 10%;
	display:inline-flex;
}
img {
	max-width: 100%;
}
</style>

<div class ="wrap">

<h1>자유게시판</h1>
<hr>


<table>
<thead>
	<tr>
		<td style="width:33%;text-align:left;">&nbsp;&nbsp;${board.boardno }</td>
		<td style="width:34%;">${board.title }</td>
		<td style="width:33%;text-align:right;"> 조회수 : ${board.hit}&nbsp;&nbsp;</td>
	</tr>
</thead>
<tbody>
	<tr>
		<td colspan="3" style="text-align:right;">
		<fmt:formatDate value="${board.writtendate }" pattern="yyyy-MM-dd" />
		&nbsp;&nbsp;${board.writer}</td>
	</tr>
</tbody>
</table>
<div class="contentdiv">
${board.content }
</div>
<hr>
<div class="button-center">	
<c:if test="${usernick eq board.writer && login eq true}">
<button id="btnUpdate" class="btn btn-primary">수정</button>
</c:if>
<c:if test="${usernick eq board.writer && login eq true || usernick eq '관리자'}">
<button id="btnDelete" class="btn btn-primary">삭제</button>
</c:if>
<br><br><br>
</div>


<c:if test="${'공지' ne board.tag}">
<div id="commentdiv">
	<c:import url="/WEB-INF/views/layout/comment.jsp" />
</div>
<br>

<c:if test="${login ne true }">
<div class="commentinsertdiv">
<textarea id="commentcontent" placeholder="로그인이 필요합니다."
	style="height:50px; width:600px; resize: none;"></textarea>
</div>
</c:if>
<c:if test="${login eq true }">
<div class="commentinsertdiv">
<textarea id="commentcontent" placeholder="내용을 입력해주세요" 
style="height:50px; width:600px; resize: none;"></textarea>&nbsp;
<button style="height:55px; width:55px;" type="button" id="btncommentinsert">작성</button>
</div>
</c:if>
</c:if>
</div>


<c:import url="/WEB-INF/views/layout/footer.jsp" />
