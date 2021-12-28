package com.care.root.main.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.care.root.main.dto.MainDTO;
import com.care.root.main.dto.MyListDTO;
import com.care.root.main.dto.ReplyDTO;
import com.care.root.main.imageFile.MainFileStorage;

public interface MainService extends MainFileStorage { // 이미지파일 저장 경로를 지정한 인터페이스를 상속

	public	void themeList(Model model, String theme);  // 테마(카테고리) 목록 불러오기 
	public void themeView(String placeName, Model model);	  //  게시물 내용보기
	public void register(MultipartHttpServletRequest mul,  //  게시물 등록하기 
										HttpServletResponse response, HttpServletRequest request);
	public void download(String imageFile, HttpServletResponse response) throws Exception;  // 이미지 불러오기
	public void deleteView(MainDTO dto);  // 게시물 삭제하기 
	public void modifyView(MultipartHttpServletRequest mul);  // 게시물 수정하기
	public String addMyList(MyListDTO dto);   // 마이리스트에 해당 게시물 담기(일정추가하기) 
	public List<MyListDTO> getMyList(HttpSession session);  // 마이리스트 불러오기 
	public String deleteMyList(int listNo);  // 마이리스트에서 삭제하기 

	public String likeCheck(int repNo,String id);  // 추천 개수 확인하기 

	public String addReply(ReplyDTO dto);  // 댓글 달기 
	public Map<String, Object> getReply(String placeName, int num);  // 해당 게시물에 대한 모든댓글 불러오기 
	public String deleteReply(int repNo);  //  댓글 삭제하기 


}
