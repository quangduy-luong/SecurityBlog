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

@WebServlet(urlPatterns = { "/deleteBlog" })
public class DeleteBlogServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public DeleteBlogServlet() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Connection conn = MyUtils.getStoredConnection(request);

		int id = Integer.parseInt(request.getParameter("id"));
		String csrf = (String) request.getParameter("csrf");
		String origcsrf = (String) request.getSession().getAttribute("csrftkn");

		String errorString = null;
		
		if(csrf == null || !csrf.equals(origcsrf)) {
			System.out.println("Tokens are not matching - possible CSRF attack");
			errorString = "Request cannot be processed at this time.";
		}

		User loginedUser = MyUtils.getLoginedUser(request.getSession());

		try {
			if (errorString == null && (loginedUser.isAdmin() || 
					loginedUser.getEmail().equals(DBUtils.findBlog(conn, id).getBlogAuthor()))) {
				DBUtils.deleteBlog(conn, id);
			}
			else {
				errorString = "You do not have the privileges to delete this blog post.";
			}
		} catch (SQLException e) {
			e.printStackTrace();
			errorString = e.getMessage();
		}
		if (errorString != null) {
			request.setAttribute("errorString", errorString);
			RequestDispatcher dispatcher = request.getServletContext()
					.getRequestDispatcher("/WEB-INF/views/errorView.jsp");
			dispatcher.forward(request, response);
		}    
		else {
			response.sendRedirect(request.getContextPath() + "/blogs");
		}

	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}