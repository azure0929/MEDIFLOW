package com.service.spring.service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.spring.dao.ReviewDAO;
import com.service.spring.domain.Review;

@Service
public class ReviewService {
	
	@Autowired
	ReviewDAO reviewDAO;
	
	public void insertReview(Review review)throws Exception {
		reviewDAO.insertReview(review);
	}
	
	public List<Review> searchReviewByHospital(int hNum)throws Exception {
		return reviewDAO.searchReviewByHospital(hNum);
	}
	
	public Map<String, Integer> countReviewByContent(int hNum)throws Exception {
		
		List<Map<String, Object>> list = reviewDAO.countReviewByContent(hNum);
		 Map<String, Integer> result = new LinkedHashMap<>();
		    for (Map<String, Object> row : list) {
		        String content = (String) row.get("R_CONTENT");
		        Integer count =((Number) row.get("count")).intValue(); 
		        result.put(content, count);
		    }
		return result;
				
	}
}
