<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>승인관리 페이지</title>
<link rel="stylesheet"
	href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/css/sb-admin-2.min.css">
<script
	src="https://cdn.studysearch.co.kr/static/jquery/jquery-1.11.3.min.895323ed2f72.js"></script>
<script>
	$(function() {
		var status = ${requestScope.status};
		if (status == -1) {
			alert("신청사항이 없습니다.");
			window.close();
		}
		var btApv = $(".btnApv"); //가입 승인, 거절 버튼
		btApv.click(function() {
			var approval = 0;
			var no = $(this).parent().siblings().eq(0).html(); //스터디 번호
			var id = $(this).parent().siblings().eq(1).html(); //신청자 id
			if ($(this).html() == '승인')//승인
			{
				approval = 1;
			} else {//거절
				approval = 2;
			}
			$.ajax({
				url : "${contextPath}/editenrol",
				method : 'post',
				data : 'study_no=' + no + '&mem_id=' + id + '&approval='
						+ approval, //study_no, mem_id, approval 보냄
				success : function(data) {
					if (data >= 1) { //승인 성공
						alert("성공적으로 처리 되었습니다.");
						if (data == 2) { //승인 성공, 스터디 마감
							alert("스터디 인원이 다 찼으므로 스터디가 마감되었습니다.");
						}
					} else if(data == 0){
						alert("이미 마감된 스터디 입니다.");
					}
					else{
						alert("처리에 실패하였습니다.");
					}
					location.reload();
					$("#btn_manageEnrol").trigger("click");
				}
			});//end ajax 
			return false;
		});//end click 
	});
</script>
</head>
<body>
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">가입신청 내역</h6>
		</div>
		<div class="card-body">
			<div class="table-responsive">
				<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
					<table class="table table-bordered dataTable" id="dataTable"
						width="100%" cellspacing="0" role="grid"
						aria-describedby="dataTable_info" style="width: 100%;">
						<c:forEach var="l" items="${requestScope.list}">
							<tr role="row" class="odd">
								<td>${l.study.study_no}</td>
								<td>${l.member.mem_id}</td>
								<td>${l.enrol_say}</td>
								<td><c:choose>
										<c:when test="${l.enrol_status==0}">
											<button class=btnApv>승인</button>
											<button class=btnApv>거절</button>
										</c:when>
										<c:when test="${l.enrol_status==1}">승인완료</c:when>
										<c:otherwise>거절</c:otherwise>
									</c:choose></td>
								<td>${l.enrol_date}</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>