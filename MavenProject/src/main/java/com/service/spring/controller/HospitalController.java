package com.service.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.service.spring.domain.Hospital;
import com.service.spring.service.HospitalService;

@Controller
public class HospitalController {
	
	@Autowired
	private HospitalService hospitalService;
	
	@GetMapping("/main/search")
	public String doSearchHospital(Hospital hospital, Model model) {
		System.out.println("들어오냐?");
		try {
			List<Hospital> hospitals = hospitalService.searchHospital(hospital);
			model.addAttribute("hospitalList" ,hospitals);
			model.addAttribute("hTitle", hospital.gethTitle());
            model.addAttribute("hDepartment", hospital.gethDepartment());
            model.addAttribute("hAddress", hospital.gethAddress());
            return "hospital/main";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "병원 검색 중 오류 발생!");
			return "error.jsp";
		}
	}
	
	
}
