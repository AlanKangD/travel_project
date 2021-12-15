package com.care.root.main.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
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
import com.care.root.main.dto.MyListDTO;
import com.care.root.main.dto.RepLikeDTO;
import com.care.root.main.dto.ReplyDTO;
import com.care.root.main.imageFile.MainFileStorage;
import com.care.root.mybatis.main.MainMapper;
import com.care.root.mybatis.main.MainRepMapper;

@Service
public class MainServiceImpl implements MainService {
	@Autowired
	MainMapper mapper;
	
	@Autowired
	MainRepMapper rmapper;
	

	@Override // 이미지 경로 및 이름 설정
	public MainDTO fileProcess(MultipartHttpServletRequest mul) {
		MainDTO dto = new MainDTO();
		MultipartFile file = mul.getFile("mainImageFile");
		if (file.getSize() != 0) {
			SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss-");
			Calendar calendar = Calendar.getInstance();
			String fileName = sf.format(calendar.getTime());
			fileName += file.getOriginalFilename(); // 20211225173532-dog.jpg

			File saveFile = new File(IMAGE_REPO + "/" + fileName); // 경로 + 파일명 => 위치
			dto.setMainImageFile(fileName);
			try {
				file.transferTo(saveFile);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			dto.setMainImageFile("nan"); // 이미지선택 안했으면 알람창 띄워주기
		}
		return dto;
	}
/*
	@Override
	public List<MainDTO> themeList(Model model, String theme) {

		model.addAttribute("list", mapper.themeList(theme));
		return null;
	}
*/
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
			msg = "문제가 발생되었습니다!!!";
			url = "/main/addPlace";
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
	public void download(String mainImageFile, HttpServletResponse response) throws Exception {
		response.addHeader("Content-disposition", "attachment; fileName=" + mainImageFile);
		File file = new File(MainFileStorage.IMAGE_REPO + "/" + mainImageFile);
		FileInputStream fis = new FileInputStream(file);
		FileCopyUtils.copy(fis, response.getOutputStream());
		fis.close();
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

	@Override
	public void modifyView(MultipartHttpServletRequest mul) {
		MainDTO dto = fileProcess(mul);
		dto.setPlaceName(mul.getParameter("placeName"));
		dto.setContentOne(mul.getParameter("contentOne"));
		dto.setContentTwo(mul.getParameter("contentTwo"));
		mapper.modifyView(dto);		
		
	}

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
	      int dataCount = mapper.getDataCount(placeName);
	      int repeat = dataCount / pageLetter;
	      if(dataCount % pageLetter != 0) {
	         repeat += 1;
	      }
	      int end = num * pageLetter;
	      int start = end + 1 - pageLetter;
	      
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
	      result.put("list", mapper.getReply(placeName,start,end));
	      result.put("repeat", repeat);
	      result.put("beginPage", beginPage);
	      result.put("endPage", endPage);
	      
	      System.out.println(result.get("list"));
	      
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
	public String updateLike(int repNo, String id) {
		RepLikeDTO dto = likeCheck(repNo, id);
		if(dto == null) {
			RepLikeDTO d = new RepLikeDTO();
			System.out.println("setid값 : " + id);
			d.setId(id);
			d.setRepNo(repNo);
			d.setLikeCheck(1);
			int result = rmapper.likeHit(d);
			System.out.println("likehit결과 : " + result);
			return "{\"result\" : true} ";   //등록 완료 
		}else {  // 있으면 
			if(dto.getLikeCheck() == 0) {   // 좋아요 안눌렀으면 
				System.out.println("dto값 체크1 " + dto.getLikeCheck());
				int num = 1;
				rmapper.updateLike(num, dto.getLikeNo());         
				return "{\"result\" : true} ";
			}else {
				System.out.println("dto값 체크2 " + dto.getLikeNo());
				int num = 0;
				rmapper.updateLike(num, dto.getLikeNo());    // 이미 눌려있으면 
				return "{\"result\" : false} ";
			}			
		}
	}
	
	private RepLikeDTO likeCheck(int repNo, String id) {
		RepLikeDTO dto;
		try {
			dto = rmapper.likeCheck(repNo, id);  // 로우가 있을 경우 
		} catch (Exception e) {
			dto = null;   // 없는 경우 insert먼저 해줘야 함 			 
		}
		return dto;
	}

}
