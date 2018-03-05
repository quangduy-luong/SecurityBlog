<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Navigation-->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top"
	id="mainNav">
	<a class="navbar-brand" href="${pageContext.request.contextPath}/">Home</a>
	<button class="navbar-toggler navbar-toggler-right" type="button"
		data-toggle="collapse" data-target="#navbarResponsive"
		aria-controls="navbarResponsive" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="navbarResponsive">
		<ul class="navbar-nav navbar-sidenav" id="exampleAccordion">
			<li class="nav-item" data-toggle="tooltip" data-placement="right"
				title="Checkout"><a class="nav-link"
				href="${pageContext.request.contextPath}/blogs"> <i
					class="fa fa-fw fa-angle-double-right"></i> <span
					class="nav-link-text">Blogs</span>
			</a></li>
			<li class="nav-item" data-toggle="tooltip" data-placement="right"
				title="Inventory"><a class="nav-link"
				href="${pageContext.request.contextPath}/sqldemo"> <i
					class="fa fa-fw fa-angle-double-right"></i> <span
					class="nav-link-text">SQL Injection</span>
			</a></li>
			<li class="nav-item" data-toggle="tooltip" data-placement="right"
				title="Customers"><a class="nav-link"
				href="${pageContext.request.contextPath}/xssdemo"> <i
					class="fa fa-fw fa-angle-double-right"></i> <span
					class="nav-link-text">Cross Site Script Injection</span>
			</a></li>
			<li class="nav-item" data-toggle="tooltip" data-placement="right"
				title="Receipts"><a class="nav-link"
				href="${pageContext.request.contextPath}/defacedemo"> <i
					class="fa fa-fw fa-angle-double-right"></i> <span
					class="nav-link-text">Website Defacing</span>
			</a></li>
			<li class="nav-item" data-toggle="tooltip" data-placement="right"
				title="Vendors"><a class="nav-link"
				href="${pageContext.request.contextPath}/sessiondemo"> <i
					class="fa fa-fw fa-angle-double-right"></i> <span
					class="nav-link-text">Session & Cookies</span>
			</a></li>
		</ul>
		<ul class="navbar-nav ml-auto">
			<c:choose>
				<c:when test="${loginedUser == null}">
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/login"> <i
							class="fa fa-fw fa-sign-in"></i>Log In
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/register"> <i
							class="fa fa-fw fa-user-plus"></i>Register
					</a></li>
					<br />
				</c:when>
				<c:otherwise>
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/profile"> <i
							class="fa fa-fw fa-user-md"></i>Profile
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/logout"> <i
							class="fa fa-fw fa-sign-out"></i>Log Out
					</a></li>
					<br />
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
</nav>