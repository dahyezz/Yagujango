<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<style type="text/css">
.pagingul {
	text-align:center;
}
.pagingul li {
	display:inline;
	vertical-align:middle;
}
.pagingul li a {
	display:-moz-inline-stack;	/*FF2*/
	display:inline-block;
	vertical-align:top;
	padding:4px;
	margin-right:3px;
	width:15px !important;
	color:#000;
	font:bold 12px tahoma;
	border:1px solid #eee;
	text-align:center;
	text-decoration:none;
	width:26px;

}
.pagingul li .first {
	width:30px !important;
}
.pagingul li a.now {
	color:#FFF;
	background-color:black;
	border:1px solid black;
}
.pagingul li a:hover, .pagingul li a:focus {
	color:#FFF;
	border:1px solid black;
	background-color:black;
}

</style>

<div class="pagingdiv">
	<ul class="pagingul">
		<!-- 처음으로 가기 -->
		<c:if test="${paging.curPage ne 1 }">
		<li>
			<a class="first" href="/board/faq/faqlist"><span>처음</span></a>
		</li>
		</c:if>

		<!-- 이전 페이지 -->
		<!-- 첫 페이지라면 버튼 동작 안 되게 만들기 -->
		<c:if test="${paging.curPage eq 1 }">
		<li class="disabled">
			<span>&laquo;</span>
		</li>
		</c:if>

		<c:if test="${paging.curPage ne 1 }">
		<li>
			<a href="/board/faq/faqlist?curPage=${paging.curPage-1 }&keyword=${keyword}&search=${search}"><span>&laquo;</span></a>
	    </li>
	    </c:if>

		<!-- 페이징 리스트 -->
		<c:forEach
	     begin="${paging.startPage }" end="${paging.endPage }"
	     var="i">
	
			<!-- 현재 보고 있는 페이지번호만 강조해주기 -->
			<c:if test="${paging.curPage eq i}">
			<li>
				<c:if test="${name eq null and keyword eq null}">
					<a class="now">${i }</a>
				</c:if>
				<c:if test="${name ne null and keyword ne null}">
					<a class="now">${i }</a>
				</c:if>
			</li>
			</c:if>
		
			<c:if test="${paging.curPage ne i}">
			<li>
				<c:if test="${name eq null and keyword eq null}">
					<a href="/board/faq/faqlist?curPage=${i }">${i }</a>
				</c:if>
				<c:if test="${name ne null and keyword ne null}">
					<a href="/board/faq/faqlist?curPage=${i }&name=${name}&keyword=${keyword}">${i }</a>
				</c:if>
			</li>
			</c:if>
			
	    </c:forEach>



		
		<!-- 다음 페이지 -->
		<c:if test="${paging.curPage eq paging.totalPage }">
		<li>
			<span>&raquo;</span>
		</li>
		</c:if>

		<c:if test="${paging.curPage ne paging.totalPage }">
		<li class="disabled">
			<a href="/board/faq/faqlist?curPage=${paging.curPage+1 }&name=${name}&keyword=${keyword}">
			<span>&raquo;</span>
		</a>
		</li>
		</c:if>
	</ul>
</div>
</html>