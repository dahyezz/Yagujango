<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<script type="text/javascript">
$(document).ready(function() {
	$("#btn1to1Write").click(function() {
		location.href="/board/1:1write";
	});
	
});
</script>

<style type="text/css">

Body {
	padding: 0 5% 0 5%;
}

.faqBody {
    clear: both;
    border-top: 3px solid #000000;
    border-bottom: 3px solid #000000;

}


.form-control { 
	line-height: 25px;
    width: 455px;
    font-size: 15px;
    border-left: none;
    border-right: none;
	padding: 0px 20px;
}


.search {
	display:block;
	text-align:center; 
	background:#d9e1e8;
	padding:0 0 0 35px;
	font-size:18px;
	color:#5e5e5e;
	font-weight:bold;
	line-height: 50px;
	cursor:pointer;
	box-sizing: content-box;
	margin: 10px 0; !important
}

.faq{
	border-bottom:0px solid #ddd;
	margin:1em 0;
}

.faq .faqHeader{
	position:relative;
	zoom:1
}

.faq .faqHeader .showAll{
	position:absolute;
	bottom:0;
	right:0;
	border:0;
	padding:0;
	overflow:visible;
	background:none;
	cursor:pointer
}
.faq .faqBody .article{
	list-style:none
}



.faq .q a {
	display: block;
    padding: 22 15px 0 100px;
    line-height: 55px;
    color: #555555;
    margin: 0 0 0 0px;
    border-bottom: 1px solid #d9e1e8;
    font-size: 16px;
    text-decoration:none;
}
    
.faq .q a:hover, .faq .q a:active, .faq .q a:focus{}
.faq .a {
	background:#f8f8f8;
	padding: 10px 75px 10px 75px;
	font-size: 16px;
	color: #444444;
	line-height: 22px;
	border-top: 1px solid #bdbdbd;
	margin:5px 0 0 0;
}
#btnBox { 

	display:block;
	text-align:center; 
	background:#d9e1e8;
	padding:0 0 0 35px;
	font-size:15px;
	color:#5e5e5e;
	font-weight:bold;
	line-height: 0px;
	cursor:pointer;
	box-sizing: content-box;
	margin: 10px 0; !important

}

#btn1to1Write {
	line-height: 38px;
	font-size: 14px;
	width: 100%; 
	text-align:right;
}



</style>

<script type="text/javascript">
jQuery(function($){
	// Frequently Asked Question
	var article = $('.faq>.faqBody>.article');
	article.addClass('hide');
	article.find('.a').hide();
	article.eq(0).removeClass('hide');
	$('.faq>.faqBody>.article>.q>a').click(function(){
		var myArticle = $(this).parents('.article:first');
		if(myArticle.hasClass('hide')){
			article.addClass('hide').removeClass('show');
			article.find('.a').slideUp(100);
			myArticle.removeClass('hide').addClass('show');
			myArticle.find('.a').slideDown(100);
		} else {
			myArticle.removeClass('show').addClass('hide');
			myArticle.find('.a').slideUp(100);
		}
		return false;
	});
});

</script>


<table class="t1">
	<tr>
		<th style="font-size: 60px;">FAQ</th>
		<th style="font-size: 15px; padding-top: 50px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;자주 질문하시는 내용과 답변입니다</th>
	</tr>
</table>


<div class="search">
	<form action="/board/faq/faqlist" method="get">
		<input type="hidden" name="name" value="faq_title">
		<input class="form-control" type="text" name="keyword" placeholder="검색어를 입력해 주세요"/>
		<button>검색</button>
	</form>
</div>

<div class="faq">
    <ul class="faqBody"> 
       <c:forEach items="${faqList}" var="i">
			<li class="article" id="a1">
				<p class="q">
					<a href="/board/faq/faqlist"  >
						Q.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${i.faq_title }
					</a>
				</p>
				<p class="a" style="background: #d9e1e8">
					&nbsp;&nbsp;&nbsp;&nbsp;A.<br>
					&nbsp;&nbsp;&nbsp;&nbsp;${i.faq_content }<br>
				</p>
			</li>
		</c:forEach>
    </ul>
</div>

<div id="pagingBox">  
	<c:import url="/WEB-INF/views/layout/faq_paging.jsp" />

</div>

<table id="btnBox">
		<tr>
			<td colspan="3">원하시는 답변을 찾지 못하셨다면, 옆에 1:1문의하여주세요.</td>
			<td>
				<button class="button-right" id="btn1to1Write">1:1 문의하기</button>
			</td>
		</tr>

</table>
 


<c:import url="/WEB-INF/views/layout/footer.jsp" />
