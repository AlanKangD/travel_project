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
	

}
