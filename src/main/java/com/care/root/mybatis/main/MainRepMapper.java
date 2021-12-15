package com.care.root.mybatis.main;

import org.apache.ibatis.annotations.Param;

import com.care.root.main.dto.RepLikeDTO;

public interface MainRepMapper {
	
	public RepLikeDTO likeCheck(@Param("repNo") int repNo, @Param("id") String id);
	public int likeHit(RepLikeDTO dto);
	public void updateLike(@Param("num") int num, @Param("likeNo") int likeNo);
}
