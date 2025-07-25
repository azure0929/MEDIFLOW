package com.service.spring.domain;

public class Booking {
	private int bNum;// 예약 번호 (컬럼명은 b_num)
	private Member member;// 회원번호 (컬럼명은 m_num)
	private Hospital hospital;// 병원번호 (컬럼명은 h_num)
	private String bDate;// 예약일자 (컬럼명은 b_date)
	private String bTime;// 예약 시간대 (컬럼명은 b_time)
	private int bStatus;// 예약 상태 (테이블에는 tinyint)
	
	public Booking() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Booking(Member member, Hospital hospital, String bDate, String bTime, int bStatus) {
		super();
		this.member = member;
		this.hospital = hospital;
		this.bDate = bDate;
		this.bTime = bTime;
		this.bStatus = bStatus;
	}

	public int getbNum() {
		return bNum;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public Hospital getHospital() {
		return hospital;
	}

	public void setHospital(Hospital hospital) {
		this.hospital = hospital;
	}

	public String getbDate() {
		return bDate;
	}

	public void setbDate(String bDate) {
		this.bDate = bDate;
	}

	public String getbTime() {
		return bTime;
	}

	public void setbTime(String bTime) {
		this.bTime = bTime;
	}

	public int getbStatus() {
		return bStatus;
	}

	public void setbStatus(int bStatus) {
		this.bStatus = bStatus;
	}

	@Override
	public String toString() {
		return "Booking [bNum=" + bNum + ", member=" + member + ", hospital=" + hospital + ", bDate=" + bDate
				+ ", bTime=" + bTime + ", bStatus=" + bStatus + "]";
	}
	
	
}
