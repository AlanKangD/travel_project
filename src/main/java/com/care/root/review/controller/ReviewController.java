package com.care.root.review.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.care.root.mybatis.review.ReviewMapper;
import com.care.root.review.dto.ReviewLikeDTO;
import com.care.root.review.service.ReviewFileService;
import com.care.root.review.service.ReviewService;

@Controller
@RequestMapping("review")
public class ReviewController {
	@Autowired ReviewService rs;
	@Autowired ReviewFileService rfs;
	
	//review관련 페이지 출력
	@GetMapping("review_write")
	public String review_write() {
		return "review/review_write";
	}
	@GetMapping("review_modify")
	public String review_modify(@RequestParam("review_no") int review_no, Model model) {
		rs.getData(review_no, model);
		rs.content_photo(review_no, model);
		return "review/review_modify";
	}
	@GetMapping("review_boardList")
	public String review_boardList(Model model,
			@RequestParam(required = false, defaultValue = "1") int num,
			@RequestParam(required = false) String r_search_option,
			@RequestParam(required = false) String keyword) {
		System.out.println(r_search_option);
		System.out.println(keyword);
		rs.boardList(model, num, r_search_option, keyword);
		return "review/review_boardList";
	}
	@GetMapping("review_content") 
	public String content(@RequestParam("review_no") int review_no, Model model, 
			HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		System.out.println("content실행");
		
		rs.content(review_no, model);
		
		rs.content_photo(review_no, model);
		
		return "review/review_content";
	}
	
	
	//review관련 기능 구현
	@PostMapping("r_writeSave")
	public void r_writeSave(MultipartHttpServletRequest mul,
			HttpServletResponse response,
			HttpServletRequest request,
			@RequestParam(value="photo_count", required=false, defaultValue="0") int photo_count) throws Exception {
		String message = rs.r_writeSave(mul, request, photo_count);
		PrintWriter out = null;
		response.setContentType("text/html; charset=utf-8");
		out = response.getWriter();
		out.println(message);
	    }
	
	
	@PostMapping("r_modify")
	public void r_modify(MultipartHttpServletRequest mul,
			HttpServletResponse response,
			HttpServletRequest request,
			@RequestParam(value="photo_count", required=false, defaultValue="0") int photo_count) throws Exception {
		String message = rs.r_modify(mul, request, photo_count);
		PrintWriter out = null;
		response.setContentType("text/html; charset=utf-8");
		out = response.getWriter();
		out.print(message);
	}
	@GetMapping("download")
	public void download(@RequestParam("stored_file_name") String stored_file_name,
	         HttpServletResponse response) throws Exception {
	    response.addHeader(
	   "Content-disposition","attachment;fileName="+ stored_file_name);// 파일 다운로드 받을 수 있도록
	    File file = new File(ReviewFileService.IMAGE_REPO+"/"+ stored_file_name);
	    FileInputStream in = new FileInputStream(file);
	    FileCopyUtils.copy(in, response.getOutputStream());
	    in.close();
	}
	
	@ResponseBody
	@RequestMapping(value="updateLike", method=RequestMethod.POST)
	public int updateLike(int review_no, String id) {
		
		// 해당 게시글 번호와 회원 아이디의 like_check 컬럼 값을 받아옴
		int likeCheck = rs.likeCheck(review_no, id);

		// likeCheck가 0일 때(현재 추천을 안 누른 상태)
		if(likeCheck == 0) {
			rs.insertLike(review_no, id);		// 좋아요 테이블에 값 insert,
			rs.updateLikeCheck(review_no, id);	// like_check 컬럼값 1로 변경,
			rs.updateLike(review_no);			// 게시글의 좋아요 수 +1
		// likeCheck가 1일 때(추천을 이미 누른 상태)
		} else if(likeCheck == 1) {
			rs.deleteLike(review_no, id);				// like_check 컬럼 값 0으로 변경,
			rs.updateLikeCheckCancel(review_no, id);	// 좋아요 테이블에 들어갔던 값 delete,
			rs.updateLikeCancel(review_no);				// 게시글의 좋아요 수 -1
		}
		// 로직 처리 후 likeCheck 값 넘김
		return likeCheck;
	}
	@GetMapping("review_delete")
	public void review_delete(@RequestParam("review_no") int review_no,
			HttpServletResponse response,
			HttpServletRequest request) throws Exception {
		System.out.println(review_no);
		String delete_check = rs.review_delete(review_no, request);
		
		PrintWriter out = null;
		response.setContentType("text/html; charset=utf-8");
		out = response.getWriter();
		out.println(delete_check);
	}
}
