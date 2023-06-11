<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/jstlHeader.jsp"%>

<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>글 내용</title>

<script type="text/javascript">

var id= ${result.id}; 
  
function boardDelete(){
	
$.ajax({
	  
		url : "/Login/deleteBoard",
		type:'POST',
		data : {
			id : id
			
		}, 
		success:function(data){
			if(data == 1){
				alert("삭제되었습니다.");
				location.href="/Login/dashboard";
			}else {
				alert("삭제실패");
			}
		},error:function(){
			console.log("error");
		}
		
	})
	
}

function boardUpdate(){
	
	
}
</script>
</head>
<body>
	<form>
		<input type=hidden id="id" value=`${result.id}` name="id"> 
		<div class="container mt-3">
			<table class="table table-bordered">
  
				<tbody>
					<tr> 
						<th style="width: 10%" colspan="2" class="table-dark">제목:
							${result.subject}</th>

					</tr>
					<tr>
						<td colspan="2" type="text">${result.context}</td>
					</tr>
					<tr>
						<th colspan="2">조회수: ${result.views}</th>

					</tr>
					<tr>
						<th colspan="2">좋아요: ${result.likes}</th>

					</tr>

				</tbody>
			</table>
			<input type="button" value="수정" class="btn btn-outline-dark"
				onclick="boardUpdate()" /> <input type="button" value="삭제"
				class="btn btn-outline-dark" onclick="boardDelete()" /> <input
				type="button" value="목록보기" class="btn btn-outline-dark"
				onclick="javascript:location.href='dashboard'" />

		</div>
	</form>
</body>
</html>