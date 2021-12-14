package com.care.root.review.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.care.root.mybatis.review.ReviewMapper;
import com.care.root.review.dto.ReviewDTO;
import com.care.root.review.dto.ReviewLikeDTO;
import com.care.root.review.dto.ReviewRepDTO;

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
	
	public void boardList(Model model, int num) {
		int pageLetter = 3;
		int allCount = mapper.selectReviewCount();
		int repeat = allCount / pageLetter;
		if(allCount % pageLetter != 0) {
			repeat += 1;
		}
		int end = num * pageLetter;
		int start = end + 1 - pageLetter;
		
		model.addAttribute("repeat", repeat);
		model.addAttribute("boardList", mapper.boardList(start, end));
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
	public void replyAdd(ReviewRepDTO dto) {
		mapper.replyAdd(dto);
	}
	public void updateReply(ReviewRepDTO dto) {
		System.out.println(dto.getR_reply_content());
		System.out.println(dto.getR_reply_no());
		mapper.updateReply(dto);
	}
	public void deleteReply(ReviewRepDTO dto) {
		mapper.deleteReply(dto);
	}
	public List<ReviewRepDTO> getRepList(int r_write_group) {
		return mapper.getRepList(r_write_group);
	}
	
	// 좋아요 구현
	public void updateLike(int review_no) {
		mapper.updateLike(review_no);
	}
	public void updateLikeCancel(int review_no) {
		mapper.updateLikeCancel(review_no);
	}
	public void insertLike(int review_no, String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("review_no", review_no);
		mapper.insertLike(map);
	}
	public void deleteLike(int review_no, String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("review_no", review_no);
		mapper.deleteLike(map);
	}
	public int likeCheck(int review_no, String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("review_no", review_no);
		return mapper.likeCheck(map);
	}
	public void updateLikeCheck(int review_no, String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("review_no", review_no);
		mapper.updateLikeCheck(map);
	}
	public void updateLikeCheckCancel(int review_no, String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("review_no", review_no);
		mapper.updateLikeCheckCancel(map);
	}

	public void updateReplyCount(int r_write_group) {
		mapper.updateReplyCount(r_write_group);
	}
	
	

	
	
}
