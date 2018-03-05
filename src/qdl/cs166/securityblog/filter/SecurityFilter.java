package qdl.cs166.securityblog.filter;

import java.io.IOException;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import qdl.cs166.securityblog.entity.User;
import qdl.cs166.securityblog.request.UserRoleRequestWrapper;
import qdl.cs166.securityblog.utils.MyUtils;
import qdl.cs166.securityblog.utils.SecurityUtils;

@WebFilter("/*")
public class SecurityFilter implements Filter {

	public SecurityFilter() {
	}

	@Override
	public void destroy() {
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) resp;
		String servletPath = request.getServletPath();
		User loginedUser = MyUtils.getLoginedUser(request.getSession());
		if (servletPath.equals("/login")) {
			chain.doFilter(request, response);
			return;
		}
		HttpServletRequest wrapRequest = request;
		if (loginedUser != null) {
			String userName = loginedUser.getEmail();
			List<String> roles = loginedUser.getRoles();
			wrapRequest = new UserRoleRequestWrapper(userName, roles, request);
		}
		if (SecurityUtils.isSecurityPage(request)) {
			if (loginedUser == null) {
				String requestUri = request.getRequestURI();
				// Store the current page to redirect to after successful login.
				int redirectId = MyUtils.storeRedirectAfterLoginUrl(request.getSession(), requestUri);
				response.sendRedirect(wrapRequest.getContextPath() + "/login?redirectId=" + redirectId);
				return;
			}
			boolean hasPermission = SecurityUtils.hasPermission(wrapRequest);
			if (!hasPermission) {
				RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/WEB-INF/views/accessDeniedView.jsp");
				dispatcher.forward(request, response);
				return;
			}
		}
		chain.doFilter(wrapRequest, response);
	}

	@Override
	public void init(FilterConfig fConfig) throws ServletException {
	}
}