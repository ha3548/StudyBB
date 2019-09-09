<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="contextPath.jsp"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.7.5/css/bulma.min.css">
<title>희망 스터디 게시판</title>
<style>
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
a:not([href]):not([tabindex]):not(.button){
  color: #007bff;
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
#boardapp>div.column{
  /*transform:scale(1.1);*/
}
#boardapp .hide{
  display:none;
}
#main-section {
  /*overflow: auto;*/
  height:auto;
  
}
#boardapp html, body {
  background: #fff9e6 !important;
}
#boardapp {
  -webkit-font-smoothing: antialiased;
  padding-top: 0p;
  margin-top: 10px;
  margin-bottom: 30px;
  text-align: center;
  height:auto;
  min-height:500px;
}
#boardapp .tweet {
  max-width: 500px;
  margin: 0 auto;
  padding-bottom: 15px;
}
#boardapp .box {
  margin-bottom: 0;
  border-radius: 0;
  cursor: default;
}
#boardapp .content small {
  color: #febf01;
}
#boardapp img {
  border-radius: 30px;
}
#boardapp .level-item {
  padding-left: 10px;
  color: #febf01;
}
#boardapp input:focus {
  border-color: #febf01;  
}
#boardapp .likes {
  padding: 0 7.5px;
}
#boardapp input {
  font-weight: bold;
}
#boardapp .tweets-move {
  transition: transform 1s;
}
#boardapp .media-content textarea{
  min-height: 90px;
}
#boardapp .level-item {
  display: inline;
  padding-left: 0px;
}
#boardapp .media-left {
  cursor: pointer;
}
#boardapp .profileBtn, .deleteBtn {
  cursor: pointer;
}
#boardapp .float-right {
  float: right;
  color: gray;
}
#boardapp div.tweetlist div.media-content p.level small.level-right.float-right{
  float: right;
  color: gray;
}
#boardapp .inputbox .control input{
  border: none;
  color: #3273dc;
  box-shadow: none;
}
#boardapp .tweet.tweetbox {
  padding-bottom: 0px;
}
#boardapp .commentbox.is-narrow{
  width: 100%;
  border: #000000
}
#boardapp .commentbox tr td:not(.left){
  text-align: center !important;
}
#boardapp .commentbox td{
  vertical-align: middle;
  font-size: 15px;
  padding-top: 10px;
  padding-bottom: 10px;
}
#boardapp .gray{
  color: #d9d9d9;
}
#boardapp .verysmall{
  font-size: 10px;
}
#boardapp .yellow{
  color: #febf01;
}
#boardapp .searchbox p.control{
  margin-bottom: 0px;
}
#boardapp .searchbox div.content{
  margin-bottom: 0px;
}
#boardapp .searchbox .message2{
  width: 100%;
}
#logo{
  margin-left: 0px;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
