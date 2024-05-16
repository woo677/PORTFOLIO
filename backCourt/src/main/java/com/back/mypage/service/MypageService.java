package com.back.mypage.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.back.mypage.dao.MypageDAO;
import com.back.mypage.dto.MypageDTO;
import com.back.official.dto.OfficialDTO;

@Service
public class MypageService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired MypageDAO mypageDAO;
	
// ========= 내 포인트 리스트 ===========
	
	public String report(String id) {
		return mypageDAO.report(id);
	}
	
	
	public void Charging_do(String loginId, String charging) {
		mypageDAO.Charging_do(loginId,charging);
	}
	public void PointMinus(String loginId, int min) {
		mypageDAO.PointMinus(loginId,min);
	}
	public String point(String loginId) {
		return mypageDAO.point(loginId);
	}
	
	//아작스로 내 포인트 리스트 출력
	@SuppressWarnings("unlikely-arg-type")
	public Map<String, Object> point_list_ajax(String loginId, int currPage, int pageParCnt) {
	
		int start = (currPage-1)*pageParCnt;
		
		Map<String, Object> result = new HashMap<String, Object>(); //아작스로 데이터를 보내기 위한 작업
		List<MypageDTO> list = mypageDAO.point_list_ajax(loginId,pageParCnt,start); //아이디,n개 보여줘,n번부터
		logger.info("list Size : "+list.size());
		result.put("list", list); //맥에 리스트 라는 이름으로 리스트를 넣는다
		result.put("currPage",currPage); //n번부터
		result.put("siez",list.size()); //리스트 사이즈
		result.put("point",list.indexOf("point")+1);
		result.put("start", start);
		result.put("totalPages", mypageDAO.point_allConut(pageParCnt,loginId)); //총 페이 갯수 계산
		
		logger.info("내 지갑 사정 : "+result.get("point"));
		
		return result;
	}
	
	
	//내 지갑 보기
	public Map<String, Object> my_allpoint_ajax(String loginId) {
		logger.info("내지갑 사정 서비스 접근");
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		String point = mypageDAO.my_allpoint_ajax(loginId);
		result.put("point", point);
		
		logger.info("내 포인트 : "+point);
		
		
		return result;
	}
	
	
	
	public void point_plus_update(String loginId) {
		mypageDAO.point_plus_update(loginId);
		
	}
	
	public void point_minus_update(String loginId) {
		mypageDAO.point_minus_update(loginId);
		
	}
	
	// ================================
	
	public int report(Map<String, Object> map) {
		logger.info("report-service  map={}",map);
		return mypageDAO.report(map);
		
	}

	public Map<String, Object> jjimList(String id, String currentPage) {
		logger.info("mypage/jjimList Service ");
		Map<String, Object> map = new HashMap<String, Object>();

		int start = (Integer.parseInt(currentPage) - 1) * 10;
		
		List<MypageDTO> list = mypageDAO.jjimList(id, start);
		
		int totalPage = mypageDAO.jjimListCount(id);
		
		if (totalPage / 10 == 0) {
			totalPage = 1;
		} else if (totalPage % 10 > 0) {
			totalPage = totalPage / 10 + 1;
		} else {
			totalPage = totalPage / 10;
		}
		
		map.put("totalPage", totalPage);
		map.put("list", list);
		return map;
	}

	public Map<String, Object> jjimDel(List<String> selectedIdxList) {
		int delCount = 0;
		for (String idx : selectedIdxList) {
			int jjimidx = Integer.parseInt(idx);
			logger.info("" + jjimidx);
			delCount += mypageDAO.jjimDel(jjimidx);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("totalDel", delCount);
		return map;

	}
	
// ============= 신청/예약 리스트 ==============
	
	
	public Map<String, Object> match_ask_list_ajax(String loginId, String choice, int currPage, int pageParnum) {
		logger.info("로그인 아이디 : {}",loginId);
		logger.info("선택 버튼 : {}",choice);
		logger.info("n번 부터 : {}",currPage);
		logger.info("n개 :  {} ",pageParnum);
		
		int startPage = (currPage-1)*pageParnum;
		
		Map<String, Object> result = new HashMap<String, Object>();

		//공식 경기를 클릭 하면 반응
		if (choice.equals("공식 경기")) {
			List<OfficialDTO> list = mypageDAO.official_match_list_ajax(loginId,pageParnum,startPage);
			logger.info("list Size : {}",list.size());
			result.put("list", list);
			result.put("Choice",choice);
			result.put("startPage", startPage); //n번 부터
			result.put("siz", list.size()); //리스트 사이즈
			result.put("totalPages",mypageDAO.official_match_allConut(pageParnum,loginId));
		}
		
		//세스트 리스트
		if (choice.equals("게스트")) {
			List<MypageDTO> list = mypageDAO.guest_match_list_ajax(loginId,pageParnum,startPage);
			logger.info("list Size : "+list.size());
			result.put("list", list);
			result.put("Choice",choice);
			result.put("startPage", startPage); //n번 부터
			result.put("siz", list.size()); //리스트 사이즈
			result.put("totalPages", mypageDAO.guest_match_allConu(pageParnum,loginId));
		}
			
		if(choice.equals("구장 예약")) {
			List<MypageDTO> list = mypageDAO.court_match_list_ajax(loginId,pageParnum,startPage);
			logger.info("구장 예약 list size : "+list.size());
			result.put("list", list);
			result.put("Choice",choice);
			result.put("startPage", startPage); //n번 부터
			result.put("siz", list.size()); //리스트 사이즈
			result.put("totalPages",mypageDAO.court_match_allConu(pageParnum,loginId));
		}
		
		logger.info("총 페이지 : {}",result.get("totalPages"));	
		
		return result;
	}
	
	// 취소시 포인트 환급
		public void official_Cancellation(String loginId, String idx) {
			logger.info("official_Cancellation 접근...");
			mypageDAO.official_Cancellation(loginId,idx);
		}
	
	//신청/예약 삭지 아작스
	public Map<String, Object> match_ask_list_del(String loginId,String idx) {
		int row=0;
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		row = mypageDAO.match_ask_list_del(loginId,idx);
		logger.info("삭제 서비스 중.....");
		
		if (row>0) {
			result.put("msg", "삭제 성공");
		}else {
			result.put("msg","삭제 실패");
		}
		
		logger.info("삭제 결과 : "+result.get("msg"));
		
		
		return result;
		
	}
	
	
	
	
	//아작스(게스트 리스트 삭제)
	public Map<String, Object> guset_match_list_del(String loginId, String idx) {
		logger.info("아작스(게스트 리스트 삭제 서비스 처리 중...)");
		
		//삭제 된 로우가 있는지 확인 할때 씀
		int row = 0;
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		row = mypageDAO.guset_match_list_del(loginId,idx);
		
		if (row>0) {
			result.put("msg", "삭제 성공");			
		}else {
			result.put("msg", "삭제 실패");
		}
		logger.info("삭제 성공 여부 : "+result.get("msg"));
		
		return result;
	}
	
	
//	취소 시 리스트에 취소라고 쓰기
	public void court_Cancellation(String loginId, String idx) {
		mypageDAO.court_Cancellation(loginId,idx);
		
	}
	
	//아작스 (구장 리스트 삭제)
	public Map<String, Object> court_match_list_del(String loginId, String idx) {
		logger.info(idx);
		int row =0;
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		row = mypageDAO.court_match_list_del(loginId,idx);
		
		if (row>0) {
			result.put("msg", "삭제 성공");
		}else {
			result.put("msg","삭제 실패");
		}
		
		return result;
	}
	
	
//	===================== 신고 리스트 / 수정 ==================================


	public MypageDTO report_detail(String loginId, String idx) {
		
		return mypageDAO.report_detail(loginId,idx);
	}


	public int report_modify(Map<String, String> param) {
		
		logger.info("param : {}",param);
		
		
		return mypageDAO.report_modify(param);
	}


	//신고 리스트 출력(ajax)
	public Map<String, Object> report_list_ajax(String loginId, int currPage, int pageSome) {
		logger.info("신고 /  문의 리스트 (서비스)");
		
		int state = (currPage-1)*pageSome; //n 번 부터 보여 주기(자동 계산)
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<MypageDTO> list =  mypageDAO.report_list(loginId,state,pageSome);
		result.put("list", list);
		logger.info("list siez : "+list.size());
		result.put("state", state); //카운트를 하기위한 것
		result.put("totalPages", mypageDAO.totalPages(pageSome,loginId)); //총 페이지 수
		
		return result;
	}


	//신고글 삭제
	public void report_del_ajax(String loginId, String idx) {
		mypageDAO.report_del_ajax(loginId,idx);
		
	}
	
	//회원 수정
		public MypageDTO profile_detail(String loginId) {
			
			return mypageDAO.mprofile_detail(loginId);
		}


		public MypageDTO profile_detail_ajax(String loginId) {
			return mypageDAO.profile_detail_ajax(loginId);
		}


		public void profile_detail_do(Map<String, String> param) {
		
			logger.info("param : {}",param);
			
			mypageDAO.profile_detail_do(param);
			
			
		}








	
	


}
