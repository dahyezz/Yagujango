<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<style type="text/css">

table thead {
	padding: 10px;
    border-top: 2px solid #000;
    border-bottom: 2px solid #000;
}					
.button-center {
	text-align: center;
}
.tablediv {
	padding: 0 5% 0 5%;
}
.contentdiv{
	padding: 0 10% 0 10%;
}
table{
	width: 100%;
	border-collapse: collapse;
    text-align: center;
    line-height: 1.5;
}
.viewinfo {
	background:#ccc;
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
.wrap{
	padding:0 5% 0 5%;
	border-collapse: collapse;
}
.contentdiv{
	width:100%;
} 
img {
	max-width: 100%;
}


</style>


<div class ="wrap">

<h1>1:1문의 내역</h1>
<hr>


<table>
<thead>
	<tr>
		<td style="width:33%;text-align:left;">&nbsp;&nbsp;${my1to1view.boardno }</td>
		<td style="width:34%;">${my1to1view.title }</td>
		<td style="width:33%;text-align:right;"> 작성자: ${my1to1view.writer_userid}&nbsp;&nbsp;</td>
	</tr>
</thead>
<tbody>

	<tr>
		<td colspan="3" style="text-align:right;">작성일:
		<fmt:formatDate value="${my1to1view.writtendate }" pattern="yyyy-MM-dd" />
		</td>
	</tr>
</tbody> 
</table>
<div class="contentdiv">
${my1to1view.content }
</div>
</div>








<c:import url="/WEB-INF/views/layout/footer.jsp" />