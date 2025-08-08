package com.service.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.service.spring.service.HospitalService;

@Controller
public class HospitalController {

	
	@Autowired
	private HospitalService hospitalService;
	
	@GetMapping("main/search")
	public String sdlfsdklfl() {
		try {
			
		}catch(Exception e) {
			e.printStackTrace();
			return "";
		}
		return "hospital/main";
	}
}
