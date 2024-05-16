package com.back.admin.controller;

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

import com.back.admin.dto.AdminMemberDTO;
import com.back.admin.service.AdminMemberService;

@Controller
public class AdminMemberController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired AdminMemberService memberService;
	
	// 회원 관리 게시판 입장
	@RequestMapping(value = "/admin/memberList.go")
	public String teammate() {
		logger.info("회원 관리 게시판 접속");
		return "/admin/member_list";
	}
	
	// 회원 관리 리스트 페이징
	@RequestMapping(value = "/admin/adminMember.ajax", method = RequestMethod.POST)
	@ResponseBody // response 객체로 반환
	public Map<String, Object> callList(String currentPage, String state, String searchWord,
			String searchFlag) {
		
		
		logger.info("listCall / currentPage = {} / state = {} / ", currentPage, state);
		logger.info(searchFlag);
		int page = Integer.parseInt(currentPage);
		if (searchFlag.equals("true")) {
			return memberService.searchList(page, state, searchWord);
		} else {
			return memberService.list(page, state);
		}

	}
	
	// 회원 상세 정보페이지 접속
	@RequestMapping(value = "/admin/memberDetail")
	public String DetailGo(HttpSession session, String memberId, Model model) {
		
		// 나중에 관리자 세션 풀어야합니다.
//		String isAdmin = (String) session.getAttribute("isAdmin");
//		if (isAdmin == null ||isAdmin.isEmpty()) {
//			return "redirect:/login.go";
//		}
		logger.info(memberId);
		memberService.detailLoad(memberId, model);
		return "/admin/member_detail";
	}
	
	// 회원정보 수정페이지 불러오기
	@RequestMapping(value = "/admin/memberDetail.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, AdminMemberDTO> memberModify(String memberId) {

		logger.info("수정페이지 memberId : " + memberId);

		return memberService.memberDetail(memberId);
	}
	
	// 회원정보 수정페이지 작성완료
	@RequestMapping(value = "/admin/memberUpdate.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> writeUpdate(String memberName, String memberPass, String memberLevel,
			String memberAddress, String memberGender, String memberPosition, String memberState, String memberId) {
		logger.info("memberUpdate " + memberName + " " + memberPass);
		logger.info("memberUpdate " + memberLevel + " " + memberAddress);
		logger.info("memberUpdate " + memberGender+ " " + memberPosition);
		logger.info("memberUpdate " + memberState+ " " + memberId);
		return memberService.writeUpdate(memberName, memberPass, memberLevel, memberAddress, memberGender,
														memberPosition, memberState, memberId);
	}
	// 회원 포인트 내역 불러오기
	@RequestMapping(value = "/admin/memberPoint")
	
	public String DetailGo(Model model, String memberId) {

		logger.info(memberId);
		memberService.pointDetail(model, memberId);
		return "/admin/member_point";
	}

	// 포인트 관리 리스트 페이징
	@RequestMapping(value = "/admin/adminPoint.ajax", method = RequestMethod.POST)
	@ResponseBody // response 객체로 반환
	public Map<String, Object> pointPage(String currentPage) {
		
		logger.info("listCall= "+ currentPage);
		int page = Integer.parseInt(currentPage);
		return memberService.pointPage(page);
	}
	// 회원 포인트 수정페이지 작성완료
	@RequestMapping(value = "/admin/pointUpdate.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> pointUpdate(String id, String pointVal,String pointState) {
		logger.info("memberUpdate =" +id);
		return memberService.pointUpdate(id, pointVal, pointState);
	}
}