package com.care.root.review.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

public interface ReviewFileService {
	public static final String IMAGE_REPO = "E:/java/image_repo";
	
	public String getMessage(HttpServletRequest request, String msg, String url);
	public String save_stored_file(MultipartFile file);
	public String save_original_file(MultipartFile file);
	public void deleteImage(String originFileName);
	
}
