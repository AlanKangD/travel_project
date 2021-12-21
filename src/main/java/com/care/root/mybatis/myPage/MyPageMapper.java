package com.care.root.mybatis.myPage;

import java.util.ArrayList;
import java.util.List;

import com.care.root.main.dto.MyListDTO;
import com.care.root.member.dto.MemberDTO;
import com.care.root.myPage.dto.CalendarDTO;
import com.care.root.qna.dto.QnADTO;
import com.care.root.review.dto.ReviewDTO;

public interface MyPageMapper {
	public ArrayList<QnADTO> getQnaData(String id); //qna 데이터 가져오기 기능
	public ArrayList<ReviewDTO> getReviewData(String id); //review 데이터 가져오기 기능
	
	public MemberDTO getMember(String id); //회원 조회 기능
	public void userModify(MemberDTO dto); //회원 수정 기능
	public void userDelete(String id); //회원 삭제 기능
	public void calendarinsert(CalendarDTO dto); //캘린더 일정 저장하기 기능 
	public List<MyListDTO> myTripList(String id); //나의 찜 목록 가져오기 기능
}
