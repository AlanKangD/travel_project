package com.care.root.member.service;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import com.care.root.member.dto.MemberDTO;

public interface MemberService {
	public void memberAllList(Model model); //회원 전체 보기기능
	public int registerWrite(MemberDTO dto); //회원 가입 기능
	public void memberView(String id, Model model); //회원 조회 기능
	public void memberDelete(String id); //회원 삭제 기능 
	public int loginChk(String id, String pw); //로그인 체크 기능
	public void memberModify(MemberDTO dto); //회원 수정 기능
	public int idChk(String id); //회원가입시 아이디 중복 체크
	
}

