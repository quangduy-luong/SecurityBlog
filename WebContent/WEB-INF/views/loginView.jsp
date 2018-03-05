<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<jsp:include page="_resources.jsp"></jsp:include>
</head>
<body class="fixed-nav sticky-footer bg-dark">
	<jsp:include page="_header.jsp"></jsp:include>
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="card card-register mx-auto mt-5">
				<div class="card-header">Login</div>
				<div class="card-body">
					<form action="${pageContext.request.contextPath}/login"
						method="POST">
						<div class="form-group">
							<div class="form-row">
								<p>${errorString}</p>
							</div>
							<div class="form-row">
								<div class="col-md-12">
									<label for="email">Email</label> <input class="form-control"
										id="email" type="text" name="email" placeholder="Email" />
								</div>
								<div class="col-md-12">
									<label for="password">Password</label> <input
										class="form-control" id="password" type="password"
										name="password" placeholder="Password" />
								</div>
								<div class="form-group">
									Remember Me <input id="rememberMe" name="rememberMe"
										type="checkbox" value="Y">
								</div>
								<input class="btn btn-primary btn-block" type="submit"
									value="Login" />
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