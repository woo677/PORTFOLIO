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
import org.springframework.web.multipart.MultipartFile;

import com.back.admin.service.AdminCourtService;

@Controller
public class AdminCourtController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	AdminCourtService adminCourtService;

	@RequestMapping(value = "/admin/courtList.go")
	public String listGo(HttpSession session) {
//		String isAdmin = "";
//		isAdmin = (String) session.getAttribute("isAdmin");
//		if (isAdmin == null || isAdmin.isEmpty()) {
//			return "redirect:/login.go";
//		}
		return "/admin/court_list";
	}

	@RequestMapping(value = "/admin/courtList.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> callList(@RequestParam Map<String, Object> param) {

		logger.info("callList / param = {}", param);

		return adminCourtService.list(param);

	}

	@RequestMapping(value = "/admin/courtWrite.go")
	public String WriteGo(HttpSession session) {
//		String isAdmin = (String) session.getAttribute("isAdmin");
//		if (isAdmin == null || isAdmin.isEmpty()) {
//			return "redirect:/login.go";
//		}
		return "/admin/court_register";
	}

	@RequestMapping(value = "/admin/courtWrite.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Boolean> write(@RequestParam("file") MultipartFile[] files,
			@RequestParam("courtWriteName") String courtWriteName,
			@RequestParam("courtWriteInfo") String courtWriteInfo,
			@RequestParam("courtWritePrice") String courtWritePrice,
			@RequestParam("courtWriteAddress") String courtWriteAddress,
			@RequestParam("courtIsOfficial") String courtIsOfficial,
			@RequestParam("courtIsDisabled") String courtIsDisabled) {

		logger.info("courtWriteName: {}", courtWriteName);
		logger.info("courtWriteInfo: {}", courtWriteInfo);
		logger.info("courtWritePrice: {}", courtWritePrice);
		logger.info("courtWriteAddress: {}", courtWriteAddress);
		logger.info("courtIsOfficial: {}", courtIsOfficial);
		logger.info("courtIsDisabled: {}", courtIsDisabled);

		// 파일 정보도 로깅
		for (MultipartFile file : files) {
			logger.info("File Name: {}", file.getOriginalFilename());
			logger.info("Content Type: {}", file.getContentType());
			logger.info("File Size: {}", file.getSize());
		}

		return adminCourtService.write(files, courtWriteName, courtWriteInfo, courtWritePrice, courtWriteAddress,
				courtIsOfficial, courtIsDisabled);
	}

	@RequestMapping(value = "/admin/courtDetail.go")
	public String DetailGo(HttpSession session, String courtIdx, Model model) {
//		String isAdmin = (String) session.getAttribute("isAdmin");
//		if (isAdmin == null || isAdmin.isEmpty()) {
//			return "redirect:/login.go";
//		}
		logger.info(courtIdx);
		adminCourtService.detailLoad(courtIdx, model);
		return "/admin/court_update";
	}

	@RequestMapping(value = "/admin/courtUpdate.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Boolean> update(@RequestParam("file") MultipartFile[] files,
			@RequestParam("courtUpdateName") String courtUpdateName,
			@RequestParam("courtUpdateInfo") String courtUpdateInfo,
			@RequestParam("courtUpdatePrice") String courtUpdatePrice,
			@RequestParam("courtUpdateAddress") String courtUpdateAddress,
			@RequestParam("courtIsOfficial") String courtIsOfficial,
			@RequestParam("courtIsDisabled") String courtIsDisabled, @RequestParam("courtIdx") String courtIdx) {

		logger.info("update controller courtIdx = " + courtIdx);
		return adminCourtService.update(files, courtUpdateName, courtUpdateInfo, courtUpdatePrice, courtUpdateAddress,
				courtIsOfficial, courtIsDisabled, courtIdx);
	}

}
