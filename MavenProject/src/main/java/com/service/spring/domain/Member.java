package com.service.spring.domain;

public class Member {
	
	private int mNum; // 회원번호(컬럼명 : m_num)
	private String mId; // :회원 아이디(컬럼명 : m_id)
	private String mPassword; // 회원 비밀번호 (컬럼명 : m_password)
	private String mName; // 회원 이름 (컬럼명 : m_name)
	private String mPhone; // 회원 전화번호 (컬럼명 : m_phone)
	private String mAge; // 회원 나이 (컬럼명 : m_age)
	
	public Member() {
		super();
	}
	
	public Member(int mNum, String mId, String mPassword, String mName, String mPhone, String mAge) {
		super();
		this.mNum = mNum;
		this.mId = mId;
		this.mPassword = mPassword;
		this.mName = mName;
		this.mPhone = mPhone;
		this.mAge = mAge;
	}

	public Member(String mId,String mPassword, String mName, String mPhone, String mAge) {
		super();
		this.mId = mId;
		this.mPassword = mPassword;
		this.mName = mName;
		this.mPhone = mPhone;
		this.mAge = mAge;
	}

	public int getmNum() {
		return mNum;
	}
	public String getmId() {
		return mId;
	}
	public void setmId(String mId) {
		this.mId = mId;
	}
	public String getmPassword() {
		return mPassword;
	}
	public void setmPassword(String mPassword) {
		this.mPassword = mPassword;
	}
	public String getmName() {
		return mName;
	}
	public void setmName(String mName) {
		this.mName = mName;
	}
	public String getmPhone() {
		return mPhone;
	}
	public void setmPhone(String mPhone) {
		this.mPhone = mPhone;
	}
	public String getmAge() {
		return mAge;
	}
	public void setmAge(String mAge) {
		this.mAge = mAge;
	}

	@Override
	public String toString() {
		return "Member [mNum=" + mNum + ", mId=" + mId + ", mPassword=" + mPassword + ", mName=" + mName + ", mPhone=" + mPhone
				+ ", mAge=" + mAge + "]";
	}
	
}
