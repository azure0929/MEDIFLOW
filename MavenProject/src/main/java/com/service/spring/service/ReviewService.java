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
	
    // DB R_CONTENT 값과 정확히 일치해야 함(공백/슬래시/띄어쓰기 주의)
    private static final List<String> CATEGORY_ORDER = List.of(
        "친절한 의사 선생님",
        "전문적인 치료",
        "상냥한 간호사 / 직원",
        "깨끗한 시설",
        "편한 교통 주차"
    );
	
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
	
    // 총 리뷰 수 (합산)
    public int getTotalReviewCountByHospital(int hNum) throws Exception {
        Map<String, Integer> m = countReviewByContent(hNum);
        int sum = 0;
        for (int v : m.values()) sum += v;
        return sum;
    }
	
    public List<String> getCategoryOrder() {
        return CATEGORY_ORDER;
    }
}
