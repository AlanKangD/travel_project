package com.care.root.main.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.care.root.common.sessionName.SessionCommonName;
import com.care.root.main.dto.MainDTO;
import com.care.root.main.dto.MyListDTO;
import com.care.root.main.service.MainService;

@RequestMapping("main")
@Controller
public class MainController implements SessionCommonName {

	@Autowired MainService ms;
	
	@GetMapping("themeList")
	public String themeList(@RequestParam String theme, Model model) {
		System.out.println("테마리스트 테마 확인 : " + theme);
		ms.themeList(model, theme);
		model.addAttribute("theme", theme);
		return "main/themeList";
	}
	
	@GetMapping("addPlace")
	public String addFormView(@RequestParam String theme, Model model) {
		model.addAttribute("theme", theme);
		return "main/addForm";
	}
	
	@PostMapping("register")
	   public void register(MultipartHttpServletRequest mul,HttpServletResponse response,
	                                    HttpServletRequest request) throws Exception {
		System.out.println("테마확인 : " + mul.getParameter("mainCategory"));
	      ms.register(mul, response, request);
	   }
	
	@GetMapping("themeView")
	public String themeView(String placeName, Model model) {
		System.out.println("modify에서 잘 넘어갓나2 :" +placeName);
		ms.themeView(placeName, model);		
		return "main/themeView";
	}
	
	@GetMapping("download")
	public void download(@RequestParam String mainImageFile, HttpServletResponse response)
										throws Exception{
		ms.download(mainImageFile, response);
	}
	
	@RequestMapping(value = "/modifyView", produces="text/plain; charset=UTF-8")
	public String modifyView(MultipartHttpServletRequest mul, RedirectAttributes ra, Model model) {
		ms.modifyView(mul);
		System.out.println("modifyView1 : " + mul.getParameter("placeName"));
		String placeName = mul.getParameter("placeName");
		String theme = mul.getParameter("mainCategory");
		try {
			theme = URLEncoder.encode(theme, "utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ra.addFlashAttribute("placeName", placeName);
		System.out.println(ra.getAttribute("placeName"));
		model.addAttribute("placeName", placeName);
		System.out.println("테마: " + mul.getParameter("mainCategory"));
		
		
	//	return "redirect:themeView";
		return "redirect:themeList?theme="+theme; //한글 문제 
	}
	
	
	@DeleteMapping(value ="deleteView",  produces = "application/json;charset=utf-8" )
	@ResponseBody
	public String deleteView(@RequestParam String placeName) {		
		System.out.println("deleteView로그 확인 : " + placeName);
		return ms.deleteView(placeName);
	}
	
	
	@PostMapping(value="addMyList", produces = "application/json;charset=utf-8")
	@ResponseBody
	   public String addMyList(@RequestBody MyListDTO dto) {
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
