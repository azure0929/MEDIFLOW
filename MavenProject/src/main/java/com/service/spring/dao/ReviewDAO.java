package com.service.spring.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.service.spring.domain.Review;

@Repository
public class ReviewDAO {
	
	public static final String NS = "ReviewMapper.";
	
	@Autowired
	private SqlSession session;
	
	public void insertReview(Review review)throws Exception {
		session.insert(NS+"insertReview",review);
	}
	
	public List<Review> searchReviewByHospital(int hNum)throws Exception {
		return session.selectList(NS+"searchReviewByHospital",hNum);
	}
	
	public List<Map<String, Object>> countReviewByContent(int hNum)throws Exception {
		return session.selectList(NS + "countReviewByContent",hNum);
	}
}
