package com.care.root.review.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.care.root.mybatis.review.ReviewMapper;
import com.care.root.review.dto.ReviewDTO;
import com.care.root.review.dto.ReviewPhotoDTO;

@Service
public class ReviewServiceImpl implements ReviewService{
	@Autowired ReviewMapper mapper;
	@Autowired ReviewFileService rfs;
	
	public String r_writeSave(MultipartHttpServletRequest mul,
			HttpServletRequest request, int photo_count) {
		
//		String file_name = mul.getParameter("review_file_list");
//		String[] file_name_list = file_name.split("/");
		int result_content_save = 0;
		int result_photo_save = 1;
		ArrayList<Integer> result_photo = new ArrayList<Integer>();
		
		ReviewDTO dto = new ReviewDTO();
		dto.setId(mul.getParameter("id"));
		dto.setReview_title(mul.getParameter("review_title"));
		dto.setReview_content(mul.getParameter("review_content"));
		System.out.println("아이디, 제목, 내용 dto set 완료");
		result_content_save = mapper.r_writeSave(dto);
		
		
		for(int i = 0; i < photo_count ; i++) {
			ReviewPhotoDTO photo_dto = new ReviewPhotoDTO();
			
			MultipartFile file = mul.getFile("review_file_name_" + i);
			
			System.out.println("file : "+file);
			if(file != null) {
				photo_dto.setId(mul.getParameter("id"));
				photo_dto.setReview_title(mul.getParameter("review_title"));
				photo_dto.setOriginal_file_name(rfs.save_original_file(file));
				photo_dto.setStored_file_name(rfs.save_stored_file(file));//
			}else {
				photo_dto.setId(mul.getParameter("id"));
				photo_dto.setReview_title("review_title");
				photo_dto.setOriginal_file_name("nan");
				photo_dto.setStored_file_name("nan");//
			}
			result_photo.add(i, mapper.photo_save(photo_dto));
		}
		
		String msg, url;
		for(int j = 0; j< photo_count; j++) {
			if(result_photo.get(j) == 0) {
				result_photo_save = 0;
			}
		}
		
		if(result_content_save == 1 && result_photo_save == 1) {
			msg = "리뷰가 추가되었습니다.";
			url = "/review/review_boardList";
		}else {
			msg = "리뷰 저장 실패";
			url = "/review/review_write";
		}
		return rfs.getMessage(request, msg, url);
	}
	
	public String r_modify(MultipartHttpServletRequest mul,
			HttpServletRequest request) {
		ReviewDTO dto = new ReviewDTO();
		dto.setReview_no(Integer.parseInt(mul.getParameter("review_no")));
		dto.setReview_title(mul.getParameter("title"));
		dto.setReview_content(mul.getParameter("content"));
		
		System.out.println("파일 이름");
		System.out.println(mul.getFile("review_file_name"));
		System.out.println("파일 이름 끝");
		
		MultipartFile file = mul.getFile("review_file_name");
		if(file.getSize() != 0 ) {
	         //이미지 변경시
	    	  dto.setReview_file_name(rfs.save_stored_file(file));
	    	  rfs.deleteImage(mul.getParameter("originFileName"));
	      }else {
	         dto.setReview_file_name(mul.getParameter("originFileName"));
	      }
		int result = mapper.r_modify(dto);
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
		model.addAttribute("photo_view", mapper.photo_view(review_no));
	}
	public void upHit(int review_no) {
		mapper.upHit(review_no);
	}
	public void getData(int review_no, Model model) {
		model.addAttribute("contentData", mapper.content(review_no));
	}
	
}
