package com.care.root.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.care.root.member.service.MemberService;

@Controller
@RequestMapping("member")
public class MemberController {
	@Autowired MemberService ms;
	
	@GetMapping("memberInfo")
	public String memberInfo(Model model) {
		ms.memberAllList(model);
		return "member/memberAllList";
	}
	
	
 }
