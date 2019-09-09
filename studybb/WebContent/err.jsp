<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page isErrorPage="true" %><%--에러전용페이지임을 나타냄 --%>
<%-- Exception e = (Exception)request.getAttribute("exception"); --%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>
<%--=e.getMessage() --%> 
<%=exception.getMessage() %>
</h1>
</body>
</html>