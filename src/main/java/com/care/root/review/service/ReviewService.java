package com.care.root.review.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.care.root.review.dto.ReviewLikeDTO;
import com.care.root.review.dto.ReviewRepDTO;

public interface ReviewService {
	public String r_writeSave(MultipartHttpServletRequest mul,
			HttpServletRequest request, int photo_count);
	public String r_modify(MultipartHttpServletRequest mul,
			HttpServletRequest request, int photo_count);
	public void boardList(Model model, int num, String r_search_option, String keyword); 
	public void content(int review_no, Model model);
	public void content_photo(int review_no, Model model);
	public void upHit(int review_no);
	public void getData(int review_no, Model model);
	public void replyAdd(ReviewRepDTO dto);
	public void updateReply(ReviewRepDTO dto);
	public void deleteReply(ReviewRepDTO dto);
	public List<ReviewRepDTO> getRepList(int r_write_group);
	public void updateReplyCount(int r_write_group);
	
	// 좋아요 구현
	public void updateLike(int review_no);
	public void updateLikeCancel(int review_no);
	
	public void insertLike(int review_no, String id);
	public void deleteLike(int review_no, String id);
	
	public int likeCheck(int review_no, String id);
	public void updateLikeCheck(int review_no, String id);
	public void updateLikeCheckCancel(int review_no, String id);
}
