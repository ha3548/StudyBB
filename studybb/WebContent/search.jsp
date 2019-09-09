<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="contextPath.jsp"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<head>
<style>
#searchapp{
  max-width: 9999px;
  margin-bottom: 100px;
}
#searchapp form.search input{
  font-size:22px; 
  line-height:31px;
  padding-top:8px; 
  padding-bottom:8px;
  margin-bottom:16px;
}
#searchapp form.search{
  border-radius: 15px;
  background-color: #fff9e6;
  padding: 30px;
  padding-bottom: 14px;
  transform:scale(0.9);
}
#searchapp form.search button{
  margin-bottom:16px;
  width: 100%;
  height: 84px;
  padding: 10px;
  font-size: 20px;
}
#searchapp > div {
  margin-left: 50px;
  margin-right: 50px;
}
div.studydetail {
  margin: 5px;
  border: 1px solid #ccc;
}
div.studydetail:hover {
  border: 1px solid #777;
}
div.studydetail img {
  width: 100%;
  height: 250px;
}
div.searchresult {
  padding: 15px;
  height: 130px;
  text-align: center;
  overflow: hide;
}
#searchresultapp{
  padding: 0px;
}
#searchapp{
  margin-top: 50px;
}
</style>
<script>
$(function(){
	var $btnSearchObj = $(".btnsearch");

	$btnSearchObj.click(function(){
		var $form = $("form.search");

		$.ajax({
			url: '${contextPath}/studylist',
			method: 'POST',
			data : $form.serialize(),
			success:function(data){
    		    $(".search-result").empty();
    		    $(".search-result").html(data);    		
    		}   
		});
		return false;
	});	
	
	var $divStudyDetailObj = $(".studydetail");
    console.log($divStudyDetailObj);
    $divStudyDetailObj.on("click", function() {
       var studyno = $(this).children("#hidden_no").val();
       location.href = "${contextPath}/studydetail?study_no="+studyno;
       //console.log("studyno")
      /*  $.ajax({
          url : '${contextPath}/studydetail',
          method : 'POST',
          data : 'study_no=' + studyno,
          success : function(data) {
             $(".mainimagesection").hide();
             $("#main-section").empty();
             $("#main-section").html(data);
          }
       }); */
       return false;
    });
});
</script>
</head>
<body>
<div class="container" id="searchapp">
  <form class="search row align-items-center">
    <div class="col-sm">
      <h4 class="handon">지역</h4>
      <select class="custom-select custom-select-lg mb-3 handont" name="area">
        <option value="전체">전체</option>
        <option value="서울 강남">서울 강남</option>
        <option value="서울 신촌">서울 신촌</option>
	    <option value="서울 종로">서울 종로</option>
	    <option value="서울 기타">서울 기타</option>
	    <option value="부산">부산</option>
	    <option value="대구">대구</option>
	    <option value="광주">광주</option>
	    <option value="인천">인천</option>
	    <option value="대전">대전</option>
	    <option value="기타">기타</option>
      </select>
    </div>
    <div class="col-sm">
      <h4 class="handon">스터디 종류</h4>
        <select class="custom-select custom-select-lg mb-3 handont" name="type">
	      <option value="2">전체</option>
	      <option value="1">멘토링 스터디</option>
	      <option value="0">자유 스터디</option>
        </select>
    </div>
    <div class="col-sm-4">
 	  <h4 class="handon">태그 검색</h4>
        <input type ="text" name="tag" class="form-control handont tagsearch" 
          placeholder = "ex) #취업#언어">
    </div>
    <div class="col-sm-3">
      <button class="btnsearch btn btn-primary btn-xl text-uppercase handon">검색하기</button>
    </div>
  </form>
  <br>
  <br>
    <div class="search-result">
      <c:set var="user" value="${sessionScope.loginInfo}"/>
	  <c:set var="status" value="${requestScope.status}"/>
	  <c:if test="${status != 1}">
	    <h6>검색 목록이 없습니다.</h6>
	  </c:if>
	  <c:set var="pb" value="${requestScope.pb}"/>
	  <c:set var="list" value="${pb.list}"/>
	  
	  <div class="row align-items-center">
	  <c:forEach var="study" items="${list}" varStatus="status">
	    <c:if test="${(status.count != 1) && (status.count % 3 == 1)}">
	      <!-- Force next columns to break to new line -->
    	  <div class="w-100"></div>
	    </c:if>
        <div class="col-sm-4" id="searchresultapp">
    	  <div class="studydetail fontthin" style="font-size: 0.9em;">
    	    <input type="hidden" id="hidden_no" value="${study.study_no}">
      	    <img src="images/study/${study.study_no}.png" 
      	      onerror="this.src='images/study/default.png'" alt="study사진" width="600" height="400"/>
 	  	    <div class="searchresult">
 	          <strong class="fontbold" style="font-size: 1.2em;">${study.study_title}</strong><br>
 	          ${study.study_week} 주 | 
 	          <c:if test="${study.study_type == 1}">
 	            <strong class="yellow">${study.study_price} 원 </strong><span> | ${study.member.mem_name} 멘토 </span><br>
	          </c:if>
	          <c:if test="${study.study_type == 0}">
	            <span>자율스터디</span><br>
	          </c:if>
	          <strong class="yellow">${study.study_start} 시작</strong>
	        </div>
          </div>
        </div>
      </c:forEach>
      </div>
    </div>
</div>
</body>