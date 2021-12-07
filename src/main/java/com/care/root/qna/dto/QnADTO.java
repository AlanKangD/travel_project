package com.care.root.qna.dto;

import java.text.SimpleDateFormat;

public class QnADTO {
	private int qnaNo;
	private int qnaHit;
	
	private String qnaTitle;
	private String qnaContent;
	
	
	private String saveDate;
	private String viewDate;
	
	private String qnaPwd;
	private String id;
	private String repCheck;
	
	public String getViewDate() {
		return viewDate;
	}
	public void setViewDate(String viewDate) {
		this.viewDate = viewDate;
	}
	
	public String getRepCheck() {
		return repCheck;
	}
	public void setRepCheck(String repCheck) {
		this.repCheck = repCheck;
	}
	public int getQnaNo() {
		return qnaNo;
	}
	public void setQnaNo(int qnaNo) {
		this.qnaNo = qnaNo;
	}
	public String getQnaTitle() {
		return qnaTitle;
	}
	public void setQnaTitle(String qnaTitle) {
		this.qnaTitle = qnaTitle;
	}
	public String getQnaContent() {
		return qnaContent;
	}
	public void setQnaContent(String qnaContent) {
		this.qnaContent = qnaContent;
	}
	public int getQnaHit() {
		return qnaHit;
	}
	public void setQnaHit(int qnaHit) {
		this.qnaHit = qnaHit;
	}
	
	public String getSaveDate() {
		return saveDate;
	}
	public void setSaveDate(java.sql.Timestamp saveDate) { 
		SimpleDateFormat fo = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
		this.saveDate = fo.format(saveDate);
		
		SimpleDateFormat fo2 = new SimpleDateFormat("YYYY-MM-dd");
		viewDate = fo2.format(saveDate);
	}
	public String getQnaPwd() {
		return qnaPwd;
	}
	public void setQnaPwd(String qnaPwd) {
		this.qnaPwd = qnaPwd;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
}