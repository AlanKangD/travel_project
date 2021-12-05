package com.care.root.mybatis.qna;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.care.root.qna.dto.QnADTO;
import com.care.root.qna.dto.QnARepDTO;

public interface QnAMapper {
	public List<QnADTO> qnaAllList(@Param("s") int start, @Param("e") int end);
	public int writeSave(QnADTO dto);
	public QnADTO contentView(int qnaNo);
	public void upHit(int qnaNo);
	public int delete(int qnaNo);
	public int modify(QnADTO dto);
	public int getDataCount();
	public int addReply(QnARepDTO dto);
	
}