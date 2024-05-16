package com.back.header.dao;

import java.util.List;

import com.back.header.dto.HeaderDTO;
import com.back.member.dto.MemberDTO;

public interface HeaderDAO {

	List<HeaderDTO> teamList(String id);

	List<HeaderDTO> noticeList(String id);

	int del(String idx);

	HeaderDTO count(String id);

	MemberDTO nav(String id);

}
