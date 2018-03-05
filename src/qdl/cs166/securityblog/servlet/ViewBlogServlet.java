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

@WebServlet(urlPatterns = { "/viewBlog" })
public class ViewBlogServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ViewBlogServlet() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = MyUtils.getStoredConnection(request);

		Integer code = Integer.parseInt(request.getParameter("id"));

		Blog blog = null;

		String errorString = null;

		try {
			blog = DBUtils.findBlog(conn, code);
		} catch (SQLException e) {
			e.printStackTrace();
			errorString = e.getMessage();
		}
		if (errorString != null && blog == null) {
			response.sendRedirect(request.getServletPath() + "/blogs");
			return;
		}
		request.setAttribute("errorString", errorString);
		request.setAttribute("blog", blog);

		RequestDispatcher dispatcher = request.getServletContext()
				.getRequestDispatcher("/WEB-INF/views/viewBlogView.jsp");
		dispatcher.forward(request, response);

	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			response.sendRedirect(request.getContextPath() + "/blogs");
	}

}