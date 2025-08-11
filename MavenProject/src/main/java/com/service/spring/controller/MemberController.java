package com.service.spring.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.service.spring.domain.Booking;
import com.service.spring.domain.Member;
import com.service.spring.domain.Review;
import com.service.spring.service.BookingService;
import com.service.spring.service.MemberService;
import com.service.spring.service.ReviewService;

import jakarta.servlet.http.HttpSession;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;
	@Autowired
	private BookingService bookingService;
	@Autowired 
	private ReviewService reviewService;
	
	// 로그인
	@PostMapping("/login")
	public String login(Member member, HttpSession session) {
		try {
			Member loggedInMember = memberService.login(member);
			System.out.println("로그인 성공: " + loggedInMember); 
			if (loggedInMember != null) {
				session.setAttribute("loggedInMember", loggedInMember);
				if ("admin".equals(loggedInMember.getmId())) {
					return "redirect:/admin/adminMain";
				} else {
					return "redirect:/index.jsp"; 
				}
			} else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			// 예외 발생 시 에러 페이지 또는 로그인 페이지로 리다이렉트
			return "redirect:/login.jsp?error=internal_error";
		}
	}

	// 회원가입
	@PostMapping("/memberRegister")
	public String insertMember(Member member) {
		try {
			memberService.insertMember(member);
			return "redirect:/index.jsp";
		} catch (Exception e) {
			e.printStackTrace();
			return "error.jsp";
		}
	}

	// 회원 탈퇴
	@GetMapping("/deleteMember")
	public String deleteMember(HttpSession session) {
		Member member = (Member) session.getAttribute("loggedInMember");
		if (member == null) {
			return "redirect:/index.jsp";
		}

		try {
			memberService.deleteMember(member.getmNum());
			session.invalidate();
			return "redirect:/index.jsp";
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/error.jsp";
		}
	}

	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/index.jsp";
	}

	// 회원정보수정
    @PostMapping("/updateMember")
    public String updateMember(Member member, HttpSession session) {
        Member loggedInMember = (Member) session.getAttribute("loggedInMember");
        if (loggedInMember == null) {
            return "redirect:/index.jsp";
        }

        try {
            String mPassword = member.getmPassword();
            String mPhone = member.getmPhone();
            
            if (mPassword != null && !mPassword.isEmpty()) {
                loggedInMember.setmPassword(mPassword);
            }
            if (mPhone != null && !mPhone.isEmpty()) {
                loggedInMember.setmPhone(mPhone);
            }

            memberService.updateMember(loggedInMember);
            session.setAttribute("loggedInMember", loggedInMember);
            
            return "redirect:/member/bookings"; // mypage로 리다이렉트
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/member/bookings?error=update_failed";
        }
    }
    
    // 예약 내역을 JSON으로 반환하는 새로운 메서드
    @GetMapping("/member/bookings")
    public String getBookingsByMember(Model model, HttpSession session) {
        Member loggedInMember = (Member) session.getAttribute("loggedInMember");
        if (loggedInMember == null) {
        	return "redirect:/member/login.jsp";
        }
        
        try {
            int mNum = loggedInMember.getmNum();
            List<Booking> bookings = bookingService.searchBookingByMember(mNum);
            bookings.forEach(e->System.out.println(e));
            
            model.addAttribute("bookingList", bookings);
            
            return "member/mypage";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/member/mypage?error=booking_failed";
        }
    }
    
    //예약내역 삭제하는 메서드
    @GetMapping("/mypage/deleteBooking")
    public String deleteBooking(int bNum) {
    	try {
    		bookingService.deleteBooking(bNum);
    	}catch(Exception e) {
    		e.printStackTrace();
    	}
    	
    	return "redirect:/member/bookings";
    }
    
    //리뷰를 등록하는 메서드 (리뷰등록시 예약상태2로 변경)
    @PostMapping("/mypage/reviewRegister")
    public String insertReview(Review review) {
    	System.out.println(review);
    	System.out.println(review.getBooking().getbNum());
    	Map<String,Integer> map = new HashMap<>();
    	map.put("Status",2);
		map.put("bNum",review.getBooking().getbNum());
    	try {
    		reviewService.insertReview(review);
    		bookingService.updateBookingStatus(map);
    	}catch(Exception e) {
    		e.printStackTrace();
    	}
    	
    	return "redirect:/member/bookings";
    }
}