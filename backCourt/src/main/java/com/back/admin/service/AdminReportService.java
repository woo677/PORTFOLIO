package com.back.admin.service;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.back.admin.dao.AdminReportDAO;
import com.back.admin.dto.AdminReportDTO;

@Service
public class AdminReportService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	AdminReportDAO adminReportDAO;

	public Map<String, Object> list(Map<String, Object> param) {
		Map<String, Object> result = new HashMap<String, Object>();

		int start = (Integer.parseInt((String) param.get("currentPage")) - 1) * 10;
		param.put("start", start);
		logger.info("list param = {}", param);

		result.put("list", adminReportDAO.list(param));
		logger.info(result.get("list") + "");
		int totalPage = adminReportDAO.totalPage(param);

		if (totalPage / 10 == 0) {
			totalPage = 1;
		} else if (totalPage % 10 > 0) {
			totalPage = totalPage / 10 + 1;
		} else {
			totalPage = totalPage / 10;
		}
		result.put("totalPage", totalPage);

		return result;
	}

	public Map<String, AdminReportDTO> detail(String reportIdx) {
		Map<String, AdminReportDTO> map = new HashMap<String, AdminReportDTO>();
		AdminReportDTO dto = adminReportDAO.detail(reportIdx);
		map.put("reportInfo", dto);
		return map;
	}

	public Map<String, Object> update(String adminId, String reportIdx, String reportState, String reportFeed,
			String reportId) {
		Map<String, Object> map = new HashMap<String, Object>();

		adminReportDAO.update(reportIdx, reportState, reportFeed);
		logger.info("params id = " + reportId + " reportIdx = " + reportIdx);
		try {
			adminReportDAO.feedInsert(adminId, reportIdx);
			adminReportDAO.noticeInsert(reportId, "문의상태가 변경");
		} catch (Exception e) {
			map.put("result", false);
		}
		map.put("result", true);
		return map;
	}

}
