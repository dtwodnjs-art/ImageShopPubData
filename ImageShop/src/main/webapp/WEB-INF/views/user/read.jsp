<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Image Shop</title>
<link rel="stylesheet" href="/css/user/read.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<jsp:include page="/WEB-INF/views/common/menu.jsp" />
	<div align="center">
		<h2>
			<spring:message code="user.header.read" />
		</h2>
		<form:form modelAttribute="member">
			<form:hidden path="userNo" />
			<table class="user_table">
				<tr>
					<td><spring:message code="user.userId" /></td>
					<td><form:input path="userId" readonly="true" /></td>
					<td><font color="red"><form:errors path="userId" /></font></td>
				</tr>
				<tr>
					<td><spring:message code="user.userPw" /></td>
					<td><form:input path="userPw" readonly="true" /></td>
					<td><font color="red"><form:errors path="userPw" /></font></td>
				</tr>
				<tr>
					<td><spring:message code="user.userName" /></td>
					<td><form:input path="userName" readonly="true" /></td>
					<td><font color="red"><form:errors path="userName" /></font></td>
				</tr>
				<tr>
					<td><spring:message code="user.job" /></td>
					<td><form:select path="job" items="${jobList}"
							itemValue="value" itemLabel="label" disabled="true" /></td>
					<td><font color="red"><form:errors path="job" /></font></td>
				</tr>
				<tr>
					<td><spring:message code="user.auth" /> - 1</td> 
					<td colspan="2">
						<form:select path="authList[0].auth" disabled="true">
							<form:option value="" label="=== 선택해 주세요 ====" />
							<form:option value="ROLE_USER" label="사용자" /> 
							<form:option value="ROLE_MEMBER" label="회원" /> 
							<form:option value="ROLE_ADMIN" label="관리자" /> 
						</form:select>
					</td>
				</tr>
				<tr>
					<td><spring:message code="user.auth" /> - 2</td> 
					<td colspan="2">
						<form:select path="authList[1].auth" disabled="true">
							<form:option value="" label="=== 선택해 주세요 ====" />
							<form:option value="ROLE_USER" label="사용자" /> 
							<form:option value="ROLE_MEMBER" label="회원" /> 
							<form:option value="ROLE_ADMIN" label="관리자" /> 
						</form:select>
					</td>
				</tr>
				<tr>
					<td><spring:message code="user.auth" /> - 3</td> 
					<td colspan="2">
						<form:select path="authList[2].auth" disabled="true">
							<form:option value="" label="=== 선택해 주세요 ====" />
							<form:option value="ROLE_USER" label="사용자" /> 
							<form:option value="ROLE_MEMBER" label="회원" /> 
							<form:option value="ROLE_ADMIN" label="관리자" /> 
						</form:select>
					</td>
				</tr>								
			</table>
		</form:form>

		<div>
			<button type="submit" id="btnEdit">
				<spring:message code="action.edit" />
			</button>
			<button type="submit" id="btnRemove">
				<spring:message code="action.remove" />
			</button>
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<button type="submit" id="btnList">
					<spring:message code="action.list" />
				</button>
			</sec:authorize>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
		$(document).ready(function() {
			let formObj = $("#member");

			$("#btnEdit").on("click", function() {
				formObj.attr("action","/user/modify")
				formObj.attr("method","post")
				formObj.submit();
			});

			$("#btnRemove").on("click", function() {
				formObj.attr("action","/user/remove")
				formObj.attr("method","post")
				formObj.submit();
			});
		
			$("#btnList").on("click", function() {
				self.location = "/user/list";
			});
		
		});
	</script>
</body>
</html>