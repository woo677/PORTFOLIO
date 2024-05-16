package com.back.official.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.back.official.dao.OfficialDAO;
import com.back.official.dto.OfficialDTO;

@Service
public class OfficialService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired OfficialDAO officialDAO;
	
	public Map<String, Object> list(int page, String address, String level) {

		Map<String, Object> result = new HashMap<String, Object>();
		List<OfficialDTO> list = null;
		List<OfficialDTO> allList = officialDAO.allList();

		int start = (page - 1) * 10;
		
		if (address.equals("") == true && level.equals("") == true) {
//			logger.info("servcie.list / address = {} /", address);
			list = officialDAO.list(start);
			result.put("totalPage", officialDAO.allMatchCount());

		}else if(address.equals("") == false && level.equals("") == true) {
//			logger.info("servcie.list / address = {} /", address);
			list = officialDAO.listFilterAddress(start, address);
			result.put("totalPage", officialDAO.addressFilteringMatchCount(address));
			
		}else if(address.equals("") == true && level.equals("") == false) {
//			logger.info("servcie.list / address = {} /", address);
			list = officialDAO.listFilterLevel(start, level);
			result.put("totalPage", officialDAO.levelFilteringMatchCount(level));

		}else if(address.equals("") == false && level.equals("") == false) {
//			logger.info("servcie.list / address = {} /", address);
			list = officialDAO.listFilterAll(start, address, level);
			result.put("totalPage", officialDAO.allFilteringMatchCount(address, level));

		}

		result.put("list", list);
		result.put("allList", allList);
		return result;
	}

	public Map<String, Object> searchList(int page, String courtSearchWord) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<OfficialDTO> list = null;
		List<OfficialDTO> allList = officialDAO.allList();

		int start = (page - 1) * 10;
		
//		logger.info("servcie.list / address = {} /", address);
		list = officialDAO.searchList(start, courtSearchWord);
		result.put("totalPage", officialDAO.searchMatchCount(courtSearchWord));


		result.put("list", list);
		result.put("allList", allList);
		return result;
	}

	public void detail(String official_match_idx, Model model) {
		List<OfficialDTO> photoList = officialDAO.photo(official_match_idx);
		model.addAttribute("photo", photoList);
		OfficialDTO info = officialDAO.info(official_match_idx);
		model.addAttribute("info", info);
		OfficialDTO address = officialDAO.addressInfo(official_match_idx);
		model.addAttribute("address", address);
	}

	public Map<String, Object> compare(String id, int idx) {
		Map<String, Object> result = new HashMap<String, Object>();
		logger.info(String.valueOf(idx));
		List<String> nikList = officialDAO.officialApli(idx);
		logger.info("nikList : {}", nikList);
		int pay = officialDAO.compare(id);
		logger.info("pay : {}", pay);
		result.put("id", id);
		result.put("pay", pay);
		result.put("list", nikList);
		
		return result;
	}

	public Map<String, Object> use(String idx, String id, int fee) {
		officialDAO.addPointList(idx, id, fee);
		int row = officialDAO.payMinus(id, fee);
		int row2 = officialDAO.insertNotice(idx, id);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("row", row);
		result.put("row2", row2);
		
		return result;
	}

	
}





















