package com.care.root.review.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface ReviewService {
	public String r_writeSave(MultipartHttpServletRequest mul,
			HttpServletRequest request, int photo_count);
	public String r_modify(MultipartHttpServletRequest mul,
			HttpServletRequest request);
	public void boardList(Model model); 
	public void content(int review_no, Model model);
	public void upHit(int review_no);
	public void getData(int review_no, Model model);
}
