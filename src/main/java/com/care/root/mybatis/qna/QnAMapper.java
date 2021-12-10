package com.care.root.mybatis.qna;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.care.root.qna.dto.QnADTO;
import com.care.root.qna.dto.QnARepDTO;

public interface QnAMapper {
	public List<QnADTO> qnaAllList(@Param("s") int start, @Param("e") int end,
				@Param("searchOption") String searchOption,@Param("keyword") String keyword);
	public int writeSave(QnADTO dto);
	public QnADTO contentView(int qnaNo);
	public void upHit(int qnaNo);
	public int delete(int qnaNo);
	public int modify(QnADTO dto);
	public int getDataCount(@Param("searchOption") String searchOption,@Param("keyword") String keyword);
	public int addReply(QnARepDTO dto);
	public List<QnARepDTO> getReply(int qnaWriteGroup);
	public List<QnARepDTO> repAllList();
	public int repDelete(int qrId);
	public int repModify(@Param("qrId") int qrId,@Param("qrContent") String qrContent);
	public List<QnADTO> noticeList();
}