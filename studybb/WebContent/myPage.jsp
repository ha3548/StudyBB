<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPage</title>
<style>
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
.bg-yellow {
   background-color: #fed136;
   background-size: cover;
}
</style>
<link rel="stylesheet"
   href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/css/sb-admin-2.min.css">
<link rel="stylesheet"
   href="https://pro.fontawesome.com/releases/v5.7.0/css/all.css">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
   src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>
var loadMyProfile = function(data){
   $("#content").empty();
   $("#content").html(data);
};
var loadMyStudy = function(data){
   $("#content").empty();
   $("#content").html(data);
};
var loadMyCart = function(data){
   $("#content").empty();
   $("#content").html(data);
};

var loadMenu = function(u, callback){
   $.ajax({
      url: u,
      method: 'GET',
      success: function(data){
         console.log("OK",data);
         callback(data);
      }
   });
}   

$(function(){
   var $menuArr = $("#sidemenu>li>a");
   $menuArr.click(function(event){
      var url = $(this).attr('href'); //attr: 선택한 요소(this)의 (href)속성값 
      switch(url){
      case '${pageContext.request.contextPath}/mypage':
         loadMenu(url, loadMyPage);
      case '${contextPath}/myprofile':
         loadMenu(url, loadMyProfile);
         break;
      case '${contextPath}/mystudy':
         loadMenu(url, loadMyStudy);
         break;
      case '${contextPath}/myCart.jsp':
         loadMenu(url, loadMyCart);
         break;   
      }
      return false; //기본이벤트핸들러 막기, 이벤트전달 중지 
   });
});
</script>
</head>
<body>
<jsp:include page="menu.jsp"/>
<div id="wrapper">
   <ul class="navbar-nav bg-yellow sidebar sidebar-dark accordion" id="sidemenu">
   <%-- <li class="nav-item active">
        <a class="nav-link" href="index.html">
          <span class="fontbold">StudyBongBong</span></a>
        </li> --%> 
        <hr class="sidebar-divider">
        <li class="nav-item active">
        <a class="nav-link" href='${contextPath}/myprofile'>
          <i class="fas fa-user"></i>
          <span>내 프로필</span></a>
        </li>
        <hr class="sidebar-divider">
        <li class="nav-item active">
        <a class="nav-link" href='${contextPath}/mystudy'>
          <i class="fas fa-book-open"></i>
          <span>내 스터디</span></a>
        </li>
        <hr class="sidebar-divider">
   <%-- <li class="nav-item active">
        <a class="nav-link" href='${contextPath}/myCart.jsp'>
          <i class="fas fa-shopping-cart"></i>
          <span>찜한 스터디</span></a>
        </li> --%> 
         <hr class="sidebar-divider d-none d-md-block">
        <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
        </div>
   </ul>
   <div id="content-wrapper">
      <div id="content" class="m-5">
         <div class="container-fluid">
            <div class="d-sm-flex align-items-center justify-content-between mb-4">
            </div>
         </div>
      </div>
   </div>
</div>
   
<jsp:include page="footer.jsp"/>
</body>
</html>