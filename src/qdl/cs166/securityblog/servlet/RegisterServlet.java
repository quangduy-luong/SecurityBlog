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
import qdl.cs166.securityblog.utils.CAPTCHAUtils;
import qdl.cs166.securityblog.utils.DBUtils;
import qdl.cs166.securityblog.utils.MyUtils;
import qdl.cs166.securityblog.utils.SecurityUtils;

@WebServlet(urlPatterns = { "/register" })
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public RegisterServlet() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/registerView.jsp");
		dispatcher.forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userName = request.getParameter("email");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String remember = request.getParameter("rememberMe");
		String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
		System.out.println("gRecaptchaResponse=" + gRecaptchaResponse);

		User user = new User();
		user.setEmail(SecurityUtils.removeScriptTags(userName));
		user.setFirstName(SecurityUtils.removeScriptTags(firstName));
		user.setLastName(SecurityUtils.removeScriptTags(lastName));
		user.setSalt(SecurityUtils.generateSalt());
		user.setPass(SecurityUtils.hash(password, user.getSalt()));
		user.setAdmin(false);
		
		boolean hasError = false;
		String errorString = null;

		if (userName == null || password == null || firstName == null || lastName == null ||
				userName.length() == 0 || password.length() == 0 || firstName.length() == 0 || lastName.length() == 0) {
			hasError = true;
			errorString = "Fields cannot be left blank.";
		}
		else if(!CAPTCHAUtils.verify(gRecaptchaResponse)) {
			errorString = "reCAPTCHA failed!";
			hasError = true;
		}
		else if (!password.equals(confirmPassword)){
			hasError = true;
			errorString = "Passwords do not match!";
		}
		else {
			Connection conn = MyUtils.getStoredConnection(request);
			try {
				// Find the user in the DB.
				DBUtils.insertUser(conn, user);
			} catch (SQLException e) {
				e.printStackTrace();
				hasError = true;
				errorString = e.getMessage();
			}
		}
		if (hasError) {
			request.setAttribute("errorString", errorString);
			request.setAttribute("user", user);
			RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/registerView.jsp");
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