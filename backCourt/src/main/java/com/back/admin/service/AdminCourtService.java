package com.back.admin.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.back.admin.dao.AdminCourtDAO;
import com.back.admin.dto.AdminCourtDTO;

@Service
public class AdminCourtService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	AdminCourtDAO adminCourtDAO;

	String macRoot = "/Users/chaehyeonpark/Documents/gdj78_backcourt/upload/court/";

	String winRoot = "C:/upload/court/";

	public Map<String, Object> list(Map<String, Object> param) {
		Map<String, Object> result = new HashMap<String, Object>();

		int start = (Integer.parseInt((String) param.get("currentPage")) - 1) * 10;
		param.put("start", start);
		logger.info("list param = {}", param);
		result.put("list", adminCourtDAO.list(param));

		result.put("addressList", addressListSplit(adminCourtDAO.addressList()));
		int totalPage = adminCourtDAO.totalPage(param);

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

	private Object addressListSplit(List<String> addressList) {
		Set<String> set = new HashSet<String>();
		List<String> splitList = new ArrayList<String>(set);
		for (String address : addressList) {
			if (address.contains(" ")) {
				set.add(address.split(" ")[1]);
//				logger.info(address);
			}
		}

		Collections.sort(splitList);
		return set;
	}

	public Map<String, Boolean> write(MultipartFile[] files, String courtWriteName, String courtWriteInfo,
			String courtWritePrice, String courtWriteAddress, String courtIsOfficial, String courtIsDisabled) {
		Map<String, Boolean> map = new HashMap<String, Boolean>();

		AdminCourtDTO dto = new AdminCourtDTO();

		dto.setCourtName(courtWriteName);
		dto.setCourtInfo(courtWriteInfo);
		dto.setCourtPrice(courtWritePrice);
		dto.setCourtAddress(courtWriteAddress);
		dto.setCourtOfficial(courtIsOfficial);
		dto.setCourtState(courtIsDisabled);

		map.put("result", adminCourtDAO.write(dto));

		int idx = dto.getCourtIdx();

		logger.info("idx = " + idx);
		logger.info(map.get("result") + "");

		courtImageUploading(idx, files);

		return map;
	}

	public void courtImageUploading(int idx, MultipartFile[] files) {

		String os = System.getProperty("os.name").toLowerCase();

		logger.info(os);
		String directory = "";
		if (os.contains("mac")) {
			directory = macRoot;
		} else if (os.contains("win")) {
			directory = winRoot;
		}
		File dirPath = new File(directory);
		logger.info("경로 " + directory);
		Path path = Paths.get(directory);
		try {
			Files.createDirectories(path.getParent());
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		// 폴더가 존재하지 않으면 생성
		if (!dirPath.exists()) {
			dirPath.mkdirs();
			logger.info("폴더가 생성되었습니다.");
		}

		int count = 1;
		for (MultipartFile file : files) {
			String fileName = file.getOriginalFilename();
			String newFileName = "court" + idx + "_image" + count;
			Path filePath = Paths.get(directory + newFileName + ".png");

			try {
				byte[] bytes = file.getBytes();
				Files.write(filePath, bytes);
				adminCourtDAO.courtImageUpload(Integer.toString(idx), newFileName);
			} catch (IOException e) {
				logger.error("Failed to write file: " + filePath, e);
			}
			count++;
		}
	}

	public void detailLoad(String courtIdx, Model model) {

		logger.info("detailLoad Service in ---------------------------------");
		model.addAttribute("fileName", adminCourtDAO.fileName(courtIdx));
		model.addAttribute("courtDetail", adminCourtDAO.detailLoad(courtIdx));
		model.addAttribute("courtIdx", courtIdx);
		logger.info("detailLoad Service out --------------------------------");
	}

	public Map<String, Boolean> update(MultipartFile[] files, String courtUpdateName, String courtUpdateInfo,
			String courtUpdatePrice, String courtUpdateAddress, String courtIsOfficial, String courtIsDisabled,
			String courtIdx) {
		Map<String, Boolean> map = new HashMap<String, Boolean>();

		AdminCourtDTO dto = new AdminCourtDTO();

		dto.setCourtName(courtUpdateName);
		dto.setCourtInfo(courtUpdateInfo);
		dto.setCourtPrice(courtUpdatePrice);
		dto.setCourtAddress(courtUpdateAddress);
		dto.setCourtOfficial(courtIsOfficial);
		dto.setCourtState(courtIsDisabled);
		dto.setCourtIdx(Integer.parseInt(courtIdx));

		map.put("result", adminCourtDAO.update(dto));
		List<String> fileNameList = adminCourtDAO.fileName(courtIdx);
		courtImageDelete(Integer.parseInt(courtIdx), fileNameList);

		logger.info(map.get("result") + "");
		courtImageUploading(Integer.parseInt(courtIdx), files);

		return map;
	}

	// 구장 이미지 테이블에서 제거후 파일 삭제
	public void courtImageDelete(int courtIdx, List<String> fileNameList) {
		adminCourtDAO.deleteFileList(courtIdx);
		String os = System.getProperty("os.name").toLowerCase();

		logger.info(os);
		String directory = "";
		if (os.contains("mac")) {
			directory = macRoot;
		} else if (os.contains("win")) {
			directory = winRoot;
		}
		for (String fileName : fileNameList) {
			File file = new File(directory + fileName);
			if (file.exists()) {
				file.delete();
			}

		}

	}

}
