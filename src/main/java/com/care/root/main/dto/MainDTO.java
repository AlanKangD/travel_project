package com.care.root.main.dto;

public class MainDTO {
	
	private String placeName;
	private String mainCategory;	//not null / 1=관광명소 2=맛집 
	private String contentOne; //not null
	private String contentTwo; //not null
	private String mainImageFile; //not null
	private int likeHit;   // like로 수정 요망 
	private int upHit;	
	private String latitude;   // 위도  
	private String longitude;   //경도   ,  
	private String address  ;
	//나중에 주소 address도 추가하기 (컬럼) 
	
	
	public String getPlaceName() {
		return placeName;
	}
	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}
	public String getMainCategory() {
		return mainCategory;
	}
	public void setMainCategory(String mainCategory) {
		this.mainCategory = mainCategory;
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
	public int getLikeHit() {
		return likeHit;
	}
	public void setLikeHit(int likeHit) {
		this.likeHit = likeHit;
	}
	public int getUpHit() {
		return upHit;
	}
	public void setUpHit(int upHit) {
		this.upHit = upHit;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	

}
