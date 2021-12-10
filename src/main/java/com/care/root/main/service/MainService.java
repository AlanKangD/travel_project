package com.care.root.main.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.care.root.main.dto.MainDTO;
import com.care.root.main.imageFile.MainFileStorage;

public interface MainService extends MainFileStorage {
	
	public List<MainDTO> themeList(Model model);
	public void themeView(int mainId, Model model);	
	public void register(MultipartHttpServletRequest mul);
	public void download(String mainImageFile, HttpServletResponse response) throws Exception;
}
