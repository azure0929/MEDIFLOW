package com.service.spring.domain;

public class Hospital {
	private int hNum; // 병원번호 (컬럼명은 h_num)
	private String hDepartment; // 진료과목(컬럼명은 h_department)
	private String hTitle; // 병원이름(컬럼명은 h_title)
	private String hDistrict; // 병원구역(컬럼명은 h_district)
	private String hAddress; // 병원주소(컬럼명은 h_address)
	private String hTel; // 병원전화번호(컬럼명은 h_tel)
	private String hContent; // 병원소개(컬럼명은 h_content)
	private String hUrl; // 병원사진(컬럼명은 h_url)

	public Hospital() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Hospital(int hNum, String hDepartment, String hTitle, String hDistrict, String hAddress, String hTel,
			String hContent, String hUrl) {
		super();
		this.hNum = hNum;
		this.hDepartment = hDepartment;
		this.hTitle = hTitle;
		this.hDistrict = hDistrict;
		this.hAddress = hAddress;
		this.hTel = hTel;
		this.hContent = hContent;
		this.hUrl = hUrl;
	}

	public Hospital(String hDepartment, String hTitle, String hDistrict, String hAddress, String hTel, String hContent,
			String hUrl) {
		super();
		this.hDepartment = hDepartment;
		this.hTitle = hTitle;
		this.hDistrict = hDistrict;
		this.hAddress = hAddress;
		this.hTel = hTel;
		this.hContent = hContent;
		this.hUrl = hUrl;
	}

	public int gethNum() {
		return hNum;
	}

	public void sethNum(int hNum) {
		this.hNum = hNum;
	}

	public String gethTitle() {
		return hTitle;
	}

	public void sethTitle(String hTitle) {
		this.hTitle = hTitle;
	}

	public String gethDepartment() {
		return hDepartment;
	}

	public void sethDepartment(String hDepartment) {
		this.hDepartment = hDepartment;
	}

	public String gethDistrict() {
		return hDistrict;
	}

	public void sethDistrict(String hDistrict) {
		this.hDistrict = hDistrict;
	}

	public String gethAddress() {
		return hAddress;
	}

	public void sethAddress(String hAddress) {
		this.hAddress = hAddress;
	}

	public String gethTel() {
		return hTel;
	}

	public void sethTel(String hTel) {
		this.hTel = hTel;
	}

	public String gethContent() {
		return hContent;
	}

	public void sethContent(String hContent) {
		this.hContent = hContent;
	}

	public String gethUrl() {
		return hUrl;
	}

	public void sethUrl(String hUrl) {
		this.hUrl = hUrl;
	}

	@Override
	public String toString() {
		return "Hospital [hNum=" + hNum + ", hDepartment=" + hDepartment + ", hTitle=" + hTitle + ", hDistrict="
				+ hDistrict + ", hAddress=" + hAddress + ", hTel=" + hTel + ", hContent=" + hContent + ", hUrl=" + hUrl
				+ "]";
	}



}
