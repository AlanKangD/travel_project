package com.care.root.qna.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.care.root.common.sessionName.SessionCommonName;
import com.care.root.qna.dto.QnADTO;
import com.care.root.qna.dto.QnARepDTO;
import com.care.root.qna.service.QnAService;

@Controller
@RequestMapping("qna")
public class QnAController implements SessionCommonName{
	@Autowired QnAService qs;
	
	@GetMapping("allList")
	public String qnaAllList(Model model,
		@RequestParam(required = false, defaultValue = "1") int num,
		@RequestParam(required = false) String searchOption,
		@RequestParam(required = false) String keyword) {
		qs.qnaAllList(model,num, searchOption, keyword);
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
	   public String contentView(@RequestParam int qnaNo, Model model, HttpServletRequest req,
								   @RequestParam(required = false, defaultValue = "1") int num,
								   @RequestParam(required = false) String searchOption,
								   @RequestParam(required = false) String keyword,
								   HttpSession session) { 	   
		model.addAttribute("num",num);	
		model.addAttribute("searchOption",searchOption);	
		model.addAttribute("keyword",keyword);	
		String admin = (String)session.getAttribute(adminSession);
		int result = qs.contentView(qnaNo, model, admin);
			if(result == 1) {
				return "qna_board/secretView";
			 }
			return "qna_board/contentView";	   
	   }
	
	@PostMapping("modify")
	public void modify(QnADTO dto, HttpServletResponse response,
						HttpServletRequest request){
		
		qs.modify(dto,response,request);
	}
	
	@GetMapping("delete")
	public void delete(@RequestParam int qnaNo, HttpServletResponse response,
				HttpServletRequest request, HttpSession session) {
			qs.delete(qnaNo,response,request,(String)session.getAttribute(userSession),
											 (String)session.getAttribute(adminSession));	
	}
	
	@PostMapping("secretPwd") //비밀글 비밀번호 체크 
	public String secretPwd(@RequestParam int qnaNo,@RequestParam String inputPwd,
							Model model, HttpServletResponse response) {
		int result = qs.secretPwdChk(inputPwd, qnaNo, model, response);
		
		if(result == 1) {
			return "qna_board/contentView"; 
		}		
		return "qna_board/secretView";	
	}
	
	@PostMapping(value = "addReply", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String addReply(@RequestBody QnARepDTO dto) {
		return qs.addReply(dto);
	}
	
	@GetMapping(value = "getReply/{qnaWriteGroup}", produces = "application/json;charset=utf-8")
	@ResponseBody
	public List<QnARepDTO> getReply(@PathVariable int qnaWriteGroup) {
		return qs.getReply(qnaWriteGroup);
	}
	
	
	@PostMapping(value = "repDelete/{qrId}", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String repDelete(@PathVariable int qrId) {
		return qs.repDelete(qrId);
	}
	
	@PostMapping("repModify")
	public void repModify(@RequestParam int qrId, @RequestParam String qrContent,
								HttpServletResponse response, HttpServletRequest request) {
		System.out.println(qrId);
		System.out.println(qrContent);
		qs.repModify(qrId,qrContent,response,request);
	}
}
