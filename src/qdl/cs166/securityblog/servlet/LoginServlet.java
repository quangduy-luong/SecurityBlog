package qdl.cs166.securityblog.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import qdl.cs166.securityblog.entity.User;
import qdl.cs166.securityblog.utils.DBUtils;
import qdl.cs166.securityblog.utils.MyUtils;

@WebServlet(urlPatterns = { "/login" })
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginServlet() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/loginView.jsp");
			dispatcher.forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userName = request.getParameter("email");
		String password = request.getParameter("password");
		String remember = request.getParameter("rememberMe");

		User user = null;
		boolean hasError = false;
		String errorString = null;

		if (userName == null || password == null || userName.length() == 0 || password.length() == 0) {
			hasError = true;
			errorString = "Fields cannot be blank.";
		} else {
			Connection conn = MyUtils.getStoredConnection(request);
			try {
				// Find the user in the DB.
				user = DBUtils.findUser(conn, userName, password);

				if (user == null) {
					hasError = true;
					errorString = "Invalid email or password.";
				}
			} catch (SQLException e) {
				e.printStackTrace();
				hasError = true;
				errorString = e.getMessage();
			}
		}
		if (hasError) {
			user = new User();
			user.setEmail(userName);
			user.setPass(password);
			request.setAttribute("errorString", errorString);
			request.setAttribute("user", user);
			RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/loginView.jsp");
			dispatcher.forward(request, response);
		}
		else {
			MyUtils.storeLoginedUser(request.getSession(), user);
			if (remember != null && remember.equals("Y")) {
				MyUtils.storeUserCookie(response, user);
			}
			else {
				MyUtils.deleteUserCookie(response);
			}
			int redirectId = -1;
			try {
				redirectId = Integer.parseInt(request.getParameter("redirectId"));
			} catch (Exception e) {
			}
			String requestUri = MyUtils.getRedirectAfterLoginUrl(request.getSession(), redirectId);
			if (requestUri != null) {
				response.sendRedirect(requestUri);
			} else {
				response.sendRedirect(request.getContextPath() + "/profile");
			}
		}
	}
}