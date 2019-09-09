<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<html>
<head>

<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet"
   href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
   href="https://cdn.studysearch.co.kr/static/common.6ced908f383f.css">
<link rel="stylesheet"
   href="https://cdn.studysearch.co.kr/static/desktop_app.bc3e8415a52a.css">
<script src="https://web.nicepay.co.kr/v3/webstd/js/nicepay-2.0.js "
   language="javascript"></script>

<script
   src="https://cdn.studysearch.co.kr/static/bson/bson.811fd3a968e8.js"></script>
<script
   src="https://cdn.studysearch.co.kr/static/html2canvas/html2canvas.2c84339e2d71.js"></script>

<!-- 
<script defer
   src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"></script>-->
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.7.5/css/bulma.min.css">
<link rel="stylesheet"
   href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">
<title>스터디 상세페이지</title>
<script>
   $(function() {

      //SSE
      /*if(typeof(EventSource) !== "undefined") {
           var source = new EventSource("${contextPath}/sse");
           source.onmessage = function(event) {
              var jsonObj = JSON.parse(event.data);
              $("#result").html(jsonObj.time + ", cnt=" + jsonObj.cnt);
              if(jsonObj.cnt > 5){
                 source.close();
              }
             //document.getElementById("result").innerHTML += event.data + "<br>";
           };
         } else {
           document.getElementById("result").innerHTML = "Sorry, your browser does not support server-sent events...";
         }*/

      //1)가입신청화면
      $("form").submit(function() {
    	 var loginInfo = '${sessionScope.loginInfo}';
    	 if(loginInfo == ""){
    		 alert("로그인한 회원만 신청 가능합니다.");
    		 return false;
    	 } else{
	         var study_no = '${requestScope.study.study_no}';
	        
	         console.log(study_no);
	         $.ajax({
	            url : '${contextPath}/enrol',
	            method : 'post',
	            data : 'study_no=' + study_no,
	            success : function(data) {
	               $("#product-article").empty();
	               $("#product-article").html(data);
	            }
	         });//end ajax
	         return false;
    	 }
      });

      //2) 스터디관리자 - 가입관리
      var $manageEnrolBtnObj = $("#btn_manageEnrol");
      $manageEnrolBtnObj.click(function() {
         var study_no = '${requestScope.study.study_no}';

         function goPopup() {
            var theURL = "${contextPath}/manageenrol?study_no=" + study_no; // 전송 URL
            window.open(theURL, "승인관리페이지",
                  "scrollbars=no,width=900,height=500,menubar=false");
            // window.open(URL,"팝업 구분값(팝업 1개일 경우 상관없음)","팝업 창 옵션")
         }
         goPopup();

      });//end click

      //3) 스터디관리자 - 스터디삭제 
      var $manageDeleteObj = $("#btn_manageDelete");

      $manageDeleteObj.click(function() {
         var result = confirm("관련된 모든 데이터가 사라집니다.\n정말 삭제하시겠습니까?");
         if (result) {
            var study_no = '${requestScope.study.study_no}';
            $.ajax({
               url : '${contextPath}/managedelete',
               method : 'post',
               data : 'study_no=' + study_no,
               success : function(data) {
                  if (data == 1) {
                     alert("성공적으로 삭제 되었습니다.");
                  } else {
                     alert("삭제할 수 없는 스터디입니다.");
                  }
               }
            });//end ajax
         }//end confirm
      });//end click

      //4) 스터디 찜하기
      var $insertCartObj = $("#bookmark-action-button");

      $insertCartObj.click(function() {
         var study_no = '${requestScope.study.study_no}';
         var mem_id = '${SessionScope.loginInfo}';
         $.ajax({
            url : '${contextPath}/insertCart',
            method : 'post',
            data : 'study_no=' + study_no + '&mem_id=' + mem_id,
            success : function(data) {
               //성공여부
            }
         });//end ajax
      });//end click
      
      //5) 스터디관리자 - 스터디수정
      var $manageEditObj = $("#btn_manageEdit");
      
      $manageEditObj.click(function() {
         alert("수정버튼클릭");
         var study_no = '${requestScope.study.study_no}';
            $.ajax({
               url : '${contextPath}/studyeditshow',
               method : 'post',
               data : 'study_no=' + study_no,
               success : function(data) {
                  $("#product-article").empty();
                  $("#product-article").html(data);
               }
            });//end ajax
      });//end click
      
   });//end load
