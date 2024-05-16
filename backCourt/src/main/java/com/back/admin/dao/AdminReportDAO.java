package com.back.admin.dao;

import java.util.List;
import java.util.Map;

import com.back.admin.dto.AdminReportDTO;

public interface AdminReportDAO {

	AdminReportDTO detail(String reportIdx);

	void update(String reportIdx, String reportState, String reportFeed);

	void feedInsert(String adminId, String reportIdx);

	int totalPage(Map<String, Object> param);

	List<AdminReportDTO> list(Map<String, Object> param);

	void noticeInsert(String findUser, String string);

}
