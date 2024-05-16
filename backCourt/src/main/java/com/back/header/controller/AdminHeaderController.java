package com.back.header.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.back.header.service.AdminHeaderService;

@Controller
public class AdminHeaderController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired AdminHeaderService adminHeaderService;
	
	@RequestMapping(value = "/header_admin")
	public String header(HttpSession session, Model model) {
		logger.info("접속");
		session.setAttribute("loginInfo", "testID2");
//		session.removeAttribute("loginInfo");
		String id = (String) session.getAttribute("loginInfo");
		String page = "redirect:/login.do";
		
		if(session.getAttribute("loginInfo") != null) {
			page = "header/header_admin";
		}
		
		return page;
	}
	
	@RequestMapping(value = "/admin_logout.do")
	public String logout(HttpSession session) {
		logger.info("로그아웃 시도");
		String page = "redirect:/login.do";
		session.removeAttribute("loginInfo");
		
		return page;
	}
	
}
























