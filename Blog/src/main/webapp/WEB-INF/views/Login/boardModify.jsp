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
		var content = $("#content").val();
		var frm = document.getElementById("myForm");
		frm.enctype = 'multipart/form-data';
		var dataWithFile = new FormData(frm); 
		           
		var id = $("#id").val();  
 
		if (!subject) {
			alert("제목 입력은 필수입니다.");
			$("#subject").focus();
			return false;
		} else if (!content) {
			alert("내용 입력은 필수 입니다.");
			$("#content").focus(); 
			return false;
		} else {
			updateBoard(subject, content, id , dataWithFile);
		} 
  
	}

	function updateBoard(sub, con, id, dataWithFile) {
		if (confirm("수정하시겠습니까?") == true){    //확인
			dataWithFile.append("subject", sub); // VO에 subject 추가
		    dataWithFile.append("context", con); // VO에 context 추가
		    dataWithFile.append("id", id); // VO에 context 추가
		    for (let key of dataWithFile.keys()) {
		    	console.log(key, ":", dataWithFile.get(key));
		    }
		$.ajax({

			url : "/Login/updateBoard",
			type : 'POST',
			enctype :'multipart/form-data',
		    data:dataWithFile,
		    processData: false, 
		    contentType: false, 
			success : function(data) {
				if (data == 1) {
					alert("글 수정이 완료되었습니다.");
					location.href = '<c:url value='/Login/boardDetail${pageMaker.makeQueryPage(result.id, pageMaker.cri.page) }'/>';
				} else {
					alert("글 수정 실패"); 
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

		<input type=hidden value="${result.id}" name="id" id="id">
		<div class="container mt-3" style="margin-left: 22%">

			<table class="table table-bordered" style="width: 70%">
				<thead class="table-dark">
					<tr>
						<td colspan=2>글수정</td>

					</tr>
				</thead>
				<tbody>
					<tr>
						<th style="width: 10%">제목:</th>
						<td><input type="text" placeholder="제목을 입력하세요. "
							style="width: 80%;" id="subject" value="${result.subject}" /></td>
					</tr>
					<tr>
						<th style="width: 10%">내용:</th>
						<td><textarea cols="90" rows="10" placeholder="내용을 입력하세요. "
								style="width: 80%; height: 600px;" id="content">${result.context}</textarea></td>
					</tr>
					<!--  <tr> 
                <th>첨부파일: </th>
                <td><input type="text" placeholder="파일을 선택하세요. " name="filename"/></td>
            </tr> --> 
					<tr>
						<td colspan=2>
							<!-- 생략 -->
							<form action='/Login/boardinsert' method="post" id="myForm">
       
				 				<div class="form-group file-group" id="file-list">
				 				
									<div class="file-add">
										<a href="#this" onclick="addFile()"><span
											class="glyphicon glyphicon-plus" aria-hidden="true"></span>
					 						파일추가</a>
					 						
									</div>
							
									<c:forEach items="${file }" var="file">
										<div class="file-input">
											<span class="glyphicon glyphicon-camera" aria-hidden="true"></span>
											${file.ORG_FILE_NAME } <span>${file.FILE_SIZE }kb</span> 
								 			<input type="hidden" name="IDX" value="${file.IDX }">
											<a href='#this' name='file-delete'>삭제</a>
										</div>         
									</c:forEach>     
								</div>
				   
						     </form> 
					 	   
						</td>
					</tr>    
 

				</tbody>
			</table>

			<input type="button" value="수정" onclick="boardValidation()"
				class="btn btn-outline-dark"> <a
				href='<c:url value='/Login/boardDetail${pageMaker.makeQueryPage(result.id, pageMaker.cri.page) }'/>'>
				<input type="button" value="취소" class="btn btn-outline-dark">
			</a>
		</div> 



	<script type="text/javascript">
    $(document).ready(function() {
        $("a[name='file-delete']").on("click", function(e) {
            e.preventDefault();
            deleteFile($(this));
        });
    })
 
    function addFile() {
        var str = "<div class='file-input'><input type='file' name='file' multiple><a href='#this' name='file-delete'>삭제</a></div>";
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