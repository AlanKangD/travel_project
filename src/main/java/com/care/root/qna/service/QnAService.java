package com.care.root.qna.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import com.care.root.qna.dto.QnADTO;
import com.care.root.qna.dto.QnARepDTO;

public interface QnAService {
	public void qnaAllList(Model model, int num);
	public void writeSave(QnADTO dto, HttpServletRequest request,HttpServletResponse response);
	public void contentView(int qnaNo,String pwd, Model model);
	public void modify(QnADTO dto, HttpServletResponse response,HttpServletRequest request);
	public void delete(int qnaNo, HttpServletResponse response,HttpServletRequest request);
	public void getDataCount();
	public void pwdCheck(int qnaNo,String qnaPwd, HttpServletResponse response,
																HttpServletRequest request);
	public String addReply(QnARepDTO dto);
}
