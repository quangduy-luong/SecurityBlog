<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
<jsp:include page="_resources.jsp"></jsp:include>
<script src='https://www.google.com/recaptcha/api.js'></script>
</head>
<body class="fixed-nav sticky-footer bg-dark">
	<jsp:include page="_header.jsp"></jsp:include>
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="card card-register mx-auto mt-5">
				<div class="card-header">Register</div>
				<div class="card-body">
					<form action="${pageContext.request.contextPath}/register"
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
								<div class="col-md-6">
									<label for="password">Password</label> <input
										class="form-control" id="password" type="password"
										name="password" placeholder="Password" />
								</div>
								<div class="col-md-6">
									<label for="confirmPassword">Confirm Password</label> <input
										class="form-control" id="confirmPassword" type="password"
										name="confirmPassword" placeholder="Confirm password" />
								</div>
								<div class="col-md-6">
									<label for="email">First Name</label> <input class="form-control"
										id="firstName" type="text" name="firstName" placeholder="First Name" />
								</div>
								<div class="col-md-6">
									<label for="email">Last Name</label> <input class="form-control"
										id="lastName" type="text" name="lastName" placeholder="Last Name" />
								</div>
								<div class="form-group">
									Remember Me <input id="rememberMe" name="rememberMe"
										type="checkbox" value="Y">
								</div>
								<div class="g-recaptcha form-group vert-offset-top-3" data-sitekey="6LcujT0UAAAAAEPgb-RUcjGetFH4xpcNJhUbIsVH"></div>
								<input class="btn btn-primary btn-block" type="submit"
									value="Register" />
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