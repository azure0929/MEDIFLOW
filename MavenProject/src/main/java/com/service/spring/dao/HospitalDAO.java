package com.service.spring.dao;

import java.util.List;
import java.util.Map;

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
	
	public int totalCountHospital()throws Exception {
		return session.selectOne(NS+"totalCountHospital");
	}
	
	public List<Hospital> searchAllHospital(Map map)throws Exception {
		return session.selectList(NS+"searchAllHospital",map);
	}
	
	public Hospital searchHospitalByNum(int hNum)throws Exception {
		return session.selectOne(NS+"searchHospitalByNum",hNum);
	}
	
	public List<Hospital> searchHospital(Hospital hospital)throws Exception {
		return session.selectList(NS+"searchHospital",hospital);
	}
}
