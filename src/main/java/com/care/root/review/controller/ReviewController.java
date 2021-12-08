package com.care.root.review.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.care.root.mybatis.review.ReviewMapper;
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
	public String review_boardList(Model model) {
		rs.boardList(model);
		return "review/review_boardList";
	}
	@GetMapping("review_content")
	public String content(@RequestParam("review_no") int review_no, Model model) {
		System.out.println("content실행");
		rs.content(review_no, model);
		return "review/review_content";
	}
	
	
	//review관련 기능 구현
	@PostMapping("r_writeSave")
	public void writeSave(MultipartHttpServletRequest mul,
			HttpServletResponse response,
			HttpServletRequest request) throws Exception {
		String message = rs.writeSave(mul, request);
		PrintWriter out = null;
		response.setContentType("text/html; charset=utf-8");
		out = response.getWriter();
		out.println(message);
	}
	@PostMapping("r_modify")
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
