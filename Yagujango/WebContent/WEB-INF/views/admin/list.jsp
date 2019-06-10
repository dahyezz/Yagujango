<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp"/>

<script type="text/javascript">
$(document).ready(function() {
	
	//글쓰기 버튼 누르면 이동
	$("#btnList").click(function() {
		location.href="/admin/blacklist";
	});
	
	//글쓰기 버튼 누르면 이동
	$("#btnmList").click(function() {
		location.href="/admin/board_1to1";
	});
	
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


		//blacklist update
		$("#btnUpdate").click(function() {
			// 선택된 체크박스
			var $checkboxes = $("input:checkbox[name='checkUp']:checked");
			
			//방법2
			// 체크된 대상들을 map으로 만들고 map을 문자열로 만들기
			var map = $checkboxes.map(function() {
				return $(this).val();
			});
			var names = map.get().join(",");
			
		
		// 전송 폼
		var $form = $("<form>")
			.attr("action", "/admin/list")
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
		
		//전체 체크/해제
		function checkAll() {
		// checkbox들
		var $checkboxes=$("input:checkbox[name='checkUp']");
		
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

<meta charset="UTF-8">
<title>회원목록</title>
<style type="text/css">
.tablediv {
	
	text-align: center;

}
</style>

<h1>회원</h1>
<hr>

<button id="btnList" class="btn btn-blacklist">블랙리스트</button>
<button id="btnmList" class="btn btn-blacklist">1:1문의확인</button>

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

<div class="form-inline text-center">
	<input class="form-control" type="text" id="keyword" />
	<button id="btnSearch" class="btn">검색</button>
</div> 


<c:import url="/WEB-INF/views/layout/footer.jsp"/>