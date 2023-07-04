<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


			<%-- HH:MM:ss --%> 
			
			<c:forEach var="board" items="${result }">
				<fmt:formatDate value="${board.create_time}" pattern="yyyy-MM-dd"
					var="dateFormat_cr" />
				<tr>
					<td>${board.id }</td>
					<td><div class="d-grid" class="border border-white">
							<a href='<c:url value='/Login/boardDetail${pageMaker.makeQueryPage(board.id, pageMaker.cri.page) }'/>'
								class="btn btn-outline-light text-dark"
								style="border: none !important">${board.subject }</a>
						</div></td>
					<td>${board.views }</td>
					<td>${dateFormat_cr }</td> 
					<td>${board.likes }</td>
				</tr>  

			</c:forEach>  
	
	
		