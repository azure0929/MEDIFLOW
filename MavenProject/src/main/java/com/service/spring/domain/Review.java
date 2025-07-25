package com.service.spring.domain;

public class Review {
	private int rNum ;// 리뷰 번호
	private Hospital hospital ;// 병원 번호 (컬럼명은 h_num)
	private Member member; //  회원 번호 (컬럼명은 m_num)
	private String rContent; //리뷰 내용 (컬럼명은 r_content)
	
	public Review() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Review(Hospital hospital, Member member, String rContent) {
		super();
		this.hospital = hospital;
		this.member = member;
		this.rContent = rContent;
	}

	public int getrNum() {
		return rNum;
	}

	public Hospital getHospital() {
		return hospital;
	}

	public void setHospital(Hospital hospital) {
		this.hospital = hospital;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public String getrContent() {
		return rContent;
	}

	public void setrContent(String rContent) {
		this.rContent = rContent;
	}

	@Override
	public String toString() {
		return "Review [rNum=" + rNum + ", hospital=" + hospital + ", member=" + member + ", rContent=" + rContent
				+ "]";
	}
	
}
