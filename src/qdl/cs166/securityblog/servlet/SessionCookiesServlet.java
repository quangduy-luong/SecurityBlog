package qdl.cs166.securityblog.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import qdl.cs166.securityblog.utils.MyUtils;

@WebServlet(urlPatterns = { "/sessiondemo" })
public class SessionCookiesServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public SessionCookiesServlet() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("usernameCookie", MyUtils.getUserNameInCookie(request));
        request.setAttribute("lastSignedInCookie", MyUtils.getDateInCookie(request));
		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/sessionCookiesView.jsp");
		dispatcher.forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
