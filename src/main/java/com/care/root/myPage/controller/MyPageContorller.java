package com.care.root.myPage.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.care.root.member.dto.MemberDTO;
import com.care.root.myPage.dto.CalendarDTO;
import com.care.root.myPage.service.MyPageService;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

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
	public String calendarForm(@RequestParam String id , Model model) {
		mps.myTripList(id, model);
		
		
		return "myPage/calendar";
	}
	
	@PostMapping(value="saveData", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String calendar(@RequestParam String data, @RequestParam String id, Model model) {
		CalendarDTO dto = new CalendarDTO();
		System.out.println("data : " + data); //데이터가 잘 넘어오는 지 확인하는 디버깅 
		System.out.println("cal Id : " + id); //들어오는 아이디 확인 완료!
		dto.setId(id);
		try {
			List<Map<String, Object>> info = new Gson().fromJson(String.valueOf(data),
		              new TypeToken<List<Map<String, Object>>>(){}.getType());
			//String으로 가져온 이중배열을 파싱을 과정을 하기 위해서 Gson 을 사용해서 풀었습니다.
			for (Map<String, Object> plz : info) {
				System.out.println("title : " +plz.get("title"));
				System.out.println("start : " +plz.get("start"));
				System.out.println("end : " +plz.get("end"));
				
				System.out.println("-------값이 잘 들어오는지를 확인하는 디버깅");
				dto.setTitle((String) plz.get("title"));
				dto.setStart((String)plz.get("start"));
				if(plz.get("end") == null) {
					dto.setEnd("null"); //배열에서 돌아오는 값들 중에 null 이 포함 되서 넘어오는 데이터가 있기 때문에 처리
				}else {
					dto.setEnd((String)plz.get("end"));
				}
				
				System.out.println("dto id : " + dto.getId());
				System.out.println("dto title : " + dto.getTitle());
				System.out.println("dto start : " + dto.getStart());
				System.out.println("dto end : " + dto.getEnd());
				System.out.println("-------------dto 값이 잘 넘겨지는 지 확인");
				mps.chkMyCal(id);
				mps.calendarinsert(dto); //아직 데이터베이스 생성 안함 생성하면 주석 없애줄 예정
				
			}
		} catch (Exception e) {
			e.printStackTrace();		
			}
		
		return "{\"data\" : \"완료\"}";
		
	}
	
}
