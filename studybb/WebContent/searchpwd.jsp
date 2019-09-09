<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>searchpwd.jsp</title>
<style>
div {
	margin-top: 50px;
    margin-left: 90px;
}
input[type=text], input[type=email]{
    box-sizing: border-box;
    display: inline-block;
    padding-left: 20px;
    width: 300px;
    height: 3pc;
    border: 1px solid #e1e1e1;
    font-size: 10pt;
}
#sendpwd {
	margin-top: 10px;
	margin-bottom: 10px;
    position: relative;
    padding: 10px;
    width: 300px;
    background: light;
    border: 1px solid #ccc;
}
button #disable {
    visibility: hidden;
}

button:disabled #disable {
    visibility: visible;
}

button:disabled #able {
    visibility: hidden;
}

button #disable span {
    position: absolute;
    top: 25px;
    display: block;
    width: 5px; 
    height: 5px;
    background: #555;
    border-radius: 50%;
}

button #disable span:first-child {
    left: 140px;
    animation-delay: 0s;
    animation-duration: 1s;
    animation-name: dot;
    animation-direction: alternate;
    animation-iteration-count: infinite;
    animation-timing-function: linear;
}

button #disable span:nth-child(2) {
    left: 150px;
    animation-delay: .2s;
    animation-duration: 1s;
    animation-name: dot;
    animation-direction: alternate;
    animation-iteration-count: infinite;
    animation-timing-function: linear;
}

button #disable span:last-child {
    left: 160px;
    animation-delay: .4s;
    animation-duration: 1s;
    animation-name: dot;
    animation-direction: alternate;
    animation-iteration-count: infinite;
    animation-timing-function: linear;
}

@keyframes dot {
    100% {
        top: 25px;
    } 50% {
        top: 10px;
    } 0% {
        top: 25px;
    }
}

@font-face {
   font-family: 'Handon3gyeopsal600g';
   src:
      url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_seven@1.2/Handon3gyeopsal600g.woff')
      format('woff');
   font-weight: normal;
   font-style: normal;
}
@font-face {
   font-family: 'Handon3gyeopsal300g';
   src:
      url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_seven@1.2/Handon3gyeopsal300g.woff')
      format('woff');
   font-weight: normal;
   font-style: normal;
}
.fontbold {
   font-family: 'Handon3gyeopsal600g';
}
.fontthin {
   font-family: 'Handon3gyeopsal300g';
}
</style>
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.7.0/css/all.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Kaushan+Script" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css">
<link href="https://blackrockdigital.github.io/startbootstrap-agency/css/agency.min.css" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
$(function(){
	$("#sendpwd").click(function(){
		var vm = this;
	
		$("form").submit(function(){
			$.ajax({
				url: '${contextPath}/searchpwd',
				method: 'POST',
				data: $(this).serialize(),
				beforeSend: function () {
		               vm.setAttribute("disabled", "disabled");
		               },
				success: function(data){
					console.log(data);
		  			var jsonObj = JSON.parse(data);
					if(jsonObj.status == 1){
						alert("비밀번호가 이메일로 전송되었습니다.");
					} else if (jsonObj.status == -1){
						alert("일치하는 회원정보가 없습니다.");
					} else if(jsonObj.status == -2) {
						alert("이메일 전송에 실패했습니다.");
					}
					vm.removeAttribute("disabled");
				}
			});
			return false;
		});
	});
});
</script>
</head>
<body class="fontthin">
<div>
<h1>비밀번호찾기</h1>
<form>
	<input type="text" name="id" placeholder="아이디" required><br>
	<input type="email" name="email" placeholder="이메일" required><br>
	<button type="submit" id="sendpwd">
		<span id="able">비밀번호찾기</span>
		<span id="disable">
            <span></span><span></span><span></span>
        </span>
	</button><br>
	로그인하시겠습니까?
	<a style="color: gray;" href="login.jsp">로그인</a><br>
	계정이 없으신가요?
	<a style="color: gray;" href="join.jsp" onClick="window.open(this.href, '', 'width=800, height=800'); window.close(); return false;" >회원가입</a><br>
</form>
</div>
</body>
</html>