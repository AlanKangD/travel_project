package com.care.root.main.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.care.root.common.sessionName.SessionCommonName;
import com.care.root.main.dto.MyListDTO;
import com.care.root.main.service.MainService;

@RequestMapping("main")
@Controller
public class MainController implements SessionCommonName {

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
		System.out.println("로그확인 : " + mainImageFile);
		ms.download(mainImageFile, response);
	}
	
	//ajax로 쓰기 
	@PostMapping("addMyList")
	public String addMyList(MyListDTO dto, @RequestParam int mainId) {
		ms.addMyList(dto);
		return"redirect:themeView?mainId="+mainId;
	}

	@GetMapping(value = "getMyList", produces = "application/json;charset=utf-8")
	@ResponseBody
	public List<MyListDTO> getMyList(HttpSession session) {
		return ms.getMyList(session);
	}
	
	@DeleteMapping(value = "deleteList", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String deleteList(@RequestParam int listNo) {
		return ms.deleteMyList(listNo);
	}
	
}
