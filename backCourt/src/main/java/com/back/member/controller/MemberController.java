package com.back.member.controller;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.back.member.dto.MemberDTO;
import com.back.member.service.MemberService;

@Controller
public class MemberController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	MemberService memberService;

	//로그인 페이지 접속
	@RequestMapping(value = "/login")
	public String home() {
		logger.info("로그인 접속");
		return "member/login";
	}
	
	//로그인
	@RequestMapping(value = "/login.do",method = RequestMethod.POST)
	public String login(HttpSession session,String id,String pw,Model model) {
		logger.info("로그인 정보 : "+ id,pw);
		String loginId = memberService.login(id,pw);
		MemberDTO loginInformation = memberService.loginperm(id,pw);
		String loginperm = loginInformation.getPerm();
		String loginstate = loginInformation.getState();
		logger.info("loginId : "+loginId);
		logger.info("loginstate : {}",loginperm);
		logger.info("loginstate : {}",loginstate);
		
		String page = "member/login";

		
		if (loginId!=null) {
			logger.info("로그인 아이디 정보 있음");
			if (loginperm.equals("고객")) {
				logger.info("고객 로그인");
				if (loginstate.equals("정지")) {
					model.addAttribute("msg","정지된 아이디 입니다");
				}else{
					session.setAttribute("loginId",loginId);
					page = "redirect:/official";				
				}
			}
			if (loginperm.equals("관리자")) {
				logger.info("관리자 로그인");
				session.setAttribute("loginId",loginId);
				page = "redirect:/admin/memberList.go";
			}
		}else {
			model.addAttribute("msg","아이디 또는 비빌번호를 확인 해주세요");	
			
		}
		
		return page;
	}
	
	//회원 가입 이동
	@RequestMapping(value = "/Join.go")
	public String JoinGo() {
		return "member/Join";
	}
	
	//회원 가입
	@RequestMapping(value = "/Join.do",method = RequestMethod.POST)
	public String Join(Model model,@RequestParam Map<String,String>param) {
		String page = "member/Join";
		String msg = "다시 회원 가입을 해주세요.";
		logger.info("회원가입 : {}",param);
		
		int row = memberService.Join(param);
		logger.info("row : "+row);
		if (row>0) {
			msg = "회원 가입 되었습니다.";
			page = "member/login";
			model.addAttribute("msg",msg);
		}
		
		return page; 
	}
	
	//회원 가입 (아이디 중복 체크)
	@RequestMapping(value = "/overlay.ajax")
	@ResponseBody
	public Map<String, Object> overlay(String id){
		logger.info("id : "+id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("use", memberService.overlay(id));
		logger.info("map : {}",map);
		
		return map;
	}

}

