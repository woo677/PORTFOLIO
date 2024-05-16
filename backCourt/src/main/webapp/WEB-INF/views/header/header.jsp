<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 블라인드 -->
<div class="curtain"></div>
<!-- header -->
<header class="header">
    <div class="inner">
        <!-- header 상단 -->
        <div class="top">
            <h1><a href="../official"><img src="../resources/img/icon/logo.png" alt=""></a></h1>
            <ul class="icoCont">
                <!-- 팀 정보 -->
                <li>
                    <a href="javascript:;" id="teamInfo" onclick="sessionChk()">
                        <span class="icon"><img src="../resources/img/icon/teamInfo_ico2.jpg" alt=""></span>
                        <span class="txt">팀정보</span>
                    </a>
                </li>
                <!-- 알림 -->
                <li>
                    <a href="javascript:;" id="notice" onclick="sessionChk()">
                        <span class="icon"><img src="../resources/img/icon/notice_ico.jpg" alt=""></span>
                        <span class="txt">알림</span>
                        <span class="num" id="noticeNum"></span>
                    </a>
                    <!-- 알림창 -->
                    <div class="noticeBox">
                        <a href="#" class="close"><img src="../resources/img/icon/close.png" alt=""></a>
                        <h2>알림</h2>
                        <ul id="noticeCont">
<!--                                 <li class="cont">
                                    <p class="date">2020.10.10</p>
                                    <p class="content">내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용</p>
                                    <button class="btn">확인</button>
                                </li> -->
                        </ul>
                    </div>
                </li>
                <!-- 마이페이지 -->
                <li>
                    <a href="javascript:;" id="myPage" onclick="sessionChk()">
                        <span class="icon"><img src="../resources/img/icon/mypage_ico.jpg" alt=""></span>
                        <span class="txt">내정보</span>
                    </a>
                </li>
            </ul>
        </div>
        
        <!-- header 하단 -->
        <ul class="menu on">
            <li><a href="../official">공식 경기</a></li>
            <li><a href="../teammate">팀 서비스</a></li>
            <li><a href="../court/list.go">구장 대여</a></li>
        </ul>
        
		 <!-- 팀서비스 2depth -->
		 <div class="teamDepth2">
		     <a href="../teammate" class="teamJoin">팀원모집</a>
		     <a href="../guest_join/list.go" class="guestJoin">게스트 모집</a>
		 </div>
         
    </div>
</header>

<!-- 내정보 nav -->
<div class="nav">
    <a href="#" class="close"><img src="../resources/img/icon/close.png" alt=""></a>
    <ul id="drawNav">
<%--         <li class="topCont">
            <div class="profile">
                <p class="nik"><a href="#" onclick="location.href='../mypage/profile_detail?id=${member.id}'">${member.id}</a></p>
                <span class="photo"><img src="../resources/img/icon/img01.jpg" alt=""></span>
            </div>
            <div class="point">
                <p>포인트<span><a href="#" onclick="location.href='../mypage/point?id=${member.id}'">${member.point}</a></span></p>
                <a href="../logout.do">로그아웃</button>
            </div>
        </li>
        <li class="cont" onclick="location.href='../mypage/match_ask_list?id=${member.id}'">
            <a href="#">신청 내역</a>
        </li>
        <li class="cont" onclick="location.href='../mypage/report_list?id=${member.id}'">
            <a href="#">신고 내역</a>
        </li>
        <li class="cont" onclick="location.href='../mypage/like?id=${member.id}'">
            <a href="#">찜 목록</a>
        </li> --%>
    </ul>
</div>

<!-- 팀 정보 팝업 -->
<div class="popup teamPop type01">
    <a href="#" class="close"><img src="../resources/img/icon/close.png" alt=""></a>
    <div class="popWrap">
        <a href="../team/create.go" class="btnTeam">팀 만들기</a>
        <h1>내 팀 리스트</h1>
        <div class="listCont">
            <ul id="listCont">
                <!-- <li>
                    <a href="#">
                        <span class="logo"><img src="../resources/img/icon/img01.jpg" alt="로고"></span>
                        <span class="teamNik">팀1</span>
                    </a>
                </li> -->
            </ul>
        </div>
    </div>
</div>

