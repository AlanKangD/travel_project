package com.care.root.review.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class ReviewFileServiceImpl implements ReviewFileService{
	
	public String getMessage(HttpServletRequest request, String msg, String url) {
		String message = null;
		String path = request.getContextPath();
		message = "<script>alert('" + msg + "');";
		message += "location.href='" + path + url + "';</script>";
		return message;
	}
	public String save_stored_file(MultipartFile file) {
		SimpleDateFormat simpl = new SimpleDateFormat("yyyyMMddHHmmss-"	);
		Calendar calendar = Calendar.getInstance();
		String stored_file_name =
				simpl.format(calendar.getTime()) + file.getOriginalFilename();
		File save_stored_file = new File(IMAGE_REPO + "/" + stored_file_name);
		try {
			file.transferTo(save_stored_file);//해당 위치에 파일 저장
		} catch (Exception e) {
			e.printStackTrace();
		}
		return stored_file_name;
	}
	public String save_original_file(MultipartFile file) {
		String original_file_name = file.getOriginalFilename();
		return original_file_name;
	}
	
	public void deleteImage(String originFileName) {
		File deleteFile = new File(IMAGE_REPO + "/" + originFileName);
		deleteFile.delete();

	}
}
