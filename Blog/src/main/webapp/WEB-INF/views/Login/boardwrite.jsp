<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>글 작성</title>
<script type="text/javascript">
 	function boardValidation() {
 
		var subject = $("#subject").val();
		var content = $("#context").val(); 
		var frm = document.getElementById("myForm");
		frm.enctype = 'multipart/form-data';
		var dataWithFile = new FormData(frm);
		
		
		if (!subject) {
			alert("제목 입력은 필수입니다.");
			$("#subject").focus();
			return false;
		} else if (!content) {
			alert("내용 입력은 필수 입니다.");
			$("#content").focus();
			return false;
		} else {
			boardWrite(subject, content, dataWithFile);
		}

	}
 	
 	 
 	function boardWrite(sub, con,dataWithFile) {
 		
		if (confirm("등록하시겠습니까?") == true){    //확인
			dataWithFile.append("subject", sub); // VO에 subject 추가
		    dataWithFile.append("context", con); // VO에 context 추가

		 
		                       
		    $.ajax({
		        url: "/Login/boardinsert",
		        type: 'POST', 
				enctype :'multipart/form-data',
			    data:dataWithFile,
			    processData: false, 
			    contentType: false, 
			success : function(data) {
			
				    	 if (data == 1) {
								alert("글 등록이 완료되었습니다.");
								location.href = "/Login/dashboard"; 
							} else {
								alert("글 등록 실패");
							} 
				    	    
				  
				
				
			},
			error : function() { 
				console.log("error");
			}

		})
		}else{   //취소

		     return false;

		 }

	}
 	 
 
 </script>
</head>
<body>
	                

		<div class="container mt-3" style="margin-left: 22%">

			<table class="table table-bordered" style="width: 70%">
				<thead class="table-dark">
					<tr>
						<td colspan=2>글쓰기</td> 
 
					</tr>
				</thead>
				<tbody>
					<tr>
						<th style="width: 10%">제목:</th>
						<td><input type="text" placeholder="제목을 입력하세요. "
							style="width: 80%;" id="subject" name="subject"/></td>
					</tr>
					<tr> 
						<th style="width: 10%">내용:</th>
						<td><textarea cols="90" rows="10" placeholder="내용을 입력하세요. "
								style="width: 80%; height: 600px;" id="context" name="context"></textarea></td>
					</tr>
					<!--  <tr>
                <th>첨부파일: </th>
                <td><input type="text" placeholder="파일을 선택하세요. " name="filename"/></td>
            </tr> -->
					<tr>
						<td colspan=2>
							<!-- 생략 -->
							<form action='/Login/boardinsert' method="post" id='myForm'>
    
							<div class="form-group" id="file-list">
								<a href="#this" onclick="addFile()">파일추가</a>
								<div class="file-group">
									<input type="file" name="file" id='file' multiple><a
										href='#this' name='file-delete'>삭제</a>
								</div>
			 				</div>
 
							</form>
						</td> 
					</tr>

				</tbody>
			</table>
<!-- onclick="boardValidation()" -->
			<input type="button" value="등록" onclick="boardValidation()"
				class="btn btn-outline-dark"> <input type="button"
				value="취소" onclick="javascript:location.href='dashboard'"
				/  class="btn btn-outline-dark">
		</div>    
	
	
	<script type="text/javascript">
		 // fileIndex 변수를 전역 범위로 이동
		
		$(document).ready(function() {
		    $("a[name='file-delete']").on("click", function(e) {
		        e.preventDefault();
		        deleteFile($(this)); 
		    });
		})
		
		function addFile() {
		    var str = "<div class='file-group'><input type='file' name='file' id='file' multiple><a href='#this' name='file-delete'>삭제</a></div>";
		    $("#file-list").append(str);
		    $("a[name='file-delete']").on("click", function(e) {
		        e.preventDefault();
		        deleteFile($(this));
		    });            
		  
		}
		
		function deleteFile(obj) {
		    obj.parent().remove();
		}
	</script>                          

</body>
</html>