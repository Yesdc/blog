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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<meta charset="UTF-8">
<title>글 작성</title>
<script type="text/javascript">
	function boardValidation() {

		var subject = $("#subject").val();
		var content = $("#content").val();
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
			updateBoard(subject, content,id);
		}
 
	}

	function updateBoard(sub, con,id) {
		if (confirm("수정하시겠습니까?") == true){    //확인

		$.ajax({

			url : "/Login/updateBoard",
			type : 'POST',
			data : {
				
				id : id,
				subject : sub,
				context : con
			},
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
	<form>
<input type=hidden value="${result.id}" name="id" id="id">
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


				</tbody>
			</table>

			<input type="button" value="수정" onclick="boardValidation()"
				class="btn btn-outline-dark"> <a
				href='<c:url value='/Login/boardDetail${pageMaker.makeQueryPage(result.id, pageMaker.cri.page) }'/>'>
				<input type="button" value="취소" class="btn btn-outline-dark">
			</a>
		</div>
	</form>
</body>
</html>