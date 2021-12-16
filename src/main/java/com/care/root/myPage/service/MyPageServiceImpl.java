package com.care.root.myPage.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.care.root.member.dto.MemberDTO;
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


	
	
	

}
