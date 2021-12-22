package com.care.root.review.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.care.root.review.dto.ReviewLikeDTO;
import com.care.root.review.dto.ReviewRepDTO;

public interface ReviewService {
	public String r_writeSave(MultipartHttpServletRequest mul,
			HttpServletRequest request, int photo_count);
	public String r_modify(MultipartHttpServletRequest mul,
			HttpServletRequest request);
	
	/* 게시판, 글 상세보기 */
	public void boardList(Model model, int num);		// 게시판 글 목록
	public void content(int review_no, Model model);	// 게시글 상세보기
	public void upHit(int review_no);					// 조회수 증가
	public void getData(int review_no, Model model);	// 상세보기 시 해당 글의 데이터 불러옴
	
	/* 댓글 */
	public void replyAdd(ReviewRepDTO dto);				// 댓글 등록
	public void updateReply(ReviewRepDTO dto);			// 댓글 수정
	public void deleteReply(ReviewRepDTO dto);			// 댓글 삭제
	public void updateReplyCount(int r_write_group);	// 댓글 개수
	public List<ReviewRepDTO> getRepList(int r_write_group);	// 댓글 목록
	
	/* 좋아요 기능 */
	public int likeCheck(int review_no, String id);	// like_check 컬럼을 통해 좋아요를 눌렀는지(1) 안 눌렀는지(0) 체크
	
	public void insertLike(int review_no, String id);	// 0 이라면(처음 추천) 테이블 insert
	public void deleteLike(int review_no, String id);	// 1 이라면(추천 취소) 테이블 delete
	
	public void updateLikeCheck(int review_no, String id);		// insert 후 like_check 1로
	public void updateLikeCheckCancel(int review_no, String id);// delete 후 like_check 0으로
	
	public void updateLike(int review_no);			// 해당 게시글의 좋아요를 +1
	public void updateLikeCancel(int review_no);	// 해당 게시글의 좋아요를 -1
	
	
}
