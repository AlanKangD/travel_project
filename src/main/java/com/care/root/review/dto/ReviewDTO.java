package com.care.root.review.dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class ReviewDTO {
	private int review_no;
	private String id;
	private String review_title;
	private String review_content;
	private int review_hit_num;
	private int review_like;
	private String review_date;
	private String review_file_name;
	private int r_reply_count;
	
	public void setReview_date(Timestamp review_date) {	// java.sql
		SimpleDateFormat fo = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
		this.review_date = fo.format(review_date);
	}
	public String getReview_date() {
		return review_date;
	}
	
	public int getR_reply_count() {
		return r_reply_count;
	}
	public void setR_reply_count(int r_reply_count) {
		this.r_reply_count = r_reply_count;
	}
	public String getReview_file_name() {
		return review_file_name;
	}
	public void setReview_file_name(String review_file_name) {
		this.review_file_name = review_file_name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getReview_title() {
		return review_title;
	}
	public void setReview_title(String review_title) {
		this.review_title = review_title;
	}
	public String getReview_content() {
		return review_content;
	}
	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}
	public int getReview_hit_num() {
		return review_hit_num;
	}
	public void setReview_hit_num(int review_hit_num) {
		this.review_hit_num = review_hit_num;
	}
	public int getReview_like() {
		return review_like;
	}
	public void setReview_like(int review_like) {
		this.review_like = review_like;
	}
	public int getReview_no() {
		return review_no;
	}
	public void setReview_no(int review_no) {
		this.review_no = review_no;
	}
	
}
