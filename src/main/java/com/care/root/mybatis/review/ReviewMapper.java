package com.care.root.mybatis.review;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.care.root.review.dto.ReviewDTO;
import com.care.root.review.dto.ReviewLikeDTO;
import com.care.root.review.dto.ReviewRepDTO;

public interface ReviewMapper {
	public int writeSave(ReviewDTO dto);
	public ArrayList<ReviewDTO> boardList(@Param("s") int start, @Param("e") int end);
	public int selectReviewCount();
	public int modify(ReviewDTO dto);
	public void upHit(int review_no);
	public ReviewDTO content(int review_no);
	public void replyAdd(ReviewRepDTO dto);
	public void updateReply(ReviewRepDTO dto);
	public void deleteReply(ReviewRepDTO dto);
	public List<ReviewRepDTO> getRepList(int r_write_group);
	public int updateReplyCount(int r_write_group);
	
	// 좋아요 구현
	public int updateLike(int review_no);
	public int updateLikeCancel(int review_no);
	public void insertLike(Map<String, Object> map);
	public void deleteLike(Map<String, Object> map);
	public void updateLikeCheck(Map<String, Object> map);
	public void updateLikeCheckCancel(Map<String, Object> map);
	public int likeCheck(Map<String, Object> map);
	
}
