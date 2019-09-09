<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="contextPath.jsp"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="user" value="${sessionScope.loginInfo}"/>
<c:set var="status" value="${requestScope.status}"/>
<c:choose>
  <c:when test="${status == -1}">
    <tr><td colspan="3"><small class="">댓글이 아직 없습니다.</small></td></tr>
  </c:when>
  <c:otherwise>
    <c:set var="pb" value="${requestScope.pb}"/>
    <c:set var="list" value="${pb.list}"/>
    <c:set var="currentPage" value="${pb.currentPage}"/>
    <c:set var="cntPerPage" value="${pb.cntPerPage}"/>
    <c:set var="totalCnt" value="${pb.totalCnt}"/>
    <c:set var="maxPage" value="${pb.maxPage}"/>

    <ul class="commentData hide">
      <li class="currentPage">${currentPage}</li>
      <li class="cntPerPage">${cntPerPage}</li>
      <li class="totalCnt">${totalCnt}</li>
      <li class="maxPage">${maxPage}</li>
    </ul>
    <c:forEach var="b" items="${list}">
      <tr>
        <td>
          <strong class="profileBtn fontthin">${b.mem.mem_id}</strong>
        </td>
        <td class="left"><small class="fontthin" style="color: black;">${b.board_content}</small></td>
        <!-- td class="deleteBtn">
          <c:if test="${b.mem.mem_id == user}">
            <small class="float-right fontbold gray">X</small>
          </c:if>
        </td-->
        <td>
          <small class="level-right fontthin verysmall gray">
            <fmt:formatDate value="${b.board_date}" pattern="MM/dd hh:mm"/>
          </small>
        </td>
      </tr>
    </c:forEach>
  </c:otherwise>
</c:choose>