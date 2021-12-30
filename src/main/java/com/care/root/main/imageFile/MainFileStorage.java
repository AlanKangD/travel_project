package com.care.root.main.imageFile;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.care.root.main.dto.MainDTO;


public interface MainFileStorage {

	public static final String IMAGE_REPO = "C:/Users/samsung/Desktop/image_repo";

	public MainDTO fileProcess(MultipartHttpServletRequest mul);

}
