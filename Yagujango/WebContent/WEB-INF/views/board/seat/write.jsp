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
var fileurl = "";
$(document).ready(function() {
    $('#summernote').summernote({
            height: 300,                 // set editor height
            minHeight: 300,             // set minimum height of editor
            maxHeight: null,             // set maximum height of editor
            focus: true,				 // set focus to editable area after initializing summernote
			lang: 'ko-KR',
			toolbar: [
		        ['style', ['style']],
		        ['font', ['bold', 'italic', 'underline', 'clear']],
		        ['fontname', ['fontname']],
		        ['color', ['color']],
		        ['para', ['ul', 'ol', 'paragraph']],
		        ['height', ['height']],
		        ['table', ['table']],
		        ['insert', ['media', 'link', 'hr', 'picture']],
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
	    $.ajax({ // ajax를 통해 파일 업로드 처리
	        data : data,
	        type : "POST",
	        url : "/board/seat/fileupload",
	        cache : false,
	        contentType : false,
	        enctype: 'multipart/form-data',
	        processData : false,
	        success : function(url) { // 처리가 성공할 경우
           		 // 에디터에 이미지 출력   
	        	$("#summernote").summernote('insertImage', url);
	        	
	        	$('#summernote').summernote({
	    			toolbar: [
	    		        ['style', ['style']],
	    		        ['font', ['bold', 'italic', 'underline', 'clear']],
	    		        ['fontname', ['fontname']],
	    		        ['color', ['color']],
	    		        ['para', ['ul', 'ol', 'paragraph']],
	    		        ['height', ['height']],
	    		        ['table', ['table']],
	    		        ['insert', ['link', 'hr']],
	    		        ['view', ['fullscreen', 'codeview']],
	    		        ['help', ['help']]
	    		    ]
	        	 });
	        	fileurl = url;
	        	
	        	console.log(fileurl);
	        }
	    });
	}
// function postForm() {
// 	$(this).append($("<input>").attr("name", "fileurl").val(fileurl));
	
// 	return false;
// 	var code = $('#summernote').summernote('code');
	
	
//     $('textarea[name="content"]').val(code);
// }

$(document).ready(function() {
	$("#fo").submit(function() {
		$(this).append($("<input>").attr("type", "hidden").attr("name", "fileurl").val(fileurl));
		var code = $('#summernote').summernote('code');
	    $('textarea[name="content"]').val(code);
		$(this).submit();
	})
})
</script>
</head>
<body>
<!-- <form action="/board/seat/write" method="post" onsubmit="postForm()"> -->
<form action="/board/seat/write" method="post" id="fo">
<table>
<tr><td class="info">아이디</td><td>${userid }</td></tr>
<tr><td class="info">구장명</td><td>
						<select name="stadium_name">
							<option>광주 KIA챔피언스필드</option>
							<option>수원 케이티위즈파크</option>
							<option>잠실</option>
							<option>창원NC파크</option>
							<option>인천SK 행복드림</option>
							<option>부산 사직</option>
							<option>대구 삼성라이온즈파크</option>
							<option>고척스카이돔</option>
							<option>한화생명 EaglesPark</option>
						</select>
					</td></tr>
<tr><td class="info">블록</td><td>
						<select name="seat_block">
							<option>A</option>
							<option>B</option>
							<option>C</option>
							<option>D</option>
							<option>E</option>
						</select>
					</td></tr>
<tr><td class="info">좌석번호</td><td>
						<select name="seat_number">
							<c:forEach begin="1" end="100" var="i">
								<option>${i}</option>
							</c:forEach>
						</select>
					</td></tr>
<tr><td colspan="2">
	<textarea name="content" style="display: none;"></textarea>
	<div id="summernote"></div>
</td></tr>
</table>
<button type="submit">작성</button>

</form>
<c:import url="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>