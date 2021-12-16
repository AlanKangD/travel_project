package com.care.root.main.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.care.root.common.sessionName.SessionCommonName;
import com.care.root.main.dto.MainDTO;
import com.care.root.main.dto.MainRepLikeDTO;
import com.care.root.main.dto.MyListDTO;
import com.care.root.main.dto.ReplyDTO;
import com.care.root.main.imageFile.MainFileStorage;
import com.care.root.mybatis.main.MainMapper;

@Service
public class MainServiceImpl implements MainService {
	@Autowired
	MainMapper mapper;	
	
	@Override // 이미지 경로 및 이름 설정
	public MainDTO fileProcess(MultipartHttpServletRequest mul) {
		MainDTO dto = new MainDTO();
		MultipartFile file = mul.getFile("mainImageFile");
		System.out.println("파일프로세스 : " + mul.getParameter("originImageFile"));
		if(file.getSize() != 0) {
			SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss-");
			Calendar calendar = Calendar.getInstance();
			String fileName = sf.format(calendar.getTime());
			fileName += file.getOriginalFilename();
			File saveFile = new File(IMAGE_REPO+"/"+fileName);
			dto.setMainImageFile(fileName);
			try {
				file.transferTo(saveFile);  //해당 위치에 파일 저장 
			} catch (Exception e) {
				e.printStackTrace();
			}
			if(mul.getParameter("originImageFile") != null) {   // 이미 등록되어있는 파일이 있으면, 삭제 
				File deleteOrigin = new File(IMAGE_REPO+"/"+mul.getParameter("originImageFile")) ; // 저장한 레파지토리에서 삭제해줌 
				deleteOrigin.delete(); 
			}			
		}else { 
			try {
				dto.setMainImageFile(mul.getParameter("originImageFile")); // 사진 필수라고 알림창띄워주기 
			} catch (Exception e) { // 게시물 첫 등록이란 소리  
				dto.setMainImageFile("nan");  // 아주 튕기게 만들어야 함 
			}
		}
		return dto;
	}
	
	@Override
	public void modifyView(MultipartHttpServletRequest mul) {
		MainDTO dto = fileProcess(mul);		
		dto.setPlaceName(mul.getParameter("placeName"));
		dto.setContentOne(mul.getParameter("contentOne"));
		dto.setContentTwo(mul.getParameter("contentTwo"));
		mapper.modifyView(dto);				
	}
	
	@Override
	public void download(String mainImageFile, HttpServletResponse response) throws Exception {
		response.addHeader("Content-disposition", "attachment; fileName=" + mainImageFile);
		File file = new File(MainFileStorage.IMAGE_REPO + "/" + mainImageFile);
		FileInputStream fis = new FileInputStream(file);
		FileCopyUtils.copy(fis, response.getOutputStream());
		fis.close();
	}

	@Override
	   public void themeList(Model model, String theme) {
	      int like = 0;
	      List<MyListDTO> myList = mapper.getAllMyList();
	      List<MainDTO> list = mapper.themeList(theme);
	      
	      for(MainDTO dto : list) {
	         for(MyListDTO myListDTO : myList) {
	            if(dto.getPlaceName().equals(myListDTO.getPlace())) {
	               like += 1;
	            }
	         }
	         dto.setLikeHit(like);
	         like = 0;
	      }	      
	      model.addAttribute("list", list);
	   }
	
