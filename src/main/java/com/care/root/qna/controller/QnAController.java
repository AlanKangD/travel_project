package com.care.root.qna.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.care.root.qna.dto.QnADTO;
import com.care.root.qna.dto.QnARepDTO;
import com.care.root.qna.service.QnAService;

@Controller
@RequestMapping("qna")
public class QnAController {
	@Autowired QnAService qs;
	
	@GetMapping("allList")
	public String qnaAllList(Model model,
					@RequestParam(required = false, defaultValue = "1") int num) {
		qs.qnaAllList(model,num);
		return "qna_board/allList";
	}
	
	@GetMapping("writeForm")
	public String writeForm() {
		
		return "qna_board/writeForm";
	}
	
	@PostMapping("writeSave")
	public void writeSave(QnADTO dto, HttpServletResponse response,
	         							HttpServletRequest request) throws Exception {
		qs.writeSave(dto, request, response);
	}
	
	@GetMapping("contentView")
	public String contentView(@RequestParam int qnaNo, Model model,
								@RequestParam(required = false) String pwd) {
		qs.contentView(qnaNo,pwd, model);
		return "qna_board/contentView";
	}
	
	@PostMapping("modify")
	public void modify(QnADTO dto, HttpServletResponse response,
						HttpServletRequest request){
		
		qs.modify(dto,response,request);
	}
	
	@GetMapping("delete")
	public void delete(@RequestParam int qnaNo, HttpServletResponse response,
				HttpServletRequest request) {
		
		qs.delete(qnaNo,response,request);		
	}
	
	@GetMapping("pwdForm")
	public String pwdForm(@RequestParam int qnaNo, Model model) {
		model.addAttribute("qnaNo",qnaNo);
		return "qna_board/pwdForm";
	}
	
	@PostMapping("pwdCheck")
	public void pwdCheck(QnADTO dto, HttpServletResponse response,
	         							HttpServletRequest request) throws Exception {	
		int qnaNo = dto.getQnaNo();
		String qnaPwd = dto.getQnaPwd();
		qs.pwdCheck(qnaNo, qnaPwd, response, request);
	}
	
	@PostMapping(value = "addReply", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String addReply(@RequestBody QnARepDTO dto) {
		System.out.println(dto.getId());
		System.out.println(dto.getQrContent());
		System.out.println(dto.getQrWriteGroup());
		
		String msg = qs.addReply(dto);
		
		return msg;
	}
	
}
