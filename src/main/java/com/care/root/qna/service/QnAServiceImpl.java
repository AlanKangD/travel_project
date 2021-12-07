package com.care.root.qna.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

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
		
		List<QnADTO> list = mapper.qnaAllList(start, end);
		replyConfirm(list);

        model.addAttribute("dataCount",dataCount);
        model.addAttribute("nowday",makeNew());
		model.addAttribute("repeat",repeat);
		model.addAttribute("qnaList",list);		
	}	
	
	private String makeNew() { // [new] 새글 로직
		   SimpleDateFormat simp = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
		   Calendar cal = Calendar.getInstance();
	       cal.add(Calendar.DAY_OF_MONTH, -1); //1일간 보이도록 하기위해서 (전날 현재시간과 비교)
	       String nowday = simp.format(cal.getTime());
		   return nowday;
	   }
	
	private List<QnADTO> replyConfirm(List<QnADTO> list){ 
		List<QnARepDTO> repList = mapper.repAllList();
		
		if(repList.size() == 0) {
			for(QnADTO dto : list) {
				dto.setRepCheck("답변예정");
			}
		}else {	
			for(QnADTO dto : list) {
				for(QnARepDTO repDto : repList) {
					if(dto.getQnaNo() ==  repDto.getQrWriteGroup()) {
						dto.setRepCheck("답변완료");
						break;
					}else {
						dto.setRepCheck("답변예정");
					}
				}
			}
		}	
		return list;
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

//	@Override
//	public void contentView(int qnaNo,String pwd, Model model) {
//		QnADTO dto = mapper.contentView(qnaNo);
//		
//		if(dto.getQnaPwd() == null) {
//			upHit(qnaNo);
//		}else {
//			if(pwd != null) {
//				model.addAttribute("pwd",pwd);
//				upHit(qnaNo);
//			}
//		}
//		model.addAttribute("dto",dto);
//	}
	
	@Override
	public int contentView(int qnaNo, Model model) {	
		int result = 0 ;			
		QnADTO	dto = mapper.contentView(qnaNo);
		if(dto.getQnaPwd() == null) {  // 비밀번호가 없으면(=비밀글이 아니면) 0
			upHit(qnaNo);	
	   		model.addAttribute("dto", dto);
		} else {  //비밀글이면  1 
				model.addAttribute("qnaPwd", dto.getQnaPwd());
				model.addAttribute("qnaNo", qnaNo);
				result = 1;
		}   
		return result;
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

//	@Override
//	public void pwdCheck(int qnaNo,String qnaPwd, HttpServletResponse response, 
//													HttpServletRequest request) {
//		
//		QnADTO dto = mapper.contentView(qnaNo);
//		int result = 0;
//		String msg, url;
//		
//		if(dto != null && encoder.matches(qnaPwd, dto.getQnaPwd())) {
//				msg = "비밀번호 일치";
//		    	url = "/qna/contentView?qnaNo="+qnaNo+"&pwd=true";
//			}else {
//				msg = "비밀글 비밀번호가 틀립니다.";
//		    	  url = "/qna/pwdForm?qnaNo="+qnaNo;
//			}
//		
//		String message = getMessage(request, msg, url);
//	      
//	    PrintWriter out = null;
//		response.setContentType("text/html; charset=utf-8");
//		try {
//			out = response.getWriter();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		out.println(message);
//	}
	
	@Override
	public int secretPwdChk(String userPwd, int qnaNo, Model model,
								HttpServletResponse response) {
		int result = 0;	
		PrintWriter out = null;
		QnADTO dto = mapper.contentView(qnaNo);
		if(encoder.matches(userPwd,dto.getQnaPwd())) {			
			upHit(qnaNo);
			model.addAttribute("dto", dto);
			result =1;
		}else {			
			model.addAttribute("check", "fail");
			model.addAttribute("qnaNo", qnaNo);
			model.addAttribute("qnaPwd", dto.getQnaPwd());
		}
		return result;
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

	@Override
	public List<QnARepDTO> getReply(int qnaWriteGroup) {
		return mapper.getReply(qnaWriteGroup);
	}
	
}
