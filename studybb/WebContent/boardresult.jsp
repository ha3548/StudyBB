<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="contextPath.jsp"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="user" value="${sessionScope.loginInfo}"/>

<c:set var="pb" value="${requestScope.pb}"/>
<c:set var="bstatus" value="${requestScope.status}"/>
<c:set var="totalCnt" value="${pb.totalCnt}"/>
<c:set var="cntPerPage" value="${pb.cntPerPage}"/>
<c:set var="list" value="${pb.list}"/>
<c:choose>
  <c:when test="${bstatus != 1}">게시물 목록이 없습니다.</c:when>
  <c:otherwise>
    <c:forEach var="b" items="${list}">
      <!--tweet box-->
      <div class="tweet tweetbox">
        <div class="box tweet">
          <span class="board_no hide" data-no="${b.board_no}">${b.board_no}</span>
          <span class="row_no hide" data-no="${b.board_row}"></span>
          <span class="totalCnt hide" data-no="${totalCnt}"></span>
          <span class="cntPerPage hide" data-no="${cntPerPage}"></span>
          <article class="media">
            <div class="media-left">
              <figure class="image is-64x64">
                <img src="images/profile/${b.mem.mem_id}.png" alt="Profile image" 
                 onerror="this.src='images/profile/default.png'">
              </figure>
            </div>
            <div class="media-content">
              <div class="content">
                <strong class="profileBtn fontbold">@${b.mem.mem_id}</strong>
                <small class="float-right fontthin">
                  <fmt:formatDate value="${b.board_date}" pattern="yyyy-MM-dd hh:mm"/>
                </small>
              </div>
              <div class="control">
                <span class="fontthin">${b.board_content}</span><br><br>
                <a class="hashtag fontthin">${b.board_tag}</a>
                <br><br>
                <a class="level-item likeBtn">
                  <span class="icon is-small"><i class="fas fa-heart"></i></span>
                  <span class="likes fontbold">${b.board_likes}</span>
                </a>&nbsp;&nbsp;
                <a class="level-item commentBtn">
                   <span class="text is-small fontthin">댓글 수</span>
                   <span id="commentNum" class="fontthin">${b.board_comments}</span>
                </a>
                <c:if test="${b.mem.mem_id == user}">
                  <small class="float-right deleteBtn fontthin">삭제</small>
                </c:if>
              </div>
            </div>
          </article>
        </div>
        <!--comment box-->
        <div class="box comment hide">
          <table class="table is-narrow commentbox">
            <colgroup>
              <col width="100">
              <col>
              <col width="80">
            </colgroup>
            <tbody class="comment align"></tbody>
            <c:if test="${sessionScope.loginInfo != null}">
            <tfoot>
              <tr><!-- front back 버튼 --></tr>
              <tr>
                <td><strong class="fontthin">${user}</strong></td>
                <td><input class="input is-small fontthin" type="text" placeholder="댓글 작성" style="width:100%"/></td>
                <td><button class="button is-warning is-small fontthin" style="width:100%">등록</button></td>
              </tr>
            </tfoot>
            </c:if>
          </table>
        </div>
      </div>
    </c:forEach>
  </c:otherwise>
</c:choose>