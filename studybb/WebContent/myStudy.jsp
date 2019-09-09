<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 스터디</title>
</head>
<body>
<c:set var="myList" value="${requestScope.myList}"/>
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">내 스터디</h6>
		</div>
		<div class="card-body">
			<div class="table-responsive">
				<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
					<table class="table table-bordered dataTable" id="dataTable"
						width="100%" cellspacing="0" role="grid"
						aria-describedby="dataTable_info" style="width: 100%;">
						<thead>
							<tr role="row">
								<th class="sorting" tabindex="0" aria-controls="dataTable"
									rowspan="1" colspan="1"
									aria-label="Position: activate to sort column ascending"
									style="width: 50%;">스터디 제목</th>
								<th class="sorting_asc" tabindex="0" aria-controls="dataTable"
									rowspan="1" colspan="1"
									aria-label="Name: activate to sort column descending"
									aria-sort="ascending" style="width: 25%;">리더 이름</th>
								<th class="sorting" tabindex="0" aria-controls="dataTable"
									rowspan="1" colspan="1"
									aria-label="Office: activate to sort column ascending"
									style="width: 25%;">수강 상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="myenrol" items="${myList}">
								<tr role="row" class="odd">
									<td class="sorting_1">${myenrol.study.study_title}</td>
									<td>${myenrol.study.member.mem_id}</td>
									<c:choose>
										<c:when test="${myenrol.enrol_status==0}"><td>대기중</td></c:when>
										<c:when test="${myenrol.enrol_status==1}"><td>승인</td></c:when>
										<c:otherwise><td>거절</td></c:otherwise>
									</c:choose>	
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

</body>
</html>