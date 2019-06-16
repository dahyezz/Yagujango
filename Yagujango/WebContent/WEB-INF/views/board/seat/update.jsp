<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


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
    
    $("select option[value='${board.stadium_name}']").attr("selected", true);
    $("select option[value='${board.seat_block}']").attr("selected", true);
    $("select option[value='${board.seat_number}']").attr("selected", true);
});
function sendFile(file, editor) {
	// 파일 전송을 위한 폼생성
	data = new FormData();
    data.append("uploadFile", file);
    data.append("boardno", $('#boardno').val());
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
        
        	
        }
    });
}
</script>

<form action="/board/free/update" method="post">

<table class="table table-bordered">
<tr><td class="info">아이디</td><td>${userid }</td></tr>
<tr><td class="info">구장명</td><td>
						<select name="stadium_name">
							<option value="광주 KIA챔피언스필드">광주 KIA챔피언스필드</option>
							<option value="수원 케이티위즈파크">수원 케이티위즈파크</option>
							<option value="잠실">잠실</option>
							<option value="창원NC파크">창원NC파크</option>
							<option value="인천SK 행복드림">인천SK 행복드림</option>
							<option value="부산 사직">부산 사직</option>
							<option value="대구 삼성라이온즈파크">대구 삼성라이온즈파크</option>
							<option value="고척스카이돔">고척스카이돔</option>
							<option value="한화생명 EaglesPark">한화생명 EaglesPark</option>
						</select>
					</td></tr>
<tr><td class="info">블록</td><td>
						<select name="seat_block">
							<option value="A">A</option>
							<option value="B">B</option>
							<option value="C">C</option>
							<option value="D">D</option>
							<option value="E">E</option>
						</select>
					</td></tr>
<tr><td class="info">좌석번호</td><td>
						<select name="seat_number">
							<c:forEach begin="1" end="100" var="i">
								<option value="${i}">${i}</option>
							</c:forEach>
						</select>
					</td></tr>
<tr><td colspan="2">
	<textarea name="content" id="summernote" >${board.content }</textarea>
</td></tr>
</table>
<input type="text" style="display: none;" id="boardno" name="boardno" value="${board.boardno}"/>
<button>수정</button>
</form>

<c:import url="/WEB-INF/views/layout/footer.jsp" />
