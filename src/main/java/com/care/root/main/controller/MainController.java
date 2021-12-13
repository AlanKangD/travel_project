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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.care.root.common.sessionName.SessionCommonName;
import com.care.root.main.dto.MyListDTO;
import com.care.root.main.service.MainService;

@RequestMapping("main")
@Controller
public class MainController implements SessionCommonName {

	@Autowired MainService ms;
	
	@GetMapping("themeList")
	public String themeList(@RequestParam String theme, Model model) {
		System.out.println(" 테마 들어오는지 :" );
		ms.themeList(model, theme);
		model.addAttribute("theme", theme);
		return "main/themeList";
	}
	
	@GetMapping("addPlace")
	public String addFormView(@RequestParam String theme, Model model) {
		System.out.println("값확인 : " + theme);
		model.addAttribute("theme", theme);
		return "main/addForm";
	}
	
	@PostMapping("register")
	   public void register(MultipartHttpServletRequest mul,HttpServletResponse response,
	                                    HttpServletRequest request) throws Exception {
	      ms.register(mul, response, request);
	   }
	
	@GetMapping("themeView")
	public String themeView(String placeName, Model model) {
		ms.themeView(placeName, model);		
		return "main/themeView";
	}
	
	@GetMapping("download")
	public void download(@RequestParam String mainImageFile, HttpServletResponse response)
										throws Exception{
		System.out.println("로그확인 : " + mainImageFile);
		ms.download(mainImageFile, response);
	}
	
	
	@PostMapping(value="addMyList", produces = "application/json;charset=utf-8")
	@ResponseBody
	   public String addMyList(@RequestBody MyListDTO dto) {
		System.out.println("컨트롤러 addmylist 아이디 파람 : " + dto.getId());
	      return ms.addMyList(dto);
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
