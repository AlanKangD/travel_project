package com.care.root.mybatis.review;

import java.util.ArrayList;
import java.util.List;


import com.care.root.review.dto.ReviewDTO;

public interface ReviewMapper {
	public int writeSave(ReviewDTO dto);
	public ArrayList<ReviewDTO> boardList();
	public int modify(ReviewDTO dto);
	public void upHit(int review_no);
	public ReviewDTO content(int review_no);
}
