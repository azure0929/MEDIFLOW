package com.service.spring.controller;

import java.io.File;
import java.util.HashMap;
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
	public String searchAllMember(@RequestParam(defaultValue = "1")int pageNum, Model model) {
		try {
			Map<String,Integer> map = new HashMap<>();
			int pageSize = 15;
			int offset = (pageNum - 1) * pageSize;
			map.put("offSet",offset);
			map.put("Limit",pageSize);
			int totalCount = memberService.totalCountMember();
			int pageCount = totalCount/pageSize +1;
			List<Member> list=memberService.searchAllMember(map);
			model.addAttribute("currentPage", pageNum);
			model.addAttribute("pageCount",pageCount);
			model.addAttribute("memberList",list);
		}catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "모든 회원 정보를 조회하는데 오류가 발생했습니다.");
			return "error";
		}
		return "admin/adminMain";
	}
	
	// 조건별 회원 조회
	@GetMapping("/searchMember")
	public String searchMember(Member member, Model model) {
		try {
			List<Member> list=memberService.searchMember(member);
			model.addAttribute("memberList",list);
		}catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "회원 정보를 조회하는데 오류가 발생했습니다.");
			return "error";
		}
		return "admin/adminMain";
	}
	
	
	//병원 관리 부분
	@GetMapping("/searchAllHospital")
	public String searchAllHospital(@RequestParam(defaultValue = "1")int pageNum, Model model) {
		try {
			Map<String,Integer> map = new HashMap<>();
			int pageSize = 8;
			int offset = (pageNum - 1) * pageSize;
			map.put("offSet",offset);
			map.put("Limit",pageSize);
			int totalCount = hospitalService.totalCountHospital();
			int pageCount = totalCount/pageSize +1;
			List<Hospital> list = hospitalService.searchAllHospital(map);
			model.addAttribute("currentPage", pageNum);
			model.addAttribute("pageCount",pageCount);
			model.addAttribute("hospitalList",list);
			
			return "admin/adminHospital";
		}catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "모든 병원 정보를 조회하는데 오류가 발생했습니다.");
			return "error";
		}
	}
	
	// 조건별 병원 조회
	@GetMapping("/searchHospital")
	public String searchHospital(Hospital hospital, Model model) {
		try {
			List<Hospital> list = hospitalService.searchHospital(hospital);
			model.addAttribute("hospitalList",list);
			return "admin/adminHospital";
		}catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "조건별 병원 정보를 조회하는데 오류가 발생했습니다.");
			return "error";
		}
	}
	
	// 병원 등록
	@PostMapping("/hospitalRegister")
	public String insertHospital(Hospital hospital,@RequestParam("uploadFile") MultipartFile file, Model model) {
		 try {	
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
	        model.addAttribute("message", "병원 등록에 실패했습니다.");
	        return "error";
	    }
	}
	
	// 병원 정보 수정 - 특정 병원 응답
	@GetMapping("/hospitalUpdatePage")
	public String searchHospitalByNum(int hNum, Model model) {
		try {
			Hospital hospital = hospitalService.searchHospitalByNum(hNum);
			model.addAttribute("hospital",hospital);
			
			return "admin/adminHospitalUpdate";
		}catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "특정 병원 정보를 불러오는데 오류가 발생했습니다.");
			return "error";
		}
	}
	
	// 병원 정보 수정 요청
	@PostMapping("/hospitalUpdate")
	public String updateHospital(Hospital hospital, Model model) {
		try {
			hospitalService.updateHospital(hospital);
			return "redirect:/admin/searchAllHospital";
		}catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "병원 정보를 수정하는데 오류가 발생했습니다.");
			return "error";
		}
	}
	
	// 병원 정보 삭제
	@GetMapping("/hospitalDelete")
	public String deleteHospital(int hNum, Model model) {
		try {
			hospitalService.deleteHospital(hNum);
			return "redirect:/admin/searchAllHospital";
		}catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("mesage", "병원 정보를 삭제하는데 오류가 발생했습니다.");
			return "error";
		}
	}
	
	//통계 관리 부분
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
			 return bookingService.countBookingByDeptAge();
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}// controller 닫히는부분
