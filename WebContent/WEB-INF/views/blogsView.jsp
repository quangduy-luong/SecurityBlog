<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List of Blogs</title>
<jsp:include page="_resources.jsp"></jsp:include>
</head>
<body class="fixed-nav sticky-footer bg-dark">
	<jsp:include page="_header.jsp"></jsp:include>
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="col-lg-6 offset-lg-3 col-md-12 mb-3">
				<div class="card text-white bg-success o-hidden h-100">
					<div class="card-body">
						<div class="mr-5">Write a new blog</div>
					</div>
					<div class="card-footer clearfix small z-1">
						<a href="newBlog" class="text-white"> <span class="float-left">Click
								here to write a new blog...</span> <span class="float-right"> <i
								class="fa fa-angle-right"></i>
						</span>
						</a>
					</div>
				</div>
			</div>
			<c:forEach items="${blogList}" var="blog">
				<div class="col-lg-6 offset-lg-3 col-md-12 mb-3">
					<div class="card text-white bg-primary o-hidden h-100">
						<div class="card-body">
							<div class="mr-5">${blog.blogTitle}</div>
						</div>
						<div class="card-footer clearfix small z-1">
							<a href="viewBlog?id=${blog.blogID}" class="text-white"> <span
								class="float-left">Posted on ${blog.blogDate} by
									${blog.blogAuthor}. Click here to read more...</span> <span
								class="float-right"> <i class="fa fa-angle-right"></i>
							</span>
							</a>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>