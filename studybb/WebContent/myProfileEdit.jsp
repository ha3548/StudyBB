<%@ page import="com.studybb.vo.Member"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myProfileEdit.jsp</title>
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
var loadMyProfile = function(data){
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
	$("#area option").each(function() {
        if($(this).text()=='${requestScope.member.mem_area}'){
            $(this).prop('selected', true);
        }
    }); //end each
	
	/*수정완료 버튼*/
	$("form").submit(function(){
		var url = '${contextPath}/myprofile';
		
		$.ajax({
			url: '${contextPath}/myprofileedit',
			method: 'POST',
			data: $(this).serialize(),
			success:function(data){
				console.log(data);
				var jsonObj = JSON.parse(data);
				if(jsonObj.status == 1){
					alert("프로필이 수정되었습니다.");
					//loadMenu(url, loadMyProfile);
					//location.href="${contextPath}/myPage.jsp";
				} else {
					alert("프로필을 수정하려면 로그인하십시오.");
				}
				loadMenu(url, loadMyProfile);
			}
		});
		return false;
	});
});
</script>
</head>
<body>
<c:set var="m" value="${requestScope.member}"></c:set>
<form>
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
                           	<td>
                           	<input type="radio" name="gender" value="여성">여성&nbsp;&nbsp;
							<input type="radio" name="gender" value="남성">남성&nbsp;&nbsp;
							<input type="radio" name="gender" value="" checked>선택안함
							</td>
                     </tr>
                     <tr role="row">
                        <th tabindex="0" aria-controls="dataTable"
                           rowspan="1" colspan="1"
                           style="width: 15%;">관심분야</th>
                           <td><input type="text" name="interest" value="${m.mem_interest}"></td>
                     </tr>
                     <tr role="row">
                        <th tabindex="0" aria-controls="dataTable"
                           rowspan="1" colspan="1"
                           style="width: 15%;">전공</th>
                           <td><input type="text" name="major" value="${m.mem_major}"></td>
                     </tr>
                     <tr role="row">
                        <th tabindex="0" aria-controls="dataTable"
                           rowspan="1" colspan="1"
                           style="width: 15%;">지역</th>
                           <td>
                             <select id="area" name="area" style="margin-top: 12px;">
						        <option value="">지역</option>
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
                           </td>
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
   <button type="submit" class="btn btn-primary btn-xl text-uppercase js-scroll-trigger">수정완료</button>
</form>
</body>
</html>