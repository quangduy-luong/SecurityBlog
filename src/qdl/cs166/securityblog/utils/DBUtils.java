package qdl.cs166.securityblog.utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import qdl.cs166.securityblog.entity.*;

public class DBUtils {

	public static User findUser(Connection conn, String userName, String password) throws SQLException {
		String salt = "";

		//first attempt to fetch salt
		String sql1 = "SELECT salt FROM users WHERE email = ?";
		PreparedStatement pstm1 = conn.prepareStatement(sql1);
		pstm1.setString(1, userName);
		ResultSet rs1 = pstm1.executeQuery();
		if (rs1.next()) {
			salt = rs1.getString("salt");
		}
		String hashedPassword = SecurityUtils.hash(password, salt);

		//then attempt to fetch user
		String sql2 = "SELECT * FROM users WHERE email = ? and pass = ?";
		PreparedStatement pstm2 = conn.prepareStatement(sql2);
		pstm2.setString(1, userName);
		pstm2.setString(2, hashedPassword);
		ResultSet rs2 = pstm2.executeQuery();

		if (rs2.next()) {
			User user = new User();
			user.setEmail(userName);
			user.setPass(password);
			user.setSalt(salt);
			user.setAdmin(rs2.getBoolean("admin"));
			user.setFirstName(rs2.getString("first_name"));
			user.setLastName(rs2.getString("last_name"));
			return user;
		}
		return null;
	}

	public static User findUser(Connection conn, String userName) throws SQLException {
		String sql = "SELECT * FROM users WHERE email = ?";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setString(1, userName);

		ResultSet rs = pstm.executeQuery();

		if (rs.next()) {
			User user = new User();
			user.setEmail(userName);
			user.setPass(rs.getString("pass"));
			user.setSalt(rs.getString("salt"));
			user.setAdmin(rs.getBoolean("admin"));
			user.setFirstName(rs.getString("first_name"));
			user.setLastName(rs.getString("last_name"));
			return user;
		}
		return null;
	}
	
	public static void insertUser(Connection conn, User user) throws SQLException {
		String sql = "INSERT INTO users(email, pass, salt, first_name, last_name, admin) "
				+ "VALUES(?, ?, ?, ?, ?, 0)";
		PreparedStatement pstm = conn.prepareStatement(sql);

		pstm.setString(1, user.getEmail());
		pstm.setString(2, user.getPass());
		pstm.setString(3, user.getSalt());
		pstm.setString(4, user.getFirstName());
		pstm.setString(5, user.getLastName());

		pstm.executeUpdate();
	}

	public static List<Blog> listBlogs(Connection conn) throws SQLException {
		String sql = "SELECT * FROM blogs ";
		PreparedStatement pstm = conn.prepareStatement(sql);

		ResultSet rs = pstm.executeQuery();
		List<Blog> list = new ArrayList<Blog>();
		while (rs.next()) {
			Blog blog = new Blog();
			blog.setBlogAuthor(rs.getString("blog_author"));
			blog.setBlogBody(rs.getString("blog_body"));
			blog.setBlogTitle(rs.getString("blog_title"));
			blog.setBlogDate(rs.getString("blog_date"));
			blog.setBlogID(rs.getInt("blog_id"));
			list.add(blog);
		}
		return list;
	}

	public static Blog findBlog(Connection conn, Integer id) throws SQLException {
		String sql = "SELECT * FROM blogs WHERE blog_id = ?";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setInt(1, id);

		ResultSet rs = pstm.executeQuery();
		while (rs.next()) {
			Blog blog = new Blog();
			blog.setBlogAuthor(rs.getString("blog_author"));
			blog.setBlogBody(rs.getString("blog_body"));
			blog.setBlogTitle(rs.getString("blog_title"));
			blog.setBlogDate(rs.getString("blog_date"));
			blog.setBlogID(id);
			return blog;
		}
		return null;
	}

	public static void updateBlog(Connection conn, Blog blog) throws SQLException {
		String sql = "UPDATE blogs set blog_title = ?, blog_body = ? where blog_id = ?";

		PreparedStatement pstm = conn.prepareStatement(sql);

		pstm.setString(1, blog.getBlogTitle());
		pstm.setString(2, blog.getBlogBody());
		pstm.setInt(3, blog.getBlogID());
		pstm.executeUpdate();
	}

	public static void insertBlog(Connection conn, Blog blog) throws SQLException {
		String sql = "INSERT INTO blogs(blog_title, blog_body, blog_date, blog_author) "
				+ "VALUES(?, ?, CURDATE(), ?)";
		PreparedStatement pstm = conn.prepareStatement(sql);

		pstm.setString(1, blog.getBlogTitle());
		pstm.setString(2, blog.getBlogBody());
		pstm.setString(3, blog.getBlogAuthor());

		pstm.executeUpdate();
	}

	public static void deleteBlog(Connection conn, Integer id) throws SQLException {
		String sql = "DELETE FROM blogs WHERE blog_id = ?";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setInt(1, id);

		pstm.executeUpdate();
	}

}