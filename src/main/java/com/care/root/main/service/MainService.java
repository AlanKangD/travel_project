package com.care.root.main.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.care.root.main.dto.MainDTO;
import com.care.root.main.dto.MyListDTO;
import com.care.root.main.imageFile.MainFileStorage;

public interface MainService extends MainFileStorage {
	
	public List<MainDTO> themeList(Model model);
	public void themeView(int mainId, Model model);	
	public void register(MultipartHttpServletRequest mul);
	public void download(String mainImageFile, HttpServletResponse response) throws Exception;
	public void addMyList(MyListDTO dto);
	
	public List<MyListDTO> getMyList(HttpSession session);
	public String deleteMyList(int listNo);
	
}
