<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/jstlHeader.jsp"%>

<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> 

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script 
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>대시보드다</title>
<style> 
.active>.page-link{
	background-color:black;
	color:white !important;
} 
  
</style>
<script>
 window.onload=function(){
	 getBoardList();
	
	
 	var getPage=document.getElementById("getPage").value;
	var page=document.getElementById(eval("'"+getPage+"'"));
/* 	page.className ='page-item active';
 */
	$("#search").click(function(){
		getBoardList();  
	})  
	  
	
	/*리스트불러오기 */
	function getBoardList(){
	 var searchKey = $("#searchKey").val();
	 var sname = $("#sname").val();
			
		if(searchKey ==null || searchKey == undefined || searchKey == "" ){
			searchKey = $("#key").val();
			sname = $("#val").val();
			var getPage=document.getElementById("getPage").value;
		    
		}else{ 
			var getPage =1; 
		}  
		 
/* 		if(sname ==null || sname == undefined || sname =="" ){
			var getPage=document.getElementById("getPage").value;
		}else{
			var getPage =1;
		} 
  */
/* 		var getPage=document.getElementById("getPage").value;
		        */
		$.ajax({ 
			   
			url : "/Login/dashBoardSearch",  			
			type:'POST',    
			dataType:'text',
			async:'false', 
			data : { 
				searchKey : searchKey,
				sname : sname,
				page : getPage, 
			 
			},
			success : function(data) {
				
				 $("#dashBoardList").empty();
				$("#dashBoardList").append(data);
				
								
			}
		})   
		
		$.ajax({ 
			  
			url : "/Login/paging",  			
			type:'POST',    
			dataType:'text',
			async:'false',
			data : { 
				searchKey : searchKey,
				sname : sname,
				page : getPage,
			 
			},
			success : function(data) {
			/* 	console.log(data); */
				 $("#paging").empty();
				$("#paging").append(data);
				
								
			}
		})
		  
	}
  
	
	
	
  
}   


</script>

</head>
<body>

<input type="hidden" name="name" value="${getPage}" id="getPage">
<input type="hidden" name="name" value="${searchKey}" id="key">
<input type="hidden" name="name" value="${sname}" id="val">


	<div>
	<a href="/Login/logout">로그아웃</a>
	 </div>
<div id="demo" class="carousel slide" data-bs-ride="carousel">

  <!-- Indicators/dots -->
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#demo" data-bs-slide-to="0" class="active"></button>
    <button type="button" data-bs-target="#demo" data-bs-slide-to="1"></button>
    <button type="button" data-bs-target="#demo" data-bs-slide-to="2"></button>
  </div>
    
  <!-- The slideshow/carousel -->
  <div class="carousel-inner" style="width:1000px; margin-right: auto;
    margin-left: auto;" >
    <div class="carousel-item active" >
      <img src="../../resources/img/la.jpg" alt="Los Angeles" class="d-block" >
    </div>
    <div class="carousel-item" >
      <img src="../../resources/img/chicago.jpg" alt="Chicago" class="d-block" >
    </div>  
    <div class="carousel-item" >
      <img src="../../resources/img/ny.jpg" alt="New York" class="d-block" >
    </div>  
  </div>     
       
  <!-- Left and right controls/icons -->
  <button class="carousel-control-prev" type="button" data-bs-target="#demo" data-bs-slide="prev" >
    <span class="carousel-control-prev-icon" ></span>
  </button> 
  <button class="carousel-control-next" type="button" data-bs-target="#demo" data-bs-slide="next" >
    <span class="carousel-control-next-icon"></span>
  </button> 
</div> 

	<div class="container mt-3"> 
		<div id="listTitle"> 
			
							<select id="searchKey" name="searchKey" style="width: 150px; margin-bottom:1%">
								 <option value="" >검색</option> 
								<option value="searchTitle">제목</option>		 
	 							<option value="searchContents" >내용</option>
							</select> 
							
     	                       <input type="text" style="width: 300px; height: 25px; margin-bottom:1%;"  id="sname" name="sname" >                    
	                           <button class="btn btn-outline-dark"  style="margin-bottom:0.5%" id="search">검  색</button>
			
		<a href="/Login/boardwrite" class="btn btn-outline-dark" style="margin-bottom:1%;margin-left:50%" >글 작성하기
			 </a>       
		</div>  
		  
		<table class="table table-bordered" >
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
			
			
			
			
			<tbody id=dashBoardList>
			<%-- <c:forEach var="board" items="${result }">
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

			</c:forEach>  --%>
			</tbody>
		</table> 
		 
		<paging id="paging" style="margin:0 auto">
		 <!-- 페이징 -->
	  <%-- <ul class="pagination" style="margin-left:41%">
			<c:if test="${pageMaker.prev }"> 
				<li class="page-item"><a
					href='<c:url value="/Login/dashboard${pageMaker.makeQueryPage(pageMaker.startPage-1) }"/>' class="page-link" style="border-color: gray;color:black">Previous</a></li>
			</c:if>
			<c:forEach begin="${pageMaker.startPage }"
				end="${pageMaker.endPage }" var="pageNum">
				<li class="page-item" id="${pageNum }" value="${pageNum }"><a class="page-link"
					href='<c:url value="/Login/dashboard${pageMaker.makeQueryPage(pageNum) }"/>' name="page"  style="border-color: gray; color:black" id="pageNum" >${pageNum }</a></li>
			</c:forEach>   
			<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
				<li class="page-item"><a
					href='<c:url value="/Login/dashboard${pageMaker.makeQueryPage(pageMaker.endPage+1) }"/>' class="page-link" style="border-color: gray;color:black">Next</a></li>
			</c:if> 
		</ul>    --%>   
    </paging>
		                                                                                               
	</div>  

</body>
</html>