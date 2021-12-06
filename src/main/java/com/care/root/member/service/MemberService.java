package com.care.root.member.service;

import org.springframework.ui.Model;

import com.care.root.member.dto.MemberDTO;

public interface MemberService {
	public void memberAllList(Model model);
	public int registerWrite(MemberDTO dto);
}
