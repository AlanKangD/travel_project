package com.care.root.main.imageFile;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.care.root.main.dto.MainDTO;


public interface MainFileStorage {
	public static final String IMAGE_REPO = "/Users/raina/Desktop/TeamProject/image_repository";
	//public static final String IMAGE_REPO = "C:/image_repo";
	public MainDTO fileProcess(MultipartHttpServletRequest mul);
}
