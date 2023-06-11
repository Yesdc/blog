<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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

function boardValidation(){
	
	var subject = $("#subject").val();
	var content = $("#content").val();
	
	if(!subject){
		alert("제목 입력은 필수입니다."); 
		$("#subject").focus();
		return false;
	}else if(!content){
		alert("내용 입력은 필수 입니다.");
		$("#content").focus();
		return false;
	}else {
		boardWrite(subject,content);
	}
	
}

function boardWrite(sub,con){
	
	$.ajax({
		
		url : "/Login/boardinsert",
		type:'POST',
		data : {
			subject : sub,
			context : con
		},
		success:function(data){
			if(data == 1){
				alert("글 등록이 완료되었습니다.");
				location.href="/Login/dashboard";
			}else {
				alert("글 등록 실패");
			}
		},error:function(){
			console.log("error");
		}
		
	})
	
}

</script>
</head>
<body>
	<form>

		<div class="container mt-3">
			<caption>글쓰기</caption>
			<table class="table table-bordered">
 
				<tbody>
					<tr>
						<th>제목:</th>
						<td><input type="text" placeholder="제목을 입력하세요. " style="width:60%;"  id="subject" /></td>
					</tr>
					<tr>
						<th>내용:</th>
						<td><textarea cols="90" rows="10" placeholder="내용을 입력하세요. " style="width:60%; height:600px;"
								id="content"></textarea></td> 
					</tr>
					<!--  <tr>
                <th>첨부파일: </th>
                <td><input type="text" placeholder="파일을 선택하세요. " name="filename"/></td>
            </tr> -->


				</tbody>
			</table>

			<input type="button" value="등록" onclick="boardValidation()"
				/  class="btn btn-outline-dark"> <input type="button"
				value="취소" onclick="javascript:location.href='dashboard'"
				/  class="btn btn-outline-dark">
		</div>
	</form>
</body>
</html>