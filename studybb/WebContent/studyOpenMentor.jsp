<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--String now = new SimpleDateFormat("yyyy-MM-dd").format(new Date()); --%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멘토 스터디 만들기</title>
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
.y {
   background-color: #fed136;
}
</style>
<link rel="stylesheet"
   href="https://pro.fontawesome.com/releases/v5.7.0/css/all.css">
<link rel="stylesheet"
   href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
   rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Kaushan+Script"
   rel="stylesheet" type="text/css">
<link
   href="https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic"
   rel="stylesheet" type="text/css">
<link
   href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700"
   rel="stylesheet" type="text/css">
<link
   href="https://blackrockdigital.github.io/startbootstrap-agency/css/agency.min.css"
   rel="stylesheet" type="text/css">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
   src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>
   function readURL(input) {
      if (input.files && input.files[0]) {
         var reader = new FileReader();
         reader.onload = function(e) {
            $('#study_image').attr('src', e.target.result);
         }
         reader.readAsDataURL(input.files[0]);
      }
   }

   $(function() {

      $("input[name=study_start]").change(function() {
         var choiceDate = Date.parse($(this).val());
         var now = Date.now();
         var dueDate = Date.parse($("input[name=study_due]").val());
         if (choiceDate <= now) {
            alert("스터디시작날짜는 내일부터 가능합니다.");
         } else if (choiceDate <= dueDate) {
            alert("스터디시작날짜는 마감날짜 이후부터 가능합니다.");
         }
      });

      $("input[name=study_due]").change(function() {
         var choiceDate = Date.parse($(this).val());
         var now = Date.now();
         var startDate = Date.parse($("input[name=study_start]").val());
         if (choiceDate <= now) {
            alert("모집마감날짜는 내일부터 가능합니다.");
         } else if (choiceDate > startDate) {
            alert("모집마감날짜는 스터디시작 이전이어야 합니다.");
         }
      });

      //login 정보 연결
      var loginInfo = "${sessionScope.loginInfo}";
      localStorage.setItem('savedId', loginInfo);

      $("form").submit(function() {
         var mem_id = localStorage.getItem('savedId');
         var formData = new FormData(this);
         formData.append("mem_id", mem_id);
         //var formIpt = $(this).serialize();
         //alert('mem_id='+ mem_id + "&" + formIpt);
         $.ajax({
            url : '${contextPath}/studyopenmentor',
            method : 'post',
            enctype : 'multipart/form-data',
            data : formData,
            processData : false,
            contentType : false,
            success : function(data) {
                var jsonObj = JSON.parse(data);
                var msg = "스터디 생성";
                if (jsonObj.status == 1) {
                   //msg += ' 성공';
                   //alert(msg);
                   //location.href = "${contextPath}/main.jsp";
                   location.reload();
                } else {
                   msg += ' 실패';
                   alert(msg);
                }
             }
         });
         return false;
      });

      //study_week 최대 99주
      $("input[name=study_week]").change(function() {
         if ($(this).val() > $(this).attr('max')) {
            alert("최대기간은 99주입니다.");
         }
      });

   });
