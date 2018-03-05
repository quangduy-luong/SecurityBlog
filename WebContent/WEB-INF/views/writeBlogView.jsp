<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Write Blog</title>
<jsp:include page="_resources.jsp"></jsp:include>
</head>
<body class="fixed-nav sticky-footer bg-dark">
	<jsp:include page="_header.jsp"></jsp:include>
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="card card-register mx-auto mt-2">
				<div class="card-header">Write a New Blog</div>
				<div class="card-body">
					<form action="${pageContext.request.contextPath}/newBlog"
						method="POST">
						<div class="form-group">
							<div class="form-row">
								<p>${errorString}</p>
							</div>
							<div class="form-row">
								<div class="col-md-12">
									<label for="title">Title</label> <input class="form-control"
										id="title" type="text" name="title" placeholder="Title" />
								</div>
								<div class="col-md-12">
									<label for="blogBody">Body</label> <textarea
										class="form-control" rows="10" id="blogBody"
										name="body" placeholder="Note that you can use basic HTML and inline CSS to render text."></textarea>
								</div>
								<input type="hidden" name="author" value="${loginedUser.email}">
								<input id="csrf" name="csrf" type="hidden" value="${sessionScope.csrftkn}">
								<input class="btn btn-primary btn-block" type="submit"
									value="Publish Blog" />
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>