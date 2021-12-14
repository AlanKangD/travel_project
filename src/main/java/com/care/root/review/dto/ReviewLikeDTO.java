package com.care.root.review.dto;

import java.sql.Timestamp;

public class ReviewLikeDTO {
	private int like_no;
	private int review_no;
	private String id;
	private int like_check;
	private Timestamp like_date;
	
	public int getLike_no() {
		return like_no;
	}
	public void setLike_no(int like_no) {
		this.like_no = like_no;
	}
	public int getReview_no() {
		return review_no;
	}
	public void setReview_no(int review_no) {
		this.review_no = review_no;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getLike_check() {
		return like_check;
	}
	public void setLike_check(int like_check) {
		this.like_check = like_check;
	}
	public Timestamp getLike_date() {
		return like_date;
	}
	public void setLike_date(Timestamp like_date) {
		this.like_date = like_date;
	}
	
	
}
