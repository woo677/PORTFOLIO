<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>게스트 작성글 상세페이지</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<link rel="stylesheet" href="../resources/css/common/reset.css">
<link rel="stylesheet" href="../resources/css/header/header.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css"/>

<script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
<style>
.guest_Detail{width:1280px;margin:0 auto;}

.guest_Detail .courtSlide h1{margin-bottom:20px;font-size:40px;font-weight:600;}

/* infoContainer - left */
.guest_Detail .infoContainer{display:flex;justify-content:space-between;}
.guest_Detail .infoContainer .leftContainer{width:65%;}
.guest_Detail .infoContainer .leftContainer .leftCont{padding:30px;background:rgb(212, 208, 208);border-radius:10px;}
.guest_Detail .infoContainer .leftContainer .leftCont.cont01{margin-bottom:20px;font-size:25px;}
.guest_Detail .infoContainer .leftContainer .leftCont.cont01 li{position:relative;padding-left:30px;}
.guest_Detail .infoContainer .leftContainer .leftCont.cont01 li:not(:last-child){margin-bottom:30px;}
.guest_Detail .infoContainer .leftContainer .leftCont.cont01 li:before{content:"";position:absolute;top:5px;left:0;width:20px;height:20px;background:#000;border-radius:100%;}
.guest_Detail .infoContainer .leftContainer .leftCont.cont01 .dateCont{}
.guest_Detail .infoContainer .leftContainer .leftCont.cont01 .dateCont .date1{margin-right:20px;}
.guest_Detail .infoContainer .leftContainer .leftCont.cont01 .dateCont .date2{}
.guest_Detail .infoContainer .leftContainer .leftCont.cont01 .levelcont{}
.guest_Detail .infoContainer .leftContainer .leftCont.cont01 .levelcont .level{}
.guest_Detail .infoContainer .leftContainer .leftCont.cont01 .recruitmentCont{}
.guest_Detail .infoContainer .leftContainer .leftCont.cont01 .recruitmentCont .present{color:green;}
.guest_Detail .infoContainer .leftContainer .leftCont.cont01 .recruitmentCont .Recruitment{margin-right:20px;}
.guest_Detail .infoContainer .leftContainer .leftCont.cont01 .recruitmentCont .state{padding:10px 20px;background:darkcyan;border-radius:15px;}
.guest_Detail .infoContainer .leftContainer .leftCont.cont01 .recruitmentCont .state.finish{background:firebrick;}

.guest_Detail .infoContainer .leftContainer .leftCont.cont02{margin-bottom:20px;font-size:20px;line-height:1.3;}
.guest_Detail .infoContainer .leftContainer .leftCont.cont02 .infoCont{}
.guest_Detail .infoContainer .leftContainer .leftCont.cont02 .infoCont #guest_info{background-color:rgb(212, 208, 208);}
.guest_Detail .infoContainer .leftContainer .mapCont{width:500px;padding:30px;border:1px solid #000;}
.guest_Detail .infoContainer .leftContainer .mapCont h1{margin-bottom:20px;font-size:30px;}
.guest_Detail .infoContainer .leftContainer .mapCont a{display:block;margin-bottom:20px;font-size:23px;}
.guest_Detail .infoContainer .leftContainer .mapCont #map{width:400px;height:400px;}

/* infoContainer - right */
.guest_Detail .infoContainer .rightCont{width:33%;}
.guest_Detail .infoContainer .rightCont .click{padding:30px;background:rgb(212, 208, 208);border-radius:10px; cursor:pointer;}
.guest_Detail .infoContainer .rightCont .click .applyButton{padding:20px;background:blue;border-radius:10px; color: white;}
.guest_Detail .infoContainer .rightCont .click .reportButton{padding:20px;background:red;border-radius:10px; color: white;}


.swiper-container {
	 	width: 50%;
	 	height: 50%; 
	 }
	.swiper-slide {
	 	font-size: 18px;
	 	background: #fff;	
	 }
	.swiper-pagination-bullet {
		 width: 12px;
		 height: 12px; 
		 border: 1px solid pink; 
		 opacity: 1; 
	}
	.swiper-pagination-bullet-active { 
		width: 40px; 
		transition: width .5s; 
		border-radius: 5px; 
		background: pink; 
		border: 1px solid; 
	}
	.swiper-container {
        overflow: hidden; /* 테이블 셀에서 넘치는 부분을 잘라냄 */
        position: relative; /* 상대적인 위치 설정 */
    }
    .swiper-button-prev, .swiper-button-next, .swiper-pagination {
        position: absolute; /* 절대적인 위치 설정 */
        z-index: 1; /* 다른 요소 위로 배치 */
    }
    
    #court_address {
    	cursor: pointer;
    }
</style>
</head>
<body>
	<jsp:include page="../header/header.jsp"/>
    <div class="guest_Detail">
        <div class="courtSlide">
            <h1 id="court_name"></h1>
            <div class="swiper-container">
		  <!-- Additional required wrapper -->
		  	<div class="swiper-wrapper" id="swiperImage">
		    
		  	</div>
		  
		  	<!-- 페이징 필요시 추가 -->
		  	<div class="swiper-pagination"></div>
		  <!-- 이전, 다음 버튼 필요시 추가 -->
		  	<div class="swiper-button-prev"></div>
		  	<div class="swiper-button-next"></div>
			
		</div> 
        </div>
        <div class="infoContainer">
            <div class="leftContainer">
                <ul class="leftCont cont01">
                	<li class="teamName">
                		팀명 : 
                        <span class="name" id="team_name"></span>
                    </li>
                    <li class="dateCont">
                    	경기 날짜 : 
                        <span class="date1" id="bookingDate"></span>
                    </li>
                    <li class="positionCont">
                    	모집 포지션 : 
                        <span class="position" id="guest_position"></span>
                    </li>
                    <li class="levelcont">
                    	모집 레벨 : 
                        <span class="level" id="guest_level"></span>
                    </li>
                    <li class="genderCont">
                    	모집 성별 : 
                        <span class="gender" id="guest_gender"></span>
                    </li>
                    <li class="feeCont">
                    	참가비 : 
                        <span class="fee" id="guest_fee"></span>
                    </li>
                    <li class="toCont">
                    	모집 인원 : 
                        <span class="to" id="guest_to"></span>
                    </li>
                </ul>
                <ul class="leftCont cont02">
                    <li class="infoCont">
                        <textarea id="guest_info" style="resize: none;" disabled></textarea>
                    </li>
                </ul>
                <div class="mapCont">
                    <span id="court_address"></span>
                    <div id="map"></div>
                </div>
            </div>
			<div class="rightCont">
				<div class="click">
					<a class="applyButton">신청하기</a>
					<a class="reportButton">신고하기</a>
				</div>
			</div>
        </div>
    </div>
</body>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1e1e062b2f95c080d4f533905cd08eba&libraries=services"></script>
<script>
	$('.menu').css('display','none');
	var guest_idx = ${guest_idx}+'';
	console.log(guest_idx);
	
	$('.applyButton').on('click',function(){
	    var confirmation = confirm("정말로 신청하시겠습니까?");
	    // 확인을 선택한 경우
	    if (confirmation) {
	    	$.ajax({
				type:'post'
				,url:'./guestJoin.ajax'
				,datatype:'json'
				,data:{"guest_idx":guest_idx}
				,success:function(data){
					console.log(data);
					if(data.result){
						alert('참가신청 성공했습니다.');
				        window.location.href = './list.go';
					}else{
						alert('참가신청 실패했습니다.');
					}
				}
				,error:function(error){
					console.log(error);
				}
			});
	    } else {
	        // 취소한 경우, 아무런 작업도 수행하지 않음
	    }
	});
	
	$('.reportButton').on('click',function(){
		window.location.href = '../mypage/report.go?reportWriteIdx='+guest_idx+'&reportWirteType="게스트모집글신고"';
	});	
	
	var msg = '${msg}';
	if(msg != ''){
		alert(msg);
	}
	
	$(document).ready(function() {
	    // 주소를 클릭할 때 이벤트 핸들러 추가
	    $('#court_address').click(function() {
	        // 클립보드에 복사할 주소 텍스트 가져오기
	        var addressText = $(this).text();

	        // 텍스트를 클립보드에 복사하기
	        navigator.clipboard.writeText(addressText)
	            .then(function() {
	                console.log('주소가 클립보드에 복사되었습니다.');
	                alert('주소가 클립보드에 복사되었습니다.');
	                // 복사가 성공한 경우 추가적인 알림이나 작업을 할 수 있습니다.
	            })
	            .catch(function(err) {
	                console.error('주소 복사 중 오류가 발생했습니다.', err);
	                // 복사 오류 메시지를 출력하거나 추가 작업을 수행할 수 있습니다.
	            });
	    });
	});
	
	$(document).ready(function(){
		$.ajax({
			type:'POST'
			, url : './info.ajax'
			, data:{
				"guest_idx":guest_idx
			}
			, dataType:'json'
			, success:function(data){
				console.log(data);
				$('#court_name').html(data.detail.court_name);
				console.log(data.detail.court_name);
				$('#team_name').html(data.detail.team_name);
				$('#bookingDate').html(data.detail.bookingDate);
				$('#guest_position').html(data.detail.guest_position);
				$('#guest_level').html(data.detail.guest_level);
				$('#guest_gender').html(data.detail.guest_gender);
				$('#guest_fee').html(data.detail.guest_fee);
				$('#guest_to').html(data.detail.guest_to);
				$('#guest_info').html(data.detail.guest_info);
				$('#court_address').html(data.detail.court_address);
				var content = '';
				if(data.fileName.length > 0){
					console.log(data.fileName);
					for(item of data.fileName){
						content += '<div class="swiper-slide"><img src="/court/'+ item +'.png" alt="Image"></div>';
					}
				}else{
					content += '<div class="swiper-slide"><img src="/court/no_image.png" alt="Image"></div>';
				}
				$('#swiperImage').html(content);
				
				// slide
			    var swiper = new Swiper('.swiper-container', {
                    
                    slidesPerView : 'auto',
                    autoplay: {
                    	delay:5000
                    },
                    loop:true,
                    spaceBetween : 10, 
                    pagination: {
                        el: '.swiper-pagination',
                        clickable: true,
                      },
                    navigation: {
                    	nextEl: '.swiper-button-next',
                        prevEl: '.swiper-button-prev',
                   	},
                })
				
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
				var court_address = $('#court_address').html();
				console.log(court_address);
				// 주소로 좌표를 검색합니다
				geocoder.addressSearch(court_address, function(result, status) {
					
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
				            content: '<div style="width:150px;text-align:center;padding:6px 0;">' + $('#court_address').html() + '</div>'
				        });
				        infowindow.open(map, marker);
				
				        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				        map.setCenter(coords);
				    } 
				});
			}
			, error: function(error){
				console.log(error);
			}
			
		});
	});
	
	
	
   

	
</script>
</html>



























