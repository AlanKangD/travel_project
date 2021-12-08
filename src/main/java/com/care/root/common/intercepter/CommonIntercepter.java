package com.care.root.common.intercepter;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.care.root.common.sessionName.SessionCommonName;

public class CommonIntercepter extends HandlerInterceptorAdapter implements SessionCommonName{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("인터셉터 등록 완료!");
		HttpSession session = request.getSession();
		if(session.getAttribute(userSession) == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print("<script> alert('글작성은 로그인한 사용자만 가능합니다.');"
					//+ "location.href='/root/member/login'; </script>");
			+ "location.href='" + request.getContextPath() + "/qna/allList'; </script>");
			return false;
		}	
		return true;
	}
}
