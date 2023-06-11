<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/jstlHeader.jsp"%>

<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>대시보드다</title>
<style>
</style>
</head>
<body>
	<a href="/Login/logout">로그아웃</a>
	</p>


	<div class="container mt-3">
		<div id="listTitle">
		<a href="/Login/boardwrite" class="btn btn-outline-dark" style="margin-left:91%; margin-bottom:1%">글 작성하기</a>
			
		</div>
		 
		<table class="table table-bordered">
			<thead class="table-dark">  
				<tr>
					<td style="width:10%">#</td>
					<td style="text-align: center; width:50%">제목</td>
					<td style="width:15%">조회수</td>
					<td style="width:20%">작성일</td> 
					<td style="width:5%">♥</td>
				</tr> 
			</thead>  
			<%-- HH:MM:ss --%> 
			<c:forEach var="board" items="${result }">
				<fmt:formatDate value="${board.create_time}" pattern="yyyy-MM-dd"
					var="dateFormat_cr" />
				<tr>
					<td>${board.id }</td>
					<td><div class="d-grid" class="border border-white">
							<a href="/Login/boardDetail?id=${board.id }"
								class="btn btn-outline-light text-dark"
								style="border: none !important">${board.subject }</a>
						</div></td>
					<td>${board.views }</td>
					<td>${dateFormat_cr }</td>
					<td>${board.likes }</td>
				</tr>


			</c:forEach> 
		</table>
		<!-- 페이징 -->
	
		<ul class="pagination" style="margin-left:41%">
			<c:if test="${pageMaker.prev }"> 
				<li class="page-item"><a
					href='<c:url value="/Login/dashboard?page=${pageMaker.startPage-1 }"/>' class="page-link">Previous</a></li>
			</c:if>
			<c:forEach begin="${pageMaker.startPage }"
				end="${pageMaker.endPage }" var="pageNum">
				<li class="page-item"><a class="page-link"
					href='<c:url value="/Login/dashboard?page=${pageNum }"/>'  name="page">${pageNum }</a></li>
			</c:forEach>
			<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
				<li class="page-item"><a
					href='<c:url value="/Login/dashboard?page=${pageMaker.endPage+1 }"/>' class="page-link">Next</a></li>
			</c:if>
		 
		</ul>
		
  
		                                                                                                    
	</div>  

</body>
</html>