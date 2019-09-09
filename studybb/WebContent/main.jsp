<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="contextPath.jsp"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<head>
<title>스터디 봉봉! 너만을 위한 스터디</title>
<style>
/* 수정! 메인 사진 슬라이드 */
ul.dot{
  padding-left: 0px;
}
 .slideimage{
        position: relative;  
                                                                
        height: 100vh;
        background-size: cover;
    }

.slideimage .imagetitle{
         position: absolute;
         top:50%;
         left:50%;
         transform: translate(-50%, -50%);                                                                   
         font-size:5rem;
         color: white;
         z-index: 2;
         text-align: center;
}
.mainimagesection {
  margin: 0;
  padding: 0px;
}

.panel{
padding-inline-start: 0px;
background-attachment: fixed;
}

.slide>ul,
.slide>ol,
.slide>li {
  list-style: none;
}

a {
  text-decoration: none;
}

img {
  vertical-align: top;
  border: none;
}

.slide {
  position: relative;
  overflow: hidden;
}

.panel {
  width: 400%;
}

.panel:after {
  content: "";
  display: block;
  clear: both;
}

.panel>li {
  width: 25%;
  height: 500px;
  float: left;
  background-repeat: no-repeat;
  background-size: 100% 100%;
  position: relative;
}

.mainimage {
 width:100%;
 height: 500px;

}

.panel>li:nth-of-type(3) {
  background-color: green;
}

.dot:after {
  content: "";
  display: block;
  clear: both;
}

.dot {
  position: absolute;
  left: 50%;
  bottom: 10%;
  transform: translateX(-50%);
}

.dot>li {
  float: left;
  width: 15px;
  height: 15px;
  border-radius: 50%;
  background-color: #666666;
  border:3px solid #ffffff;
  margin-left: 10px;
  margin-right: 10px;
  text-indent: -9999px;
  cursor: pointer;
  
}

.dot>li.on {
  background-color: #ffffff;
}

.prev {
  position: absolute;
  width: 50px;
  height: 50px;
  background-color: transparent;
  top: 50%;
  transform: translateY(-50%);
  left: 8%;
  cursor: pointer;
}

.next {
  position: absolute;
  width: 50px;
  height: 50px;
  background-color: transparent;
  top: 50%;
  transform: translateY(-50%);
  right: 8%;
  cursor: pointer;
}
/*수정 메인 슬라이드 끝*/
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
$(function(){
	slide();
	
	$.ajax({
		url: '${contextPath}/studylist',
		method:'get',
		success: function(data){
			$("#main-section").empty();
			$("#main-section").html(data);
		}
	});
});
//수정! 슬라이드  
function slide() {
  var wid = 0;
  var now_num = 0;
  var slide_length = 0;
  var auto = null;
  var $dotli = $('.dot>li');
  var $panel = $('.panel');
  var $panelLi = $panel.children('li');

  // 변수 초기화
  function init() {
    wid = $('.slide').width();
    now_num = $('.dot>li.on').index();
    slide_length = $dotli.length;
  }

  // 이벤트 묶음
  function slideEvent() {

    // 슬라이드 하단 dot버튼 클릭했을때
    $dotli.click(function() {
      now_num = $(this).index();
      slideMove();
    });

    // 이후 버튼 클릭했을때
    $('.next').click(function() {
      nextChkPlay();
    });

    // 이전 버튼 클릭했을때
    $('.prev').click(function() {
      prevChkPlay();
    });

    // 오토플레이
    autoPlay();

    // 오토플레이 멈춤
    autoPlayStop();

    // 오토플레이 재시작
    autoPlayRestart();

    // 화면크기 재설정 되었을때
    resize();
  }

  // 자동실행 함수
  function autoPlay() {
    auto = setInterval(function() {
      nextChkPlay();
    }, 3000);
  }

  // 자동실행 멈춤
  function autoPlayStop() {
    $panelLi.mouseenter(function() {
      clearInterval(auto);
    });
  }


  // 자동실행 멈췄다가 재실행
  function autoPlayRestart() {
    $panelLi.mouseleave(function() {
      auto = setInterval(function() {
        nextChkPlay();
      }, 2500);
    });
  }

  // 이전 버튼 클릭시 조건 검사후 슬라이드 무브
  function prevChkPlay() {
    if (now_num == 0) {
      now_num = slide_length - 1;
    } else {
      now_num--;
    }
    slideMove();
  }

  // 이후 버튼 클릭시 조건 검사후 슬라이드 무브
  function nextChkPlay() {
    if (now_num == slide_length - 1) {
      now_num = 0;
    } else {
      now_num++;
    }
    slideMove();
  }

  // 슬라이드 무브
  function slideMove() {
    $panel.stop().animate({
      'margin-left': -wid * now_num
    });
    $dotli.removeClass('on');
    $dotli.eq(now_num).addClass('on');
  }

  // 화면크기 조정시 화면 재설정
  function resize() {
    $(window).resize(function() {
      init();
      $panel.css({
        'margin-left': -wid * now_num
      });
    });
  }
  init();
  slideEvent();
}
</script>
</head>
<html style="overflow-y:scroll;">
<body id="main">
  <jsp:include page="menu.jsp"/>
  <!-- Services -->
  <section class="mainimagesection">
	<!-- 여기부터수정 -->
	<div class="slide">
	  <ul class="panel">
		<li><img class="mainimage" src="./images/header/header1.png" /></li>
		<li><img class="mainimage" src="./images/header/header2.png" /></li>
		<li><img class="mainimage" src="./images/header/header3.png" /></li>
      </ul>
	  <ul class="dot">
		<li class="on">슬라이드 1번</li>
		<li>슬라이드2번</li>
		<li>슬라이드3번</li>
	  </ul>
	  <div class="prev">
		<i class="fas fa-angle-double-left fa-4x" style="color: white"></i>
	  </div>
	  <div class="next">
		<i class="fas fa-angle-double-right fa-4x" style="color: white"></i>
	  </div>
	</div>
  </section>
  <!-- 여기까지 -->
  <section class="container" id="main-section"></section>
  <jsp:include page="footer.jsp"/>
</body>
</html>
