package com.service.spring.controller;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.service.spring.domain.Hospital;
import com.service.spring.domain.Member;
import com.service.spring.service.BookingService;
import com.service.spring.service.HospitalService;
import com.service.spring.service.MemberService;

@RequestMapping("admin")
@Controller
public class AdminController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private HospitalService hospitalService;
	
	@Autowired
	private BookingService bookingService;
	
	//회원 관리 부분
	@GetMapping("/adminMain")
	public String searchAllMember(Model model) {
		try {
		List<Member> list=memberService.searchAllMember();
			model.addAttribute("memberList",list);
		}catch(Exception e) {
			e.printStackTrace();
			return "";
		}
		return "admin/adminMain";
	}
	
	@GetMapping("/searchMember")
	public String searchMember(Member member, Model model) {
		System.out.println(member);
		try {
			List<Member> list=memberService.searchMember(member);
			model.addAttribute("memberList",list);
		}catch(Exception e) {
			e.printStackTrace();
			return "";
		}
		return "admin/adminMain";
	}
	
	
	//병원 관리 부분
	@GetMapping("/searchAllHospital")
	public String searchAllHospital(Model model) {
		try {
			List<Hospital> list = hospitalService.searchAllHospital();
			model.addAttribute("hospitalList",list);
			
			return "admin/adminHospital";
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@GetMapping("/searchHospital")
	public String searchHospital(Hospital hospital, Model model) {
		try {
			List<Hospital> list = hospitalService.searchHospital(hospital);
			model.addAttribute("hospitalList",list);
			return "admin/adminHospital";
		}catch(Exception e) {
			e.printStackTrace();
			return "";
		}
	}
	
	@PostMapping("/hospitalRegister")
	public String insertHospital(Hospital hospital,@RequestParam("uploadFile") MultipartFile file, Model model) {
		 try {	
//			 	System.out.println(hospital);
//			 	System.out.println(file);
		        // 1. 병원 이름을 파일명으로 사용 (공백 제거 및 확장자 추가)
		        String originalTitle = hospital.gethTitle(); // 예: "서울삼성병원"
		        String sanitizedTitle = originalTitle.replaceAll("\\s+", ""); // 공백 제거
		        String savedFileName = sanitizedTitle + ".webp"; // 고정 확장자 사용

		        // 2. 저장 경로 (src/main/webapp/img)
		        String uploadPath = new File("src/main/webapp/img").getAbsolutePath();
		        File saveFile = new File(uploadPath, savedFileName);

		        // 3. 저장 디렉토리 없으면 생성
		        if (!saveFile.getParentFile().exists()) {
		            saveFile.getParentFile().mkdirs();
		        }

		        // 4. 저장 (덮어쓰기 허용)
		        file.transferTo(saveFile);

		        // 5. 이미지 URL을 VO에 저장
		        String imageUrl = "/img/" + savedFileName;
		        hospital.sethUrl(imageUrl);
		        hospitalService.insertHospital(hospital);
		        
		        return "redirect:/admin/searchAllHospital";
		    } catch (Exception e) {
		        e.printStackTrace();
		        return "errorPage";
		    }
	}
	
	@GetMapping("/hospitalUpdatePage")
	public String searchHospitalByNum(int hNum, Model model) {
		try {
			Hospital hospital = hospitalService.searchHospitalByNum(hNum);
			model.addAttribute("hospital",hospital);
			
			return "admin/adminHospitalUpdate";
		}catch(Exception e) {
			e.printStackTrace();
			return "";
		}
	}
	
	@PostMapping("/hospitalUpdate")
	public String updateHospital(Hospital hospital) {
		try {
			System.out.println(hospital);
			hospitalService.updateHospital(hospital);
			return "redirect:/admin/searchAllHospital";
		}catch(Exception e) {
			e.printStackTrace();
			return "";
		}
	}
	
	@GetMapping("/hospitalDelete")
	public String deleteHospital(int hNum) {
		try {
			hospitalService.deleteHospital(hNum);
			return "redirect:/admin/searchAllHospital";
		}catch(Exception e) {
			e.printStackTrace();
			return "";
		}
	}
	//통계 관리 부분
	
	//동기처리 방식일때 사용햇음
//	@GetMapping("/adminDashboard")
//	public String countBookingByAge(Model model) {
//		try {
//			Map<String, Integer> map = bookingService.countBookingByAge();
//			System.out.println(map);
//			ObjectMapper mapper = new ObjectMapper();
//	        String jsonMap = mapper.writeValueAsString(map); // → {"20대":4,"30대":3}
//	        System.out.println(jsonMap);
//	        model.addAttribute("countBookingByAgeJson", jsonMap);
//			return "admin/adminDashboard";
//		}catch(Exception e) {
//			e.printStackTrace();
//			return "";
//		}
//	}
	
	@GetMapping("/ageChart")
	@ResponseBody
	public Map<String, Integer> getAgeChartData() {
		try {
			 return bookingService.countBookingByAge();
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@GetMapping("/addressChart")
	@ResponseBody
	public Map<String, Map<String, Integer>> getaddressChartData() {
		try {
			Map<String, Map<String, Integer>> map=bookingService.countBookingByDistrictDept();
			System.out.println(map);
			 return bookingService.countBookingByDistrictDept();
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@GetMapping("/departmentChart")
	@ResponseBody
	public Map<String, Map<String, Integer>> getdepartmentChartData() {
		try {
			Map<String, Map<String, Integer>> map=bookingService.countBookingByDeptAge();
			System.out.println(map);
			 return bookingService.countBookingByDeptAge();
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}// controller 닫히는부분
