package com.care.root.main.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.care.root.main.dto.MainDTO;
import com.care.root.main.dto.MyListDTO;
import com.care.root.main.dto.ReplyDTO;
import com.care.root.main.imageFile.MainFileStorage;

public interface MainService extends MainFileStorage {
	
	public void themeList(Model model, String theme);
	public void themeView(String placeName, Model model);	
	public void register(MultipartHttpServletRequest mul,HttpServletResponse response, HttpServletRequest request);
	public void download(String mainImageFile, HttpServletResponse response) throws Exception;
	public String deleteView(String placeName);
	public void modifyView(MultipartHttpServletRequest mul);

	public String addMyList(MyListDTO dto);
	public List<MyListDTO> getMyList(HttpSession session);
	public String deleteMyList(int listNo);
	
	public String addReply(ReplyDTO dto);
	public List<ReplyDTO> getReply(String placeName);
	public String deleteReply(int repNo);
	
}
