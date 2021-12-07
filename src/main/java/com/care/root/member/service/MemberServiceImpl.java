package com.care.root.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.care.root.member.dto.MemberDTO;
import com.care.root.mybatis.member.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired MemberMapper mapper;

	@Override
	public void memberAllList(Model model) {
		model.addAttribute("memberList",mapper.memberAllList());
		
	}

	@Override
	public int registerWrite(MemberDTO dto) {
		dto.setSessionId("nan");
		int result=mapper.registerWrite(dto);
		return result;
	}

	@Override
	public void memberView(String id, Model model) {
		model.addAttribute("user",mapper.getMember(id));
		
		
	}

	@Override
	public void memberDelete(String id) {
		mapper.memberDelete(id);
	}
	
	@Override
	public int loginChk( String id, String pw) {
		MemberDTO dto = mapper.getMember(id);
		if(dto != null) {
			if(dto.getPw().equals(pw)) {
				if(id.equals("admin")) {
					return 2; //관리자 로그인 성공
				}
			return 1; //유저 로그인 성공
			}		
		}
		return 0; //아이디 없음
	}
	

}
