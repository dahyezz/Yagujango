<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	
	$("#allChk").click(function(){
		//allChk가 클릭되어 있으면
		if($("#allChk").prop("checked")){
			$("input[type=checkbox]").prop("checked",true);	//checkbox를 모두 체크
		} else{
			$("input[type=checkbox]").prop("checked",false);	//checkbox를 모두 체크 해제
		}
	});
	
	//각각의 체크박스가 해제되었을 때 allChk 체크 해제
	$("#chk1").click(function(){
		if(!$("#chk1").prop("checked")){
			$("#allChk").prop("checked",false);
		}
	});
	
	$("#chk2").click(function(){
		if(!$("#chk2").prop("checked")){
			$("#allChk").prop("checked",false);
		}
	});
	
	$("#chk3").click(function(){
		if(!$("#chk3").prop("checked")){
			$("#allChk").prop("checked",false);
		}
	});
	
	$("#chk4").click(function(){
		if(!$("#chk4").prop("checked")){
			$("#allChk").prop("checked",false);
		}
	});
	
	//필수 동의 항목 체크 여부
	$("#btnAgree").click(function() {
		
		if(!$("#chk1").prop("checked") || !$("#chk2").prop("checked") || !$("#chk3").prop("checked")){
			alert('필수 동의 항목에 체크해 주십시오');
		}
		
		if($("#chk1").prop("checked") && $("#chk2").prop("checked") && $("#chk3").prop("checked")){
			$(location).attr("href", "/member/join");
		}
	});
});
</script>

<style type="text/css">
#allChk, #chk1, #chk2, #chk3, #chk4{
	width:30px;
	height:30px;
}

#terms1, #terms2, #terms3{
	width:600px;
	height:100px;
	border:1px solid #ccc;
	overflow:auto;
}
.info1{
	margin-left:500px;
}
.info2{
	margin-left:130px;
}
.info3{
	margin-left:300px;
	margin-bottom:50px;
}
.btn-join{
	margin-left:500px;
	background-color: #9baec8;
	border:0;
	color: white;
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
	border-bottom-left-radius: 5px;
	border-bottom-right-radius: 5px;
	padding: 15px;
}
.btn-join:hover{
    color:white;
    background-color: #9baec8;
    border: 1px solid #9baec8;
}

.btn-join2{
	margin-left:30px;
	background-color:  #0080ff;
	border:0;
	color:white;
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
	border-bottom-left-radius: 5px;
	border-bottom-right-radius: 5px;
	padding: 15px;
	
}
.btn-join2:hover{
    color:white;
    background-color: #0080ff;
    border: 1px solid #0080ff;
}

/* #joinTerms, #terms1, #terms2, #terms3{
 	text-align: center;
 } */
 
span{
 	vertical-align:7px;
 	font-weight:bold;
 	font-size:20px;
 }
</style>

<div id="joinTerms">

<h1 class="info1">회원가입</h1>


<p><input type="checkbox" id="allChk" name="allChk" class="info2"/>
<label for="allChk"><span><u>이용약관, 개인정보 수집 및 이용, 위치정보 이용약관(선택),프로모션 안내메일 수신(선택)에 모두 동의합니다.</u></span></label></p>

<div class="info3">
<p><input type="checkbox" id="chk1" name="chk1"/>
<label for="chk1"><span>야구장고 이용약관 동의 (필수)</span></label></p>

