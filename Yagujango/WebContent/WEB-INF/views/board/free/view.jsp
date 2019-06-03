<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:import url="/WEB-INF/views/layout/header.jsp" />
<script type="text/javascript">
$(document).ready(function() {
	$("#btnDelete").click(function() {
		location.href="/board/free/delete?boardno=${board.boardno}";
	})
	$("#btnList").click(function() {
		location.href="/board/free/list";
	})
	$("#btnUpdate").click(function() {
		$(location).attr("href", "/board/free/update?boardno=${board.boardno }");
	});
	$("#btncommentinsert").click(function(){
		
		var boardno = ${board.boardno};
		var content = $("#commentcontent").val();
		
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
.tablediv {
	padding: 0 5% 0 5%;
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
</style>
</head>
<body>
<div class ="container">
<div class="tablediv">
<table>
<tbody>
	<tr>
		<td class="viewinfo">글번호</td>
		<td>${board.boardno }</td>
	</tr>
	<tr>
		<td class="viewinfo">제목</td>
		<td>${board.title }</td>
	</tr>
	<tr>
		<td class="viewinfo">작성자</td>
		<td>${board.writer }</td>
	</tr>
	<tr>
		<td class="viewinfo">조회수</td>
		<td>${board.hit }</td>
	</tr>
	<tr>
		<td class="viewinfo">작성일</td>
		<td>${board.writtendate }</td>
	</tr>
	<tr>
		<td class="viewinfo">본문</td>
	</tr>
	<tr>
		<td>${board.content }</td>
	</tr>
</tbody>
</table>


<div class="text-center">	
<button id="btnList" class="btn btn-primary">목록</button>
<c:if test="${usernick eq board.writer && login eq true || usernick eq '관리자'}">
<button id="btnUpdate" class="btn btn-primary">수정</button>
<button id="btnDelete" class="btn btn-primary">삭제</button>
</c:if>
</div>

<c:if test="${'공지' ne board.tag}">
<div id="commentdiv">
<table class="table table-striped table-hover table-condensed">
	<tr class="info">
		<td>작성자</td>
		<td colspan="5">내용</td>
		<td>작성일</td>
		<td></td>
	
	</tr>
	<c:forEach var="j" items="${comment }">
	<tr>
		<td>${j.writer }</td>
		<td colspan="5">${j.content }</td>
		<td>${j.writtendate}</td>
		<c:if test="${j.writer eq usernick }">
		<!-- 해당 행의 commentno 정보 td에 등록 -->
		<td data-commentno="${j.commentno }"><a class="deleteanchor">삭제</a></td>
		</c:if>
	</tr>
	</c:forEach>
</table>
</div>
<input type="text" id="commentcontent">
<button type="button" id="btncommentinsert">작성</button>
</c:if>


</div>


</div>
<c:import url="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>