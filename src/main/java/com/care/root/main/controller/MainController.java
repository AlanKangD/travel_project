package com.care.root.main.controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.care.root.main.service.MainService;

@RequestMapping("main")
@Controller
public class MainController {

	@Autowired MainService ms;
	
	@GetMapping("themeList")
	public String themeList(Model model) {
		ms.themeList(model);
		return "main/themeList";
	}
	
	@GetMapping("addPlace")
	public String addFormView() {
		return "main/addForm";
	}
	
	@PostMapping("register")
	public String register(MultipartHttpServletRequest mul) {
		ms.register(mul);
		return "redirect:themeList";
	}
	
	@GetMapping("themeView")
	public String themeView(int mainId, Model model) {
		ms.themeView(mainId, model);		
		return "main/themeView";
	}
	
	@GetMapping("download")
	public void download(@RequestParam String mainImageFile, HttpServletResponse response)
										throws Exception{
		ms.download(mainImageFile, response);
	}
	
	
}
