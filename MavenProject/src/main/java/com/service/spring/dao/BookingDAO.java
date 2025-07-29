package com.service.spring.dao;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.service.spring.domain.Booking;

@Repository
public class BookingDAO {

	public final static String NS = "BookingMapper.";

	@Autowired
	private SqlSession session;

	public void insertBooking(Booking booking) throws Exception {
		session.insert(NS + "insertBooking", booking);
	}

	public void deleteBooking(int bNum) throws Exception {
		session.delete(NS + "deleteBooking", bNum);
	}

	public List<Booking> searchBookingByMember(int mNum) throws Exception {
		return session.selectList(NS + "searchBookingByMember", mNum);
	}

	public List<Map<String, Object>> countBookingByAge() throws Exception {
		return session.selectList(NS + "countBookingByAge");
	}

	public List<Map<String, Object>> countBookingByDeptAge() throws Exception {
		return session.selectList(NS + "countBookingByDeptAge");
	}

	public List<Map<String, Object>> countBookingByDistrictDept() throws Exception {
		return session.selectList(NS + "countBookingByDistrictDept");
	}
}
