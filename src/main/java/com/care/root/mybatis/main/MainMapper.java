package com.care.root.mybatis.main;

import java.util.List;

import com.care.root.main.dto.MainDTO;
import com.care.root.main.dto.MyListDTO;

public interface MainMapper {
	
	public List<MainDTO> themeList();
	public void register(MainDTO dto);
	public MainDTO themeView(int mainId);
	public void addMyList(MyListDTO myDto);

	public List<MyListDTO> getMyList(String userId);
	public int deleteMyList(int listNo);
}
