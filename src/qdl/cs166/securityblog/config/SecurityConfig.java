package qdl.cs166.securityblog.config;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class SecurityConfig {

	public static final String ROLE_USER = "USER";
	public static final String ROLE_ADMIN = "ADMIN";
	public static final String SITE_KEY = "--removed--";
	public static final String SECRET_KEY = "--removed--";

	private static final Map<String, List<String>> mapConfig = new HashMap<String, List<String>>();

	static {
		init();
	}

	private static void init() {
		List<String> urlPatterns1 = new ArrayList<String>();
		urlPatterns1.add("/profile");
		urlPatterns1.add("/newBlog");
		urlPatterns1.add("/deleteBlog");
		mapConfig.put(ROLE_USER, urlPatterns1);

		List<String> urlPatterns2 = new ArrayList<String>();
		urlPatterns2.add("/profile");
		urlPatterns2.add("/newBlog");
		urlPatterns2.add("/deleteBlog");
		mapConfig.put(ROLE_ADMIN, urlPatterns2);
	}

	public static Set<String> getAllAppRoles() {
		return mapConfig.keySet();
	}

	public static List<String> getUrlPatternsForRole(String role) {
		return mapConfig.get(role);
	}

}
