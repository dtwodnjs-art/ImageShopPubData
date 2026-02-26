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
<link rel="stylesheet" href="/css/board/read.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<jsp:include page="/WEB-INF/views/common/menu.jsp" />

	<div align="center">
		<h2>
			<spring:message code="board.header.read" />
		</h2>

		<%-- form의 id는 기본적으로 모델명(board)을 따라가서 jQuery에서 $("#board")로 잡을 수 있어 --%>
		<form:form modelAttribute="board" action="/board/read" method="post">
			<form:hidden path="boardNo" />
			<!-- 현재 페이지 번호와 페이징 크기를 숨겨진 필드 요소를 사용하여 전달한다. -->
			<input type="hidden" id="page" name="page" value="${pgrq.page}">
			<input type="hidden" id="sizePerPage" name="sizePerPage"
				value="${pgrq.sizePerPage}">

			<table border="1">
				<%-- 선이 안 보이면 답답하니까 살짝 추가 --%>
				<tr>
					<td><spring:message code="board.title" /></td>
					<td><form:input path="title" readonly="true" /></td>
					<td><font color="red"><form:errors path="title" /></font></td>
				</tr>
				<tr>
					<td><spring:message code="board.writer" /></td>
					<td><form:input path="writer" readonly="true" /></td>
					<td><font color="red"><form:errors path="writer" /></font></td>
				</tr>
				<tr>
					<td><spring:message code="board.content" /></td>
					<td><form:textarea path="content" readonly="true" rows="5"
							cols="30" /></td>
					<td><font color="red"><form:errors path="content" /></font></td>
				</tr>
				<%-- 권한 정보가 굳이 필요 없다면 이 부분은 삭제해도 무방해! --%>
			</table>
		</form:form>

		<div style="margin-top: 20px;">
			<%-- 현재 로그인한 사용자 정보 가져오기 --%>
			<sec:authentication property="principal" var="pinfo" />

			<%-- 1. 관리자이거나 2. 본인인 경우에만 수정/삭제 버튼 노출 --%>
			<sec:authorize access="anyClick">
				<%-- 관리자 권한 확인 --%>
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<c:set var="isAdmin" value="true" />
				</sec:authorize>

				<%-- 작성자와 로그인 유저 비교 (Spring Security의 username 필드 사용) --%>
				<c:if test="${isAdmin || pinfo.username eq board.writer}">
					<button type="button" id="btnEdit">
						<spring:message code="action.edit" />
					</button>
					<button type="button" id="btnRemove">
						<spring:message code="action.remove" />
					</button>
				</c:if>
			</sec:authorize>

			<button type="button" id="btnList">
				<spring:message code="action.list" />
			</button>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
		$(document).ready(function() {
			// form:form의 기본 id는 모델명인 'board'가 돼
			let formObj = $("#board");

			$("#btnEdit").on("click", function() {
				let page = $("#page").val(); 
		        let sizePerPage = $("#boardNo").val(); 
				formObj.attr("action", "/board/modify");
				formObj.attr("method", "get"); // 수정 화면으로 이동하니까 GET
				formObj.submit();
			});

			$("#btnRemove").on("click", function() {
				if (confirm("정말 삭제하시겠습니까?")) {
					formObj.attr("action", "/board/remove");
					formObj.attr("method", "post"); // 삭제는 보안상 POST가 좋아(Controller도 확인 필요!)
					formObj.submit();
				}
			});

			$("#btnList").on("click", function() {
				location.href = "/board/list";
			});
		});
	</script>
</body>
</html>