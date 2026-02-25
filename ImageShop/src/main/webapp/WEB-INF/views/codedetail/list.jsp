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
<link rel="stylesheet" href="/css/codedetail/list.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<jsp:include page="/WEB-INF/views/common/menu.jsp" />
	<!-- 메인화면 작업시작 -->
	<div align="center">
		<h2>
			<spring:message code="codedetail.header.list" />
		</h2>
		<a href="register"><spring:message code="action.new" /></a>
		<table border="1" class="codedetail_table">
			<tr>
				<th align="center" width="160"><spring:message
						code="codedetail.groupCode" /></th>
				<th align="center" width="160"><spring:message
						code="codedetail.codeValue" /></th>
				<th align="center" width="160"><spring:message
						code="codedetail.codeName" /></th>
				<th align="center" width="160"><spring:message
						code="codedetail.sortSeq" /></th>
				<th align="center" width="180"><spring:message
						code="codedetail.regdate" /></th>
			</tr>
			<c:choose>
				<c:when test="${empty list}">
					<tr>
						<td colspan="5"><spring:message code="common.listEmpty" /></td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${list}" var="codeDetail">
						<tr>
							<td align="center">${codeDetail.groupCode}</td>
							<td align="center">${codeDetail.codeValue}</td>
							<td align="left"><a
								href="/codedetail/read?groupCode=${codeDetail.groupCode}&codeValue=${codeDetail.codeValue}">
								${codeDetail.codeName}</a>
							</td>
							<td align="center">${codeDetail.sortSeq}</td>
							<td align="center"><fmt:formatDate
									pattern="yyyy-MM-dd HH:mm" value="${codeDetail.regDate}" /></td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
	</div>
	<!-- 메인화면 작업끝 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<!-- 이벤트처리방식 -->
	<script>
		var result = "${msg}";
		if (result === "SUCCESS") {
			alert("<spring:message code='common.processSuccess' />");
		} else if (result === "FAIL") {
			alert("처리내용 실패");
		}
	</script>
</body>
</html>