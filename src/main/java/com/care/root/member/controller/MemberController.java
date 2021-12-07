package com.care.root.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.care.root.common.sessionName.SessionCommonName;
import com.care.root.member.dto.MemberDTO;
import com.care.root.member.service.MemberService;

@Controller
@RequestMapping("member")
public class MemberController implements SessionCommonName{
	@Autowired MemberService ms;
	
	@GetMapping("memberInfo")
	public String memberInfo(Model model) {
		ms.memberAllList(model);
		return "member/memberAllList";
	}
	
	@GetMapping("registerForm")
	public String registerForm() {
		
		return "member/registerForm";
	}
	@PostMapping("registerWrite")
	public String registerWrite(MemberDTO dto) {
		
		int result = ms.registerWrite(dto);
		if(result == 1) {
			return "redirect:memberInfo";
		}
	
		return "redirect:registerForm";
	}
	@GetMapping("memberView")
	public String memberView(@RequestParam String id, Model model) {
		ms.memberView(id, model);
	return "member/memberView";	
	}
	@GetMapping("memberDelete")
	public String memberDelete(@RequestParam String id) {
		ms.memberDelete(id);
		return "redirect:memberInfo";
	}
	@GetMapping("loginForm")
	public String loginForm() {
		
		return "member/loginForm";
	}
	@PostMapping("loginChk")
	public String loginChk(Model model,@RequestParam String id, @RequestParam String pw) {
		int result = ms.loginChk(id, pw);
		if(result == 2 ) {
			System.out.println("admin" + id);
			model.addAttribute("adminId", id);
			return "redirect:loginSuccess";
		}else if(result == 1) {
			System.out.println("user" + id);
			model.addAttribute("userId",id);
			return "redirect:loginSuccess";
		}
		return "redirect:loginForm";
	}
	@GetMapping("loginSuccess")
	public String loginSuccess(@RequestParam(value="adminId",required = false, defaultValue = "nan") String adminId,
									@RequestParam(value="userId",required = false, defaultValue = "nan") String userId,
											HttpSession session) {
		System.out.println(adminId);
		System.out.println(userId);
		if(adminId.equals("admin")) {
			session.setAttribute(adminSession, adminId);
		}else if(!userId.equals("nan")) {
			session.setAttribute(userSession, userId);
		}
		
		
		return "member/loginForm";
	}
	@GetMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/index";
	}
 }
