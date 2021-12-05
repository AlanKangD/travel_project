package com.care.root.qna.service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.care.root.mybatis.qna.QnAMapper;
import com.care.root.qna.dto.QnADTO;
import com.care.root.qna.dto.QnARepDTO;

@Service
public class QnAServiceImpl implements QnAService{
	@Autowired QnAMapper mapper;
	BCryptPasswordEncoder encoder;
	
	public QnAServiceImpl() {
		encoder = new BCryptPasswordEncoder();
	}
	
	@Override
	public void qnaAllList(Model model, int num) {
		int pageLetter = 4;
		int dataCount = mapper.getDataCount();
		int repeat = dataCount / pageLetter;
		if(dataCount % pageLetter != 0) {
			repeat += 1;
		}
		
		int end = num * pageLetter;
		int start = end + 1 - pageLetter;
		
		model.addAttribute("repeat",repeat);
		model.addAttribute("qnaList",mapper.qnaAllList(start, end));
	}	

	@Override
	public void writeSave(QnADTO dto, HttpServletRequest request,HttpServletResponse response) {
		int result = 0;
		String msg, url;
		
		if(!dto.getQnaPwd().equals("")) {
			String securePw = encoder.encode(dto.getQnaPwd());
			dto.setQnaPwd(securePw);
		}
		
		try {
			result = mapper.writeSave(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(result == 1) {
	    	  msg = "새로운 문의글이 추가되었습니다.";
	    	  url = "/qna/allList";
	      }else {
	    	  msg = "오류가 발생했습니다.";
	    	  url = "/qna/writeForm";  
	      }
		
		String message = getMessage(request, msg, url);
	      
	    PrintWriter out = null;
		response.setContentType("text/html; charset=utf-8");
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		out.println(message);
	  
	}
	
	
	private String getMessage(HttpServletRequest request, String msg, String url) {
		String message = null;
		String path = request.getContextPath();
		message = "<script>alert('"+msg+"');";
		message += "location.href='"+path+url+"'; </script>";

		return message;
	}

	@Override
	public void contentView(int qnaNo,String pwd, Model model) {
		QnADTO dto = mapper.contentView(qnaNo);
		
		if(dto.getQnaPwd() == null) {
			upHit(qnaNo);
		}else {
			if(pwd != null) {
				model.addAttribute("pwd",pwd);
				upHit(qnaNo);
			}
		}
		model.addAttribute("dto",dto);
	}
	
	private void upHit(int qnaNo) {
		mapper.upHit(qnaNo);	
	}
	
	@Override
	public void modify(QnADTO dto, HttpServletResponse response, HttpServletRequest request) {
		int result = 0;
		String msg, url;
		
		result = mapper.modify(dto);
		
		if(result == 1) {
			msg = "글이 수정되었습니다.";
			url = "/qna/allList";
		}else {
			msg = "수정하는중 오류가 발생하였습니다.";
			url = "/qna/contentView?qnaNo="+dto.getQnaNo();
		}
		
		String message = getMessage(request,msg,url);
		
		PrintWriter out = null;
		response.setContentType("text/html; charset=utf-8");
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		out.println(message);
		
	}
	

	@Override
	public void delete(int qnaNo, HttpServletResponse response, HttpServletRequest request) {
		int result = 0;
		String msg, url;
		
		result = mapper.delete(qnaNo);		
		
		if(result == 1) {
			msg = "글이 삭제되었습니다.";
			url = "/qna/allList";
		}else {
			msg = "삭제도중 오류가 발생하였습니다.";
			url = "/qna/contentView?qnaNo="+qnaNo;
		}
		
		String message = getMessage(request,msg,url);
		
		PrintWriter out = null;
		response.setContentType("text/html; charset=utf-8");
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		out.println(message);
	}

	@Override
	public void getDataCount() {
		mapper.getDataCount();
	}

	@Override
	public void pwdCheck(int qnaNo,String qnaPwd, HttpServletResponse response, 
													HttpServletRequest request) {
		
		QnADTO dto = mapper.contentView(qnaNo);
		int result = 0;
		String msg, url;
		
		if(dto != null && encoder.matches(qnaPwd, dto.getQnaPwd())) {
				msg = "비밀번호 일치";
		    	url = "/qna/contentView?qnaNo="+qnaNo+"&pwd=true";
			}else {
				msg = "비밀글 비밀번호가 틀립니다.";
		    	  url = "/qna/pwdForm?qnaNo="+qnaNo;
			}
		
		String message = getMessage(request, msg, url);
	      
	    PrintWriter out = null;
		response.setContentType("text/html; charset=utf-8");
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		out.println(message);
	}

	@Override
	public String addReply(QnARepDTO dto) {
		int result = 0;
		result = mapper.addReply(dto);
		if(result == 1) {
			return "{\"result\" : true}";
		}else {
			return "{\"result\" : false}";
		}
	}
	
}
