package com.care.root.review.dto;

import java.sql.Timestamp;

public class ReviewRepDTO {
	private String id;
	private String content;
	private int review_write_group;
	private Timestamp write_date;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getReview_write_group() {
		return review_write_group;
	}
	public void setReview_write_group(int review_write_group) {
		this.review_write_group = review_write_group;
	}
	public Timestamp getWrite_date() {
		return write_date;
	}
	public void setWrite_date(Timestamp write_date) {
		this.write_date = write_date;
	}
	
	
}
