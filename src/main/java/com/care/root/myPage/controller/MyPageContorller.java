package com.care.root.myPage.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.care.root.member.dto.MemberDTO;
import com.care.root.myPage.service.MyPageService;

@Controller
@RequestMapping("myPage")
public class MyPageContorller {
	@Autowired MyPageService mps;
	
	
	@GetMapping("myPageList")
	public String myPageData() {
		
		return "myPage/myPageList";
	}
	@GetMapping("myWriteSave")
	public String myWriteSave(@RequestParam String id, Model model) {
		System.out.println("myWriteSave id : " + id);
		mps.getUserData(id, model);
		
		return "myPage/myWriteSave";
	}
	
	@GetMapping("myInfo")
	public String myInfo(@RequestParam String id,  Model model) {
		mps.getInfo(id, model);		
		
		return "myPage/myInfo";
	}
	
	@GetMapping("ModifyForm")
	public String ModifyForm(@RequestParam String id, Model model) {
		model.addAttribute("id", id);
		return "myPage/ModifyForm";
	}
	
	@PostMapping("myPage/userModify")
	public String userModify(MemberDTO dto, Model model) {
		model.addAttribute("id",dto.getId());
		mps.usermodify(dto);
		return "redirect:myInfo";
	}
	@GetMapping("myPage/Delete")
	public String Delete(@RequestParam String id, Model model, HttpSession session){
		mps.userDelete(id);
		session.invalidate();
		return "redirect:/index";
	}
	
	@GetMapping("calendar")
	public String calendar(@RequestParam String id) {
		
		return "myPage/calendar";
	}
	
}
