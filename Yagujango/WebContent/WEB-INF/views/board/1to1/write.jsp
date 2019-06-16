<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 

<!-- include summernote css/js -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.js"></script>


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
	
	$('#summernote').summernote({
		width:1000,
        height: 300,                 // set editor height
        minHeight: 350,             // set minimum height of editor
        maxHeight: 350,             // set maximum height of editor
        focus: true,				 // set focus to editable area after initializing summernote
		lang: 'ko-KR',
		placeholder: '항목은 반드시 입력해주셔야 문의 접수가 가능합니다.<br>적어주신 정보는 문의 처리를 위한 용도로만 이용됩니다.',
		toolbar: [
	        ['style', ['style']],
	        ['font', ['bold', 'italic', 'underline', 'clear']],
	        ['fontname', ['fontname']],
	        ['color', ['color']],
	        ['para', ['ul', 'ol', 'paragraph']],
	        ['height', ['height']],
	        ['table', ['table']],
	        ['help', ['help']]
	    ]
	});
});



</script> 

<script type="text/javascript">
$(function(){	
	$(document).ready(function(){
		$('select[name=emailSelection]').change(function() {
			if($(this).val()=="1"){
				$('#email2').val("");
			} else {
				$('#email2').val($(this).val());
				$("#email2").attr("readonly", true);
			}
		});
	});
});

</script>

<style type="text/css">
.wrtierfull {
	margin: 0 5% 0 5%;
}

.witerBody {
    clear: both;
    border-top: 3px solid #000000;
    border-bottom: 3px solid #000000;
    
    padding-right: 10px;
    padding-left: 10px;
    padding-top: 30px;
    padding-bottom: 30px;
}
.text-center { 
    position: relative;
/*     left: 1000px; */
	line-height: 40px;
	font-size: 15px; 
/* 	width: 1000px;  */
	float: right;
}



.btn btn-info {

    display: inline block;

}

a {
	text-decoration: none;
}
</style>

<div class="wrtierfull">

<div class="witer">
	<div class="witerBody">
		<form action="/board/1:1write" method="post">


<table class="t1">
	<tr>
		<td style="font-size: 45px;" rowspan="2"><h3 style="margin: 0 0 0 0;">1:1문의</h3></td>
	</tr>
</table>


			<table class="table 1">
				<tr>
					<th class="witer_info" style="font-size: 13px;">이메일</th>
					<th style="color: #0080ff; font-size: 12px;">(필수)</th>
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
				
				<tr>
					<th class="witer_info" style="font-size: 13px;">제목</th>
					<th style="color: #0080ff; font-size: 12px;">(필수)</th>
					<td><input type="text" name="title" style="width:1000px"/></td>
				</tr>
				
				<tr> 
					<th class="witer_info" style="font-size: 13px;">내용</th>
					<th style="color: #0080ff; font-size: 12px;">(필수)</th>
					<td colspan="2">
						<textarea id="summernote" name="content"></textarea>
					</td>
				</tr>
			</table>	
			
			<hr>
		</form>
	</div>
	
	
	<div class="text-center" id="text-center">	
		<button type="button" id="btnWrite" class="btn btn-info">1:1 문의접수</button>
		<button type="button" id="btnCancel" class="btn btn-danger">취소</button>
	</div>
</div>
 
</div>

<c:import url="/WEB-INF/views/layout/footer.jsp" />



