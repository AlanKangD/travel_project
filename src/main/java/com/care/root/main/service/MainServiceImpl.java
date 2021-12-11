package com.care.root.main.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
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
	@Autowired MainMapper mapper;

	@Override // 이미지 경로 및 이름 설정 
	public MainDTO  fileProcess(MultipartHttpServletRequest mul) {				
		MainDTO dto = new MainDTO();
		MultipartFile file = mul.getFile("mainImageFile");		
		if(file.getSize() != 0) {
			SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss-");
			Calendar calendar = Calendar.getInstance();
			String fileName = sf.format(calendar.getTime());
			fileName += file.getOriginalFilename(); // 20211225173532-dog.jpg			
			
			File saveFile = new File(IMAGE_REPO+"/"+fileName); // 경로 + 파일명 => 위치 		
			dto.setMainImageFile(fileName);			
			try {
				file.transferTo(saveFile);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else {
				dto.setMainImageFile("nan"); // 이미지선택 안했으면 알람창 띄워주기 
		}		
		return dto;
	}
	
	@Override
	public List<MainDTO> themeList(Model model) {
		
		model.addAttribute("list", mapper.themeList());
		return null;
	}

	@Override
	public void register(MultipartHttpServletRequest mul) {
		MainDTO dto = fileProcess(mul);
		
		if(mul.getParameter("mainCategory").equals("1")) {
			dto.setMainCategory("관광명소");
		}else if(mul.getParameter("mainCategory").equals("2")) {
			dto.setMainCategory("맛집");
		}		
		dto.setPlaceName(mul.getParameter("placeName"));
		dto.setContentOne(mul.getParameter("contentOne"));
		dto.setContentTwo(mul.getParameter("contentTwo"));		
		mapper.register(dto);		
	}

	@Override
	public void themeView(int mainId, Model model) {
		model.addAttribute("dto", mapper.themeView(mainId) );
	}

	@Override
	public void download(String mainImageFile, HttpServletResponse response) throws Exception {
		response.addHeader("Content-disposition", "attachment; fileName="+mainImageFile);
		File file = new File(MainFileStorage.IMAGE_REPO+"/"+mainImageFile);
		FileInputStream fis = new FileInputStream(file);
		FileCopyUtils.copy(fis,  response.getOutputStream());
		fis.close();
	}

	@Override
	public void addMyList(MyListDTO dto) {	
		mapper.addMyList(dto);
	}

	@Override
	public List<MyListDTO> getMyList(HttpSession session) {
		String id = (String)session.getAttribute(SessionCommonName.userSession);
		System.out.println("세션값 : " +id);
		return mapper.getMyList(id);
	
	}
	
	

}


