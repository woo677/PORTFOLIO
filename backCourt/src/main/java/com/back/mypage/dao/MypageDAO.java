package com.back.mypage.dao;

import java.util.List;
import java.util.Map;

import com.back.mypage.dto.MypageDTO;
import com.back.official.dto.OfficialDTO;

public interface MypageDAO {
	
// =========== 내 포인트 리스트 =============
	
	String report(String id);

	//내 지갑 보기
	String my_allpoint_ajax(String loginId);

	void Charging_do(String loginId, String charging);

	void PointMinus(String loginId, int min);

	String point(String loginId);
	
	List<MypageDTO> point_list_ajax(String loginId, int currPage, int start);

	Object point_allConut(int pageParCnt, String loginId);
	
	void point_plus_update(String loginId);
	
	void point_minus_update(String loginId);
	
// ============================================

	int report(Map<String, Object> map);

	List<MypageDTO> jjimList(String id, int start);

	int jjimListCount(String id);

	int jjimDel(int jjimidx);

	
	
// ========== 신청/예약 리스트 ====================
	
	
	List<OfficialDTO> official_match_list_ajax(String loginId, int pageParnum, int startPage);

	Object official_match_allConut(int pageParnum, String loginId);

	List<MypageDTO> guest_match_list_ajax(String loginId, int pageParnum, int startPage);

	Object guest_match_allConu(int pageParnum, String loginId);

	List<MypageDTO> court_match_list_ajax(String loginId, int pageParnum, int startPage);

	Object court_match_allConu(int pageParnum, String loginId);

	// 취소시 포인트 환급
	void official_Cancellation(String loginId, String idx);
	
	int match_ask_list_del(String loginId,String idx);
	

	int guset_match_list_del(String loginId, String idx);
	
//	취소 시 리스트에 취소라고 쓰기
	void court_Cancellation(String loginId, String idx);

	int court_match_list_del(String loginId, String idx);


	
//	===================== 신고 리스트 / 수정 ==================================

	

	MypageDTO report_detail(String loginId, String idx);

	int report_modify(Map<String, String> param);

	//신고/문의 리스트
	List<MypageDTO> report_list(String loginId, int state, int pageSome);

	//총 페이지 자동 계산
	Object totalPages(int pageSome, String loginId);

	//신고글 삭제
	void report_del_ajax(String loginId, String idx);


	MypageDTO mprofile_detail(String loginId);

	MypageDTO profile_detail_ajax(String loginId);

	void profile_detail_do(Map<String, String> param);






}
