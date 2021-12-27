package com.care.root.myPage.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.ui.Model;

import com.care.root.member.dto.MemberDTO;
import com.care.root.myPage.dto.CalendarDTO;

public interface MyPageService {
	public void getUserData(String id, Model model); //유저            글 전체 가져오기
	public void getInfo(String id, Model model); //회원의 정보 보기
	public void usermodify(MemberDTO dto); //회원 수정 기능
	public void userDelete(String id); //회원 삭제 기능
	
	
	public void calendarinsert(CalendarDTO dto); //캘린더 일정 데이터베이스 저장 기능
	public void myTripList(String id, Model model); //나의 찜목록 가져오기 기능
	public ArrayList<CalendarDTO> getCalendarList(String id); // 해당 아이디의 모든 캘린더 정보를 가져오는 기능
	public void deleteAllCal(String id); //모든 캘린더의 정보를 삭제해줍니다. 
}
