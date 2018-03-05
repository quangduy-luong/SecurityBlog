package qdl.cs166.securityblog.utils;

import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.List;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import qdl.cs166.securityblog.config.SecurityConfig;

public class SecurityUtils {

	private static SecureRandom random = new SecureRandom();
	private static MessageDigest md;

	public static boolean isSecurityPage(HttpServletRequest request) {
		String urlPattern = UrlPatternUtils.getUrlPattern(request);

		Set<String> roles = SecurityConfig.getAllAppRoles();

		for (String role : roles) {
			List<String> urlPatterns = SecurityConfig.getUrlPatternsForRole(role);
			if (urlPatterns != null && urlPatterns.contains(urlPattern)) {
				return true;
			}
		}
		return false;
	}

	public static boolean hasPermission(HttpServletRequest request) {
		String urlPattern = UrlPatternUtils.getUrlPattern(request);

		Set<String> allRoles = SecurityConfig.getAllAppRoles();

		for (String role : allRoles) {
			if (!request.isUserInRole(role)) {
				continue;
			}
			List<String> urlPatterns = SecurityConfig.getUrlPatternsForRole(role);
			if (urlPatterns != null && urlPatterns.contains(urlPattern)) {
				return true;
			}
		}
		return false;
	}

	public static String generateSalt() {
		byte[] bytes = new byte[32];
		random.nextBytes(bytes);
		StringBuilder sb = new StringBuilder();
		for(int i=0; i< bytes.length ;i++){
			sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
		}
		String salt = sb.toString();
		return salt;
	}

	public static String hash(String password, String salt) {
		String generatedPassword = null;
		try {
			if (md == null) md = MessageDigest.getInstance("SHA-512");
			md.update(salt.getBytes("UTF-8"));
			byte[] bytes = md.digest(password.getBytes("UTF-8"));
			StringBuilder sb = new StringBuilder();
			for(int i=0; i< bytes.length ;i++){
				sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
			}
			generatedPassword = sb.toString();
		} 
		catch (Exception e){
		}
		return generatedPassword;
	}
	
	public static String removeScriptTags(String message) {
	      String scriptRegex = "<(/)?[ ]*script[^>]*>";
	      Pattern pattern2 = Pattern.compile(scriptRegex);

	      if(message != null) {
	            Matcher matcher2 = pattern2.matcher(message);
	            StringBuffer str = new StringBuffer(message.length());
	            while(matcher2.find()) {
	              matcher2.appendReplacement(str, Matcher.quoteReplacement(" "));
	            }
	            matcher2.appendTail(str);
	            message = str.toString();
	      }
	     return message;
	}
}