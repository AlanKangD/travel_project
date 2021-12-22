package com.care.root.review.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.care.root.review.dto.ReviewRepDTO;
import com.care.root.review.service.ReviewService;

@RestController
@RequestMapping("review")
public class ReviewRepController {
	
	@Autowired ReviewService rs;
	
	@PostMapping(value="replyAdd", produces = "application/json; charset=utf-8")
	public String replyAdd(@RequestBody Map<String, Object> map) throws Exception {
		ReviewRepDTO dto = new ReviewRepDTO();
		// 가져온 아이디, 댓글 내용, 글 번호, 태그를 DTO에 넣고 replyAdd로 넘겨줌
		dto.setId( (String)map.get("replyId") );
		dto.setR_reply_content((String)map.get("replyContent"));
		dto.setR_write_group( Integer.parseInt((String)map.get("write_no")) );
		dto.setR_reply_tag( (String)map.get("tagId") );
		rs.replyAdd(dto);
		// DB에 성공적으로 값이 들어갔다면 ajax에 true 반환
		return "{\"result\" : true}";
	}
	
	@PostMapping(value="updateReply", produces = "application/json; charset=utf-8")
	public String updateReply(@RequestBody Map<String, Object> map) throws Exception {
		System.out.println("updateReply 소환");
		ReviewRepDTO dto = new ReviewRepDTO();
		System.out.println( (String)map.get("content") );
		System.out.println( (Integer)map.get("rid"));
		dto.setR_reply_content((String)map.get("content"));
		dto.setR_reply_no( (Integer)map.get("rid") );
		rs.updateReply(dto);
		return "{\"result\" : true}";
	}
	
	@PostMapping(value="deleteReply", produces = "application/json; charset=utf-8")
	public String deleteReply(@RequestBody Map<String, Object> map) throws Exception {
		ReviewRepDTO dto = new ReviewRepDTO();
		System.out.println("deleteReply 소환");
		System.out.println( (Integer)map.get("rid"));
		dto.setR_reply_no( (Integer)map.get("rid") );
		rs.deleteReply(dto);
		return "{\"result\" : true}";
	}
	
	@GetMapping(value="replyData/{r_write_group}", 
			produces="application/json;charset=utf-8")
	public List<ReviewRepDTO> replyData(@PathVariable int r_write_group) {
		ReviewRepDTO dto = new ReviewRepDTO();
		rs.updateReplyCount(r_write_group);
		return rs.getRepList(r_write_group);
	}
	
	
	

	
	
	
	

}
