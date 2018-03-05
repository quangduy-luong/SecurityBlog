package qdl.cs166.securityblog.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import qdl.cs166.securityblog.utils.MyUtils;
import qdl.cs166.securityblog.utils.SecurityUtils;

@WebServlet(urlPatterns = { "/sqldemo" })
public class SQLAttackServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public SQLAttackServlet() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/sqlAttackView.jsp");
		dispatcher.forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = MyUtils.getStoredConnection(request);
		String userName = request.getParameter("email");
		String password = request.getParameter("password");
		String choice = request.getParameter("choice");

		String sqlsalt = "SELECT salt  FROM users WHERE email = ?";
		try {
			PreparedStatement saltStatement = conn.prepareStatement(sqlsalt);
			saltStatement.setString(1, userName);
			ResultSet rs = saltStatement.executeQuery();
			if (rs.next()) {
				password = SecurityUtils.hash(password, rs.getString("salt"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		String sqlgood = "SELECT * FROM users WHERE email = ? AND pass = ?";
		String sqlbad = "SELECT * FROM users WHERE email = '" + userName + "' AND pass = '" + password + "'";
		System.out.println("Good: " + sqlgood);
		System.out.println("Bad " + sqlbad);
		String result = "";
		PreparedStatement pstm;
		try {
			if(choice == null) {
				pstm = conn.prepareStatement(sqlgood);
				pstm.setString(1, userName);
				pstm.setString(2, password);
			}
			else {
				pstm = conn.prepareStatement(sqlbad);
			}
			ResultSet rs = pstm.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
			   int columnsNumber = rsmd.getColumnCount();
			   while (rs.next()) {
			       for (int i = 1; i <= columnsNumber; i++) {
			           if (i > 1) result += (",  ");
			           String columnValue = rs.getString(i);
			           result += (columnValue + " " + rsmd.getColumnName(i));
			       }
			       result += ("<br/><br/>");
			   }
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		request.setAttribute("queryresult", result);
		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/sqlAttackView.jsp");
		dispatcher.forward(request, response);
	}

}
