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

import qdl.cs166.securityblog.entity.Blog;
import qdl.cs166.securityblog.utils.DBUtils;
import qdl.cs166.securityblog.utils.MyUtils;
import qdl.cs166.securityblog.utils.SecurityUtils;

@WebServlet(urlPatterns = { "/newBlog" })
public class WriteBlogServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public WriteBlogServlet() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/WEB-INF/views/writeBlogView.jsp");
		dispatcher.forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = MyUtils.getStoredConnection(request);

		String title = (String) request.getParameter("title");
		String body = (String) request.getParameter("body");
		String author = (String) request.getParameter("author");
		String csrf = (String) request.getParameter("csrf");
		String origcsrf = (String) request.getSession().getAttribute("csrftkn");
		
		String errorString = null;
		
		if(!csrf.equals(origcsrf)) {
			System.out.println("Tokens are not matching - possible CSRF attack");
			errorString = "Request cannot be processed at this time.";
		}
		
		Blog blog = new Blog();
		blog.setBlogAuthor(SecurityUtils.removeScriptTags(author));
		blog.setBlogBody(SecurityUtils.removeScriptTags(body));
		blog.setBlogTitle(SecurityUtils.removeScriptTags(title));

		if (title.length() == 0 || body.length() == 0 || author.length() == 0) {
			errorString = "Fields cannot be blank.";
		}
		
		if (errorString == null) {
			try {
				DBUtils.insertBlog(conn, blog);
			} catch (SQLException e) {
				e.printStackTrace();
				errorString = e.getMessage();
			}
		}

		request.setAttribute("errorString", errorString);
		request.setAttribute("blog", blog);

		if (errorString != null) {
			RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/WEB-INF/views/writeBlogView.jsp");
			dispatcher.forward(request, response);
		}

		else {
			response.sendRedirect(request.getContextPath() + "/blogs");
		}
	}

}