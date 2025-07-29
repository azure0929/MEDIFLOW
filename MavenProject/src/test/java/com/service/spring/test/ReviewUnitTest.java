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


public class ReviewUnitTest {
	private static final String NS = "ReviewMapper.";
	private SqlSession getSqlSession()throws Exception{
		Reader reader=Resources.getResourceAsReader("config/SqlMapConfig.xml");
		SqlSessionFactory factory=new SqlSessionFactoryBuilder().build(reader);
		SqlSession session=factory.openSession();
		
		return session;
	}
//	@Test
//	public void insertReview()throws Exception {
//		SqlSession session = getSqlSession();
//		Hospital hos = new Hospital(1,null,null,null,null,null,null,null);
//		Member mem = new Member(6,null,null,null,null,null);
//		Review review = new Review(hos,mem,"친절한 진료");
//		int result=session.insert(NS+"insertReview",review);
//		session.commit();
//		System.out.println(result);
//	}
//	@Test
//	public void searchReviewByHospital()throws Exception {
//		SqlSession session = getSqlSession();
//		List<Review> result=session.selectList(NS+"searchReviewByHospital",1);
//		result.forEach(e->System.out.println(e));
//	}
	@Test
	public void countReviewByContent()throws Exception {
		SqlSession session = getSqlSession();
	    List<Map<String, Object>> list = session.selectList(NS + "countReviewByContent",1);

	    Map<String, Integer> result = new LinkedHashMap<>();
	    for (Map<String, Object> row : list) {
	        String content = (String) row.get("R_CONTENT");
	        Integer count =((Number) row.get("count")).intValue(); 
	        // MyBatis는 DB에서 조회한 숫자 타입(count)을 Java의 어떤 타입으로 매핑할지는 JDBC 드라이버 + DB 벤더에 따라 다릅니다.
	        result.put(content, count);
	    }
		System.out.println(result);
	}

}