var isEnd = false;
$(function(){
   // 새로고침 시 스크롤 가장 위로
   $(window.parent).scrollTop(0);
   
   $.ajax({
      url: "${contextPath}/boardlist",
      method: "get",
      success: function(data){
         $(".tweetlist").empty();
         $(".tweetlist").html(data);
      }
   });
   /*
   // 스크롤 다운 -> 데이터 로드
   $(window).scroll(function(){
      console.log($(window).scrollTop()+" / " + $(window).height() + " / " + $(document).height());
      // scrollbar의 thumb가 바닥에 도달 하면 리스트를 가져온다.
      if($(window).scrollTop() + $(window).height() == $(document).height()){
           // 로딩 + scroll disabled
           console.log("스크롤");
         fetchList();
        }
    });
   
   var scrollHeight = $(document).height();
   var scrollPosition = $(window).height() + $(window).scrollTop();
   if ((scrollHeight - scrollPosition) / scrollHeight === 0) {
      console.log("fetch!")
      fetchList();
    }*/

    $("#loadboard").click(function(){
       fetchList();
    });
    
   var mem_id = "${sessionScope.loginInfo}";
   var $dropdownBtnObj = $("a.dropdown-item");
   var $searchBtnObj = $(".searchbox p.searchBtn");
   var $submitBtnObj = $(".tweet.inputbox a[type='submit']");
   // 게시글 등록 버튼 클릭 리스너
   $submitBtnObj.click(function(){
      var $contentObj = $(".inputbox .control textarea");
      var $tagObj = $(".inputbox .control input");
      console.log($contentObj.val() + "   " + $tagObj.val());
      
      $.ajax({
         url: "${contextPath}/boardwrite",
         method: "post",
         data: "mem_id=" + mem_id
            + "&board_content=" + $contentObj.val()
            + "&board_tag=" + $tagObj.val(),
         success: function(data){
            var jsonObj = JSON.parse(data);
            if(jsonObj.status == 1){
               // notify
               // reload
               location.reload();
            } else {
               alert("게시글 작성에 실패하였습니다.");
            }            
         }
      });
      return false;
   });
   
   // 최신순/좋아요 클릭 리스너 *수정 필요 -> 검색 결과에 대해서도 정렬
   $dropdownBtnObj.click(function(){
      var type = $("span.sortingType");
      var inputData = $(".searchbox strong.searchkeyword").html();
      // 현재 정렬기준과 같을 경우 아무것도 안함
      //console.log(type.html() + "=?" + $(this).html());
      if(type.html() == $(this).html()){
         return false;
      } else {
         // 현재 정렬기준과 다를 경우 tweetlist 비우고 새 정렬기준 리스트 가져오기
         // type html변경
         type.html($(this).html());
         type.removeData("no");
         type.data("no", $(this).data("no"));
         //console.log($(this).data("no"));
         $.ajax({
            url: "${contextPath}/boardlist",
            method: "post",
            data: "no=1"
                + "&input=" + inputData
                 + "&type=" + $(this).data("no"),
            success: function(data){
               // 기존 게시글 리스트를 비우고 
               $(".tweetlist").empty();
               // 새 정렬기준 데이터로 대체
               $(".tweetlist").html(data);
               //var totalHeight = $(document).height();
               //$("html").height(totalHeight);
            }
         });
      }
      return false;
   });
   
   // 좋아요 버튼 클릭 리스너
   $(".tweetlist").on("click", ".tweetbox .likeBtn", function(){
      if(${sessionScope.loginInfo == null}){
         // 로그아웃 상태일 시 
         alert("좋아요 기능은 로그인 이후 사용하실 수 있습니다.");
         return false;
      }
      // 좋아요 개수 가져오기
      var likeCnt = $(this).children(".likes").html();
      console.log(likeCnt);
      // board 번호 가져오기
      var board_no = $(this).parents(".box.tweet").find(".board_no").html();
      console.log(board_no);
      
      // 좋아요 servlet 이동
      $.ajax({
         url: "${contextPath}/boardlike",
         method: "post",
         data: "mem_id=" + mem_id
            + "&board_no=" + board_no,
         context: this,
         success: function(data){
            likeCnt = Number(likeCnt);
            console.log(likeCnt + 1);
            var jsonObj = JSON.parse(data);
            if(jsonObj.status == 1){
               // 좋아요 수 변경
               $(this).children(".likes").html(likeCnt + 1);
            } else {
               // 좋아요 실패 (+이미 좋아요한 경우)
               console.log("이미 좋아요한 게시글");
               // 툴팁 추가
               $(this).attr("title", "이미 좋아요한 게시글입니다.");
            }
         }
      });
      return false;
   });

   // 댓글버튼 클릭리스너
   $(".tweetlist").on("click", ".tweetbox .commentBtn", function(){
      // 해당 게시글의 번호와 commentbox요소 가져오기
      var board_no = $(this).parents(".box.tweet").find(".board_no").html();
      var $commentbox = $(this).parents(".box.tweet").siblings(".box.comment");
      
      if($commentbox.css("display") == "none") {
         // 댓글 로딩 + disable
         // 댓글 servlet 이동
         $.ajax({
            url: "${contextPath}/boardcomment",
            method: "post",
            data: "board_no=" + board_no,
            context: this,
            success: function(data){
               $commentbox.find(".comment").empty();
               $commentbox.find(".comment").html(data);
            }
         });
         // 로딩 없애고 toggle 구문으로 넘어가기
      }      
      // 댓글 닫고 열기
      $commentbox.slideToggle();
      
      return false;
   });
   
   // 댓글등록버튼 클릭리스너
   $(".tweetlist").on("click", "table tfoot tr:last-child button", function(){
      // 0자 일경우 전송 버튼 disable
      // 댓글 정보 불러오기
      var $contentObj = $(this).parent().siblings().children("input");
      var $parentNoObj = $(this).parents(".box.comment").siblings(".box.tweet").find(".board_no");
      if($contentObj.val() == ""){
         return false;
      }
      // boardwrite ajax 요청
      $.ajax({
         url: "${contextPath}/boardwrite",
         method: "post",
         data: "mem_id=" + mem_id
            + "&board_content=" + $contentObj.val()
            + "&parent_no=" + $parentNoObj.html(),
         context: this,
         success: function(data){
            // input 지우기
            $contentObj.val("");
            // 댓글 목록 다시 불러오기
            $(this).parents("tfoot").siblings("tbody").empty();
            $(this).parents("tfoot").siblings("tbody").html(data);
            // 댓글 수 늘리기
            var $commentNum = $(this).parents(".box.comment").siblings(".box.tweet").find("#commentNum");
            var commentNum = $commentNum.html();
            commentNum *= 1;
            commentNum += 1;
            $commentNum.html(commentNum);
         }
      });
      return false;
   });   
   
   // 삭제 버튼 클릭 리스너
   $(".tweetlist").on("click", ".box.tweet .deleteBtn", function(){
      // board 번호 가져오기
      var board_no = $(this).parents(".box.tweet").find(".board_no").html();
      $.ajax({
         url: "${contextPath}/boarddelete",
         method: "post",
         data: "board_no=" + board_no,
         success: function(data){
            var jsonObj = JSON.parse(data);
            if(jsonObj.status == 1){
               // notify
               alert("게시글이 삭제되었습니다.");
               // reload
               location.reload();
            } else {
               alert("게시글 삭제에 실패하였습니다.");
            }      
         }
      });
      return false;
   });
   
   // 댓글 삭제 클릭 리스너
   $(".tweetlist").on("click", ".box.comment .deleteBtn", function(){
      // board 번호 가져오기
      var board_no = $(this).parents(".box.comment").siblings(".box.tweet").find(".board_no").html();
      console.log("삭제 버튼 클릭 " +board_no);
      $.ajax({
         url: "${contextPath}/boarddelete",
         method: "post",
         data: "board_no=" + board_no,
         context: this,
         success: function(data){
            var jsonObj = JSON.parse(data);
            console.log(jsonObj);
            if(jsonObj.status == 1){
               // notify
               alert("댓글이 삭제되었습니다.");
               // 삭제된 댓글 안보이게 하기
               $(this).parent().hide();
               // 댓글 수 줄이기
               var $commentNum = $(this).parents(".box.comment").siblings(".box.tweet").find("#commentNum");
               var commentNum = $commentNum.html();
               commentNum *= 1;
               if(commentNum != 0)
                  commentNum -= 1;
               $commentNum.html(commentNum);
            } else {
               alert("댓글 삭제에 실패하였습니다.");
            }      
         }
      });
      return false;
   });
   
   // 검색 클릭 리스너
   $searchBtnObj.click(function(){
      var $inputObj = $(".searchbox p input");
      var $inputDataObj = $(".searchbox strong.searchkeyword");
      var startNo = $("span.row_no.hide").last().data("no");
      var sortingType = $("span.sortingType").data("no");
      var $messageObj = $(".searchbox .message2");
      console.log($inputObj.val());
      
      // message 출력 여부 결정
      if($inputObj.val() == ""){
         $messageObj.hide();
      } else {
         $messageObj.show();
      }
      
      // input 값 저장
      $inputDataObj.html($inputObj.val());
      
      // input된 검색어에 대한 검색 결과 출력
      $.ajax({
         url: "${contextPath}/boardlist",
         method: "post",
         data: "input=" + $inputDataObj.html()
              + "&type=" + $("span.sortingType").html(),
         success: function(data){
            // 기존 게시글 리스트를 비우고 
            $(".tweetlist").empty();
            // 새 정렬기준 데이터로 대체
            $(".tweetlist").html(data);
            // input창 비우기
            $inputObj.val("");

            var totalHeight = $(document).height();
            $("html").height(totalHeight);
         }
      });
      return false;
   });
   // 태그 검색 클릭 리스너
});
// 다음 게시글 불러오는 함수
var fetchList = function(){
   // 게시글 리스트를 가져올 때 시작 게시글 번호/총 게시글 수/한번에 가져올 게시글 수를 가져온다
    // ajax에서는 data- 속성의 값을 가져오기 위해 data() 함수를 제공.
    console.log("fetch?");
    var startNo = $("span.row_no.hide").last().data("no");
    var totalCnt = $(".totalCnt.hide").data("no");
    var cntPerPage = $(".cntPerPage.hide").data("no");
    startNo *= 1; startNo += 1;   // number형으로 변환 후 +1
    console.log(startNo + " " + totalCnt + " " + cntPerPage);
    
    // 더이상 가져올 게시글이 없을 시 바로 리턴
    if(isEnd == true || startNo > totalCnt){
      console.log("true");
        return;
    }

    // 현재 정렬 기준을 가져온다
   var sortingType = $("span.sortingType").data("no");
   var inputData = $(".searchbox strong.searchkeyword").html();
   console.log(sortingType + " " + inputData);
    // 시작 번호 + 한페이지에 표시할 항목 수가 마지막 rownum보다 작을때, 무한 스크롤 종료
    $.ajax({
        url:"${contextPath}/boardlist",
        type: "post",
        data: "no=" + startNo
           + "&input=" + inputData
           + "&type=" + sortingType,
        success: function(data){
         // 다음페이지 리스트를 기존 tweetbox 마지막에 append
         $(".tweetbox:last").after(data);
         var totalHeight = $(document).height();
         $("html").height(totalHeight);
        }
    });
}
</script>
</head>
<body>
<jsp:include page="menu.jsp"/>
<section class="boardapp">
<div id="boardapp" class="columns">
  <%--c:set초기화 변수->다른 페이지랑 통합시 수정 필--%>
  <c:set var="user" value="${sessionScope.loginInfo}"/>
  <%--                                --%>
    <div class="column">
    <%-- 로그인 안되어 있을 경우에는 출력하지 않는다. --%>
      <!--input box-->
      <div class="tweet inputbox">
        <c:choose>
          <c:when test="${sessionScope.loginInfo == null}">
            <div class="box">게시판은 로그인한 사용자만 작성 가능합니다.</div>
          </c:when>
          <c:otherwise>
            <div class="box">
              <article class="media">
                <div class="media-left">
                  <figure class="image is-64x64">
                    <img src="images/profile/${user}.png" alt="Profile Image" onerror="this.src='images/profile/default.png'">
                  </figure>
                </div>
                <div class="media-content">
                  <div class="content">
                    <strong class="fontbold">@${user}</strong>
                    <div class="control">
                      <textarea class="textarea is-warning fontthin" placeholder="원하는 스터디를 요청해보세요!"></textarea>
                      <input class="input is-small fontthin" type="text" placeholder="#해시태그">
                    </div>
                  </div>
                </div>
              <div class="media-right">
                <a class="button is-warning is-rounded fontthin" type="submit">등록</a>
              </div>
            </article>
          </div>
        </c:otherwise>
      </c:choose>
    </div>

    <!-- search box -->
    <div class="tweet searchbox">
      <div class="box">
        <article class="media">
          <div class="media-content">
            <div class="content">
              <div class="field has-addons">
                <p class="control">
                  <input class="input fontthin" type="text" placeholder="키워드 검색">
                </p>
                <p class="control searchBtn">
                  <button class="button fontthin">검색</button>
                </p>
              </div>
            </div>
            <div class="control message2 hide">
              <strong class="yellow fontbold">'</strong>
              <strong class="yellow fontbold searchkeyword"></strong>
              <strong class="yellow fontbold">' 에 대한 검색 결과입니다.</strong>
            </div>
          </div>
          <div class="dropdown is-right is-hoverable media-right">
            <div class="dropdown-trigger">
              <button class="button" aria-haspopup="true" aria-controls="dropdown-menu4">
                <span class="sortingType fontthin" data-no="recent">최신순</span>
                <span class="icon is-small">
                  <i class="fas fa-angle-down" aria-hidden="true"></i>
                </span>
              </button>
            </div>
            <div class="dropdown-menu" id="dropdown-menu4" role="menu">
              <div class="dropdown-content">
                <div class="dropdown-item">
                  <a href="" class="dropdown-item fontthin" data-no="recent">최신순</a>
                  <a href="" class="dropdown-item fontthin" data-no="likes">좋아요순</a>
                </div>
              </div>
            </div>
          </div>
        </article>
      </div>
    </div>
    
    <!-- tweet list -->
    <div class="tweetlist"></div>
    <br><br>
    <button class="button is-warning is-rounded fontthin" id="loadboard">더보기..</button>
  </div>
</div>
</section>
<jsp:include page="footer.jsp"/>
</body>