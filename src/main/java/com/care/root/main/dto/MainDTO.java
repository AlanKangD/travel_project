package com.care.root.main.dto;

public class MainDTO {
	
	private int mainId; // not null
	private String mainCategory;	//not null / 1=관광명소 2=맛집
	private String userId; 
	private String placeName; //not null
	private String contentOne; //not null
	private String contentTwo; //not null
	private String mainImageFile; //not null
	private int take;
	private int upHit;	
	
	
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getMainId() {
		return mainId;
	}
	public void setMainId(int mainId) {
		this.mainId = mainId;
	}
	public String getMainCategory() {
		return mainCategory;
	}
	public void setMainCategory(String mainCategory) {
		this.mainCategory = mainCategory;
	}
	public String getPlaceName() {
		return placeName;
	}
	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}
	public String getContentOne() {
		return contentOne;
	}
	public void setContentOne(String contentOne) {
		this.contentOne = contentOne;
	}
	public String getContentTwo() {
		return contentTwo;
	}
	public void setContentTwo(String contentTwo) {
		this.contentTwo = contentTwo;
	}
	public String getMainImageFile() {
		return mainImageFile;
	}
	public void setMainImageFile(String mainImageFile) {
		this.mainImageFile = mainImageFile;
	}
	public int getTake() {
		return take;
	}
	public void setTake(int take) {
		this.take = take;
	}
	public int getUpHit() {
		return upHit;
	}
	public void setUpHit(int upHit) {
		this.upHit = upHit;
	}

}
