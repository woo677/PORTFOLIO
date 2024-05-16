<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<link rel="stylesheet" href="../resources/css/common/reset.css">
<link rel="stylesheet" href="../resources/css/header/header.css">
<link rel="stylesheet" href="../resources/css/official/official.css">
<style>

</style>
</head>
<body>
	<jsp:include page="../header/header.jsp"/>
    <div class="officialDetail">
        <div class="courtSlide">
            <h1>${address.court_name}</h1>
            <div class="swiper mySwiper">
                <div class="swiper-wrapper">
					<c:forEach items="${photo}" var="list">
						<div class="swiper-slide"><img src="/court/${list.file_name}.png"></div>
					</c:forEach>
                </div>
                <div class="swiper-button-next"></div>
                <div class="swiper-button-prev"></div>
                <div class="swiper-pagination"></div>
            </div>
        </div>
        <div class="infoContainer">
            <div class="leftContainer">
                <ul class="leftCont cont01">
                    <li class="dateCont">
                        <span class="date1">${info.official_match_date}</span>
                        <span class="date2">${info.official_match_start_time} ~ ${info.official_match_end_time}</span>
                    </li>
                    <li class="levelcont">
                        <span class="level">${info.official_match_level}</span>
                    </li>
                    <li class="recruitmentCont">
                        <span class="present">${info.currentCount}</span> / 
                        <span class="Recruitment">${info.official_match_to}</span>
                        <span class="state">모집중</span>
                    </li>
                </ul>
                <ul class="leftCont cont02">
                    <li class="infoCont">
                        ${info.official_match_info}
                    </li>
                </ul>
                <div class="mapCont">
                    <h1>구장 주소</h1>
                    <a href="https://map.kakao.com/link/search/${address.court_address}">${address.court_address}</a>
                    <div id="map"></div>
                </div>
            </div>
            <div class="rightCont">
                <div class="peeCont">
                    <p class="tit">참가 신청 금액</p>
                    <p class="txt">
                        <span class="pee">${info.official_match_fee}</span>
                        <a href="javascript:;" class="recoBtn" onclick="payment(${info.official_match_fee})">신청하기</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=86ee56828a1df32070d00203e39aa157&libraries=services"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=86ee56828a1df32070d00203e39aa157"></script>
<script>

	//퍼블 영역
	$(function(){
		// 상세보기에서 헤더 변경
	    $('.menu').css('display','none');
		
	    // slide
	    var swiper = new Swiper(".mySwiper", {
	        spaceBetween: 30,
	        centeredSlides: true,
	        // autoplay: {
	        //     delay: 2500,
	        //     disableOnInteraction: false,
	        // },
	        autoplay: false,
	        pagination: {
	            el: ".swiper-pagination",
	            clickable: true,
	        },
	        navigation: {
	            nextEl: ".swiper-button-next",
	            prevEl: ".swiper-button-prev",
	        },
	    });
	    
	});
	
	// 개발 영역
	$(document).ready(function(){
		recruitmentChk();
	});
	
	var msg = '${msg}';
	if(msg != ''){
		alert(msg);
	}
	
	var apliChk = true;
	
	// 포인트 신청하기
	function payment(fee) {
		
		$.ajax({
			type:'POST'
			,url:'./payment.ajax'
			,data:{
				'fee':fee
				,'idx':${info.official_match_idx}
			}
			,dataType:'json'
			,success:function(data){
				var cf;
				for(item of data.list){
					if(item == data.id){
						alert('이미 신청한 이력이 있습니다.');
						apliChk = false;
						break;
					}
				}
				if(apliChk){
					if(data.pay < fee){
						cf = confirm("포인트가 부족합니다. 충전페이지로 이동할까요?");
						if(cf){
							location.href = '../mypage/point_add.go';
						}
					}else{
						cf = confirm("예약하시겠습니까?");
						if(cf){
							if(${info.currentCount} == ${info.official_match_to}){
								alert('인원 모집이 완료되었습니다.');
							}else{
								use(fee, ${info.official_match_idx});
								alert('예약 완료되었습니다.');
								location.href = '../official';
							}
						}
					}
				}
			}
			,error:function(error){
				console.log(error);
			}
		});
	}
	
	function use(fee, idx){
		$.ajax({
			type:'POST'
			,url:'./use.ajax'
			,data:{
				'fee':fee
				,'idx':idx
			}
			,dataType:'json'
			,success:function(data){
				console.log(data.row);
				console.log(data.row2);
				
			}
			,error:function(error){
				console.log(error);
			}
		});
	}
	
	function recruitmentChk(){
		var Recruitment = $('.Recruitment').html();
		var present = $('.present').html();
		if(Recruitment == present){
			$('.state').html('모집완료');
			$('.state').addClass('finish');
		}
	}
	
    // 지도 api
   	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch('${address.court_address}', function(result, status) {
		
	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {
	
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords
	        });
	
	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        var infowindow = new kakao.maps.InfoWindow({
	            content: '<div style="width:150px;text-align:center;padding:6px 0;">' + '${address.court_name}' + '</div>'
	        });
	        infowindow.open(map, marker);
	
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	});

	
</script>
</html>



























