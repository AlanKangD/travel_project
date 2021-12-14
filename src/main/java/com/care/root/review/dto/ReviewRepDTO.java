package com.care.root.review.dto;

import java.sql.Timestamp;

public class ReviewRepDTO {
	private String id;
	private String r_reply_content;
	private Timestamp r_reply_date;
	private Integer r_write_group;
	private Integer r_reply_no;
	private Integer r_reply_count;
	private String r_reply_tag;
	
	public String getR_reply_tag() {
		return r_reply_tag;
	}
	public void setR_reply_tag(String r_reply_tag) {
		this.r_reply_tag = r_reply_tag;
	}
	public Integer getR_reply_count() {
		return r_reply_count;
	}
	public void setR_reply_count(Integer r_reply_count) {
		this.r_reply_count = r_reply_count;
	}
	public Integer getR_reply_no() {
		return r_reply_no;
	}
	public void setR_reply_no(Integer r_reply_no) {
		this.r_reply_no = r_reply_no;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getR_reply_content() {
		return r_reply_content;
	}
	public void setR_reply_content(String r_reply_content) {
		this.r_reply_content = r_reply_content;
	}
	public Timestamp getR_reply_date() {
		return r_reply_date;
	}
	public void setR_reply_date(Timestamp r_reply_date) {
		this.r_reply_date = r_reply_date;
	}
	public Integer getR_write_group() {
		return r_write_group;
	}
	public void setR_write_group(Integer r_write_group) {
		this.r_write_group = r_write_group;
	}
	
	
}
