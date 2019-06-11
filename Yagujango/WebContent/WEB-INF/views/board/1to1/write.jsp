<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>


<script type="text/javascript">
$(document).ready(function() {
	
	//작성버튼 동작
	$("#btnWrite").click(function() {
		$("form").submit();
		alert( "1:1문의 접수완료" );
	});
	
	//취소버튼 동작
	$("#btnCancel").click(function() {
		history.go(-1);
	});
});
</script> 

<script type="text/javascript">
$(function(){	
	$(document).ready(function(){
		$('select[name=emailSelection]').change(function() {
			if($(this).val()=="1"){
				$('#email2').val("메일을선택해주세요");
			} else {
				$('#email2').val($(this).val());
				$("#email2").attr("readonly", true);
			}
		});
	});
});

</script>

<style type="text/css">
Body {
    width: 1170px;
	padding-right: 15px;
    padding-left: 15px;
    margin-right: auto;
    margin-left: auto;
}

.witerBody {
    clear: both;
    border-top: 3px solid #000000;
    border-bottom: 3px solid #000000;
}
.text-center { 
    position: relative;
    left: 1000px;
	line-height: 40px;
	font-size: 15px;
	width: 100%; 
}
.witerBody {
    padding-right: 162px;
    padding-left: 155px;
    padding-top: 30px;
    padding-bottom: 30px;
    
}


.btn btn-info {

    display: inline block;

}

	


</style>

<table class="t1">
	<tr>
		<th style="font-size: 45px;">1:1문의</th>
		<th style="font-size: 13px; padding-top: 20px;">
			<ul>
				<il>&nbsp;&nbsp;&nbsp;&nbsp;(필수)항목은 반드시 입력해주셔야 문의 접수가 가능합니다.</il><br>
				<il>적어주신 정보는 문의 처리를 위한 용도로만 이용됩니다.</il>	
			</ul>
		</th>
	</tr>
</table>

<div class="witer">
	<div class="witerBody">
		<form action="/board/1:1write" method="post">
		
			<table class="table 1">
				<tr>
					<th class="witer_info" style="font-size: 13px;">답변 받을 이메일</th>
					<th style="color: blue; font-size: 12px;">(필수)</th>
					<td>
						<input type="text" name="email1" id="email1" class="box" class=""/>@
						<input type="text" name="email2" id="email2" class="box"/>
						<select name="emailSelection" class="emailSelection">
							<option value="1" selected="selected">메일을 선택해주세요</option>
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="hatmail.net">hatmail.net</option>
							<option value="nate.com">nate.com</option>
							<option value="yahoo.co.kr">yahoo.co.kr</option>
							<option value="dreamwiz.com">dreamwiz.com</option>
							<option value="korea.com">korea.com</option>
							<option value="paran.com">paran.com</option>
							
						</select>
					</td>
				</tr>
			</table>	
			
			<hr>
			
			<table class="table 2">

				<tr>
					<th class="witer_info" style="font-size: 13px;">제목</th>
					<th style="color: blue; font-size: 12px;">(필수)</th>
					<td><input type="text" name="title" style="width:100%"/></td>
				</tr>
				
				<tr> 
					<th class="witer_info" style="font-size: 13px;">내용</th>
					<th style="color: blue; font-size: 12px;">(필수)</th>
					<td colspan="2">
						<textarea id="content" name="content" rows="10" cols="100" ></textarea>
					</td>
				</tr>
				 
			</table>
		</form>
	</div>
	
	
	<div class="text-center" id="text-center">	
		<button type="button" id="btnWrite" class="btn btn-info">1:1 문의접수</button>
		<button type="button" id="btnCancel" class="btn btn-danger">취소</button>
	</div>
</div>
 


<c:import url="/WEB-INF/views/layout/footer.jsp" />



