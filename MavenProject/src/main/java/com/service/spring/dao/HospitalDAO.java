package com.service.spring.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.service.spring.domain.Hospital;

@Repository
public class HospitalDAO {
	public final static String NS = "HospitalMapper.";
	@Autowired
	private SqlSession session;
	
	public void insertHospital(Hospital hospital)throws Exception {
		session.insert(NS+"insertHospital",hospital);
	}
	
	public void updateHospital(Hospital hospital)throws Exception {
		session.update(NS+"updateHospital",hospital);
	}
	
	public void deleteHospital(int hNum)throws Exception {
		session.delete(NS+"deleteHospital",hNum);
	}
	
	public List<Hospital> searchAllHospital()throws Exception {
		return session.selectList(NS+"searchAllHospital");
	}
	
	public Hospital searchHospitalByNum(int hNum)throws Exception {
		return session.selectOne(NS+"searchHospitalByNum",hNum);
	}
	
	public List<Hospital> searchHospital(Hospital hospital)throws Exception {
		return session.selectList(NS+"searchHospital",hospital);
	}
}
