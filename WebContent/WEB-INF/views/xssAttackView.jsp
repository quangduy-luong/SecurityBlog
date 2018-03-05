<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>XSS Attack Demonstration</title>
<jsp:include page="_resources.jsp"></jsp:include>
</head>
<body class="fixed-nav sticky-footer bg-dark">
	<jsp:include page="_header.jsp"></jsp:include>
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="card mx-5">
				<div class="card-header h3">Cross Site Scripting Attack
					Demonstration</div>
				<div class="card-body">
					<div class="form-group">
						<div class="form-row">
							<div class="col-12">
								<p>On this page, we demonstrate how XSS (Cross Site Script
									Injection) attack works. Blog posts on this site are stored as
									64-KB strings. In order to make them look better, we allow HTML
									tags to be displayed when using them. However, this can
									potentially expose the website to harmful XSS attacks.</p>

								<p>In an XSS attack, the attacker attempts to insert a piece
									of script into plaintext, hoping that it will be executed. This
									could either breach confidentiality of some files or pages, or
									they could perform harmful things on the client. This is bad,
									because attackers could spread the attack via e-mail, with
									unsuspecting people clicking on the links. In here, we will
									show how that can be done.</p>

								<p>
									Entering information in the textfield below will cause the text
									immediately following it to change to match. This is a
									simplified version of a blog view; if we insert something like
									<code>&lt;b&gt;Hello&lt;/b&gt;</code>
									in the field, we will get back&nbsp;
									<code>
										<strong>Hello</strong>
									</code>
									.&nbsp;This is because the text is rendered with no attempt at
									stripping anything from it.
								</p>

								<form action="${pageContext.request.contextPath}/xssdemo"
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

								<p>Suppose that someone would enter this, however:</p>

								<p>
									<code> &lt;script&gt;window.alert("Hi") &lt;/script&gt;
									</code>
								</p>

								<p>This script simply pops up a "Hi" (Google Chrome may disable
									the webpage, but it works on Mozilla Firefox), but of course it
									is just a simple example.</p>

								<p>In this project, I use a stripping function to get rid of
									all script tags from the text before I save it in the database.
									The function is as follows:</p>

								<p>
									<code>
										&nbsp; &nbsp; public static String removeScriptTags(String
										message) {<br /> &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;
										&nbsp;String scriptRegex = &quot;&lt;(/)?[
										]*script[^&gt;]*&gt;&quot;;<br /> &nbsp;&nbsp; &nbsp; &nbsp;
										&nbsp; &nbsp;Pattern pattern2 = Pattern.compile(scriptRegex);
									</code>
								</p>

								<p>
									<code>
										&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if(message != null) {<br />
										&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
										&nbsp;Matcher matcher2 = pattern2.matcher(message);<br />
										&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
										&nbsp;StringBuffer str = new StringBuffer(message.length());<br />
										&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
										&nbsp;while(matcher2.find()) {<br /> &nbsp;&nbsp; &nbsp;
										&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
										&nbsp;matcher2.appendReplacement(str,
										Matcher.quoteReplacement(&quot; &quot;));<br /> &nbsp;&nbsp;
										&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br />
										&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
										&nbsp;matcher2.appendTail(str);<br /> &nbsp;&nbsp; &nbsp;
										&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;message =
										str.toString();<br /> &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;
										&nbsp;}<br /> &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; return
										message;<br /> &nbsp;&nbsp; &nbsp;}
									</code>
								</p>

								<form action="${pageContext.request.contextPath}/xssdemo"
									method="POST">
									<div class="form-group">
										<div class="form-row">
											<div class="col-md-4">
												<input class="form-control" id="scriptTwo" type="text"
													name="scriptTwo" />
											</div>
											<div class="col-md-4">
												<input class="btn btn-success" value="Show" id="submit"
													type="submit" name="submit" />
											</div>
										</div>
									</div>
								</form>

								<div class="col-md-4">${outputTwo}</div>

								<p>The textfield above strips all script tags before it
									renders the text, so it still works with HTML but no is no
									longer prone to XSS attacks.</p>

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