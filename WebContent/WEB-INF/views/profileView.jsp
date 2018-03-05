<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile Page</title>
<jsp:include page="_resources.jsp"></jsp:include>
</head>
<body class="fixed-nav sticky-footer bg-dark">
	<jsp:include page="_header.jsp"></jsp:include>
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="card card-register mx-auto mt-5">
				<div class="card-header h3">User Profile</div>
				<div class="card-body">
						<div class="form-group">
							<div class="form-row">
								<div class="col-md-12">
									<label for="email">Email</label> <input class="form-control"
										id="email" type="text" name="email" value="${loginedUser.email}" disabled/>
								</div>
								<div class="col-md-6">
									<label for="email">First Name</label> <input class="form-control"
										id="firstName" type="text" name="firstName" value="${loginedUser.firstName}" disabled />
								</div>
								<div class="col-md-6">
									<label for="email">Last Name</label> <input class="form-control"
										id="lastName" type="text" name="lastName" value="${loginedUser.lastName}" disabled />
								</div>
							</div>
						</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>