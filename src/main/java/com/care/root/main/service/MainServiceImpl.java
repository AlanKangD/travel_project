package com.care.root.main.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

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

	@Override
	public List<MainDTO> themeList(Model model, String theme) {

		model.addAttribute("list", mapper.themeList(theme));
		return null;
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
    System.out.println("addMylist로그확인 : " + dto.getId());
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
          System.out.println("result = 1 확인");
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

}
