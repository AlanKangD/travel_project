package com.care.root.qna.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import com.care.root.qna.dto.QnADTO;
import com.care.root.qna.dto.QnARepDTO;

public interface QnAService {
	public void qnaAllList(Model model, int num,String searchOption, String keyword); //전체 문의글을 가져오는 기능
	public void writeSave(QnADTO dto, HttpServletRequest request, HttpServletResponse response); //작성글 저장하는 기능
	public int contentView(int qnaNo, Model model, String admin); //해당 게시물의 상세정보를 가져오는 기능
	public void modify(QnADTO dto, HttpServletResponse response, HttpServletRequest request); //문의글을 수정하는 기능 
	public void delete(int qnaNo, HttpServletResponse response, HttpServletRequest request, //문의글을 삭제하는 기능 
													String userSession,String adminSession);
	public int secretPwdChk(String userPwd, int qnaNo, Model model, //비밀글의 비밀번호가 일치하는지 확인하는 기능
									  HttpServletResponse response);
	public String addReply(QnARepDTO dto); //문의글에 작성한 댓글을 저장하는 기능
	public List<QnARepDTO> getReply(int qnaWriteGroup); //해당 문의글에 작성한 모든 댓글을 가져오는 기능
	public String repDelete(int qrId); //문의글의 댓글을 삭제하는 기능
	public void repModify(int qrId, String qrContent,HttpServletResponse response, //문의글의 댓글을 수정하는 기능 
											     		HttpServletRequest request);
}
