package qdl.cs166.securityblog.entity;

public class Blog {
	
	private int blogID;
	private String blogTitle;
	private String blogBody;
	private String blogDate;
	private String blogAuthor;
	
	public Blog() {
		
	}

	public int getBlogID() {
		return blogID;
	}

	public void setBlogID(int blogID) {
		this.blogID = blogID;
	}

	public String getBlogTitle() {
		return blogTitle;
	}

	public void setBlogTitle(String blogTitle) {
		this.blogTitle = blogTitle;
	}

	public String getBlogBody() {
		return blogBody;
	}

	public void setBlogBody(String blogBody) {
		this.blogBody = blogBody;
	}

	public String getBlogDate() {
		return blogDate;
	}

	public void setBlogDate(String blogDate) {
		this.blogDate = blogDate;
	}

	public String getBlogAuthor() {
		return blogAuthor;
	}

	public void setBlogAuthor(String blogAuthor) {
		this.blogAuthor = blogAuthor;
	}

}
