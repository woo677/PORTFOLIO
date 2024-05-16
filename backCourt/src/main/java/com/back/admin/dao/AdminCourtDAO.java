package com.back.admin.dao;

import java.util.List;
import java.util.Map;

import com.back.admin.dto.AdminCourtDTO;

public interface AdminCourtDAO {

	List<AdminCourtDTO> list(Map<String, Object> param);

	Boolean write(AdminCourtDTO dto);

	void courtImageUpload(String idx, String newFileName);

	Object callImageName();

	AdminCourtDTO detailLoad(String courtIdx);

	List<String> fileName(String courtIdx);

	Boolean update(AdminCourtDTO dto);

	void deleteFileList(int courtIdx);

	List<String> addressList();

	int totalPage(Map<String, Object> param);

}
