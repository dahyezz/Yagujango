<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>

<script type="text/javascript">

$(document).ready(function() {
	
	$("#btn1:1Write").click(function() {
		location.href="/board/1:1write";
	});
	
	$("#btnSearch").click(function() {
		location.href="/board/faq/faqlist?search="+$("#search").val();
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

.btn {
	line-height: 25px;
    font-size: 15px;
	width: 70px; 
}




.search {
	display:block;
	text-align:center; 
	background:#CCC;
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
/* 	display:block;text-align:left;  */
/* 	background:url("q_icon.png") no-repeat 0 0; */
/* 	padding:0 0 0 35px; */
/* 	font-size:18px; */
/* 	color:#5e5e5e; */
/* 	font-weight:bold; */
/* 	line-height: 27px; */
/* 	cursor:pointer; */
/* 	margin: 10px 0; !important */
	display: block;
    padding: 0 15px 0 100px;
    line-height: 55px;
    color: #555555;
    margin: 0 0 0 0px;
    border-bottom: 1px solid #dedede;
    font-size: 16px;
    text-decoration:none;
}
    
.faq .q a:hover, .faq .q a:active, .faq .q a:focus{}
.faq .a {
	background:#f8f8f8 url("a_icon.png") no-repeat 40px 10px;padding: 10px 75px 10px 75px;
	font-size: 16px;
	color: #444444;
	line-height: 22px;
	border-top: 1px solid #bdbdbd;
	margin:5px 0 0 0;
}
.t2 { 
	display:block;
	text-align:center; 
	background:#CCC;
	padding:0 0 0 35px;
	font-size:15px;
	color:#5e5e5e;
	font-weight:bold;
	line-height: 0px;
	cursor:pointer;
	box-sizing: content-box;
	margin: 10px 0; !important

}



</style>

<script type="text/javascript">

jQuery(function($){
    // Frequently Asked Question
    var article = $('.faq>.faqBody>.article');
    article.addClass('hide');
    article.find('.a').hide();
    article.eq(0).removeClass('hide');
    article.eq(0).find('.a').show();
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
    
    $('.faq>.faqHeader>.showAll').click(function(){
        var hidden = $('.faq>.faqBody>.article.hide').length;
        if(hidden > 0){
            article.removeClass('hide').addClass('show');
            article.find('.a').slideDown(100);
        } else {
            article.removeClass('show').addClass('hide');
            article.find('.a').slideUp(100);
        }
    });
});

</script>
</head>
<body>
<table class="t1">
	<tr>
		<th style="font-size: 60px;">FAQ</th>
		<th style="font-size: 15px; padding-top: 50px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;자주 질문하시는 내용과 답변입니다</th>
	</tr>
</table>


<div class="search">
	<input class="form-control" type="text" id="search" placeholder="검색어를 입력해 주세요"/>
	<button id="btnSearch" class="btn">검색</button>

</div>

<div class="faq">
    <ul class="faqBody"> 
        <li class="article" id="a1">
            <p class="q"><a href="#a1">Q.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;경기가 우천으로 취소되면 어떻게 해야 합니까?</a></p>
            <p class="a" style="background: #CCC">
            	&nbsp;&nbsp;&nbsp;&nbsp;A.<br>
            	&nbsp;&nbsp;&nbsp;&nbsp;매표 및 입장 이전에 우천으로 경기가 취소되면 카드결제는 자동으로 취소되며<br>
            	&nbsp;&nbsp;&nbsp;&nbsp;자세한문의는(이메일 yagujanggo@gmail.com)로 메일주시면 환불이 가능합니다.</p>
        </li>
        
        <li class="article" id="a2">
            <p class="q" ><a href="#a2">Q.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;예매티켓은 어떻게 발권합니까?</a></p>
            <p class="a" style="background: #CCC; display: black;">
            	&nbsp;&nbsp;&nbsp;&nbsp;A.<br>
				&nbsp;&nbsp;&nbsp;&nbsp;1. 현장에서 예약번호를 제시하고 티켓수령 후 입장하시면 됩니다.<br>
				&nbsp;&nbsp;&nbsp;&nbsp;2. 마이페이지에서 예매확인/취소 에서 바코드 발급으로 수령이 가능합니다.<br></p>
        </li>
        
        <li class="article" id="a3">
            <p class="q"><a href="#a3">Q.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;예매를 취소하고 싶습니다</a></p>
            <p class="a" style="background: #CCC">
            	&nbsp;&nbsp;&nbsp;&nbsp;A.<br>
				&nbsp;&nbsp;&nbsp;&nbsp;1. 예매취소를 원하시는 경우에는(yagujanggo@gmail.com)로 메일주시면 취소가 가능합니다. <br>
				&nbsp;&nbsp;&nbsp;&nbsp;2. 취소시에는 일정 금액을 제외하고 환불이 가능합니다.<br>
        </li>
        
        <li class="article" id="a4">
            <p class="q"><a href="#a4">Q.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;단체관람 관련 문의는?</a></p>
            <p class="a" style="background: #CCC">
            	&nbsp;&nbsp;&nbsp;&nbsp;A.<br>
            	&nbsp;&nbsp;&nbsp;&nbsp;10명 이상은(이메일 yagujanggo@gmail.com)로 문의주시기 바랍니다.</p>
        </li>
        
        <li class="article" id="a5">
            <p class="q"><a href="#a5">Q.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;무료입장의 범위는 어떻게 됩니까?</a></p>
            <p class="a" style="background: #CCC">
            	&nbsp;&nbsp;&nbsp;&nbsp;A.<br>
            	&nbsp;&nbsp;&nbsp;&nbsp;어린이 회원은 외야석에 한하여 무료입장이 가능합니다.</p>
        </li>
        
		<li class="article" id="a6">
            <p class="q"><a href="#a6">Q.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;각 구단 홈경기 팬서비스</a></p>
            <p class="a" style="background: #CCC">
            	&nbsp;&nbsp;&nbsp;&nbsp;A.<br>
            	&nbsp;&nbsp;&nbsp;&nbsp;홈경기를 찾는 팬들에게 야구장의 추억을 간직할 수 있는 기념품 선물을 지급합니다.</p>
        </li>
        
		<li class="article" id="a7">
            <p class="q"><a href="#a7">Q.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;각 구단 모임 환담회는 언제 하나요?</a></p>
            <p class="a" style="background: #CCC">
          		&nbsp;&nbsp;&nbsp;&nbsp;A.<br>
				&nbsp;&nbsp;&nbsp;&nbsp;시즌 종료 후 팬들과 함께 야구장 그라운드에서 선수와 함께 즐기는 팬페스트입니다.<br> 
				&nbsp;&nbsp;&nbsp;&nbsp;구체적인 일정은 시즌 종료 후 결정되며,<br>
				&nbsp;&nbsp;&nbsp;&nbsp;결정된 사항은 홈페이지와 보도 자료를 통해 팬 여러분들께 공지해 드립니다.<br>
				&nbsp;&nbsp;&nbsp;&nbsp;많은 관심과 참가 바랍니다</p>
        </li>
        
		<li class="article" id="a8">
            <p class="q"><a href="#a8">Q.경기 중 응원단상에서 진행되는 이벤트가 궁금해요</a></p>
            <p class="a" style="background: #CCC">
            	&nbsp;&nbsp;&nbsp;&nbsp;A.<br>
            	&nbsp;&nbsp;&nbsp;&nbsp;준비중입니다.</p>
        </li>
        
		<li class="article" id="a9">
            <p class="q"><a href="#a9">Q.각구단 공통 이벤트가 궁금해요</a></p>
            <p class="a" style="background: #CCC">
            	&nbsp;&nbsp;&nbsp;&nbsp;A.<br>
				&nbsp;&nbsp;&nbsp;&nbsp;1. 스페셜 유니폼 착용<br>
				&nbsp;&nbsp;&nbsp;&nbsp;2. 선수 사인회<br>
				&nbsp;&nbsp;&nbsp;&nbsp;3. 치어리더 포토 타임<br>
				&nbsp;&nbsp;&nbsp;&nbsp;4. 응원단상 이벤트(가족대상)<br></p>
        </li>
       
    </ul>
</div>

<div id="pagingBox">
<c:import url="/WEB-INF/views/layout/faq_paging.jsp" />
</div>

<table class="t2">
		<tr>
			<th>원하시는 답변을 찾지 못하셨다면, 옆에 1:1문의하여주세요.</th>
			<th>
				<button class="faqWrite" id="btn1:1Write">1:1문의하기</button>
			</th>
		</tr>

</table>
</body>
</html>