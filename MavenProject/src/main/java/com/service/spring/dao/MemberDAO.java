package com.service.spring.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.service.spring.domain.Member;

@Repository
public class MemberDAO {
	public static final String NS = "MemberMapper.";
	
	@Autowired
	private SqlSession session;
	
	public MemberDAO() {
	}
	
	public Member logIn(Member member)throws Exception{
		return session.selectOne(NS+"logIn",member);
	}
	
	public void insertMember(Member member)throws Exception {
		session.insert(NS+"insertMember",member);
	}
	
	public void updateMember(Member member)throws Exception {
		session.update(NS+"updateMember",member);
	}
	
	public void deleteMember(int mId)throws Exception {
		session.delete(NS+"deleteMember",mId);
	}
	
	public int totalCountMember()throws Exception{
		return session.selectOne(NS+"totalCountMember");
	}
	
	public List<Member> searchAllMember(Map map)throws Exception {
		return session.selectList(NS+"searchAllMember",map);
	}
	
	public Member searchMemberByNum(int mId)throws Exception{
		return session.selectOne(NS+"searchMemberByNum",mId);
	}
	
	public List<Member> searchMember(Member member)throws Exception{
		return session.selectList(NS+"searchMember",member);
	}
}
