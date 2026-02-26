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
			<spring:message code="board.header.read" />
		</h2>
		<form:form modelAttribute="board" action="/board/modify" method="post">
			<form:hidden path="boardNo" />
			<!-- 현재 페이지 번호와 페이징 크기를 숨겨진 필드 요소를 사용하여 전달한다. --> 
            <input type="hidden" id="page" name="page" value="${pgrq.page}"> 
            <input type="hidden" id="sizePerPage" name="sizePerPage" value="${pgrq.sizePerPage}">
			<table>
				<tr>
					<td><spring:message code="board.title" /></td>
					<td><form:input path="title"/></td>
					<td><font color="red"><form:errors path="title" /></font></td>
				</tr>
				<tr>
					<td><spring:message code="board.writer" /></td>
					<td><form:input path="writer" readonly="true" /></td>
					<td><font color="red"><form:errors path="writer" /></font></td>
				</tr>
				<tr>
					<td><spring:message code="board.content" /></td>
					<td><form:textarea path="content"/></td>
					<td><font color="red"><form:errors path="content" /></font></td>
				</tr>
			</table>
		</form:form>

		<div>
			<sec:authentication property="principal" var="principal" />

			<sec:authorize access="hasRole('ROLE_MEMBER')">
				<%-- 로그인한 사용자(principal.username)와 게시글 작성자(board.writer)가 일치하는지 확인 --%>
				<c:if test="${principal.username eq board.writer}">
					<button type="button" id="btnModify">
						<spring:message code="action.modify" />
					</button>
					<button type="button" id="btnRemove">
						<spring:message code="action.remove" />
					</button>
				</c:if>
			</sec:authorize>

			<%-- 목록 버튼은 권한과 관계없이 항상 표시 --%>
			<button type="button" id="btnList">
				<spring:message code="action.list" />
			</button>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
		$(document).ready(function() {
			let formObj = $("#board");

			$("#btnModify").on("click", function() {
				formObj.submit();
			});

			$("#btnRemove").on("click", function() {
				let boardNo = $("#boardNo")
				self.location = "/board/remove?${pgrq.toUriString()}&boardNo=" + boardNo.val();
			});

			$("#btnList").on("click", function() {
				self.location = "/board/list${pgrq.toUriString()}";
			});

		});
	</script>
</body>
</html>