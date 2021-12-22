package com.care.root.main.dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class ReplyDTO {
	private int repNo;
	private String repContent;
	private String placeName;
	private String id;
	private int likeHit;
	private String saveDate;
	
	public String getPlaceName() {
		return placeName;
	}
	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}
	public int getRepNo() {
		return repNo;
	}
	public void setRepNo(int repNo) {
		this.repNo = repNo;
	}
	public String getRepContent() {
		return repContent;
	}
	public void setRepContent(String repContent) {
		this.repContent = repContent;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getLikeHit() {
		return likeHit;
	}
	public void setLikeHit(int likeHit) {
		this.likeHit = likeHit;
	}
	public String getSaveDate() {
		return saveDate;
	}
	public void setSaveDate(Timestamp saveDate) {
		SimpleDateFormat fo = new SimpleDateFormat("YYYY년 MM월 dd일");
		this.saveDate = fo.format(saveDate);
	}
	
	
}