	@Override
	public void register(MultipartHttpServletRequest mul, HttpServletResponse response, HttpServletRequest request) {
		MainDTO dto = fileProcess(mul);

		dto.setMainCategory(mul.getParameter("mainCategory"));
		dto.setPlaceName(mul.getParameter("placeName"));
		dto.setContentOne(mul.getParameter("contentOne"));
		dto.setContentTwo(mul.getParameter("contentTwo"));
		dto.setLatitude(mul.getParameter("latitude"));
		dto.setLongitude(mul.getParameter("longitude"));
		dto.setAddress(mul.getParameter("address"));

		String msg, url;
		int result = 0;
		try {
			result = mapper.register(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (result == 1) {
			msg = "새로운 관광지가 추가되었습니다";
			url = "/main/themeList?theme=" + mul.getParameter("mainCategory");
		} else {
			msg = "모든 값은 필수 입력사항입니다.";
			url = "/main/addPlace?theme="+ mul.getParameter("mainCategory");
		}

		String message = getMessage(request, msg, url);

		PrintWriter out = null;
		response.setContentType("text/html; charset=utf-8");
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		out.println(message);
	}

	private String getMessage(HttpServletRequest request, String msg, String url) {
		String message = null;
		String path = request.getContextPath(); // 절대경로
		message = "<script>alert('" + msg + "');";
		message += "location.href='" + path + url + "'; </script>"; // 절대경로에 사용자가 넘겨주는 경로
		return message;
	}

	@Override
	public void themeView(String placeName, Model model) {
		System.out.println("themeView 서비스 로그 확인 : " +placeName );
		model.addAttribute("dto", mapper.themeView(placeName));
	}

	

	@Override
    public String addMyList(MyListDTO dto) {         
    System.out.println(dto.getImage());
    System.out.println(dto.getPlace());
    int result = 0;
    List<MyListDTO> list = mapper.getMyList(dto.getId());
    
    if(list.size() == 10) {
       return "{\"result\" : \"overList\"}";
    }else if(list.size() != 0) {
          for(MyListDTO listDTO : list) {
             if(listDTO.getPlace().equals(dto.getPlace())) {
                return "{\"result\" : false}";
             }
          }
       }         
      result = mapper.addMyList(dto);
      System.out.println("result : " + result);
       if(result == 1){ 
          return "{\"result\" : true}";
       }else {
          return "{\"result\" : false3}";
       }
    }
	
	
	@Override
	   public List<MyListDTO> getMyList(HttpSession session) {
	      String id = (String) session.getAttribute(SessionCommonName.userSession);
	      if(id == null) {
	         List list = new ArrayList();
	         return list;
	      }
	      return mapper.getMyList(id);
	   }

	@Override
	public String deleteMyList(int listNo) {
		int result = mapper.deleteMyList(listNo);
		if (result == 1) {
			return "{\"result\" : true}";
		} else {
			return "{\"result\" : false}";
		}
	}

	@Override
	public String deleteView(String placeName) {
		int result = mapper.deleteView(placeName);	
		System.out.println("result :" +result);
		if(result == 1) {
			return "{\"result\" : true} ";
		}else {
			return "{\"result\" : false}";
		}
		
	}

//	@Override
//	public void modifyView(MultipartHttpServletRequest mul) {
//		MainDTO dto = fileProcess(mul);
//		
//		dto.setPlaceName(mul.getParameter("placeName"));
//		dto.setContentOne(mul.getParameter("contentOne"));
//		dto.setContentTwo(mul.getParameter("contentTwo"));
//		mapper.modifyView(dto);		
//		
//	}

	@Override
	public String addReply(ReplyDTO dto) {
		int result = mapper.addReply(dto);
		if(result == 1) {
			return "{\"result\" : true}";
		}else {
			return "{\"result\" : false}";
		}
	}
	
	@Override
	   public Map<String, Object> getReply(String placeName, int num) {		
	      int pageLetter = 5;	    
	      int end = num * pageLetter;
	      int start = end + 1 - pageLetter;
	      
	      Map<String, Object> result = pagingNum(placeName, num);	      	      	 
	      result.put("list", mapper.getReply(placeName,start,end));	      
	      
	      return result;
	   }
	
	private Map<String, Object> pagingNum(String placeName, int num) {
		  int pageLetter = 5;
	      int dataCount = mapper.getDataCount(placeName);
	      int repeat = dataCount / pageLetter;
	      if(dataCount % pageLetter != 0) {
	         repeat += 1;
	      }	      
	      int pagingNum = 5; // 페이징 넘버링 개수(1 ~ 5 / 6 ~ 10)
	      int beginPage = 0;
	      int endPage = 0;
	      
	      int pageingCount = (num-1) / pagingNum;
	      beginPage = pageingCount * pagingNum + 1 ;
	      endPage = beginPage + 4;    // 10개로한다면 여기 +5해줘야한다
	      
	      if(repeat < endPage) {
	         endPage = repeat;
	      }
	      Map<String, Object> result = new HashMap<String, Object>();
	      result.put("dataCount", dataCount);
	      result.put("beginPage", beginPage);
	      result.put("endPage", endPage);
		  
	      return result;
	}
	
	@Override
	public String deleteReply(int repNo) {
		int result = mapper.deleteReply(repNo);
		if(result == 1) {
			return "{\"result\" : true}";
		}else {
			return "{\"result\" : false}";
		}
	}

	@Override
	   public String likeCheck(int repNo, String id) {
	      List<MainRepLikeDTO> list = mapper.getLikeList();
	      if(list.size() != 0) {
	         for(MainRepLikeDTO dto : list) {
	            if(dto.getId().equals(id) && dto.getRepNo() == repNo) { // 추천하기를 눌렀다면 취소
	               mapper.cancelLike(repNo, id);
	               mapper.likeSet(repNo, 1);
	               return "{\"result\" : false}";
	            }
	         }
	      }
	      mapper.updateLike(repNo, id);   // 추천하기를 눌렀다면 추가
	      mapper.likeSet(repNo, 0);
	      return "{\"result\" : true}";
	   }

}
