package com.care.root.qna.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import com.care.root.qna.dto.QnADTO;
import com.care.root.qna.dto.QnARepDTO;

public interface QnAService {
	public void qnaAllList(Model model, int num,String searchOption,String keyword);
	public void writeSave(QnADTO dto, HttpServletRequest request,HttpServletResponse response);
	public int contentView(int qnaNo, Model model);
	public void modify(QnADTO dto, HttpServletResponse response,HttpServletRequest request);
	public void delete(int qnaNo, HttpServletResponse response,HttpServletRequest request,
															String userSession,String adminSession);
	public int secretPwdChk(String userPwd, int qnaNo, Model model,
														HttpServletResponse response);
	public String addReply(QnARepDTO dto);
	public List<QnARepDTO> getReply(int qnaWriteGroup);
	public String repDelete(int qrId);
	public void repModify(int qrId, String qrContent,HttpServletResponse response,
																	HttpServletRequest request);
}
