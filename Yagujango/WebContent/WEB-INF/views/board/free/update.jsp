<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    $('#summernote').summernote({
            height: 300,                 // set editor height
            minHeight: 300,             // set minimum height of editor
            maxHeight: null,             // set maximum height of editor
            focus: true,				 // set focus to editable area after initializing summernote
			lang: 'ko-KR',
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
	    $.ajax({ // ajax를 통해 파일 업로드 처리
	        data : data,
	        type : "POST",
	        url : "/board/free/fileupload",
	        cache : false,
	        contentType : false,
	        enctype: 'multipart/form-data',
	        processData : false,
	        success : function(url) { // 처리가 성공할 경우
           		 // 에디터에 이미지 출력   
	        	$("#summernote").summernote('insertImage', url);
	        }
	    });
	}
</script>
</head>
<body>
<form action="/board/free/update" method="post">
<input type="hidden" name="boardno" value="${board.boardno }" />

<table class="table table-bordered">
<tr><td class="info">아이디</td><td>${userid }</td></tr>
<tr><td class="info">닉네임</td><td>${usernick }</td></tr>
<tr><td class="info">제목</td><td><input type="text" name="title" style="width:100%" value="${board.title }"/></td></tr>
<tr><td class="info" colspan="2">본문</td></tr>
<tr><td colspan="2">
	
	<textarea id="summernote" name="content">${board.content }</textarea>
</td></tr>
</table>
<button>수정</button>
</form>
</body>
</html>