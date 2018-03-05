package qdl.cs166.securityblog.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import qdl.cs166.securityblog.utils.SecurityUtils;

@WebServlet(urlPatterns = { "/xssdemo" })
public class XSSAttackServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public XSSAttackServlet() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/xssAttackView.jsp");
		dispatcher.forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String scriptOne = request.getParameter("scriptOne");
		String scriptTwo = request.getParameter("scriptTwo");
		
		String strippedScript = SecurityUtils.removeScriptTags(scriptTwo);
		
		request.setAttribute("outputOne", scriptOne);
		request.setAttribute("outputTwo", strippedScript);

		
		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/xssAttackView.jsp");
		dispatcher.forward(request, response);
	}

}