</script>
</head>
<body>
<section class="page-section">
   <div class="container shadow p-3">
      <div class="row">
         <div class="col-lg-12 text-center">
            <i class="fas fa-chalkboard-teacher fa-5x"></i>
            <h2 class="section-heading text-uppercase fontbold mt-3 mb-5">
               <span class="y">멘토 스터디 만들기</span></h2>
         </div>
      </div>
      <div class="row">
         <div class="col-lg-12">
            <form id="contactForm" name="sentMessage" novalidate="novalidate">
               <div class="row">
                  <div class="col-md-6">
                     <div class="form-group">
                        <span class="fontbold">제목</span> <input
                           class="form-control fontthin" type="text" name="study_title"
                           placeholder="스터디 제목을 입력하세요." required="required"
                           data-validation-required-message="Please enter study title.">
                        <p class="help-block text-danger"></p>
                     </div>
                     <div class="form-group">
                        <span class="fontbold">대표 사진</span><br> <input
                           class="fontthin" name="study_image" type="file"
                           onchange="readURL(this);" required="required"
                           data-validation-required-message="Please upload study image">
                        <p class="help-block text-danger"></p>
                        <div>
                           <img id="study_image" class="img-fluid"
                              src="images/studyimages/default.jpg" alt="">
                        </div>
                     </div>
                     <div class="form-group">
                        <span class="fontbold">자기 소개</span>
                        <textarea class="form-control fontthin"
                           name="study_leader_intro" rows="5" type="text"
                           placeholder="스터디원에게 자신을 소개해보세요." required="required"
                           data-validation-required-message=""></textarea>
                        <p class="help-block text-danger"></p>
                     </div>
                     </div>
                  <div class="col-md-6">
                  <div class="form-group">
                        <span class="fontbold">스터디 소개</span>
                        <textarea class="form-control fontthin" name="study_content" rows="4"
                           placeholder="상세 일정, 진행 방식, 스터디 규칙 등을 자세히 설명해주세요.&#13;&#10;ex) 주 2회 (월, 수) 오후  6시~8시" required="required"
                           data-validation-required-message=""></textarea>
                        <p class="help-block text-danger"></p>
                     </div>
                     <div class="form-group">
                        <span class="fontbold">지역</span><br> 
                        <select name="study_area" class="fontthin p-2">
                           <option selected="true" disabled="disabled">지역 선택</option>
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
                        </select>
                     </div>
                     <div class="form-group">
                        <span class="fontbold">모집 마감날짜</span> <input
                           class="form-control" name="study_due" type="date"
                           placeholder="" required="required"
                           data-validation-required-message="">
                        <p class="help-block text-danger"></p>
                     </div>
                     <div class="form-group">
                        <span class="fontbold">스터디 시작일</span> <input
                           class="form-control" name="study_start" type="date"
                           placeholder="" required="required"
                           data-validation-required-message="">
                        <p class="help-block text-danger"></p>
                     </div>
                     <div class="form-group">
                        <span class="fontbold">스터디 기간</span><br>
                        <input style="display: inline-block;"
                           class="form-control col-md-3 mr-1" type="number" name="study_week"
                           placeholder="" required="required"  min="1" max="99"  value="1"
                           data-validation-required-message=""><span>주</span>
                        <p class="help-block text-danger"></p>
                     </div>
                     <div class="form-group">
                        <span class="fontbold">가격</span><br>
                        <input style="display: inline-block;"
                           class="form-control col-md-6 mr-1"
                           name="study_price" type="number" step="1000" min="0" value="0"
                           required="required" data-validation-required-message=""><span>원</span>
                        <p class="help-block text-danger"></p>
                     </div>
                     <div class="form-group">
                        <span class="fontbold">태그</span> 
                        <input class="form-control fontthin"
                           name="study_tag" placeholder="ex) #java #코딩  #IT" required="required"
                           data-validation-required-message="">
                        <p class="help-block text-danger"></p>
                     </div>
                     <div class="form-group">
                        <span class="fontbold">인원</span><br> 
                        <input style="display:inline-block;"
                           class="form-control col-md-3 mr-1" name="study_cap" type="number"
                           placeholder="최대 정원" required="required"
                           data-validation-required-message=""><span>명</span>
                        <p class="help-block text-danger"></p>
                     </div>
                  </div>
                  
                  <div class="clearfix"></div>
               </div>
               <div class="col-lg-12 text-center">
                  <div id="success"></div>
                  <button id="sendMessageButton"
                     class="btn btn-primary btn-xl text-uppercase" type="submit">
                     <span class="fontbold">만들기</span>
                  </button>
               </div>
            </form>
         </div>
      </div>
   </div>
</section>   
</body>
</html>