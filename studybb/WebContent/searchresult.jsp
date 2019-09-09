<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="contextPath.jsp"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="user" value="JHJ"/>
<c:set var="username" value="전혜진"/>
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