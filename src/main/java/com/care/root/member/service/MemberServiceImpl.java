package com.care.root.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.care.root.member.dto.MemberDTO;
import com.care.root.mybatis.member.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired MemberMapper mapper;
	BCryptPasswordEncoder encoder;
	public MemberServiceImpl() {
		encoder=new BCryptPasswordEncoder();
	}
	

	@Override
	public void memberAllList(Model model) {
		model.addAttribute("memberList",mapper.memberAllList());
		
	}

	@Override
	public int registerWrite(MemberDTO dto) {
		dto.setSessionId("nan");
		String securePw=encoder.encode(dto.getPw());
		dto.setPw(securePw);
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
			if(encoder.matches(pw,dto.getPw()) || pw.equals(dto.getPw())) {
				if(id.equals("admin")) {
					return 2; //관리자 로그인 성공
				}
			return 1; //유저 로그인 성공
			
				}		
		}
		return 0; //아이디 없음
	}

	@Override
	public void memberModify(MemberDTO dto) {
		dto.setSessionId("nan");
		mapper.memberModify(dto);
		
	}

	@Override
	public int idChk(String id) {
		System.out.println(id);
		int result=mapper.idChk(id);
		System.out.println("result : "+result);
		if(result==0) {
			return 0;  //아이디중복X     
		}else {
			return 1;  //아이디 중복
		}
	}

	

	
	

}
