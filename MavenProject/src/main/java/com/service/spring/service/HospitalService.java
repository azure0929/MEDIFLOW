package com.service.spring.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.spring.dao.HospitalDAO;
import com.service.spring.domain.Hospital;

@Service
public class HospitalService {
	
	@Autowired
	private HospitalDAO hospitalDAO;
	
	public void insertHospital(Hospital hospital)throws Exception {
		hospitalDAO.insertHospital(hospital);
	}
	
	public void updateHospital(Hospital hospital)throws Exception {
		hospitalDAO.updateHospital(hospital);
	}
	
	public void deleteHospital(int hNum)throws Exception {
		hospitalDAO.deleteHospital(hNum);
	}
	
	public int totalCountHospital()throws Exception{
		return hospitalDAO.totalCountHospital();
	}
	
	public List<Hospital> searchAllHospital(Map map)throws Exception {
		return hospitalDAO.searchAllHospital(map);
	}
	
	public Hospital searchHospitalByNum(int hNum)throws Exception {
		return hospitalDAO.searchHospitalByNum(hNum);
	}
	
	public List<Hospital> searchHospital(Hospital hospital)throws Exception {
		return hospitalDAO.searchHospital(hospital);
	}
}
