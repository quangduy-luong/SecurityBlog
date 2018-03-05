package qdl.cs166.securityblog.entity;

import java.util.ArrayList;
import java.util.List;

import qdl.cs166.securityblog.config.SecurityConfig;

public class User {
	
	private String email;
	private String pass;
	private String salt;
	private String firstName;
	private String lastName;
	private boolean admin;
	
	public User() {
		
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public boolean isAdmin() {
		return admin;
	}

	public void setAdmin(boolean admin) {
		this.admin = admin;
	}
	
	public List<String> getRoles() {
		List<String> list = new ArrayList<String>();
		if (admin) {
			list.add(SecurityConfig.ROLE_ADMIN);
		} else {
			list.add(SecurityConfig.ROLE_USER);
		}
		return list;
	}

}
