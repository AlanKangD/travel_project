package com.care.root.mybatis.main;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.care.root.main.dto.MainDTO;
import com.care.root.main.dto.MainRepLikeDTO;
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
	public List<ReplyDTO> getReply(@Param("placeName") String placeName, @Param("s") int start, @Param("e") int end);
	
	public int deleteReply(int repNo);
	public int getDataCount(String placeName);
	
	public List<MainRepLikeDTO> getLikeList();
	public void updateLike(@Param("repNo") int repNo, @Param("id") String id);
	public void cancelLike(@Param("repNo") int repNo, @Param("id") String id);
	public void likeSet(@Param("repNo") int repNo, @Param("num") int num);

}
