package com.service.spring.service;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.service.spring.dao.BookingDAO;
import com.service.spring.domain.Booking;

import jakarta.annotation.PostConstruct;

@Service
public class BookingService {
	
	@Autowired
	private BookingDAO bookingDAOp;
	
	public void insertBooking(Booking booking) throws Exception {
		bookingDAOp.insertBooking(booking);
	}

	public void deleteBooking(int bNum) throws Exception {
		bookingDAOp.deleteBooking(bNum);
	}
	
	public void updateBookingStatus(Map map) throws Exception {
		bookingDAOp.updateBookingStatus(map);
	}
	
	@PostConstruct //서버 실행시 바로 작동
	public void runOnStartup() {
	    autoUpdateBookingStatus(); // 스케줄러 메서드 호출
	}
	//실제 서비스에서는 이용완료 근거 필요하지만, 본 프로젝트는 단순화를 위해 시간 경과만으로 처리”라는 점을 문서에 명시
	//매 분마다 스케줄러로 자동 실행
	@Scheduled(cron = "0 * * * * *", zone = "Asia/Seoul")
	public void autoUpdateBookingStatus() {
		try {
			int updated = bookingDAOp.autoUpdateBookingStatus();
			System.out.println("자동 상태변경 : " + updated+" 건");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public List<Booking> searchBookingByMember(int mNum) throws Exception {
		return bookingDAOp.searchBookingByMember(mNum);
	}

	public Map<String, Integer> countBookingByAge() throws Exception {
		List<Map<String, Object>> list = bookingDAOp.countBookingByAge();
		Map<String, Integer> result = new LinkedHashMap<>();
		for (Map<String, Object> row : list) {
			String ageGroup = (String) row.get("M_AGE");
			Integer count = ((Number) row.get("count")).intValue();
			result.put(ageGroup, count);
		}
		return result;
	}

	public Map<String, Map<String, Integer>> countBookingByDeptAge() throws Exception {
		List<Map<String, Object>> rawList = bookingDAOp.countBookingByDeptAge();

		Map<String, Map<String, Integer>> chartData = new HashMap<>();
		for (Map<String, Object> row : rawList) {
			String dept = (String) row.get("H_DEPARTMENT");
			String age = (String) row.get("M_AGE");
			int count = ((Number) row.get("count")).intValue();

			chartData.computeIfAbsent(dept, k -> new HashMap<>()).put(age, count);
		}
		return chartData; //Controller에서 json으로 전환해서 jsp에 보내줘야함
	}

	public Map<String, Map<String, Integer>> countBookingByDistrictDept() throws Exception {
		List<Map<String, Object>> rawList = bookingDAOp.countBookingByDistrictDept();
		 
		 Map<String, Map<String, Integer>> chartData = new HashMap<>();
			for (Map<String, Object> row : rawList) {
				String district = (String) row.get("H_DISTRICT");
				String dept = (String) row.get("H_DEPARTMENT");
				int count = ((Number) row.get("count")).intValue();

				chartData.computeIfAbsent(district, k -> new HashMap<>()).put(dept, count);
			}
			return chartData; //Controller에서 json으로 전환해서 jsp에 보내줘야함
	}
}