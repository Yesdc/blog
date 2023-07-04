<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/jstlHeader.jsp"%>
<style> 
.active>.page-link{
	background-color:black;
	color:white !important;
} 
  
</style>
<script>
var getPage=document.getElementById("getPage").value;
var page=document.getElementById(eval("'"+getPage+"'"));
 	page.className ='page-item active';

</script>
  


 



<ul class="pagination" >
			<c:if test="${pageMaker.prev }"> 
				<li class="page-item"><a
					href='<c:url value="/Login/dashboard${pageMaker.makeQueryPage(pageMaker.startPage-1) }"/>' class="page-link" style="border-color: gray;color:black">Previous</a></li>
			</c:if>
			<c:forEach begin="${pageMaker.startPage }"
				end="${pageMaker.endPage }" var="pageNum">
				<li class="page-item" id="${pageNum }" value="${pageNum }"><a class="page-link"
					href='<c:url value="/Login/dashboard${pageMaker.makeQueryPage(searchKey, sname, pageNum) }"/>' name="page"  style="border-color: gray; color:black" id="pageNum" >${pageNum }</a></li>
			</c:forEach>   
			<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
				<li class="page-item"><a
					href='<c:url value="/Login/dashboard${pageMaker.makeQueryPage(pageMaker.endPage+1) }"/>' class="page-link" style="border-color: gray;color:black">Next</a></li>
			</c:if> 
		</ul>   
		
		
		
