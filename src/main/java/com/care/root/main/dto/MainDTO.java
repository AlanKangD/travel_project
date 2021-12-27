package com.care.root.main.dto;

public class MainDTO {
	
	private String placeName;
	private String mainCategory;	//not null / 1=관광명소 2=맛집 
	private String contentOne; //not null
	private String contentTwo; //not null
	private String mainImageFile; //not null
	private int likeHit; 
	private String latitude;   // 위도  
	private String longitude;   //경도   ,  
	private String address;
	private String imageFile1;
	private String imageFile2;

	
	public String getImageFile1() {
		return imageFile1;
	}
	public void setImageFile1(String imageFile1) {
		this.imageFile1 = imageFile1;
	}
	public String getImageFile2() {
		return imageFile2;
	}
	public void setImageFile2(String imageFile2) {
		this.imageFile2 = imageFile2;
	}

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
