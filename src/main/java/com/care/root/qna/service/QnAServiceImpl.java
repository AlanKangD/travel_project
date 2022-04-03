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
import javax.servlet.http.HttpSession;

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
	public void qnaAllList(Model model, int num,String searchOption,String keyword) {
		int pageLetter = 8;
		int end = num * pageLetter;
		int start = end + 1 - pageLetter;
		pagingNum(model, num, searchOption, keyword);
		
		List<QnADTO> list = mapper.qnaAllList(start, end, searchOption, keyword);
		List<QnADTO> noticeList = mapper.noticeList();
		
		model.addAttribute("searchOption",searchOption);
		model.addAttribute("keyword",keyword);
        model.addAttribute("nowday",makeNew());
		model.addAttribute("qnaList",replyConfirm(list));		
		model.addAttribute("noticeList",noticeList);		
	}	
	
	private void pagingNum(Model model, int num, String searchOption, String keyword){
		int pageLetter = 8;
		int dataCount = mapper.getDataCount(searchOption, keyword);
		int repeat = dataCount / pageLetter;
		if(dataCount % pageLetter != 0) {
			repeat += 1;
		}
		int pagingNum = 5; // 페이징 넘버링 개수(1 ~ 5 / 6 ~ 10)
		int beginPage = 0;
		int endPage = 0;
		
		int pagingCount = (num-1) / pagingNum; // (0 ~ 4 / 5 ~ 9)
		beginPage = pagingCount * pagingNum + 1 ;
		endPage = beginPage + 4; // 10개로 한다면 여기 +5 해줘야한다
		
		if(repeat < endPage) {
			endPage = repeat;
		}			
		model.addAttribute("beginPage",beginPage);
		model.addAttribute("endPage",endPage);
		model.addAttribute("dataCount",dataCount);
		model.addAttribute("repeat",repeat);
	}
	
	private String makeNew() {
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
	
	@Override
	public int contentView(int qnaNo, Model model, String admin) {	
		int result = 0 ;			
		QnADTO	dto = mapper.contentView(qnaNo);
		if(dto.getQnaPwd() == null || admin != null) {  // 비밀번호가 없으면(=비밀글이 아니면) 0
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
	public void delete(int qnaNo, HttpServletResponse response, HttpServletRequest request,
											String userSession,String adminSession){
		int result = 0;
		String msg, url;
		
		QnADTO	dto = mapper.contentView(qnaNo);
		
		if(adminSession == null && userSession == null) {
			msg = "글을 작성한사람 혹은 관리자만 삭제 가능합니다.";
			url = "/qna/allList";
		}else if(userSession != null && !dto.getId().equals(userSession)){
			msg = "글을 작성한사람 혹은 관리자만 삭제 가능합니다.";
			url = "/qna/allList";
		}else {
			result = mapper.delete(qnaNo);		
			
			if(result == 1) {
				msg = "글이 삭제되었습니다.";
				url = "/qna/allList";
			}else {
				msg = "삭제도중 오류가 발생하였습니다.";
				url = "/qna/contentView?qnaNo="+qnaNo;
			}
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
	public int secretPwdChk(String userPwd, int qnaNo, Model model,
								HttpServletResponse response) {
		System.out.println("여기들어옴?");
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

	@Override
	public String repDelete(int qrId) {
		int result = 0;
		result = mapper.repDelete(qrId);
		if(result == 1) {
			return "{\"result\" : true}";
		}else {
			return "{\"result\" : false}";
		}
	}

	@Override
	public void repModify(int qrId, String qrContent, HttpServletResponse response, 
																HttpServletRequest request) {
		int result = 0;
		String msg, url;
		
		result = mapper.repModify(qrId,qrContent);
		
		if(result == 1) {
			msg = "답변이 수정되었습니다.";
			url = "/qna/allList";
		}else {
			msg = "수정하는중 오류가 발생하였습니다.";
			url = "/qna/allList";
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
	
}