</script>
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
html{
  overflow-x: hidden !important;
  overflow-y: scroll !important;
  height:auto;
  min-height:900px;
}
body{
  overflow-x:visible !important;
  height:auto;
  min-height:900px;
}
.navbar-brand {
    display: inline-block;
    padding-top: .3125rem;
    padding-bottom: .3125rem;
    margin-right: 1rem;
    font-size: 1.25rem;
    line-height: inherit;
    white-space: nowrap;
}
.navbar-toggler {
    font-size: 12px;
    right: 0;
    padding: 13px;
    text-transform: uppercase;
    color: #fff;
    border: 0;
    background-color: #fed136 !important;
    box-sizing: border-box;
    float: right;
}
#div_leadersetting button {
   margin-top: 10px;
   border: 1px solid #dcdcdc;
   box-sizing: border-box;
   color: #777;
   background-color: #FFF;
}
#product-article{
	height : auto !important;
}
#product-article html, body {
   background-color: #fff9e6 !important;
}

#product-article .verified {
   background-color: #e9fbe9;
}
#product-content-wrap>section {
    padding: 0;
}
#actions-widget{
padding-top:100px;
}	

#main{
padding-bottom: 0px;
} 
</style>
</head>
<body>
<jsp:include page="menu.jsp"/>
<article id="product-article" class="relative">
   <div class="fixed-width-wrap relative">
      <div id="product-related-info" class="shadow">
         <header id="product-header">
            <div id="product-header-images" style="width: 696px;">
               <img class=img_study src="${contextPath}/images/study/${requestScope.study.study_no}.png"
               onError="this.src='images/study/default.png'" />
            </div>
            <div id="product-header-texts">
               <span class="area font-weight-bold" style="color: #febf01;">${requestScope.study.study_area}</span>
               <h1>${requestScope.study.study_title}</h1>
            </div>
         </header>
         <div id="product-content-wrap">
            <section id="product-information">
               <div id="product-description" class="section-wrap">
                  <h1 class="section-label">스터디소개</h1>
                  <div class="section-content">
                     ${requestScope.study.study_content}</div>
               </div>
               <div id="product-detail" class="section-wrap">
                  <h2 class="section-label">상세 정보</h2>
                  <div class="section-content">
                     <dl id="detail-list" class="product-detail">
                        <dt>지역:</dt>
                        <dd>${requestScope.study.study_area}</dd>
                        <br>
                        <dt>인원:</dt>
                        <dd>${requestScope.study.study_cap}명</dd>
                        <br>
                        <dt>일정</dt>
                        <dd>${requestScope.study.study_week}주과정</dd>
                        <br>
                        <dd class="first item">
                           <div class="participation-info">
                              지금 신청하면 <span class="date">${requestScope.study.study_start}</span>
                              첫 스터디 시작!
                           </div>
                        </dd>
                     </dl>
                  </div>
               </div>
            </section>
            <section id="leader-information">
               <div class="section-wrap">
                  <header class="section-label">
                     <h1>리더 소개</h1>
                     <img src="images/profile/${requestScope.study.member.mem_id}.png"
                        class="leader-profile-image">
                  </header>
                  <div class="section-content">
                     <c:if test="${requestScope.study.study_type == 1}">
                        <c:if test="${requestScope.mentor.mentor_status == 1}">
                           <span class=verified><i class="fas fa-check"
                              style="color: green;"></i>인증된 멘토입니다!</span>
                           <br>
                        </c:if>
                     </c:if>
                     <div class="leader-introduction">
                        ${requestScope.mentor.mentor_career}<br><br>
                        안녕하세요, ${requestScope.study.member.mem_name}입니다!<br>
                        ${requestScope.study.study_leader_intro}
                        
                     </div>
                  </div>
               </div>
            </section>
            <section id="review-info" class="section-cintent">
               <c:if test="${requestScope.study.study_type==1}">
                  <header>
                     <h1 id="review-count" class="heading">멘토에 대한 후기</h1>
                  </header>
               </c:if>
               <div id=app>
                  <c:forEach var="r" items="${requestScope.review}">
                     <div class="tweet tweetbox">
                        <div class="box" style="margin-bottom:20px; padding-bottom:0;">
                           <article class="media">
                              <div class="media-left">
                                 <figure class="image is-64x64">
                                    <img src="images/profile/${r.member.mem_id}.png"
                                       alt="Profile image"
                                       onerror="this.src='images/profile/default.png'">
                                 </figure>
                              </div>
                              <div class="media-content">
                                 <div class="content">
                                    <strong class="profileBtn fontbold">${r.member.mem_name}</strong>
                                    <small class="fontthin">@${r.member.mem_id}</small> <small
                                       class="float-right fontthin"> ${r.review_date} </small>
                                 </div>
                                 <div class="control">
                                    <span class="fontthin">${r.review_content}</span><br> <br>
                                    <a class="fontthin"
                                       href="${contextPath}/studydetail?study_no=${r.study.study_no}">${r.study.study_title}</a>
                                    <br> <br>
                                 </div>
                              </div>
                           </article>
                        </div>
                     </div>
                  </c:forEach>
               </div>
            </section>
         </div>
      </div>
      <aside id="actions-widget" class="fixed mt-4">
         <div class="order-action-wrap">
            <h1 class="title">${requestScope.study.study_title}</h1>
            <form id="participation-form">
               <ul id="participation-choices">
                  <li><input id="full-participation-choice"
                     class="participation-choice-button" type="radio" checked
                     name="trial" value="N"><label
                     for="full-participation-choice"><span class="mock-radio"></span><span
                        class="participation-choice-text" style="color: #febf01;">${requestScope.study.study_week}주</span></label></li>
               </ul>
               <c:if test="${requestScope.study.study_type==1}">
                  <div id="price-wrap">
                     <div class="amount-to-pay">
                        <span class="price-text">참가비</span>
                        <div class="discounted-price-wrap">
                           <div class="price-wrap">
                              <div class="price-value" style="color: #febf01;">${requestScope.study.study_price}원</div>
                           </div>
                        </div>
                     </div>
                  </div>
               </c:if>
               <c:if
                  test="${requestScope.study.member.mem_id!=sessionScope.loginInfo}">
                  <c:choose>
                     <c:when
                        test="${requestScope.study.study_status == null||requestScope.study.study_status == 0}">
                        <input type="submit" id="purchase-action-button"
                           class="action-button in-promotion" value="참여 신청하기"
                           style="background-color: #fed136; color: black;">
                     </c:when>
                     <c:otherwise>
                        <div id="closed-study-action-button" class="action-button">마감되었습니다</div>
                     </c:otherwise>
                  </c:choose>
               </c:if>
            </form>
            <a id="bookmark-action-button" class="action-button" href="#"><span
               class="icon bookmarked"></span>찜하기</a>
            <!-- <span
               class="icon bookmarked"></span>찜취소</a> -->
            <c:if
               test="${requestScope.study.member.mem_id==sessionScope.loginInfo}">
               <div id=div_leadersetting>
                  <button id=btn_manageEnrol class="action-button">스터디 신청관리</button>
                  <button id=btn_manageDelete class="action-button">스터디 삭제</button>
                  <button id=btn_manageEdit class="action-button">스터디 수정</button>
               </div>
            </c:if>
         </div>
      </aside>
   </div>
</article>
<jsp:include page="footer.jsp"/>
</body>
</html>