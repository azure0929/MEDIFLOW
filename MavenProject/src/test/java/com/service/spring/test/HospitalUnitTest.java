package com.service.spring.test;

import java.io.Reader;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.jupiter.api.Test;

import com.service.spring.domain.Hospital;


public class HospitalUnitTest {
	private static final String NS = "HospitalMapper.";
	private SqlSession getSqlSession()throws Exception{
		Reader reader=Resources.getResourceAsReader("config/SqlMapConfig.xml");
		SqlSessionFactory factory=new SqlSessionFactoryBuilder().build(reader);
		SqlSession session=factory.openSession();
		
		return session;
	}
//	@Test
//	public void insertHospital()throws Exception {
//		SqlSession session = getSqlSession();
//		Hospital hospital=new Hospital("치과","종로치과","종로구","서울시 종로구","02-444-7777","종로치과입니다.","/image/종로치과.png");
//		session.insert(NS+"insertHospital",hospital);
//		session.commit();
//	}
//	@Test
//	public void updateHospital()throws Exception {
//		SqlSession session = getSqlSession();
//		Hospital hospital=new Hospital(3,"정형외과","혜화정형외과","혜화구","서울시 혜화구","02-555-8888","혜화정형외과입니다.","/image/정형외과.png");
//		session.update(NS+"updateHospital",hospital);
//		session.commit();
//	}
//	@Test
//	public void deleteHospital()throws Exception {
//		SqlSession session = getSqlSession();
//		session.delete(NS+"deleteHospital",3);
//		session.commit();
//	}
//	@Test
//	public void searchAllHospital()throws Exception {
//		SqlSession session = getSqlSession();
//		List<Hospital> list=session.selectList(NS+"searchAllHospital");
//		list.forEach(e-> System.out.println(e));
//	}
//	@Test
//	public void searchHospitalByNum()throws Exception {
//		SqlSession session = getSqlSession();
//		Hospital hospital=session.selectOne(NS+"searchHospitalByNum",4);
//		System.out.println(hospital);
//	}
	@Test
	public void searchHospital()throws Exception {
		SqlSession session = getSqlSession();
		Hospital hospital1=new Hospital("치과",null,null,null,null,null,null);
		List<Hospital> list1=session.selectList(NS+"searchHospital",hospital1);
		list1.forEach(e-> System.out.println(e));
		System.out.println("===============================");
		Hospital hospital2=new Hospital(null,"스마일",null,null,null,null,null);
		List<Hospital> list2=session.selectList(NS+"searchHospital",hospital2);
		list2.forEach(e-> System.out.println(e));
		System.out.println("===============================");
		Hospital hospital3=new Hospital(null,null,"마포",null,null,null,null);
		List<Hospital> list3=session.selectList(NS+"searchHospital",hospital3);
		list3.forEach(e-> System.out.println(e));
	}
}
