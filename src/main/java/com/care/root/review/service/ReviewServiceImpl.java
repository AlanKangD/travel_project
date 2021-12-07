package com.care.root.review.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.care.root.mybatis.review.ReviewMapper;
import com.care.root.review.dto.ReviewDTO;

@Service
public class ReviewServiceImpl implements ReviewService{
	@Autowired ReviewMapper mapper;
	@Autowired ReviewFileService rfs;
	
	public String writeSave(MultipartHttpServletRequest mul,
			HttpServletRequest request) {
		ReviewDTO dto = new ReviewDTO();
		dto.setId(mul.getParameter("id"));
		dto.setReview_title(mul.getParameter("review_title"));
		dto.setReview_content(mul.getParameter("review_content"));
		
		MultipartFile file = mul.getFile("review_file_name");
		if(file.getSize() != 0) {
			dto.setReview_file_name(rfs.saveFile(file));//
		}else {
			dto.setReview_file_name("nan");
		}
		
		int result = 0;
		String msg, url;
		result = mapper.writeSave(dto); //데이터베이스에 리뷰저장
		if(result == 1) {
			msg = "리뷰가 추가되었습니다.";
			url = "/review/review_boardList";
		}else {
			msg = "리뷰 저장 실패";
			url = "/review/review_write";
		}
		return rfs.getMessage(request, msg, url);
	}
	
	public String modify(MultipartHttpServletRequest mul,
			HttpServletRequest request) {
		ReviewDTO dto = new ReviewDTO();
		dto.setReview_no(Integer.parseInt(mul.getParameter("review_no")));
		dto.setReview_title(mul.getParameter("title"));
		dto.setReview_content(mul.getParameter("content"));
		
		MultipartFile file = mul.getFile("review_file_name");
		if(file.getSize() != 0 ) {
	         //이미지 변경시
	    	  dto.setReview_file_name(rfs.saveFile(file));
	    	  rfs.deleteImage(mul.getParameter("originFileName"));
	      }else {
	         dto.setReview_file_name(mul.getParameter("originFileName"));
	      }
		int result = mapper.modify(dto);
		String msg, url;
		if(result == 1) {
			msg = "성공적으로 수정되었습니다";
			url = "/review/review_boardList";
		}else {
			msg = "수정 중 문제가 발생했습니다.";
			url = "/review/modify";
		}
		String message = rfs.getMessage(request, msg, url);
		return message;
	}
	public void boardList(Model model) {
		model.addAttribute("boardList", mapper.boardList());
	}
	public void content(int review_no, Model model) {
		upHit(review_no);
		model.addAttribute("contentData", mapper.content(review_no));
	}
	public void upHit(int review_no) {
		mapper.upHit(review_no);
	}
	public void getData(int review_no, Model model) {
		model.addAttribute("contentData", mapper.content(review_no));
	}
	
}
