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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.back.admin.dto.AdminReportDTO;
import com.back.admin.service.AdminReportService;

@Controller
public class AdminReportController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	AdminReportService adminReportService;

	@RequestMapping(value = "/admin/reportList.go")
	public String reportListGo(HttpSession session) {
//		String isAdmin = (String) session.getAttribute("isAdmin");
//		if (isAdmin == null || isAdmin.isEmpty()) {
//			return "redirect:/login.go";
//		}
		return "/admin/report_list";
	}

	@RequestMapping(value = "/admin/reportList.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> callList(@RequestParam Map<String, Object> param) {
//		logger.info("callList / param = {} /  ", param);

		return adminReportService.list(param);

	}

	@RequestMapping(value = "/admin/reportDetail.go")
	public String reportDetailGo(HttpSession session, Model model, String reportIdx) {
//		String isAdmin = (String) session.getAttribute("isAdmin");
//		if (isAdmin == null || isAdmin.isEmpty()) {
//			return "redirect:/login.go";
//		}
		logger.info("reportDetailGo " + reportIdx);
		model.addAttribute("reportIdx", reportIdx);
		return "/admin/feed";
	}

	@RequestMapping(value = "/admin/reportDetail.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, AdminReportDTO> reportDetail(String reportIdx) {
		logger.info("reportDetail " + reportIdx);
		return adminReportService.detail(reportIdx);
	}

	@RequestMapping(value = "/admin/reportUpdate.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> reportUpdate(HttpSession session, String reportState, String reportFeed,
			String reportIdx, String reportId) {
		logger.info(reportId);
		String adminId = (String) session.getAttribute("loginId");
		return adminReportService.update(adminId, reportIdx, reportState, reportFeed,reportId);
	}

}
