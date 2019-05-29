<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
			},
			uploadcare: {
	            publicKey: 'demopublickey',
	            crop: 'free',
	            tabs: 'file url instagram',
	            tooltipText: 'Upload files or video or something',
	            multiple: false
	        },
			 toolbar: [
		            ['uploadcare', ['uploadcare']], // this is the button
		            ['style', ['style']],
		            ['font', ['bold', 'italic', 'underline', 'clear']],
		            ['fontname', ['fontname']],
		            ['color', ['color']],
		            ['para', ['ul', 'ol', 'paragraph']],
		            ['height', ['height']],
		            ['table', ['table']],
		            ['insert', ['media', 'link', 'hr', 'picture', 'video']],
		            ['view', ['fullscreen', 'codeview']],
		            ['help', ['help']]
		          ]
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
	        	$("#summernote").summernote('insertImage', 'http://localhost:8088/'+url);
	        }
	    });
	}
function postForm() {
    $('textarea[name="content"]').val($('#summernote').summernote('code'));
}


</script>
</head>
<body>
<form action="/board/free/write" method="post" onsubmit="postForm()">
<table class="table table-bordered">
<tr><td class="info">아이디</td><td>${userid }</td></tr>
<tr><td class="info">제목</td><td><input type="text" name="title" style="width:100%"/></td></tr>
<tr><td class="info" colspan="2">본문</td></tr>
<tr><td colspan="2">
	<textarea name="content" style="display: none;"></textarea>
	<div id="summernote"></div>
</td></tr>
</table>
<button type="submit">작성</button>

</form>
</body>
</html>