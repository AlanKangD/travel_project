package com.care.root.mybatis.main;

import java.util.List;

import com.care.root.main.dto.MainDTO;

public interface MainMapper {
	
	public List<MainDTO> themeList();
	public void register(MainDTO dto);
	public MainDTO themeView(int mainId);

}
