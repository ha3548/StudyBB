<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스터디 생성</title>
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
   src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_seven@1.2/Handon3gyeopsal300g.woff') format('woff'); 
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
<link rel="stylesheet"
   href="https://pro.fontawesome.com/releases/v5.7.0/css/all.css">
<link rel="stylesheet"
   href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Kaushan+Script" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css">
<link href="https://blackrockdigital.github.io/startbootstrap-agency/css/agency.min.css" rel="stylesheet" type="text/css">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
   src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>
var loadMentor = function(data){
   $("#portfolio").empty();
   $("#portfolio").html(data);
};

var loadNoMentor = function(data){
   $("#portfolio").empty();
   $("#portfolio").html(data);
};

var loadMenu = function(u, callback) {
   $.ajax({
      url : u,
      method : 'GET',
      success : function(data) {
         console.log("OK", data);
         callback(data);
      }
   });
};

   $(function() {
      var $divMentor = $("div#mentor");//멘토스터디생성div

      //login이랑 아직 연결안돼서 test용으로 넣어둔 것!
      //localStorage.setItem('savedId', 'YEO');
      

      $divMentor.click(function() {//클릭시 StudyOpenServlet(/studyopen)으로 이동
         //var mem_id = localStorage.getItem('savedId');
         var mem_id = "${sessionScope.loginInfo}";
         $.ajax({
            url : "${contextPath}/studyopen",
            data : 'mem_id=' + mem_id,
            method : 'post',
            success : function(data) {
               var jsonObj = JSON.parse(data);
               if (jsonObj.status == 1) {
                  loadMenu("studyOpenMentor.jsp", loadMentor);
               } else {
                  alert("생성 권한이 없습니다. 자율스터디 생성을 이용해주세요.");
               }
            }
         });//end ajax
      });

      var $divNoMentor = $("div#nomentor");//자율스터디생성div
      $divNoMentor.click(function() {//클릭시 StudyOpenServlet(/studyopen)으로 이동
    	 var loginInfo = "${sessionScope.loginInfo}";
    	 if(loginInfo == ""){
    		 alert("로그인한 회원만 스터디 생성 가능합니다.");
    		 return false;
    	 } else {
         	loadMenu("studyOpenNoMentor.jsp", loadNoMentor);
    	 }
      });
   });
</script>
</head>
<body>
<jsp:include page="menu.jsp"/>
   <section class="bg-light page-section" id="portfolio">
      <div class="container">
         <div class="row">
            <div class="col-lg-12 text-center">
               <i class="fas fa-book-open fa-5x"></i>
               <h2 class="section-heading text-uppercase fontbold mt-3">새로운 스터디 만들기</h2>
               <h3 class="section-subheading text-muted"></h3>
            </div>
         </div>
         <div class="row">
            <div class="col-md-6 col-sm-6 portfolio-item" id="mentor">
               <a class="portfolio-link" data-toggle="modal"
                  href="#portfolioModal1">
                  <div class="portfolio-hover">
                     <div class="portfolio-hover-content">
                        <i class="fas fa-plus fa-3x"></i>
                     </div>
                  </div> 
                  <img class="img-fluid" src="images/mentor.jpg" alt="">
               </a>
               <div class="portfolio-caption">
                  <h4 class="fontbold">멘토 스터디</h4>
                  <p class="text-muted"><span class="fontthin">새로운 수업을 만들어보세요.</span></p>
               </div>
            </div>
            <div class="col-md-6 col-sm-6 portfolio-item" id="nomentor">
               <a class="portfolio-link" data-toggle="modal"
                  href="#portfolioModal2">
                  <div class="portfolio-hover">
                     <div class="portfolio-hover-content">
                        <i class="fas fa-plus fa-3x"></i>
                     </div>
                  </div> 
                  <img class="img-fluid" src="images/nomentor.jpg" alt="">
               </a>
               <div class="portfolio-caption">
                  <h4 class="fontbold">자율 스터디</h4>
                  <p class="text-muted"><span class="fontthin">우리만의 맞춤 스터디를 만들어보세요.</span></p>
               </div>
            </div>
         </div>
      </div>   
   </section>
   <jsp:include page="footer.jsp"/>
</body>
</html>