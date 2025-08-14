package com.service.spring.test;

import java.io.Reader;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.jupiter.api.Test;


public class BookingUnitTest {
	private static final String NS = "BookingMapper.";
	private SqlSession getSqlSession()throws Exception{
		Reader reader=Resources.getResourceAsReader("config/SqlMapConfig.xml");
		SqlSessionFactory factory=new SqlSessionFactoryBuilder().build(reader);
		SqlSession session=factory.openSession();
		
		return session;
	}
//	@Test
//	public void insertBooking()throws Exception {
//		SqlSession session = getSqlSession();
//		Hospital hos=new Hospital(1,"이비인후과","스마일병원","마포구","서울시 마포구","02-555-6666","스마일병원입니다.",null);
//		Member member = new Member(5,"test","1234","test","010-3333-4444","20대");
//		Booking booking = new Booking(member,hos,"오전");
//		session.insert(NS+"insertBooking",booking);
//		session.commit();
//	}
//	@Test
//	public void deleteBooking()throws Exception {
//		SqlSession session = getSqlSession();
//		session.delete(NS+"deleteBooking",1);
//		session.commit();
//	}
//	@Test
//	public void searchBookingByMember()throws Exception {
//		SqlSession session = getSqlSession();
//		List<Booking> list=session.selectList(NS+"searchBookingByMember",2);
//		list.forEach(e-> System.out.println(e));
//	}
//	@Test
//	public void countBookingByAge()throws Exception {
//		SqlSession session = getSqlSession();
//	    List<Map<String, Object>> list = session.selectList(NS + "countBookingByAge");
//	    list.forEach(e->System.out.println(e));
//	    Map<String, Integer> result = new LinkedHashMap<>();
//	    for (Map<String, Object> row : list) {
//	        String ageGroup = (String) row.get("M_AGE");
//	        Integer count =((Number) row.get("count")).intValue();
//	        //MyBatis는 DB에서 조회한 숫자 타입(count)을 Java의 어떤 타입으로 매핑할지는 JDBC 드라이버 + DB 벤더에 따라 다릅니다.
//	        result.put(ageGroup, count);
//	    }
//		System.out.println(result);
//	}
//	@Test
//	public void countBookingByDepartment()throws Exception {
//		SqlSession session = getSqlSession();
//	    List<Map<String, Object>> list = session.selectList(NS + "countBookingByDeptAge");
//	    System.out.println(list);
//	    list.forEach(e->System.out.println(e));
//	}
	@Test
	public void countBookingByDistrict()throws Exception {
		SqlSession session = getSqlSession();
	    List<Map<String, Object>> list = session.selectList(NS + "countBookingByDistrictDept");
	    System.out.println(list);
	    list.forEach(e->System.out.println(e));
	}
}
