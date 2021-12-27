package com.care.root.mybatis.member;

import java.util.ArrayList;

import com.care.root.member.dto.MemberDTO;

public interface MemberMapper {
	public ArrayList<MemberDTO> memberAllList(); //회원 전체 보기 기능
	public int registerWrite(MemberDTO dto); //회원 가입 기능
	public MemberDTO getMember(String id); //회원 조회 기능
	public void memberDelete(String id);//회원 삭제 기능
	public void memberModify(MemberDTO dto); //회원 수정 기능
	public int idChk(String id); //아이디 중복체크
	
}
