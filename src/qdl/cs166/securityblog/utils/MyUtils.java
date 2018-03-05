package qdl.cs166.securityblog.utils;

import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import qdl.cs166.securityblog.entity.User;

public class MyUtils {

	public static final String ATT_NAME_CONNECTION = "ATTRIBUTE_FOR_CONNECTION";
	private static final String ATT_NAME_USER_NAME = "ATTRIBUTE_FOR_STORE_USER_NAME_IN_COOKIE";
	private static final String ATT_NAME_DATE = "ATTRIBUTE_FOR_STORE_DATE_LOGGED_IN_COOKIE";
	private static int REDIRECT_ID = 0;
	private static final Map<Integer, String> id_uri_map = new HashMap<Integer, String>();
	private static final Map<String, Integer> uri_id_map = new HashMap<String, Integer>();

	public static void storeConnection(ServletRequest request, Connection conn) {
		request.setAttribute(ATT_NAME_CONNECTION, conn);
	}

	public static Connection getStoredConnection(ServletRequest request) {
		Connection conn = (Connection) request.getAttribute(ATT_NAME_CONNECTION);
		return conn;
	}

	public static void storeLoginedUser(HttpSession session, User loginedUser) {
		session.setAttribute("loginedUser", loginedUser);
		session.setAttribute("csrftkn", SecurityUtils.generateSalt());
	}

	public static User getLoginedUser(HttpSession session) {
		User loginedUser = (User) session.getAttribute("loginedUser");
		return loginedUser;
	}

	public static void storeUserCookie(HttpServletResponse response, User user) {
		System.out.println("Store user cookie");
		Cookie cookieUserName = new Cookie(ATT_NAME_USER_NAME, user.getEmail());
		String timeStamp = new SimpleDateFormat("dd:MM:yyyy_HH:mm:ss:SSS").format(Calendar.getInstance().getTime());
		Cookie thecookie = new Cookie(ATT_NAME_DATE, timeStamp);
		thecookie.setMaxAge(86400);
		response.addCookie(thecookie);
		// 1 day = 86400 seconds
		cookieUserName.setMaxAge(86400);
		response.addCookie(cookieUserName);
	}

	public static String getUserNameInCookie(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (ATT_NAME_USER_NAME.equals(cookie.getName())) {
					return cookie.getValue();
				}
			}
		}
		return null;
	}
	
	public static String getDateInCookie(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (ATT_NAME_DATE.equals(cookie.getName())) {
					return cookie.getValue();
				}
			}
		}
		return null;
	}

	public static void deleteUserCookie(HttpServletResponse response) {
		Cookie cookieUserName = new Cookie(ATT_NAME_USER_NAME, null);
		Cookie cookieDate = new Cookie(ATT_NAME_DATE, null);
		cookieUserName.setMaxAge(0);
		cookieDate.setMaxAge(0);
		response.addCookie(cookieUserName);
		response.addCookie(cookieDate);
	}

	public static int storeRedirectAfterLoginUrl(HttpSession session, String requestUri) {
		Integer id = uri_id_map.get(requestUri);
		if (id == null) {
			id = REDIRECT_ID++;
			uri_id_map.put(requestUri, id);
			id_uri_map.put(id, requestUri);
			return id;
		}
		return id;
	}

	public static String getRedirectAfterLoginUrl(HttpSession session, int redirectId) {
		String url = id_uri_map.get(redirectId);
		if (url != null) {
			return url;
		}
		return null;
	}

}