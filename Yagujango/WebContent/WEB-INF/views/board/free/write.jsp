<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:import url="/WEB-INF/views/layout/header.jsp" />
<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 

<!-- include summernote css/js -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.js"></script>

<script type="text/javascript">

$(document).ready(function() {
	$("#btnCancle").click(function() {
		location.href="/board/free/list";
	})
    $('#summernote').summernote({
            height: 300,                 // set editor height
            minHeight: 300,             // set minimum height of editor
            maxHeight: null,             // set maximum height of editor
            focus: true,				 // set focus to editable area after initializing summernote
			lang: 'ko-KR',
			placeholder: '불건전한 언어 사용, 타인 비방 및 게시판 운영을 방해하는 행위가 확인되면 서비스 이용이 제한될 수 있습니다.<br>게시글 작성 시 타인에 대한 배려와 책임을 담아주세요.',
			toolbar: [
		        ['style', ['style']],
		        ['font', ['bold', 'italic', 'underline', 'clear']],
		        ['fontname', ['fontname']],
		        ['color', ['color']],
		        ['para', ['ul', 'ol', 'paragraph']],
		        ['height', ['height']],
		        ['table', ['table']],
		        ['insert', ['link', 'hr', 'picture']],
		        ['view', ['fullscreen', 'codeview']],
		        ['help', ['help']]
		    ],
			callbacks: {
				onImageUpload: function(files, editor) {
					sendFile(files[0],editor);
				}
			}
			 
    });
});
function sendFile(file, editor) {
    	// 파일 전송을 위한 폼생성
		data = new FormData();
	    data.append("uploadFile", file);
	    data.append("boardno",$('#boardno').val());
// 	    console.log($('#boardno').val());
	    $.ajax({ // ajax를 통해 파일 업로드 처리
	        data : data,
	        dataType: "json",
	        type : "POST",
	        url : "/board/free/fileupload",
	        cache : false,
	        contentType : false,
	        enctype: 'multipart/form-data',
	        processData : false,
	        success : function(data) { // 처리가 성공할 경우
           		 // 에디터에 이미지 출력   
	        	$("#summernote").summernote('insertImage', data.url);
	        	$('#boardno').val(data.boardno);
	        }
	    });
	}
function postForm() {
    $('textarea[name="content"]').val($('#summernote').summernote('code'));
}


</script>
<style type="text/css">
.wrap{
	padding:0 5% 0 5%;
	border-collapse: collapse;
}
.button-right{
	text-align:right;
}
.inline{
	display:inline;
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


</style>
</head>
<body>
<div class="wrap">
<div class="up">
<h1>자유게시판</h1>
<hr>
</div>
<form action="/board/free/write" method="post" onsubmit="postForm()">
<div class="inline">
<select name="tag">
    <option>잡담</option>
    <option>질문</option>
   	<option>후기</option>
<c:if test="${userid eq 'admin'}">
	<option>공지</option>
</c:if>
</select>
&nbsp;
<input type="text" name="title" style="width:50%;"placeholder="제목을 입력하세요"/>
<br>
<br>
</div>
<textarea name="content" style="display: none;"></textarea>
<div id="summernote"></div>
<input type="text" style="display: none;" id="boardno" name="boardno" value="0"/>
<div class ="button-right">
<button type="submit">작성</button><button type="button" id="btnCancle">취소</button>
</div>
</form>
</div>
<c:import url="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>