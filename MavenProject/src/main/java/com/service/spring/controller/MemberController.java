package com.service.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.service.spring.domain.Member;
import com.service.spring.service.MemberService;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@RestController
public class MemberController {

    @Autowired
    private MemberService memberService;

    // 로그인
    @PostMapping("/login")
    public ResponseEntity<String> login(Member member, HttpSession session, HttpServletResponse response) {
        try {
            Member loggedInMember = memberService.login(member);
            if (loggedInMember != null) {
                session.setAttribute("loggedInMember", loggedInMember);

                // 로그인 성공 시 세션 ID를 쿠키에 저장
                Cookie cookie = new Cookie("JSESSIONID", session.getId());
                cookie.setPath("/");
                cookie.setMaxAge(3600); // 쿠키 유효기간 (초 단위, 1시간)
                response.addCookie(cookie);

                if ("admin".equals(loggedInMember.getmId())) {
                    return new ResponseEntity<>("Success_Admin", HttpStatus.OK);
                } else {
                    return new ResponseEntity<>("Success", HttpStatus.OK);
                }
            } else {
                return new ResponseEntity<>("Failed", HttpStatus.UNAUTHORIZED);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Error", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // 회원가입
    @PostMapping("/memberRegister")
    public ResponseEntity<String> insertMember(@RequestBody Member member) {
        try {
            memberService.insertMember(member);
            return new ResponseEntity<>("Success", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Failed", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // 회원 탈퇴
    @PostMapping("/deleteMember")
    public ResponseEntity<String> deleteMember(HttpSession session) {
        Member member = (Member) session.getAttribute("loggedInMember");
        if (member == null) {
            return new ResponseEntity<>("NotLoggedIn", HttpStatus.UNAUTHORIZED);
        }
        
        try {
            memberService.deleteMember(member.getmNum());
            session.invalidate();
            return new ResponseEntity<>("Success", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Failed", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // 로그아웃
    @PostMapping("/logout")
    public ResponseEntity<String> logout(HttpSession session) {
        session.invalidate();
        return new ResponseEntity<>("Success", HttpStatus.OK);
    }
}