<div id="terms1">
<p>여러분을 환영합니다. 야구장고 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 야구장고 서비스의 이용과 관련하여 야구장고 서비스를 제공하는 야구장고 주식회사(이하 ‘야구장고’)와 이를 이용하는 야구장고 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 야구장고 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.</p>
<p>미묘한 인생에 품으며, 속에서 힘차게 것은 봄날의 인생을 이것이다. 때까지 품었기 기관과 길을 시들어 수 풀이 싹이 오아이스도 교향악이다. 구하지 것이다.보라, 보이는 청춘 이것이다. 피가 못할 위하여 힘차게 트고, 청춘의 얼음 목숨이 철환하였는가? 그들을 얼마나 얼마나 아니더면, 불어 노년에게서 새 위하여, 남는 교향악이다. 어디 꽃이 찾아 피에 부패를 얼마나 꾸며 되려니와, 굳세게 아니다. 그들은 곳으로 피에 위하여서 소담스러운 구하지 돋고, 청춘에서만 힘있다. 원대하고, 동력은 가는 설산에서 하여도 보라. 못하다 꾸며 꽃 위하여서. 싸인 못할 맺어, 풀밭에 같은 가치를 주는 듣는다. 방황하였으며, 얼음에 따뜻한 아니한 뿐이다.</p>
<p>끓는 원질이 심장은 그들의 같이, 인간의 이것이다. 이상은 청춘 방지하는 쓸쓸하랴? 눈이 원대하고, 모래뿐일 그와 사랑의 유소년에게서 것은 원질이 거친 말이다. 가슴에 있음으로써 때까지 있는 만물은 있는 말이다. 현저하게 얼음 생생하며, 이것이다. 목숨을 그것은 이것을 그들의 풍부하게 있는가? 많이 있는 끓는 이것은 크고 피고 원대하고, 약동하다. 피어나는 역사를 청춘 공자는 가치를 우리는 가치를 품고 꽃 것이다. 같이, 피가 위하여 대중을 얼마나 봄날의 시들어 있으며, 그리하였는가? 끓는 길을 새가 튼튼하며, 봄날의 봄바람을 뼈 같은 말이다. 주는 가지에 것이 그것은 싸인 대한 피어나기 얼음이 봄바람이다.</p>
<p>모래뿐일 만천하의 얼마나 뛰노는 우는 바이며, 너의 청춘 이상, 이것이다. 같지 불어 속잎나고, 설레는 끝까지 뜨거운지라, 때문이다. 힘차게 같지 그것을 것이다. 그들은 이성은 지혜는 맺어, 주며, 안고, 행복스럽고 찾아 밝은 사막이다. 얼음이 풀이 못할 이것은 사람은 보내는 튼튼하며, 보라. 청춘에서만 갑 이는 그들의 눈이 아니더면, 황금시대다. 그들의 같은 살 열락의 있는 설레는 인생에 황금시대다. 못할 들어 맺어, 곳으로 우리 어디 인생을 바이며, 긴지라 것이다. 그들에게 그들은 살았으며, 실로 운다. 청춘이 품에 뛰노는 교향악이다. 군영과 구하지 속에서 인생에 두손을 봄날의 천고에 끓는 황금시대다.</p>
</div>

<p><input type="checkbox" id="chk2" name="chk2"/>
<label for="chk2"><span>개인정보 수집 및 이용에 대한 안내 (필수)</span></label></p>

<div id="terms2">
<p>정보통신망법 규정에 따라 네이버에 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 개인정보의 보유 및 이용기간을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.</p>
<p>미묘한 인생에 품으며, 속에서 힘차게 것은 봄날의 인생을 이것이다. 때까지 품었기 기관과 길을 시들어 수 풀이 싹이 오아이스도 교향악이다. 구하지 것이다.보라, 보이는 청춘 이것이다. 피가 못할 위하여 힘차게 트고, 청춘의 얼음 목숨이 철환하였는가? 그들을 얼마나 얼마나 아니더면, 불어 노년에게서 새 위하여, 남는 교향악이다. 어디 꽃이 찾아 피에 부패를 얼마나 꾸며 되려니와, 굳세게 아니다. 그들은 곳으로 피에 위하여서 소담스러운 구하지 돋고, 청춘에서만 힘있다. 원대하고, 동력은 가는 설산에서 하여도 보라. 못하다 꾸며 꽃 위하여서. 싸인 못할 맺어, 풀밭에 같은 가치를 주는 듣는다. 방황하였으며, 얼음에 따뜻한 아니한 뿐이다.</p>
<p>끓는 원질이 심장은 그들의 같이, 인간의 이것이다. 이상은 청춘 방지하는 쓸쓸하랴? 눈이 원대하고, 모래뿐일 그와 사랑의 유소년에게서 것은 원질이 거친 말이다. 가슴에 있음으로써 때까지 있는 만물은 있는 말이다. 현저하게 얼음 생생하며, 이것이다. 목숨을 그것은 이것을 그들의 풍부하게 있는가? 많이 있는 끓는 이것은 크고 피고 원대하고, 약동하다. 피어나는 역사를 청춘 공자는 가치를 우리는 가치를 품고 꽃 것이다. 같이, 피가 위하여 대중을 얼마나 봄날의 시들어 있으며, 그리하였는가? 끓는 길을 새가 튼튼하며, 봄날의 봄바람을 뼈 같은 말이다. 주는 가지에 것이 그것은 싸인 대한 피어나기 얼음이 봄바람이다.</p>
<p>모래뿐일 만천하의 얼마나 뛰노는 우는 바이며, 너의 청춘 이상, 이것이다. 같지 불어 속잎나고, 설레는 끝까지 뜨거운지라, 때문이다. 힘차게 같지 그것을 것이다. 그들은 이성은 지혜는 맺어, 주며, 안고, 행복스럽고 찾아 밝은 사막이다. 얼음이 풀이 못할 이것은 사람은 보내는 튼튼하며, 보라. 청춘에서만 갑 이는 그들의 눈이 아니더면, 황금시대다. 그들의 같은 살 열락의 있는 설레는 인생에 황금시대다. 못할 들어 맺어, 곳으로 우리 어디 인생을 바이며, 긴지라 것이다. 그들에게 그들은 살았으며, 실로 운다. 청춘이 품에 뛰노는 교향악이다. 군영과 구하지 속에서 인생에 두손을 봄날의 천고에 끓는 황금시대다.</p>
</div>

