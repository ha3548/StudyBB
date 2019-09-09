<%@page import="java.util.Random"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>join.jsp</title>
<style>
div:not(.terms-of-service):not(#code_div){
    margin-top: 50px;
    margin-left: 90px;
    margin-right: 80px;
}
button {
    position: relative;
    padding: 10px;
    width: 120px;
    background: #fff;
    border: 1px solid #ccc;
}
button[type=submit]{
	margin-top: 12px;
	background-color: lightgray;
	width: 430px;
}
select {
    margin-top: 9pt;
    padding: 10px;
    border: 1px solid #e1e1e1;
}
.terms-of-service {
    padding-left: 1pc;
    background: #f5f5f5;
    border: 1px solid #e6e6e6;
    border-radius: 3px;
	width: 100%;
    height: 56px;
    line-height: 56px;
}
input[type=text], input[type=password], input[type=email] {
    box-sizing: border-box;
    display: inline-block;
    margin-top: 9pt;
    padding-left: 20px;
    width: 300px;
    height: 3pc;
    border: 1px solid #e1e1e1;
    font-size: 10pt;
}
#submit, #code_div{
display: none;
}
button #disable {
    visibility: hidden;
}
#sendmail:disabled #disable {
    visibility: visible;
}
#sendmail:disabled #able {
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
    left: 50px;
    animation-delay: 0s;
    animation-duration: 1s;
    animation-name: dot;
    animation-direction: alternate;
    animation-iteration-count: infinite;
    animation-timing-function: linear;
}
button #disable span:nth-child(2) {
    left: 60px;
    animation-delay: .2s;
    animation-duration: 1s;
    animation-name: dot;
    animation-direction: alternate;
    animation-iteration-count: infinite;
    animation-timing-function: linear;
}
button #disable span:last-child {
    left: 70px;
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
.red{
	color: red;
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
	/*중복확인*/
	var $idObj = $("input[name=id]");
	var $dupchkObj = $("#dupchk");
	$dupchkObj.click(function(){
		if($idObj.val()=="") {
			 alert("아이디를 입력하세요");
			 $idObj.focus();
			 return false;
		 }
		$.ajax({
			url: '${contextPath}/dupchk',
			method: 'POST',
			data: 'id=' + $idObj.val(),
			success: function(data){
				var jsonObj = JSON.parse(data);
				var msg = jsonObj.id + "는 ";

				if(jsonObj.status == 1){
					msg+="이미 존재하는 아이디입니다.";
					alert(msg);
					$idObj.val("");
				} else if(jsonObj.status == -1){
					msg+="사용가능한 아이디입니다.";
					alert(msg);
				}
			}
		});
		return false;
	});
	
	/*인증번호 받기(전송)*/
	var $emailObj = $("input[name=email]");
	var $codeObj = $("input[name=code_check]");
	
	$("#sendmail").click(function(){
		 var vm = this;
		 console.log(vm);
		if($emailObj.val()==""){
			alert("이메일을 입력하세요");
			$emailObj.focus();
			return false;
		} else if($emailObj.val().match("@")==null){
			alert("이메일형식으로 입력하세요");
			$emailObj.val("");
			return false;
		}
		$("#code_div").css("display","block");
		
		$.ajax({
			url: '${contextPath}/sendmail',
			data: 'email=' + $emailObj.val()+'&'+'code_check='+$codeObj.val(),
			beforeSend: function () {
	               vm.setAttribute("disabled", "disabled");
	               },
			success: function(data){
				alert("인증번호를 이메일로 전송했습니다.");
				vm.removeAttribute("disabled");
			}
		});
		return false;
	});
	
	/*인증번호 확인*/
	var $code_check_input = $("input[name=code_check_input]");//인증번호입력란
		console.log($codeObj.val());
	$("#code_confirm").click(function(){//인증번호 확인버튼
		//console.log($code_check_input.val());
		if($codeObj.val() == $code_check_input.val()){
			alert("인증완료")
			$("#submit").css("display","block");
		} else {
			alert("인증번호가 일치하지 않습니다.")
			$code_check_input.val("");
		}
		return false;
	});

	/*가입하기*/
	$("form").submit(function(){
		if($("input[name=pwd]").val() != $("#pwd_confirm").val()) {
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}
		
		$.ajax({
			url: '${contextPath}/join',
			method: 'POST',
			data: $(this).serialize(),
			success:function(data){
				var jsonObj = JSON.parse(data);
				if(jsonObj.status == 1){
					alert("가입완료! 로그인되었습니다.");
					opener.parent.location='${contextPath}/main.jsp';
					window.close();
				} else if(jsonObj.status == -1){
					alert("가입에 실패했습니다. 다시 시도해주세요.");
				}
			}
		});
		return false;
	});

});
</script>
</head>
<body class="fontthin">
<%! public String getRandom(){
    StringBuffer key = new StringBuffer();
    Random rnd = new Random();
    for (int i = 0; i < 10; i++) {
        int index = rnd.nextInt(3);
        switch (index) {
            case 0:
                key.append((char) ((int) (rnd.nextInt(26)) + 97));
                break;
            case 1:
                key.append((char) ((int) (rnd.nextInt(26)) + 65));
                break;
            case 2:
                key.append((rnd.nextInt(10)));
                break;
        }
    }
    return key.toString();
}%>
<div>
<h1 style="display: inline;">회원가입</h1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<h5 style="display: inline;">*표시는 필수입력항목</h5>
<form>
	<div class="terms-of-service">
	<input type="checkbox" required><span class="red">(필수)</span>
	스터디봉봉의 
	<a href="https://studysearch.co.kr/terms/" target="_blank">이용약관</a>,
	<a href="https://studysearch.co.kr/policy/" target="_blank">개인정보 취급방침</a>,
	<a href="https://studysearch.co.kr/participant-terms/" target="_blank">참가자 약관</a>,
	<a href="https://studysearch.co.kr/leader-terms/" target="_blank">리더약관</a>
	에 동의합니다.<br>
	</div>
	<input type="email" name="email" placeholder="*이메일" required>
	<button type="button" id="sendmail">
		<span id="able">인증번호 받기</span>
		<span id="disable">
            <span></span><span></span><span></span>
        </span>
    </button><br>
	<div id="code_div">	
		<input type="text" name="code_check_input" placeholder="*이메일 인증번호"required>
		<button type="button" id="code_confirm">인증번호 확인</button>
		<input type="hidden" name="code_check" value="<%=getRandom()%>"><br>
	</div>
	
	<input type="text" name="id" placeholder="*아이디" required>
	<button type="button" id="dupchk">중복확인</button><br>
	<input type="password" name="pwd" placeholder="*비밀번호" required><br>
	<input type="password" id="pwd_confirm" placeholder="*비밀번호 확인" required><br>
	<input type="text" name="name" placeholder="*이름" required><br>
	<hr style=" display:inline-block; margin: 20px 0px 5px 0px; width: 105px;">
	<span style="font-size: 10pt; color: gray;">선택입력항목</span>
	<hr style=" display:inline-block; margin: 20px 0px 5px 0px; width: 105px;"><br>
    <input type="text" name="major" placeholder="전공"><br>
	<input type="text" name="interest" placeholder="관심분야"><br>
	<select name="area" style="margin-top: 12px;">
        <option value="">지역</option>
        <option value="서울 강남">서울 강남</option>
        <option value="서울 신촌">서울 신촌</option>
        <option value="서울 종로">서울 종로</option>
        <option value="서울 기타">서울 기타</option>
        <option value="부산">부산</option>
        <option value="대구">대구</option>
        <option value="인천">인천</option>
        <option value="대전">대전</option>
        <option value="광주">광주</option>
        <option value="기타">기타</option>
    </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="radio" name="gender" value="여성">여성&nbsp;&nbsp;
	<input type="radio" name="gender" value="남성">남성<br>
	<button type="submit" id="submit">가입하기</button>
</form>
</div>
</body>
</html>