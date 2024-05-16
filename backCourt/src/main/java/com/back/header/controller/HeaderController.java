package com.back.header.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.back.header.dto.HeaderDTO;
import com.back.header.service.HeaderService;
import com.back.member.dto.MemberDTO;

@Controller
public class HeaderController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired HeaderService headerserivce;
	
	@RequestMapping(value = "*/session.ajax")
	@ResponseBody 
	public Map<String, Object> sessionChk(HttpSession session, Model model) {
		logger.info("접속");

		String id = (String) session.getAttribute("loginId");
		Map<String, Object> map = new HashMap<String, Object>();
		MemberDTO dto = new MemberDTO();
		boolean sessionCk = false;
		if(id != null) {
			sessionCk = true;
			dto = headerserivce.nav(id);
		}
		map.put("sessionCk", sessionCk);
		map.put("info", dto);
		
		return map;
	}
	
	@RequestMapping(value = "*/header/list.ajax", method = RequestMethod.GET)
	@ResponseBody 
	public Map<String, Object> teamListCall(HttpSession session, Model model) {
		logger.info("team팝업 list 출력");
		
		String id = "";
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(session.getAttribute("loginId") != null) {
			id = (String) session.getAttribute("loginId");
			
			List<HeaderDTO> list = headerserivce.teamList(id);
			map.put("list", list);
		}
		
		return map; 
	}
	
	@RequestMapping(value = "*/notice/list.ajax", method = RequestMethod.GET)
	@ResponseBody 
	public Map<String, Object> noticeListCall(HttpSession session) {
		logger.info("notice list 출력");
		
		String id = (String) session.getAttribute("loginId");
		Map<String, Object> map = new HashMap<String, Object>();
		List<HeaderDTO> list = new ArrayList<HeaderDTO>();
		
		
		list = headerserivce.noticeList(id);
		HeaderDTO dto = headerserivce.count(id);
		map.put("list", list);
		map.put("count", dto);
		
		
		return map; 
	}
	
	@RequestMapping(value = "*/notice/delete.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> del(String idx){
		logger.info("idx : " + idx);
		
		int cnt = headerserivce.del(idx);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cnt", cnt);
		
		return map;
	}
	
	@RequestMapping(value = "/logout.do")
	public String logout(HttpSession session) {
		logger.info("로그아웃 시도");
		String page = "redirect:/login.do";
		session.removeAttribute("loginId");
		
		return page;
	}
	
}

















