package com.service.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.service.spring.domain.Hospital;
import com.service.spring.service.HospitalService;

@Controller
public class HospitalController {
	
	@Autowired
	private HospitalService hospitalService;
	
	@GetMapping("/hospital/search")
	public String doSearchHospital(Hospital hospital, Model model) {
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
	
	@GetMapping("/hospital/detail")
    public String doGetHospitalDetail(@RequestParam("hNum") int hNum, Model model) {
        try {
            // 병원 번호를 이용해 단일 병원 정보 조회
            Hospital hospital = hospitalService.searchHospitalByNum(hNum);

            if (hospital != null) {
                model.addAttribute("hospital", hospital);
                // hospitalDetail.jsp 뷰로 이동
                return "hospital/hospitalDetail"; 
            } else {
                model.addAttribute("message", "해당하는 병원 정보가 없습니다.");
                return "error";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }
	
	
}
