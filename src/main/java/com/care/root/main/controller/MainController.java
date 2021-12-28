package com.care.root.main.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.care.root.common.sessionName.SessionCommonName;
import com.care.root.main.dto.MainDTO;
import com.care.root.main.dto.MyListDTO;
import com.care.root.main.dto.ReplyDTO;
import com.care.root.main.service.MainService;

@RequestMapping("main")
@Controller
public class MainController implements SessionCommonName {

	@Autowired MainService ms;
	
	@GetMapping("themeList")
	public String themeList(@RequestParam String theme, Model model) {
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
		      ms.register(mul, response, request);
	   }
	
	@GetMapping("themeView")
	public String themeView(String placeName, Model model) {
		ms.themeView(placeName, model);		
		return "main/themeView";
	}
	
	@GetMapping("download")
	public void download(@RequestParam String imageFile, HttpServletResponse response)
										throws Exception{
		ms.download(imageFile, response);
	}
	
	@PostMapping("deleteView")
	public String deleteView(MainDTO dto) {
		 ms.deleteView(dto);		
		 String theme = dto.getMainCategory();
			try {
				theme = URLEncoder.encode(theme, "utf-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			return "redirect:themeList?theme="+theme;
	}
	
	@RequestMapping("modifyView")
	public String modifyView(MultipartHttpServletRequest mul) {
		ms.modifyView(mul);
		String theme = mul.getParameter("mainCategory");	
		try {
			theme = URLEncoder.encode(theme, "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return "redirect:themeList?theme="+theme;
	}
	
	@PostMapping(value="addMyList", produces = "application/json;charset=utf-8")
	@ResponseBody
	   public String addMyList(@RequestBody MyListDTO dto) {
	      return ms.addMyList(dto);
	   }
	
	@GetMapping(value = "getMyList", produces = "application/json;charset=utf-8")
	@ResponseBody // 찜하기 사진 내용 가져오기 기능 contoller ->  jsp의 header.jsp ajax myList로 작동
	public List<MyListDTO> getMyList(HttpSession session) {
		return ms.getMyList(session);
	}
	
	@DeleteMapping(value = "deleteList", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String deleteList(@RequestParam int listNo) {
		return ms.deleteMyList(listNo);
	}
	
	// 댓글 
	
	@PostMapping(value ="addReply", produces="application/json;charset=utf-8")
	@ResponseBody
	public String addReply(@RequestBody ReplyDTO dto) {
		return ms.addReply(dto);
	}

	@GetMapping(value ="getReply", produces="application/json;charset=utf-8")
	@ResponseBody
	public Map<String, Object> getReply(@RequestParam String placeName,@RequestParam int num) {
		return ms.getReply(placeName, num);
	}
	
	@DeleteMapping(value = "deleteReply", produces="application/json;charset=utf-8")
	@ResponseBody
	public String deleteReply(@RequestParam int repNo) {
		return ms.deleteReply(repNo);
	}
	
	@PostMapping(value="likeCheck", produces="application/json;charset=utf-8")
	@ResponseBody
	public String likeCheck(@RequestParam int repNo,@RequestParam String id) {
		return ms.likeCheck(repNo,id);
	}	
}
