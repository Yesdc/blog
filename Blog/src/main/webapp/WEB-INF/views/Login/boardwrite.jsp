<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


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
		var fileInput = document.getElementById("files");

		  // 선택된 파일들 가져오기
		  var files = fileInput.files;

		  // FormData 객체 생성
		  var formData = new FormData();

		  // 파일들을 FormData에 추가하기
		  for (var i = 0; i < files.length; i++) {
		    var file = files[i];
		    formData.append("file", file);
		  }
		  for (let key of formData.keys()) {
				console.log(key, ":", formData.get(key));
			}
		
		
		
		
		if (!subject) {
			alert("제목 입력은 필수입니다.");
			$("#subject").focus();
			return false;
		} else if (!content) {
			alert("내용 입력은 필수 입니다.");
			$("#content").focus();
			return false;
		} else {
			boardWrite(subject, content);
		}

	}

	function boardWrite(sub, con) {
	    
		
		
		
		if (confirm("작성하시겠습니까?") == true){    //확인

		$.ajax({

			url : "/Login/boardinsert",
			type : 'POST',
			data : {
				subject : sub,
				context : con, 
				
			},
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
	<form>

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
							style="width: 80%;" id="subject" /></td>
					</tr>
					<tr>
						<th style="width: 10%">내용:</th>
						<td><textarea cols="90" rows="10" placeholder="내용을 입력하세요. "
								style="width: 80%; height: 600px;" id="content"></textarea></td>
					</tr>
					<!--  <tr>
                <th>첨부파일: </th>
                <td><input type="text" placeholder="파일을 선택하세요. " name="filename"/></td>
            </tr> -->
				<tr>
				<td colspan=2>
		    <!-- 생략 -->
			    <div class="form-group" id="file-list">
			        <a href="#this" onclick="addFile()">파일추가</a>
			        <div class="file-group">
			            <input type="file" name="file" id='files'><a href='#this' name='file-delete'>삭제</a>
			        </div>   
			    </div>
			   
	
				</td>
				</tr>

				</tbody> 
			</table>

			<input type="button" value="등록" onclick="boardValidation()"
				/  class="btn btn-outline-dark"> <input type="button"
				value="취소" onclick="javascript:location.href='dashboard'"
				/  class="btn btn-outline-dark">
		</div> 
	</form>
	<script type="text/javascript">
    $(document).ready(function() {
        $("a[name='file-delete']").on("click", function(e) {
            e.preventDefault();
            deleteFile($(this)); 
        });
    })
     
    function addFile() {
        var str = "<div class='file-group'><input type='file' name='file' id='files'><a href='#this' name='file-delete'>삭제</a></div>";
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