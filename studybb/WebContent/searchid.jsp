<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>searchid.jsp</title>
<style>
div {
	margin-top: 50px;
    margin-left: 90px;
}
div.atag{
	margin-top: 10px;
	padding-left: 60px;
}
input[type=email] {
    box-sizing: border-box;
    display: inline-block;
    padding-left: 20px;
    width: 300px;
    height: 3pc;
    border: 1px solid #e1e1e1;
    font-size: 10pt;
}
input[type=submit] {
    margin-top: 10pt;
    margin-bottom: 10pt;
    position: relative;
    padding: 10px;
    width: 300px;
    border: 1px solid #ccc;
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
	$("form").submit(function(){
		$.ajax({
			url: '${contextPath}/searchid',
			method: 'POST',
			data: 'email=' + $("input[name=email]").val(),
			success: function(data){
				var jsonObj = JSON.parse(data);
				
				if(jsonObj.id != null){
					alert("회원님의 아이디는 " + jsonObj.id +"입니다.");
				} else if(jsonObj.id == null){
					alert("일치하는 회원정보가 없습니다.");
				}
				
			}
		});
		return false;
	});
});
</script>
</head>
<body class="fontthin">
<div>
<h1>아이디찾기</h1>
<form>
	<input type="email" name="email" class="search_email" placeholder="이메일" required><br>
	<input type="submit" class="request_authnumber" value="아이디찾기"><br>
	로그인하시겠습니까?
	<a style="color: gray;" href="login.jsp">로그인</a><br>
	비밀번호를 잊으셨나요?
	<a style="color: gray;" href="searchpwd.jsp">비밀번호 찾기</a><br>
</form>
</div>
</body>
</html>