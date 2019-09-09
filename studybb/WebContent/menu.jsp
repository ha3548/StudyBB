<%@page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="contextPath.jsp"%>
<head>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<!--Import materialize.css-->
<link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>

<!--Let browser know website is optimized for mobile-->
<meta name="viewport" content="width=device-width, initial-scale=1.0"/> 
<script src="https://kit.fontawesome.com/80a62b0c6a.js"></script>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom fonts for this template -->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
<link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>

<!-- Custom styles for this template -->
<link href="css/agency.min.css" rel="stylesheet">
<style>
@import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css); 
.nanumgothic * { 
  font-family: 'Nanum Gothic', sans-serif; 
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
.yellow{
  color: #febf01;
}
.handon {
   font-family: 'Handon3gyeopsal600g' !important;
}
.handont {
   font-family: 'Handon3gyeopsal300g' !important;
}
.nanum {
   font-family: 'Nanum Gothic', sans-serif !important;
}
header.masthead{
  max-height: 500px;
}
.intro-text{
  padding-top: 150px;
  height: 500px;
}
.float-right{
  float: right;
}
.float-left{
  float:left;
}
.nav-link{
  color: black;
}
.bg-img {
  /* The image used */
  background-color: #212529;

  min-height: 100px;

  /* Center and scale the image nicely */
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
  
  /* Needed to position the navbar */
  position: relative;
}
footer ul li a svg{
  margin-top: 15px;
}
.leftmenu{
  margin-right: 150px;
}
section{
  padding-top: 0px;
  padding-bottom: 0px;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"></script>
<script>
$(function() {
   // 메인 화면 이동
   $('#logo').click(function() {
       location.href="${contextPath}/main.jsp";
   });
});
</script>
</head>
<body>
<!-- Navigation -->
<div class="bg-img">
  <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
    <div class="container">
      <a class="navbar-brand js-scroll-trigger" id="logo">Study BongBong</a>
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        Menu
        <i class="fas fa-bars"></i>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">    <!-- 수정 -->
        <ul class="navbar-nav text-uppercase ml-auto">
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="${contextPath}/main.jsp">스터디 찾기</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="${contextPath}/studyOpen.jsp">스터디 만들기</a>
          </li>
          <li class="nav-item leftmenu">
            <a class="nav-link js-scroll-trigger" href="${contextPath}/board">희망스터디 신청</a>
          </li>
          <c:choose>
          <%--로그인 안된경우에 보일 메뉴 --%>
          <c:when test="${empty sessionScope.loginInfo}">
           <li class="nav-item"><a class="nav-link js-scroll-trigger" href='${contextPath}/login.jsp'
               onclick="window.open(this.href,'로그인창','width=500, height=400'); return false;">로그인</a></li>
           <li class="nav-item"><a class="nav-link js-scroll-trigger" href='${contextPath}/join.jsp'
               onclick="window.open(this.href,'회원가입창','width=800, height=800'); return false;">회원가입</a></li>
          </c:when>
          <%--로그인된 경우에 보일 메뉴 --%>
          <c:otherwise>
           <li class="nav-item"><a class="nav-link js-scroll-trigger" href='${contextPath}/logout'>로그아웃</a></li>
           <li class="nav-item">
                <a class="nav-link js-scroll-trigger" href="${contextPath}/myPage.jsp">Mypage</a>
              </li>
          </c:otherwise>
         </c:choose>
        </ul>
      </div>
    </div>
  </nav>
</div>

<!-- Header -->
<header class="masthead"></header>
</body>