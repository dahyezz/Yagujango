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
			placeholder: '마지막에 업로드하는 이미지가 미리보기 이미지로 등록됩니다.<br>부적절한 이미지 게시 시, 글이 삭제는 등 불이익을 받을 수 있습니다.',
			
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
	    $.ajax({ // ajax를 통해 파일 업로드 처리
	        data : data,
	        dataType: "json",
	        type : "POST",
	        url : "/board/seat/fileupload",
	        cache : false,
	        contentType : false,
	        enctype: 'multipart/form-data',
	        processData : false,
	        success : function(data) { // 처리가 성공할 경우
           		 // 에디터에 이미지 출력   
           		console.log(data);
           		$("#summernote").summernote('insertImage', data.url);
	        	fileurl = data.url;
	        	$('#boardno').val(data.boardno);
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
<style type="text/css">
.wrap{
	padding:0 5% 0 5%;
	border-collapse: collapse;
}
p{
	color:blue;
	font-weight:bold;
}
.button-right{text-align:right;}
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
<h1>좌석 뷰 게시판</h1>
<hr>
<!-- <form action="/board/seat/write" method="post" onsubmit="postForm()"> -->
<form action="/board/seat/write" method="post" id="fo">
<table>
<tr><td>구장명</td><td><p>(필수)</p></td><td>
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
<tr><td>블럭</td><td><p>(필수)</p></td><td>
						<select name="seat_block">
							<option>A</option>
							<option>B</option>
							<option>C</option>
							<option>D</option>
							<option>E</option>
						</select>
					</td></tr>
<tr><td>좌석번호</td><td><p>(필수)</p></td><td>
						<select name="seat_number">
							<c:forEach begin="1" end="100" var="i">
								<option>${i}</option>
							</c:forEach>
						</select>
					</td></tr>
</table>
<textarea name="content" style="display: none;"></textarea>
<div id="summernote"></div>
<input type="text" style="display: none;" id="boardno" name="boardno" value="0"/>
<div class ="button-right">
<button type="submit">작성</button>
</div>
</form>
</div>
<c:import url="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>