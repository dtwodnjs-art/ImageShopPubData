<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Image Shop</title>
	<link rel="stylesheet" href="/css/codegroup/modify.css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<jsp:include page="/WEB-INF/views/common/menu.jsp" />
	<div align="center">
		<h2>
			<spring:message code="codegroup.header.modify" />
		</h2>
		<form:form modelAttribute="codeGroup" action="/codegroup/modify" method="post">
			<table>
				<tr>
					<!--   
					<td><label for="groupCode">코드그룹</label> </td>
					<td><input type="text" name="groupCode" id="groupCode"/></td>
					-->
					<td><spring:message code="codegroup.groupCode" /></td>
					<td><form:input path="groupCode"  readonly="true"/></td>
					<td><font color="red"><form:errors path="groupCode" /></font></td>
				</tr>
				<tr>
					<td><spring:message code="codegroup.groupName" /></td>
					<td><form:input path="groupName" /></td>
					<td><font color="red"><form:errors path="groupName" /></font></td>
				</tr>
			</table>
		</form:form>

		<div>
			<button type="submit" id="btnModify">
				<spring:message code="action.modify" />
			</button>
			<button type="submit" id="btnList">
				<spring:message code="action.list" />
			</button>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
		<!-- $(document).ready(function() : html 코드가 document로 객체가 완료 -->
		$(document).ready(function() {
			<!-- form 객체찾기  -->
			let formObj = $("#codeGroup");
			<!-- $("#btnRegister").on("click", function() : 등록버튼을 클릭할때 작동하는 핸들러정의 -->
			$("#btnModify").on("click", function() {
				formObj.submit(); 
			});
			$("#btnList").on("click", function() {
				<!-- 서버에 페이지요청  http://localhost:8080/codegroup/list -->
				self.location = "/codegroup/list";
			});
		});
	</script>
</body>
</html>