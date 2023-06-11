<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../../resources/loginPage.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> 

<script type="text/javascript">

function loginValidation(){
	
	var userId = $("#userId").val();
	var password = $("#password").val();
	
	if(!userId){
		alert("아이디를 입력하세요.");
		$("#userId").focus();
		return false;
	}else if(!password){
		alert("비밀번호를 입력하세요.");
		$("#password").focus();
		return false;
	}else {
		login(userId,password);
	}
	
}

function login(userId,password){
	
	$.ajax({
		
		url : "/Login/login",
		type : 'POST',
		data : { userId : userId, 
				password : password	
		},
		success:function(data){
			if(data == 2){
				alert("아이디 혹은 비밀번호가 맞지 않습니다.");
				return false;
			}else if(data == 3){
				location.href="/Login/dashboard";
			}
		}
		
	})
	
}

function enterKeyCheck(){
	
 if(event.keyCode == 13)
	  {
	 loginValidation();
	  }
	
	
}

</script>

</head>
<body>

<form class="signUp" id="signupForm">
   <h1 class="signUpTitle">로그인</h1>
   <input type="text" id="userId" class="signUpInput" placeholder="ID" autofocus onkeyup="enterKeyCheck()">
   <input type="password" id="password" class="signUpInput" placeholder="Password" onkeyup="enterKeyCheck()">
   <input type="button" value="로그인" onclick="loginValidation()" class="loginButton">
   <input type="button" value="회원가입" onclick="location.href='/Login/signUpPage'" class="signUpButton">
</form>

</body>
</html>