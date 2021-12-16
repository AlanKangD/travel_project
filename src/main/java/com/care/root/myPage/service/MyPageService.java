package com.care.root.myPage.service;

import org.springframework.ui.Model;

import com.care.root.member.dto.MemberDTO;

public interface MyPageService {
	public void getUserData(String id, Model model); //유저            글 전체 가져오기
	public void getInfo(String id, Model model); //회원의 정보 보기
	public void usermodify(MemberDTO dto); //회원 수정 기능
	public void userDelete(String id); //회원 삭제 기능
}
