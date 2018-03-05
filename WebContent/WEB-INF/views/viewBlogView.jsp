<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${blog.blogTitle}</title>
<jsp:include page="_resources.jsp"></jsp:include>
</head>
<body class="fixed-nav sticky-footer bg-dark">
	<jsp:include page="_header.jsp"></jsp:include>
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="card mx-5">
				<div class="card-header h3">${blog.blogTitle}</div>
				<div class="card-body">
					<div class="form-group">
						<div class="form-row">
							<div class="col-12">
								<c:out value="${blog.blogBody}" escapeXml="false" />
							</div>
						</div>
					</div>
				</div>
				<div class="card-footer">
					<div class="form-row">
						<div class="col-md-12">Written by ${blog.blogAuthor} on
							${blog.blogDate}</div>
					</div>
				</div>
				<c:choose>
					<c:when
						test="${loginedUser != null && (loginedUser.email == blog.blogAuthor || loginedUser.admin)}">
						<div class="form-row">
							<div class="col-8">
								<a href="blogs" class="btn btn-primary btn-block">Back to
									blogs</a>
							</div>
							<div class="col-4">
								<form method="POST" action="deleteBlog">
									<input type="hidden" name="id" value="${blog.blogID}">
									<input id="csrf" name="csrf" type="hidden"
										value="${sessionScope.csrftkn}"> <input type="submit"
										onclick="if (!(confirm('Are you sure you want to delete this blog?'))) return false"
										class="btn btn-danger btn-block" value="Delete this blog post">
								</form>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="form-row">
							<div class="col-12">
								<a href="blogs" class="btn btn-primary btn-block">Back to
									blogs</a>
							</div>
						</div>

					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>