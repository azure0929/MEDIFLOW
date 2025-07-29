package com.service.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.spring.dao.MemberDAO;
import com.service.spring.domain.Member;

@Service
public class MemberService {
	
	@Autowired
	private MemberDAO memberDAO;
	
	public Member login(Member member)throws Exception{
		return memberDAO.logIn(member);
	}
	
	public void insertMember(Member member)throws Exception {
		memberDAO.insertMember(member);
	}
	
	public void updateMember(Member member)throws Exception {
		memberDAO.updateMember(member);
	}
	
	public void deleteMember(int mId)throws Exception {
		memberDAO.deleteMember(mId);
	}
	
	public List<Member> searchAllMember()throws Exception {
		return memberDAO.searchAllMember();
	}
	
	public Member searchMemberByNum(int mId)throws Exception{
		return memberDAO.searchMemberByNum(mId);
	}
	
	public List<Member> searchMember(Member member)throws Exception{
		return memberDAO.searchMember(member);
	}
}