<script>
	var sessionCheck = 'false';
	var noticeCheck = 'on';

	// 프론트
    $(function(){
        // 팀 정보 팝업
        $('#teamInfo').on('click',function(){
        	if(sessionCheck){
            	teamListCall();
        	}
        });
        $('.close').on('click',function(){
            $('.popup').removeClass('on');
            $('.curtain').removeClass('on');
            $('html').removeClass('on');
        });

        // 알림
        $('#notice').on('click',function(){
        	if(sessionCheck){
	            noticeListCall();
        	}
        });
        $('.noticeBox .close').on('click',function(){
            $('.noticeBox').removeClass('on');
        });

        // 마이페이지 nav
        $('#myPage').on('click',function(){
        	if(sessionCheck){
	            $('.nav').stop(true, false).animate({
	                right:'0'
	            });
	            $('.nav').addClass('on');
        	}
        });
        $('.nav .close').on('click',function(){
            $('.nav').stop(true, false).animate({
                right:'-450px'
            });
            $('.nav').removeClass('on');
        });
        
    })
	function numChk(){
		var numChk = $('#noticeNum').html();
		console.log(numChk);
    	if(numChk <= 1){
			$('#noticeNum').removeClass('on');
		}
	}
	
	// 로그인 체크
	function sessionChk(){
		$.ajax({
			type : 'get', 
			url : './session.ajax',
			data : {},
			dataType : 'json',
			success : function(data){ 
				console.log(data.sessionCk);
				if(data.sessionCk == true){
					sessionCheck = 'true';
					drawInfo(data.info);
				}else{
					sessionCheck = 'false';
					loginMsg();
					location.href = '../login';
				}
				
			}, 
			error : function(error){
				console.log(error);
			}, 
		});
	}
	
	function loginMsg(){
		alert('로그인이 필요한 서비스입니다.');
	}
	
	function drawInfo(info){
		var content = '';
		
		content += '<li class="topCont">';
		content += '<div class="profile">';
		content += '<p class="nik"><a href="../mypage/profile_detail.go?id=' + info.id + '">' + info.id + '</a></p>';
		content += '<span class="photo"><img src="../resources/img/icon/propile.jpg" alt=""></span>';
		content += '</div>';
		content += '<div class="point">';
		content += '<p>포인트<span><a href="../mypage/point.go?id=' + info.id + '">' + info.point + '</a></span></p>';
		content += '<a href="../logout.do">로그아웃</button>';
		content += '</div>';
		content += '</li>';
		content += '<li class="cont">';
		content += '<a href="../mypage/match_ask_list.go?id=' + info.id + '">신청 내역</a>';
		content += '</li>';
		content += '<li class="cont">';
		content += '<a href="../mypage/report_list.go?id=' + info.id + '">신고 내역</a>';
		content += '</li>';
		content += '<li class="cont">';
		content += '<a href="../mypage/jjim.go?id=' + info.id + '">찜 목록</a>';
		content += '</li>';
		
		
		$('#drawNav').html(content);
	}
	
	
	$(document).ready(function(){
		noticeListCall(noticeCheck);
	});
    
	// 팀 페이지 ajax
    function teamListCall(){
		$.ajax({
			type : 'get', 
			url : './header/list.ajax',
			data : {},
			dataType : 'json',
			success : function(data){ 
				console.log(data.list);
				if(data.list != ''){
					$('.popup').addClass('on');
		            $('.curtain').addClass('on');
		            $('html').addClass('on');
					drawTeamList(data.list);
				}else if(data.list == ''){
					$('.popup').addClass('on');
		            $('.curtain').addClass('on');
		            $('html').addClass('on');
		            drawTeamList02();
				}
				
				
			}, 
			error : function(error){
				console.log(error);
			}, 
		});
	}
	
 	// 팀 리스트
	function drawTeamList(list){
		var content = '';
		
		for(item of list){
			content += '<li>';
			content += '<a href="../team/info_list.go?team_idx=' + item.team_idx + '">';
			content += '<span class="logo"><img src="/logo/' + item.logo + '.png" alt="로고"></span>';
			content += '<span class="teamNik">' + item.team_name + '</span>';
			content += '</a>';
			content += '</li>';
		}
		
		$('#listCont').html(content);
	}
	function drawTeamList02(){
		var content = '';
		
		content += '<li class="noTeam">팀이 없습니다.</li>';
		
		$('#listCont').html(content);
	}
	
	// 알림 ajax
    function noticeListCall(on){
		$.ajax({
			type : 'get', 
			url : './notice/list.ajax',
			data : {},
			dataType : 'json',
			success : function(data){ 
				
				drawNoticeList(data.list);
				drawCountList(data.count);
				
				console.log(data.list);
				console.log(data.count);
				
				if(on != 'on'){
					$('.noticeBox').addClass('on');
				}
				
			}, 
			error : function(error){
				console.log(error);
			}, 
		});
	}
	
 	// 알림 리스트
	function drawNoticeList(list){
		var content = '';

		
		for(item of list){
			
			content += '<li class="cont">';
			
			var date = new Date(item.notice_time);
		    var dateStr = date.toLocaleDateString("ko-KR");
			
			content += '<p class="date">' + dateStr + '</p>';
			content += '<p class="content">' + item.notice_content + '</p>';
			content += '<button class="btn" onclick ="del(' + item.notice_idx + '); numChk();">확인</button>';
			content += '</li>';
			
		}
		
		$('#noticeCont').html(content);
	}
	function drawCountList(count){
		var content = '';
	
		content = count.notice_count;
	
		if(count.notice_count > 0){
			$('#noticeNum').addClass('on');
		}
		
		$('#noticeNum').html(content);
	}
 	
	function del(idx){
		
		$.ajax({
			type: 'post',
			url: './notice/delete.ajax',
			data: {'idx' : idx},
			dataType: 'json',
			success: function(data){
				noticeListCall();
			},
			error: function(error){
				console.log(error);
			}
		});
		
	}

</script>