<p><input type="checkbox" id="chk3" name="chk3"/>
<label for="chk3"><span>위치 정보 이용약관 동의 (필수)</span></label></p>

<div id="terms3">
<p>위치정보 이용약관에 동의하시면, 위치를 활용한 광고 정보 수신 등을 포함하는 네이버 위치기반 서비스를 이용할 수 있습니다.</p>
<p>미묘한 인생에 품으며, 속에서 힘차게 것은 봄날의 인생을 이것이다. 때까지 품었기 기관과 길을 시들어 수 풀이 싹이 오아이스도 교향악이다. 구하지 것이다.보라, 보이는 청춘 이것이다. 피가 못할 위하여 힘차게 트고, 청춘의 얼음 목숨이 철환하였는가? 그들을 얼마나 얼마나 아니더면, 불어 노년에게서 새 위하여, 남는 교향악이다. 어디 꽃이 찾아 피에 부패를 얼마나 꾸며 되려니와, 굳세게 아니다. 그들은 곳으로 피에 위하여서 소담스러운 구하지 돋고, 청춘에서만 힘있다. 원대하고, 동력은 가는 설산에서 하여도 보라. 못하다 꾸며 꽃 위하여서. 싸인 못할 맺어, 풀밭에 같은 가치를 주는 듣는다. 방황하였으며, 얼음에 따뜻한 아니한 뿐이다.</p>
<p>끓는 원질이 심장은 그들의 같이, 인간의 이것이다. 이상은 청춘 방지하는 쓸쓸하랴? 눈이 원대하고, 모래뿐일 그와 사랑의 유소년에게서 것은 원질이 거친 말이다. 가슴에 있음으로써 때까지 있는 만물은 있는 말이다. 현저하게 얼음 생생하며, 이것이다. 목숨을 그것은 이것을 그들의 풍부하게 있는가? 많이 있는 끓는 이것은 크고 피고 원대하고, 약동하다. 피어나는 역사를 청춘 공자는 가치를 우리는 가치를 품고 꽃 것이다. 같이, 피가 위하여 대중을 얼마나 봄날의 시들어 있으며, 그리하였는가? 끓는 길을 새가 튼튼하며, 봄날의 봄바람을 뼈 같은 말이다. 주는 가지에 것이 그것은 싸인 대한 피어나기 얼음이 봄바람이다.</p>
<p>모래뿐일 만천하의 얼마나 뛰노는 우는 바이며, 너의 청춘 이상, 이것이다. 같지 불어 속잎나고, 설레는 끝까지 뜨거운지라, 때문이다. 힘차게 같지 그것을 것이다. 그들은 이성은 지혜는 맺어, 주며, 안고, 행복스럽고 찾아 밝은 사막이다. 얼음이 풀이 못할 이것은 사람은 보내는 튼튼하며, 보라. 청춘에서만 갑 이는 그들의 눈이 아니더면, 황금시대다. 그들의 같은 살 열락의 있는 설레는 인생에 황금시대다. 못할 들어 맺어, 곳으로 우리 어디 인생을 바이며, 긴지라 것이다. 그들에게 그들은 살았으며, 실로 운다. 청춘이 품에 뛰노는 교향악이다. 군영과 구하지 속에서 인생에 두손을 봄날의 천고에 끓는 황금시대다.</p>
</div>

<p><input type="checkbox" id="chk4" name="chk4"/>
<label for="chk4"><span>이벤트 및 프로모션 알림 메일 수신 (선택)</span></label></p>
</div>
</div>

<button onclick="history.go(-1)" class="btn btn-join">비동의</button>
<button id="btnAgree" class="btn btn-join2">동의</button>



<c:import url="/WEB-INF/views/layout/footer.jsp" />