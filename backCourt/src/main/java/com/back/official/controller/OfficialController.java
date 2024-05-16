package com.back.official.controller;

import java.util.HashMap;
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

import com.back.official.service.OfficialService;

@Controller
public class OfficialController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired OfficialService officialService;
	
	// 공식 경기 접속 및 리스트
	
	@RequestMapping(value = "/")
	public String home() {
		return "redirect:/official";
	}
	
	@RequestMapping(value = "/official")
	public String official() {
		return "redirect:/official/match_list.go";
	}
	
	@RequestMapping(value = "/official/match_list.go")
	public String listGo(HttpSession session, Model model) {
		logger.info("match_list.go /");
		
		if(session.getAttribute("loginId") != null) {
			model.addAttribute("chk", "on");
		}else {
			model.addAttribute("chk", "notOn");
		}
		
		return "official/match_list";
	}
	
	@RequestMapping(value = "/official/match_list.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> callList(String currentPage, String address, String level) {
		logger.info("listCall / currentPage = {} / address = {} / level = {} / ", currentPage, address);
		logger.info("listCall / level = {} / ", level);
		int page = Integer.parseInt(currentPage);
		Map<String, Object> map = officialService.list(page, address, level);

		return map;
	}
	
	@RequestMapping(value = "/official/searchList.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> searchList(String courtSearchWord, String currentPage) {
		logger.info("listCall / courtSearchWord = {} ", courtSearchWord);
		int page = Integer.parseInt(currentPage);
		Map<String, Object> map = officialService.searchList(page, courtSearchWord);

		return map;
	}
	
	
	// 공식 경기 상세보기
	@RequestMapping(value = "/official/match_info.go")
	public String detail(HttpSession session, Model model, String official_match_idx) {
		logger.info("상세보기 이동");
		logger.info("official_match_idx : {} ", official_match_idx);
		String page = "../login";
		
		if(session.getAttribute("loginId") != null) {
			page = "official/match_info";
			officialService.detail(official_match_idx, model);
		}else {
			model.addAttribute("msg", "로그인이 필요한 서비스입니다.");
		}
		
		return page;
	}
	
	@RequestMapping(value = "/official/payment.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> payment(HttpSession session, int fee, int idx) {
		logger.info("결제 시도");
		logger.info("fee : {} ", fee);
		String id = "";
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(session.getAttribute("loginId") != null) {
			id = (String) session.getAttribute("loginId");
			map = officialService.compare(id, idx);
		}
		
		return map;
	}
	
	@RequestMapping(value = "/official/use.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> use(HttpSession session, Model model, int fee, String idx) {
		logger.info("결제 사용 확인");
		logger.info("fee : {} ", fee);
		logger.info("idx : {} ", idx);
		String id = "";
		
		id = (String) session.getAttribute("loginId");
		Map<String, Object> map = officialService.use(idx, id, fee);
		
		return map;
	}
	
}


















