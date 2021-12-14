package com.care.root.mybatis.main;

import java.util.List;

import com.care.root.main.dto.MainDTO;
import com.care.root.main.dto.MyListDTO;
import com.care.root.main.dto.ReplyDTO;

public interface MainMapper {
	
	public List<MainDTO> themeList(String mainCategory);
	public int register(MainDTO dto);
	public MainDTO themeView(String placeName);
	public int deleteView(String placeName);
	public int modifyView(MainDTO dto);
	
	
	public int addMyList(MyListDTO myDto);
	public List<MyListDTO> getMyList(String userId);
	public List<MyListDTO> getAllMyList();
	public int deleteMyList(int listNo);
	
	public int addReply(ReplyDTO dto);
	public List<ReplyDTO> getReply(String placeName);
	public int deleteReply(int repNo);
}
