<%@ page import="com.studybb.vo.Member"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myProfile.jsp</title>
<style>
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}
th, td {
  padding: 15px;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
var loadMyProfileEdit = function(data){
	   $("#content").empty();
	   $("#content").html(data);
};
var loadMenu = function(u, callback){
	   $.ajax({
	      url: u,
	      method: 'GET',
	      success: function(data){
	         console.log("OK",data);
	         callback(data);
	      }
	   });
}
$(function(){
	   var $btnObj = $("button");
	   $btnObj.click(function(event){
		   	var url = '${contextPath}/myprofileeditshow';
		   	loadMenu(url, loadMyProfileEdit);
	      	return false; //기본이벤트핸들러 막기, 이벤트전달 중지 
	   });
});
</script>
</head>
<body>
<c:set var="m" value="${requestScope.member}"></c:set>

 <div class="card shadow mb-4 w-60">
      <div class="card-header py-3">
         <h6 class="m-0 font-weight-bold text-primary">내 프로필</h6>
      </div>
      <div class="card-body">
         <div class="table-responsive">
            <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
               <table class="table table-bordered dataTable" id="dataTable" 
                  width="100%" cellspacing="0" role="grid"
                  aria-describedby="dataTable_info" style="width: 100%;">
                     <tr role="row">
                        <th tabindex="0" aria-controls="dataTable"
                           rowspan="1" colspan="1"
                           style="width: 15%;">이름</th>
                           <td>${m.mem_name}</td>
                     </tr>
                     <tr role="row">
                        <th tabindex="0" aria-controls="dataTable"
                           rowspan="1" colspan="1"
                           style="width: 15%;">아이디</th>
                           <td>${m.mem_id}</td>
                     </tr>
                     <tr role="row">
                        <th tabindex="0" aria-controls="dataTable"
                           rowspan="1" colspan="1"
                           style="width: 15%;">이메일</th>
                           <td>${m.mem_email}</td>
                     </tr>
                     <tr role="row">
                        <th tabindex="0" aria-controls="dataTable"
                           rowspan="1" colspan="1"
                           style="width: 15%;">성별</th>
                           <td>${m.mem_gender}</td>
                     </tr>
                     <tr role="row">
                        <th tabindex="0" aria-controls="dataTable"
                           rowspan="1" colspan="1"
                           style="width: 15%;">관심분야</th>
                           <td>${m.mem_interest}</td>
                     </tr>
                     <tr role="row">
                        <th tabindex="0" aria-controls="dataTable"
                           rowspan="1" colspan="1"
                           style="width: 15%;">전공</th>
                           <td>${m.mem_major}</td>
                     </tr>
                     <tr role="row">
                        <th tabindex="0" aria-controls="dataTable"
                           rowspan="1" colspan="1"
                           style="width: 15%;">지역</th>
                           <td>${m.mem_area}</td>
                     </tr>
                     
                   <c:if test="${m.mentor_career != null}">
                     <tr role="row">
                        <th tabindex="0" aria-controls="dataTable"
                           rowspan="1" colspan="1"
                           style="width: 15%;">멘토이력</th>
                           <td>${m.mentor_career}</td>
                     </tr>
				   </c:if>
               </table>
            </div>
         </div>
      </div>
   </div>
   <button class="btn btn-primary btn-xl text-uppercase js-scroll-trigger">수정하기</button>

</body>
</html>