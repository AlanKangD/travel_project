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
         HttpServletRequest request, int photo_count);//리뷰 작성
   public String r_modify(MultipartHttpServletRequest mul,
         HttpServletRequest request, int photo_count);//리뷰 수정
   
   public void boardList(Model model, int num, String r_search_option, String keyword);//리뷰 게시판
   public void content(int review_no, Model model);//리뷰 내용보기
   public void content_photo(int review_no, Model model);//리뷰 내용 사진불러오기
   public String review_delete(int review_no, HttpServletRequest request);//리뷰 삭제
   public void upHit(int review_no);//리뷰 조회수 갱신
   public void getData(int review_no, Model model);//조회수 갱신없이 내용 불러오기
   public void replyAdd(ReviewRepDTO dto);//댓글 추가
   public void updateReply(ReviewRepDTO dto);//댓글 업데이트
   public void deleteReply(ReviewRepDTO dto);//댓글 삭제
   public List<ReviewRepDTO> getRepList(int r_write_group);//댓글 불러오기
   public void updateReplyCount(int r_write_group);//댓글 수 
   
   // 좋아요 구현
   public void updateLike(int review_no);
   public void updateLikeCancel(int review_no);
   
   public void insertLike(int review_no, String id);
   public void deleteLike(int review_no, String id);
   
   public int likeCheck(int review_no, String id);
   public void updateLikeCheck(int review_no, String id);
   public void updateLikeCheckCancel(int review_no, String id);
}