package com.care.root.qna.dto;

import java.text.SimpleDateFormat;

public class QnARepDTO {
	private String id;
    private String qrContent;
    private int qrWriteGroup;
    private String saveDate;
    private int qrId;

    public int getQrId() {
		return qrId;
	}
	public void setQrId(int qrId) {
		this.qrId = qrId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getQrContent() {
		return qrContent;
	}
	public void setQrContent(String qrContent) {
		this.qrContent = qrContent;
	}
	public int getQrWriteGroup() {
		return qrWriteGroup;
	}
	public void setQrWriteGroup(int qrWriteGroup) {
		this.qrWriteGroup = qrWriteGroup;
	}
	public String getSaveDate() {
		return saveDate;
	}
	public void setSaveDate(java.sql.Timestamp saveDate) { 
		SimpleDateFormat fo = new SimpleDateFormat("YYYY년 MM월 dd일");
		this.saveDate = fo.format(saveDate);
	}
}
