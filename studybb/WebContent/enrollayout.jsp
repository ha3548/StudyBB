<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 멘토스터디 신청페이지 -->
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="canonical" href="https://startbootstrap.com/previews/agency/">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-6jHF7Z3XI3fF4XZixAuSu0gGKrXwoX/w3uFPxC56OtjChio7wtTGJWRW53Nhx6Ev" crossorigin="anonymous">

<link type="application/atom+xml" rel="alternate" href="https://startbootstrap.com/feed.xml" title="startbootstrap">


<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>enrollayout.jsp</title>
<style>
#main-section{
margin-bottom:200px;
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

input[type=text]{
width: 90%;
height: 100px;
}

table{
   width: 100%;
    border-collapse: separate;
    border-spacing: 1px;
    text-align: center;
    line-height: 1.5;
    margin: 20px 10px;
}
table th {
    width: 155px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #fff;
    background: #fed136;
}
table td {
    width: 155px;
    padding: 10px;
    vertical-align:middle;
    border-bottom: 1px solid #ccc;
    background: #eee;
}

div.form-group{
width: 70%;
}

form{
width: 80%;
margin: 0 auto;
}

.btn{
background-color: #fed136;
}

.btn-class{
margin: 0 auto;
width: 200px;
}

div.form-group{
margin: 0 auto;
margin-bottom: 30px;
}

form{
height: auto;

}
.page-section>.container{
background-image: url('images/imageDS.jpg'); 
background-size:auto; 
background-position: center; 
height: 400px; 
margin-left: 10px; 
margin-right: 10px;
background-repeat:no-repeat; 
background-color: #fed136;
}

h1{
text-align: center; 
color: white;
}

h3{
text-align: center; 
color: white;

}

.font-background-color{
background-color: rgba( 153, 153, 153, 0.5 );
background-size: 50px;
margin-top: 150px;
width: 500px;
margin-left: 230px;
}

.remaining{
float: right;
font-size: 0.8em;
color: gray;
}
</style>

<script>
$(function(){

      $("form").submit(function(){
         $.ajax({
             url: "${pageContext.request.contextPath}/enrolinsert",
             method:'post',
             data: $(this).serialize(),
             success:function(data){
                alert(data);
                location.reload();
             }
         }); 
          return false;
      });
      
      
      // input 입력폼 enter키 누를경우 submit 막기
      $('input[type="text"]').keydown(function() {
           if (event.keyCode === 13) {
             event.preventDefault();
           };
         });
      
      
      // enrol_say 글자수 100자 제한
      $(function() {
          $('.remaining').each(function() {
              // count 정보 및 count 정보와 관련된 textarea/input 요소를 찾아내서 변수에 저장한다.
              var $count = $('.count', this);
              var $input = $(this).prev();
              // .text()가 문자열을 반환하기에 이 문자를 숫자로 만들기 위해 1을 곱한다.
              var maximumCount = $count.text() * 1;
              // update 함수는 keyup, paste, input 이벤트에서 호출한다.
              var update = function() {
                  var before = $count.text() * 1;
                  var now = maximumCount - $input.val().length;
                  // 사용자가 입력한 값이 제한 값을 초과하는지를 검사한다.
                  if (now < 0) {
                      var str = $input.val();
                      alert('글자 입력수가 초과하였습니다.');
                      $input.val(str.substr(0, maximumCount));
                      now = 0;
                  }
                  // 필요한 경우 DOM을 수정한다.
                  if (before != now) {
                      $count.text(now);
                  }
              };
              // input, keyup, paste 이벤트와 update 함수를 바인드한다
              $input.bind('input keyup paste', function() {
                  setTimeout(update, 0)
              });
              update();
          });
      });
      
      // 신청버튼
         var $btnPayObj = $("#btnpay"); 
         $btnPayObj.click(function(){
            console.log("신청버튼 클릭");
         
         });

      
});
</script>
</head>
<body class="fontthin">
<form>
<c:choose>
<c:when test="${requestScope.study.study_price == 0}">
<section class="page-section" id="services">
    <div class="container">
      <div class="row">
        <div class="col-lg-12 text-center0">
          <div class="font-background-color">
          <h1 class="fontbold">자율스터디 신청하기</h1>
          <h3>나와 꼭 맞는 사람들과 함께스터디해요!</h3>
        </div>
      </div>
    </div>
 </div>
  </section>
<table class="fontthin">
  <tr>
     <th>스터디</th>
    <th>스터디 시작일</th> 
    <th>스터디기간</th>
  </tr>
  <tr>
    <td>${requestScope.study.study_area}<br>
    ${requestScope.study.study_title}</td>
    <td>${requestScope.study.study_start}</td>
    <td>${requestScope.study.study_week}주 과정</td>
  </tr>
</table>
</c:when>
<c:otherwise>
<section class="page-section" id="services">
    <div class="container">
      <div class="row">
        <div class="col-lg-12 text-center">
        <div class="font-background-color">
          <h1 class="fontbold">멘토스터디 신청하기</h1>
          <h3>멘토가 이끄는 스터디에 참여해보세요.</h3>
          </div>
        </div>
      </div>
    </div>
  </section>
   <table class="fontthin">
  <tr>
     <th>스터디</th>
    <th>스터디 시작일</th> 
    <th>스터디기간</th>
    <th>스터디가격</th>
  </tr>
  <tr>
    <td>${requestScope.study.study_area}<br>
    ${requestScope.study.study_title}</td>
    <td>${requestScope.study.study_start}</td>
    <td>${requestScope.study.study_week}주 과정</td>
    <td>${requestScope.study.study_price}원</td>
  </tr>
</table>
</c:otherwise>
</c:choose>

<br>
<input name="enrol_date" type="hidden"><fmt:formatDate value="${requestScope.enrol.enrol_date}" pattern="yy-MM-dd hh:mm:ss"/>
<div class="col-lg-12 text-center">
<h3 class="fontbold" style="color:black;">스터디에서 무엇을 배우고 싶나요?</h3><br>

<input name="study_no" value="${param.study_no}" type="hidden">
<input name="mem_id" value="${sessionScope.loginInfo}" type="hidden">
<input name="enrol_status" value="0" type="hidden">

<div class="form-group">
<textarea class="form-control" name="enrol_say" placeholder="하고싶은 말을 남겨주세요." style="height: 200px;"></textarea>
<div class="remaining">입력 글자 수 : <span class="count">100</span>/100</div>
</div>
</div>

<div class="btn-class">
<button id="btnpay" class="btn" type="submit">결제하기</button>&nbsp;&nbsp;&nbsp;
<button class="btn">취소</button>
</div>

</form>
</body>
</html>