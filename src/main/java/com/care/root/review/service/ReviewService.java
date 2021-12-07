package com.care.root.review.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface ReviewService {
	public String writeSave(MultipartHttpServletRequest mul,
			HttpServletRequest request);
	public String modify(MultipartHttpServletRequest mul,
			HttpServletRequest request);
	public void boardList(Model model); 
	public void content(int review_no, Model model);
	public void upHit(int review_no);
	public void getData(int review_no, Model model);
}
