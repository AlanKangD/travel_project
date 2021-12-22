package com.care.root.main.dto;

public class MyListDTO {
	private int listNo;  //primary key
	private String id;  // userid  나중에 fk로 
	private String place;
	private String image;
	
	public int getListNo() {
		return listNo;
	}
	public void setListNo(int listNo) {
		this.listNo = listNo;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	

	
}
