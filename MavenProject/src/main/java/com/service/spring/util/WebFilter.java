package com.service.spring.util;

import java.io.IOException;

import org.springframework.stereotype.Component;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component //필터를 스프링 빈으로 등록
public class WebFilter implements Filter{
	
	 @Override
	 public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)throws IOException, ServletException {

	        // UTF-8 인코딩 설정
	        request.setCharacterEncoding("UTF-8");
	        response.setCharacterEncoding("UTF-8");
	        
//	        HttpServletRequest req = (HttpServletRequest) request;
//	        HttpServletResponse res = (HttpServletResponse) response;
	        
	        chain.doFilter(request, response);
	 }

}
