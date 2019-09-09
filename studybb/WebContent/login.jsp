<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login.jsp</title>
<style>
div:first-child {
	margin-top: 50px;
    margin-left: 90px;
}
div.atag{
	margin-top: 10px;
	padding-left: 20px;
}
button {
    position: relative;
    padding: 10px;
    width: 300px;
    border: 1px solid #ccc;
}
input[type=text], input[type=password] {
    box-sizing: border-box;
    display: inline-block;
    padding-left: 20px;
    width: 300px;
    height: 3pc;
    border: 1px solid #e1e1e1;
    font-size: 10pt;
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
<link href="https://pro.fontawesome.com/releases/v5.7.0/css/all.css" rel="stylesheet">
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Kaushan+Script" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css">
<link href="https://blackrockdigital.github.io/startbootstrap-agency/css/agency.min.css" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
$(function(){
	/*기억된 ID찾기*/
	var savedId = localStorage.getItem("savedId");
	if(savedId != null && savedId !=''){
		$("input[name=id]").val(savedId)
	}
	
	$("form").submit(function(){
		/*아이디 기억*/
		$saveObj = $("input[name=login_id_save]");
		if($saveObj.prop("checked")){//선택됨
			var id = $("input[name=id]").val();
			localStorage.setItem("savedId",id);
		} else {//선택안됨
			localStorage.removeItem("savedId");
		}
		
		/*로그인*/
		$.ajax({
			url: '${contextPath}/login',
			method: 'POST',
			data: $(this).serialize(),
			success: function(data){
				var jsonObj = JSON.parse(data);
				if(jsonObj.status == 1){
					alert("로그인 성공!");
					opener.parent.location='${contextPath}/main.jsp';
					window.close();
				} else if(jsonObj.status == -1){
					alert("비밀번호가 일치하지 않습니다.");
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
<h1>로그인</h1>
<form>
	<input type="text" name="id" placeholder="아이디" required><br>
	<input type="password" name="pwd" placeholder="비밀번호" required><br>
	<input type="checkbox" name="login_id_save" checked>로그인ID 유지<br>
	<button type="submit" name="submit_btn" style="margin-top: 9pt;">로그인</button><br>
	<div class="atag">
		<a style="color: gray;" href="searchid.jsp">아이디 찾기</a>
		<span> | </span>
		<a style="color: gray;" href="searchpwd.jsp">비밀번호 찾기</a>
		<span> | </span>
		<a style="color: gray;" href="join.jsp" onClick="window.open(this.href, '', 'width=800, height=800'); window.close(); return false;" >회원가입</a><br>
	</div>
</form>
</div>
</body>
</html>