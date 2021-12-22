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
	
<<<<<<< HEAD
	public String writeSave(MultipartHttpServletRequest mul,
			HttpServletRequest request) {
=======
	public String r_writeSave(MultipartHttpServletRequest mul,
			HttpServletRequest request, int photo_count) {
		
		int result_content_save = 0;
		int result_photo_save = 1;
		ArrayList<Integer> result_photo = new ArrayList<Integer>();
		
>>>>>>> 6e5821183581dcad68c3d0fa477fca163e981a3a
		ReviewDTO dto = new ReviewDTO();
		dto.setId(mul.getParameter("id"));
		dto.setReview_title(mul.getParameter("review_title"));
		dto.setReview_content(mul.getParameter("review_content"));
		
<<<<<<< HEAD
		MultipartFile file = mul.getFile("review_file_name");
		if(file.getSize() != 0) {
			dto.setReview_file_name(rfs.saveFile(file));//
		}else {
			dto.setReview_file_name("nan");
=======
		for(int i = 0; i < photo_count ; i++) {
			ReviewPhotoDTO photo_dto = new ReviewPhotoDTO();
			
			MultipartFile file = mul.getFile("review_file_name_" + i);
			
			System.out.println("file : "+file);
			if(file != null) {
				photo_dto.setId(mul.getParameter("id"));
				photo_dto.setReview_title(mul.getParameter("review_title"));
				photo_dto.setOriginal_file_name(rfs.save_original_file(file));
				photo_dto.setStored_file_name(rfs.save_stored_file(file));
			}else {
				photo_dto.setId(mul.getParameter("id"));
				photo_dto.setReview_title("review_title");
				photo_dto.setOriginal_file_name("nan");
				photo_dto.setStored_file_name("nan");
			}
			result_photo.add(i, mapper.photo_save(photo_dto));
>>>>>>> 6e5821183581dcad68c3d0fa477fca163e981a3a
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
	
<<<<<<< HEAD
	public String modify(MultipartHttpServletRequest mul,
			HttpServletRequest request) {
=======
	public String r_modify(MultipartHttpServletRequest mul,
			HttpServletRequest request, int photo_count) {
		
		int result_content_modify = 0;
		int result_photo_modify = 1;
		ArrayList<Integer> result_photo = new ArrayList<Integer>();
>>>>>>> 6e5821183581dcad68c3d0fa477fca163e981a3a
		ReviewDTO dto = new ReviewDTO();
		
		dto.setReview_no(Integer.parseInt(mul.getParameter("review_no")));
		dto.setReview_title(mul.getParameter("review_title"));
		dto.setReview_content(mul.getParameter("review_content"));
		result_content_modify = mapper.r_modify(dto);
		
<<<<<<< HEAD
		MultipartFile file = mul.getFile("review_file_name");
		if(file.getSize() != 0 ) {
	         //이미지 변경시
	    	  dto.setReview_file_name(rfs.saveFile(file));
	    	  rfs.deleteImage(mul.getParameter("originFileName"));
	      }else {
	         dto.setReview_file_name(mul.getParameter("originFileName"));
	      }
		int result = mapper.modify(dto);
=======
		for(int j = 0; j < 10 ;j++) {//기존 파일 update하는 곳
			ReviewPhotoDTO photo_dto_old = new ReviewPhotoDTO();
			
			if(mul.getParameter("original_file_name_" + j) != null && mul.getParameter("original_file_" + j) != null) {//original_file_name_숫자가 없으면 같은 값을 가지고있는 original_file_숫자로 폴더에 저장된 파일 삭제
				
			}else {
				if(mul.getParameter("original_file_" + j) != null) {
					rfs.deleteImage(mul.getParameter("original_file_" + j));
					photo_dto_old.setOriginal_file_name(mul.getParameter("original_file_" + j));
					result_photo.add(mapper.photo_delete(photo_dto_old));
				}
			}
		}
		for(int i = 0; i < 10 ; i++) {//새로운 파일 insert하는 곳
			if(mul.getFile("review_file_" + i) != null) {
				ReviewPhotoDTO photo_dto = new ReviewPhotoDTO();
				
				MultipartFile file = mul.getFile("review_file_" + i);
				
				System.out.println("추가된 file : "+file);
				if(file.getSize() != 0 ) {
			         //이미지 변경시
					photo_dto.setId(mul.getParameter("id"));
					photo_dto.setReview_title(mul.getParameter("review_title"));
					photo_dto.setOriginal_file_name(rfs.save_original_file(file));
					photo_dto.setStored_file_name(rfs.save_stored_file(file));
					result_photo.add(mapper.photo_save(photo_dto));
				}
			}
		}
		
>>>>>>> 6e5821183581dcad68c3d0fa477fca163e981a3a
		String msg, url;
		for(int j = 3; j< photo_count; j++) {
			if(result_photo.get(j) == 0) {
				result_photo_modify = 0;
			}
		}
		if(result_content_modify == 1 && result_photo_modify == 1) {
			msg = "리뷰가 수정되었습니다.";
			url = "/review/review_boardList";
		}else {
			msg = "리뷰 수정 실패";
			url = "/review/review_write";
		}
		
		return rfs.getMessage(request, msg, url);
	}
	
<<<<<<< HEAD
	public void boardList(Model model, int num) {
		int pageLetter = 100;
		int allCount = mapper.selectReviewCount();
		int repeat = allCount / pageLetter;
		if(allCount % pageLetter != 0) {
			repeat += 1;
=======
	public String review_delete(int review_no, HttpServletRequest request) {
		int result = mapper.review_delete(review_no);
		String msg, url;
		
		if(result == 1) {
			msg = "성공적으로 삭제 되었습니다";
			url = "/review/review_boardList"; 
		}else {
			msg = "성공적으로 삭제 되었습니다";
			url = "/review/review_content?review_no = ${review_no}";
>>>>>>> 6e5821183581dcad68c3d0fa477fca163e981a3a
		}
		String message = rfs.getMessage(request, msg, url);
		
		return message;
	}
	
	public void boardList(Model model, int num, String r_search_option, String keyword) {
	      int pageLetter = 5;
	      int dataCount = mapper.selectReviewCount(r_search_option, keyword);
	      int repeat = dataCount / pageLetter;
	      if(dataCount % pageLetter != 0) {
	         repeat += 1;
	      }
	      int end = num * pageLetter;
	      int start = end + 1 - pageLetter;
	      
	      int pagingNum = 5; // 페이징 넘버링 개수(1 ~ 5 / 6 ~ 10)
	      int beginPage = 0;
	      int endPage = 0;
	      
	      int pageingCount = (num-1) / pagingNum;
	      beginPage = pageingCount * pagingNum + 1 ;
	      endPage = beginPage + 4; // 10개로한다면 여기 +5해줘야한다
	      
	      if(repeat < endPage) {
	         endPage = repeat;
	      }
	      
	      model.addAttribute("keyword", keyword);
	      model.addAttribute("search_option", r_search_option);
	      model.addAttribute("dataCount",dataCount);
	      model.addAttribute("beginPage",beginPage);
	      model.addAttribute("endPage",endPage);
	      model.addAttribute("repeat", repeat);
	      model.addAttribute("boardList", mapper.boardList(start, end, r_search_option, keyword));
	   }
	
	//content.jsp 내용 불러오기
	public void content(int review_no, Model model) {
		upHit(review_no);
		model.addAttribute("contentData", mapper.content(review_no));
<<<<<<< HEAD
=======
	}
	
	//content.jsp 사진 불러오는 기능
	public void content_photo(int review_no, Model model){
		model.addAttribute("photo_view", mapper.photo_view(review_no));
>>>>>>> 6e5821183581dcad68c3d0fa477fca163e981a3a
	}
	
	//조회수 증가 기능
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
	@Override
	public void deleteLike(int review_no, String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("review_no", review_no);
		mapper.deleteLike(map);
	}
	@Override
	public int likeCheck(int review_no, String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("review_no", review_no);
		return mapper.likeCheck(map);
	}
	@Override
	public void updateLikeCheck(int review_no, String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("review_no", review_no);
		mapper.updateLikeCheck(map);
	}
	@Override
	public void updateLikeCheckCancel(int review_no, String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("review_no", review_no);
		mapper.updateLikeCheckCancel(map);
	}

	@Override
	public void updateReplyCount(int r_write_group) {
		mapper.updateReplyCount(r_write_group);
	}

	@Override
	public String r_writeSave(MultipartHttpServletRequest mul, HttpServletRequest request, int photo_count) {
		return null;
	}

	@Override
	public String r_modify(MultipartHttpServletRequest mul, HttpServletRequest request) {
		return null;
	}
	
	

	
	
}
