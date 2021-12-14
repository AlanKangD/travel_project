package com.care.root.review.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

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
		return "review/review_modify";
	}
	@GetMapping("review_boardList")
	public String review_boardList(Model model,
			@RequestParam(required = false, defaultValue = "1") int num) {
		rs.boardList(model, num);
		return "review/review_boardList";
	}
	@GetMapping("review_content")
	public String content(@RequestParam("review_no") int review_no, Model model, 
			HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		System.out.println("content실행");
		
		rs.content(review_no, model);
		return "review/review_content";
	}
	
	@ResponseBody
	@RequestMapping(value="updateLike", method=RequestMethod.POST)
	public int updateLike(int review_no, String id) {
		int likeCheck = rs.likeCheck(review_no, id);
		System.out.println(likeCheck);
		if(likeCheck == 0) {
			// 좋아요 처음 누름
			rs.insertLike(review_no, id);				// like 테이블 삽입
			rs.updateLike(review_no);					// 게시판 테이블 +1
			rs.updateLikeCheck(review_no, id);			// like 테이블 구분자 1
		} else if(likeCheck == 1) {
			rs.updateLikeCheckCancel(review_no, id);	// like 테이블 구분자 0
			rs.updateLikeCancel(review_no);				// 게시판 테이블 -1
			rs.deleteLike(review_no, id);				// like 테이블 삭제
		}
		return likeCheck;
	}
	
	//review관련 기능 구현
	@PostMapping("writeSave")
	public void writeSave(MultipartHttpServletRequest mul,
			HttpServletResponse response,
			HttpServletRequest request) throws Exception {
		String message = rs.writeSave(mul, request);
		PrintWriter out = null;
		response.setContentType("text/html; charset=utf-8");
		out = response.getWriter();
		out.println(message);
	}
	
	@PostMapping("modify")
	public void modify(MultipartHttpServletRequest mul,
			HttpServletResponse response,
			HttpServletRequest request) throws Exception {
		String message = rs.modify(mul, request);
		PrintWriter out = null;
		response.setContentType("text/html; charset=utf-8");
		out = response.getWriter();
		out.print(message);
	}
	@GetMapping("download")
	public void download(@RequestParam("review_file_name") String review_file_name,
	         HttpServletResponse response) throws Exception {
	    response.addHeader(
	   "Content-disposition","attachment;fileName="+ review_file_name);
	    File file = new File(ReviewFileService.IMAGE_REPO+"/"+ review_file_name);
	    FileInputStream in = new FileInputStream(file);
	    FileCopyUtils.copy(in, response.getOutputStream());
	    in.close();
	}
}
