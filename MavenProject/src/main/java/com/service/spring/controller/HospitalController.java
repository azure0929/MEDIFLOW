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
	
	// index.jsp에서 사용자가 선택한 옵션에 따라 처음으로 보여줄 검색 결과
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
			return "error";
		}
	}
	
	// mian.jsp에서 사용자가 검색어 입력 시 보여줄 검색 결과
	// select option을 선택 후, 검색 결과가 없을 경우 어떻게 할 것인지?
	// 전체 검색은 무엇을 입력해도 전체 검색결과가 나오도록 했는데, 어떻게 할 것인지
	@GetMapping("/hospital/search/result")
	public String doSearchHospital(@RequestParam(value = "searchType", defaultValue = "all") String searchType, 
            					   @RequestParam(value = "keyword", required = false) String keyword,  Model model){
		
		// 검색어에 공백이 끼어있을 경우 공백 삭제
		String trimmedKeyword = (keyword != null) ? keyword.replaceAll("\\s+", "") : "";
		
		System.out.println("검색 타입: " + searchType);
		System.out.println("기존 검색 키워드: " + keyword);
		System.out.println("공백 제거 검색 키워드: " + trimmedKeyword);
		
		try {
			Hospital hospital = new Hospital();
			
			if (!trimmedKeyword.isEmpty()) {
				switch (searchType) {
					case "hospitalName":
						hospital.sethTitle(trimmedKeyword);
						break;
					case "location":
						hospital.sethAddress(trimmedKeyword);
						break;
					case "specialty":
						hospital.sethDepartment(trimmedKeyword);
						break;
				}
			}
			
			List<Hospital> hospitals = hospitalService.searchHospital(hospital);
			model.addAttribute("hospitalList" ,hospitals);
			
			model.addAttribute("searchType", searchType);
			model.addAttribute("keyword", trimmedKeyword);
			return "hospital/main";
			
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "병원 검색 중 오류가 발생했습니다.");
			return "error"; 
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
