package com.service.spring.test;

import java.io.Reader;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.jupiter.api.Test;

import com.service.spring.domain.Member;


public class MemberUnitTest {
	private static final String NS = "MemberMapper.";
	private SqlSession getSqlSession()throws Exception{
		Reader reader=Resources.getResourceAsReader("config/SqlMapConfig.xml");
		SqlSessionFactory factory=new SqlSessionFactoryBuilder().build(reader);
		SqlSession session=factory.openSession();
		
		return session;
	}
//	@Test
//	public void logIn()throws Exception {
//		SqlSession session = getSqlSession();
//		Member member = new Member();
//		member.setmId("kosa");
//		member.setmPassword("1234");
//		Member result=session.selectOne(NS+"logIn",member);
//		System.out.println(result);
//	}
//	@Test
//	public void insertMember()throws Exception {
//		SqlSession session = getSqlSession();
//		Member member = new Member();
//		member.setmId("test");
//		member.setmPassword("1234");
//		member.setmName("홍길동");
//		member.setmPhone("010-2222-9999");
//		member.setmAge("30대");
//		int result=session.insert(NS+"insertMember",member);
//		session.commit();
//		System.out.println(result);
//	}
//	@Test
//	public void updateMember()throws Exception {
//		SqlSession session = getSqlSession();
//		Member member = new Member(4,"test","0123","홍길동2","010-3333-4444","30대");
//		int result=session.update(NS+"updateMember",member);
//		session.commit();
//		System.out.println(result);
//	}
//	@Test
//	public void deleteMember()throws Exception {
//		SqlSession session = getSqlSession();
//		int result=session.delete(NS+"deleteMember",4);
//		session.commit();
//		System.out.println(result);
//	}
//	@Test
//	public void searchAllMember()throws Exception {
//		SqlSession session = getSqlSession();
//		Member member = new Member();
//		List<Member> result=session.selectList(NS+"searchAllMember");
//		result.forEach(e->System.out.println(e));
//	}
//	@Test
//	public void searchMemberByNum()throws Exception {
//		SqlSession session = getSqlSession();
//		Member result=session.selectOne(NS+"searchMemberByNum",1);
//		System.out.println(result);
//	}
	@Test
	public void searchMember()throws Exception {
		SqlSession session = getSqlSession();
		Member member1=new Member(null,null,"관리자",null,null);
		List<Member> list1=session.selectList(NS+"searchMember",member1);
		list1.forEach(e-> System.out.println(e));
		System.out.println("===============================");
		Member member2=new Member(null,null,null,null,"20대");
		List<Member> list2=session.selectList(NS+"searchMember",member2);
		list2.forEach(e-> System.out.println(e));
		System.out.println("===============================");
		Member member3=new Member(null,null,null,"010",null);
		List<Member> list3=session.selectList(NS+"searchMember",member3);
		list3.forEach(e-> System.out.println(e));
	}
}
