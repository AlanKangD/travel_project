package com.care.root.myPage.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.care.root.main.dto.MyListDTO;
import com.care.root.member.dto.MemberDTO;
import com.care.root.myPage.dto.CalendarDTO;
import com.care.root.mybatis.myPage.MyPageMapper;
import com.care.root.qna.dto.QnADTO;
import com.care.root.review.dto.ReviewDTO;

@Service
public class MyPageServiceImpl implements MyPageService{
	@Autowired MyPageMapper mapper;

	@Override
	public void getUserData(String id, Model model) {
		System.out.println("qnaData id : " + id);
		ArrayList<ReviewDTO> list = mapper.getReviewData(id);
		for(ReviewDTO test : list) {
			System.out.println("id :" + test.getId()); 
			System.out.println("test :" + test.getReview_title()); 
		}
		model.addAttribute("reviewData",mapper.getReviewData(id));
		model.addAttribute("qnaData",mapper.getQnaData(id));
		
	}

	@Override
	public void getInfo(String id, Model model) {
		model.addAttribute("myInfo", mapper.getMember(id));
		
	}

	@Override
	public void usermodify(MemberDTO dto) {
		dto.setSessionId("nan");
		mapper.userModify(dto);
		
	}

	@Override
	public void userDelete(String id) {
		mapper.userDelete(id);		
	}

	@Override
	public void calendarinsert(CalendarDTO dto) {
		mapper.calendarinsert(dto);		
	}

	@Override
	public void myTripList(String id, Model model) {
		List<MyListDTO> list = mapper.myTripList(id);
		for(MyListDTO test : list) {
			System.out.println("찜한 목록 : " + test.getPlace());
			
		} // 디버깅
		model.addAttribute("myList", list);
	}

	@Override
	public ArrayList<CalendarDTO> getCalendarList(String id) {
		ArrayList<CalendarDTO> list =  mapper.getCalendarList(id);
		for(CalendarDTO test : list) {
			System.out.println("test id : " + test.getId());
			System.out.println("test title : " + test.getTitle());
			
		} 
		
		return list;
	}

	@Override
	public void deleteAllCal(String id) {
		mapper.deleteAllCal(id);
	}


	
	
	

}
