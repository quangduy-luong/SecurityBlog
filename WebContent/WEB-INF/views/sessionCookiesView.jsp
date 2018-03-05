<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cookies and Sessions</title>
<jsp:include page="_resources.jsp"></jsp:include>
</head>
<body class="fixed-nav sticky-footer bg-dark">
	<jsp:include page="_header.jsp"></jsp:include>
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="card mx-5">
				<div class="card-header h3">Cookies and Session Management</div>
				<div class="card-body">
					<div class="form-group">
						<div class="form-row">
							<div class="col-12">
								<p>By default, the system does not store cookies about user
									login unless the user selects the &quot;remember me&quot;
									option when signing up or logging in. Then, the cookie stays in
									the system for up to 1 day, after which it deletes itself. When
									selected, the cookies store the username of the user logged in
									as well as the timestamp of login. Upon hitting sign-out, the
									cookies are also deleted so that they don&#39;t automatically
									sign the user up.</p>

								<p>Below is the code that saves the cookies when the user
									signs in or signs up:</p>

								<p>
									<img alt="" src="https://i.imgur.com/mpufCxT.png"
										class="img-fluid" />The current values being stored are:
								</p>

								<p><code>user email: ${usernameCookie}</code></p>

								<p><code>time of signing in: ${lastSignedInCookie}</code></p>

								<p>As for session management, the user currently logged in
									is stored as an attribute in the session. This way, JSP files
									can always retrieve information about the user. Also, when the
									user signs in, the session is invalidated and all cookies are
									deleted. Below are snippets of code that take care of that:</p>

								<p>
									<img alt="" src="https://i.imgur.com/HLKHjLX.png"
										class="img-fluid" />
								</p>

								<p>And here is the code to logout the user in the servlet:</p>

								<p>
									<img alt="" src="https://i.imgur.com/geHnntX.png"
										class="img-fluid" />
								</p>

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