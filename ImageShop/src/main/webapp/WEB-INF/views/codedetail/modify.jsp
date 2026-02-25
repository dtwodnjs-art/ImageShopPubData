<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Image Shop</title>
<link rel="stylesheet" href="/css/codedetail/modify.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<jsp:include page="/WEB-INF/views/common/menu.jsp" />
	<div align="center">
		<h2>
			<spring:message code="codegroup.header.read" />
		</h2>
		<form:form modelAttribute="codeDetail">
			<form:hidden path="groupCode"/>
			<form:hidden path="codeValue"/>
			<table>
				<tr>
					<td><spring:message code="codedetail.groupCode" /></td>
					<td><form:select path="groupCode" items="${groupCodeList}"
							itemValue="value" itemLabel="label" disabled="true" /></td>
					<td><font color="red"><form:errors path="groupCode" /></font></td>
				</tr>
				<tr>
					<td><spring:message code="codedetail.codeValue" /></td>
					<td><form:input path="codeValue" readonly="true" disabled="true" /></td>
					<td><font color="red"><form:errors path="codeValue" /></font></td>
				</tr>
				<tr>
					<td><spring:message code="codedetail.codeName" /></td>
					<td><form:input path="codeName" /></td>
					<td><font color="red"><form:errors path="codeName" /></font></td>
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
			let formObj = $("#codeDetail");
			<!-- $("#btnRegister").on("click", function() : 등록버튼을 클릭할때 작동하는 핸들러정의 -->
			$("#btnModify").on("click", function() {
				formObj.attr("action","/codedetail/modify");
				formObj.attr("method","post");
				formObj.submit(); 
			});
			
			$("#btnList").on("click", function() {
				<!-- 서버에 페이지요청  http://localhost:8080/codedetail/list -->
				self.location = "/codedetail/list";
			});
		});
	</script>
</body>
</html>