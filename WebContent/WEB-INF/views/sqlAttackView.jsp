<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SQL Injection Attack Demonstration</title>
<jsp:include page="_resources.jsp"></jsp:include>
</head>
<body class="fixed-nav sticky-footer bg-dark">
	<jsp:include page="_header.jsp"></jsp:include>
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="card mx-5">
				<div class="card-header h3">SQL Injection Attack Demonstration</div>
				<div class="card-body">
					<div class="form-group">
						<div class="form-row">
							<div class="col-12">
								<p>On this page, we demonstrate how SQL injection attack
									works. Let&#39;s say we have a login form that we want to use
									to authenticate the user. Assuming the password is already
									hashed with salt, one might try the following code to
									authenticate users:</p>

								<p>
									<code>
										String sqlbad = &quot;SELECT * FROM users WHERE email =
										'&quot; + userName + &quot;' AND pass = '&quot; + password +
										&quot;'&quot;;<br /> pstm = conn.prepareStatement(sqlbad);<br />
										ResultSet rs = pstm.executeQuery();
									</code>
								</p>

								<p>Then, one might think to simply check whether the result
									set contains values, and if it does, then the user can be
									extracted from the result set.</p>

								<p>While this approach works fine, it is susceptible to SQL
									injection attacks: that is, a crafty attacker might figure out
									ways to cheat the form. The form below is wired up so it
									executes the statement listed above (of course it also gets the
									salt and generates the hashes before).</p>

								<form action="${pageContext.request.contextPath}/sqldemo"
									method="POST">
									<div class="form-group">
										<div class="form-row">
											<div class="col-md-4">
												<input class="form-control" id="firstName" type="text"
													name="email" placeholder="Email" />
											</div>
											<div class="col-md-4">
												<input class="form-control" id="lastName" type="text"
													name="password" placeholder="Password" />
											</div>
											<input type="hidden" value="Y" name="choice">
											<div class="col-md-4">
												<input class="btn btn-success" value="Query" id="submit"
													type="submit" name="submit" />
											</div>
										</div>
									</div>
								</form>

								<p>While giving proper information in the form will either
									result in empty set or one user found, if inserting special
									symbols in the email or password input can have unexpected
									results.</p>
								<p>
									Try inserting
									<code>a ' OR '1'='1' --&nbsp;</code>
								</p>

								<p>Submitting that form will cause the result set to instead
									select all users. A craftier user might even insert more lines
									of code that could have catastrophic consequences on the
									database.</p>

								<p>Instead of using the SQL code as above, we could have
									chosen a safer approach. The form below is wired to the
									following code instead:</p>

								<p>
									<code>
										String sqlgood = &quot;SELECT * FROM users WHERE email = ? AND
										pass = ?&quot;;<br /> pstm = conn.prepareStatement(sqlgood);<br />
										pstm.setString(1, userName);<br /> pstm.setString(2,
										password);<br /> ResultSet rs = pstm .executeQuery();
									</code>
								</p>

								<form action="${pageContext.request.contextPath}/sqldemo"
									method="POST">
									<div class="form-group">
										<div class="form-row">
											<div class="col-md-4">
												<input class="form-control" id="firstName" type="text"
													name="email" placeholder="Email" />
											</div>
											<div class="col-md-4">
												<input class="form-control" id="lastName" type="text"
													name="password" placeholder="Password" />
											</div>
											<div class="col-md-4">
												<input class="btn btn-success" value="Query" id="submit"
													type="submit" name="submit" />
											</div>
										</div>
									</div>
								</form>

								<p>If you try the code now, it no longer has the issue with
									SQL injections. Dynamically parametrized prepared statements
									are one approach that can be used to prevent SQL injection
									attacks.</p>
								<p>
									The results of the query are: <br />
									<code><c:out value="${queryresult}" escapeXml="false" /></code>
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