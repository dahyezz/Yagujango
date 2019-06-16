<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />
<script src="https://cdn.jsdelivr.net/npm/exif-js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#btnDelete").click(function() {
		location.href="/board/seat/delete?boardno=${board.boardno}";
	})
	$("#btnList").click(function() {
		location.href="/board/seat/list";
	})
	$("#btnUpdate").click(function() {
		$(location).attr("href", "/board/seat/update?boardno=${board.boardno }");
	})
	$("#btncommentinsert").click(function(){
		
		var boardno = ${board.boardno};
		var content = $("#commentcontent").val();
		
		if(content !=null){
			$.ajax({
				url : "/board/seat/comment/insert",
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
				url : "/board/seat/comment/delete",
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
img {
	transform-origin: top left; /* IE 10+, Firefox, etc. */
	-webkit-transform-origin: top left; /* Chrome */
	-ms-transform-origin: top left; /* IE 9 */
}
.rotate90 {
	transform: rotate(90deg) translateY(-100%);
	-webkit-transform: rotate(90deg) translateY(-100%);
	-ms-transform: rotate(90deg) translateY(-100%);
}						
.button-center {
	text-align: center;
}
.tablediv {
	padding: 0 5% 0 5%;
}
table{
	width: 100%;
	border-collapse: collapse;
    line-height: 1.5;
}
.viewinfo {
	background:#ccc;
}
table thead {
	padding: 10px;
    border-top: 2px solid #282c37;
}			
table tbody {
	padding: 10px;
    border-bottom: 2px solid #282c37;
}	

img {max-width: 100%;}
.contentdiv{padding: 0 10% 0 10%;}
</style>

<div class="tablediv">
<table>
<thead>
	<tr>
		<td style="width:33%;text-align:left;">&nbsp;&nbsp;${board.boardno }</td>
		<td style="width:34%;">${board.stadium_name} ${board.seat_block }열 ${board.seat_number }번 좌석</td>
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


<div class="button-center">	
<button id="btnList" class="btn btn-primary">목록</button>
<c:if test="${usernick eq board.writer && login eq true}">
<button id="btnUpdate" class="btn btn-primary">수정</button>
</c:if>
<c:if test="${usernick eq board.writer && login eq true || usernick eq '관리자'}">
<button id="btnDelete" class="btn btn-primary">삭제</button>
</c:if>
<br><br><br>
</div>
<hr>
</div>

<c:import url="/WEB-INF/views/layout/footer.jsp" />
