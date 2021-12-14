package com.care.root.mybatis.review;

import java.util.ArrayList;
import java.util.List;


import com.care.root.review.dto.ReviewDTO;
import com.care.root.review.dto.ReviewPhotoDTO;

public interface ReviewMapper {
	public int r_writeSave(ReviewDTO dto);
	public int photo_save(ReviewPhotoDTO photo_dto);
	public ArrayList<ReviewDTO> boardList();
	public int r_modify(ReviewDTO dto);
	public void upHit(int review_no);
	public ReviewDTO content(int review_no);
	public ReviewPhotoDTO photo_view(int review_no);
}
