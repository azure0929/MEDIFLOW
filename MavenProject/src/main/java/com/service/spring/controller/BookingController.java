package com.service.spring.controller;

import com.service.spring.domain.Booking;
import com.service.spring.domain.Hospital;
import com.service.spring.domain.Member;
import com.service.spring.service.BookingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class BookingController {

	@Autowired
	private BookingService bookingService;

	// 예약 등록
	@PostMapping("/booking/insert")
	@ResponseBody
	public String insertBook(@RequestParam("mNum") int mNum,
	                         @RequestParam("hNum") int hNum,
	                         @RequestParam("bDate") String bDate,
	                         @RequestParam("bTime") String bTime,
	                         Model model) {

	    // 1. 요청 파라미터로 Member와 Hospital 객체를 직접 생성합니다.
	    Member member = new Member();
	    member.setmNum(mNum);
	    
	    Hospital hospital = new Hospital();
	    hospital.sethNum(hNum);
	    
	    // 2. 생성한 객체들을 Booking 객체에 세팅합니다.
	    Booking booking = new Booking();
	    booking.setMember(member);
	    booking.setHospital(hospital);
	    booking.setbDate(bDate);
	    booking.setbTime(bTime);
	    
	    System.out.println("====== 예약 정보 출력 ======");
	    System.out.println(booking); // 이제 member와 hospital 객체가 출력됩니다.
	    System.out.println("===========================");

	    try {
	        bookingService.insertBooking(booking);
	        return "success";
	    } catch (Exception e) {
	        e.printStackTrace();
	        model.addAttribute("message", "예약 실패했습니다.");
	        return "error";
	    }
	}
}