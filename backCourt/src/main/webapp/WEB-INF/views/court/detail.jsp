<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>제목 입력</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<link rel="stylesheet" href="../resources/css/common/reset.css">
<link rel="stylesheet" href="../resources/css/header/header.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css"/>

<script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>

<style>
    .courtDetailTable,.courtDetailTh,.courtDetailTd {
        border: 1px solid black;
        border-collapse: collapse;
    }
    .courtDetailTh,.courtDetailTd {
        padding: 5px 10px;
    }
    #courtDetailInfo {
        resize: none;
        width: 500px;
        height: 150px;
    }
    #datepicker {
        margin-bottom: 20px;
    }
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
    .courtDetailTimeBtn{
   		background-color : skyblue;
   	}
</style>
</head>
<body>
<jsp:include page="../header/header.jsp"/>
<table class="courtDetailTable">
    <tr>
        <th class="courtDetailTh">구장 이름</th>
        <td class="courtDetailTd"><span id="courtDetailName"></span></td>
    </tr>
    <tr>
        <th class="courtDetailTh">구장 사진</th>
        <td class="courtDetailTd">
		<!-- Slider main container -->
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
    </tr>
    <tr>
        <th class="courtDetailTh">구장 예약 시간</th>
        <td class="courtDetailTd">
			<input id="courtDetailDate" type="text" readonly/>
            <br/>
            <input class="courtDetailTimeBtn" id="0" type="button" value="00~02">
            <input class="courtDetailTimeBtn" id="2" type="button" value="02~04">
            <input class="courtDetailTimeBtn" id="4" type="button" value="04~06">
            <input class="courtDetailTimeBtn" id="6" type="button" value="06~08">
            <input class="courtDetailTimeBtn" id="8" type="button" value="08~10">
            <input class="courtDetailTimeBtn" id="10" type="button" value="10~12">
            <input class="courtDetailTimeBtn" id="12" type="button" value="12~14">
            <input class="courtDetailTimeBtn" id="14" type="button" value="14~16">
            <input class="courtDetailTimeBtn" id="16" type="button" value="16~18">
            <input class="courtDetailTimeBtn" id="18" type="button" value="18~20">
            <input class="courtDetailTimeBtn" id="20" type="button" value="20~22">
            <input class="courtDetailTimeBtn" id="22" type="button" value="22~24">
        </td>
    </tr>
    <tr>
        <th class="courtDetailTh">구장 정보</th>
        <td class="courtDetailTd"><textarea id="courtDetailInfo" readonly></textarea></td>
    </tr>
    <tr>
        <th class="courtDetailTh">구장 가격</th>
        <td class="courtDetailTd"><span id="courtDetailPrice"></span><input id="courtDetailBooking" type="button" value="예약"/></td>
    </tr>
    <tr>
        <th class="courtDetailTh">구장 위치</th>
        <td class="courtDetailTd">
            <span id="courtDetailAddress"></span><input type="button" value="복사" />
            <div id="map" style="width:100%;height:350px;"></div>
        </td>
    </tr>
</table>
<input id="courtDetailReport" type="button" value="문의하기"/>
<div id="courtListPopup">

</div>
</body>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c9f77d7846342440699b7b6723322c23&libraries=services"></script>
<script>
    var courtIdx = '${courtIdx}';
    var courtDetailTime = '';
    var currentDate = new Date();
    var formattedDate = currentDate.getFullYear() + "-" + (currentDate.getMonth() + 1).toString().padStart(2, '0') + "-" + currentDate.getDate().toString().padStart(2, '0');
    $('#courtDetailDate').val(formattedDate);
    var selectDate = $('#courtDetailDate').val();

    var selectedId = '';



	$('input[value="복사"]').on('click', function(){
		var text = $('#courtDetailAddress').text()
		console.log(text);
		navigator.clipboard.writeText(text).then(function() {
	        alert("주소가 클립보드에 복사되었습니다.");
	    }, function(error) {
	        console.error("클립보드 복사 오류:", error);
	    });
	});

	
    $('#courtDetailReport').on('click',function(){
    	window.location.href = '../mypage/report.go?reportWriteIdx='+courtIdx+'&reportWirteType="구장문의"';
    });
    $('.menu').css('display','none');
    $('.courtDetailTimeBtn:not([disabled])').click(function() {
    	selectedId = $(this).attr('id');
        // 모든 버튼의 배경색을 하늘색으로 초기화
        $('.courtDetailTimeBtn:not([disabled])').not(this).css('background-color', 'skyblue');

        // 클릭된 버튼의 배경색을 검정색으로 변경
        $(this).css('background-color', 'black');
        courtDetailTime = $(this).attr('id');
       	// console.log(courtDetailTime);
    });
    $('#courtDetailBooking').on('click',function(){

        if (courtDetailTime == '') {
            alert('예약할 시간을 선택하세요.');
        } else {
           if(confirm('정말로 예약 하시겠습니까?')){
				$.ajax({
					type:'post'
					, url:'./booking.ajax'
					, data:{
						'courtStartTime':selectedId
						,'courtIdx':courtIdx
						,'courtPrice':$('#courtDetailPrice').html()
						,'courtDate':selectDate
					}
					, dataType:'json'
					, success:function(data){
						console.log(data.money);
                        console.log('------');
                        console.log(data.result);
						if(data.money == false){
							if(confirm('포인트가 부족합니다. 충전하시겠습니까?')){
								window.location.href = '../mypage/point_add.go';
							}
						}else if(data.result == false){
							alert('예약에 실패했습니다.');
						}else{
							alert('예약이 완료 되었습니다.');
							window.location.href = './list.go';
						}
					}
					, error:function(){}
				});
           }
        }
    });
    
    $('#courtDetailDate').change(function() {
        selectDate = $(this).val();
        $('.courtDetailTimeBtn').css('background-color', 'skyblue');
        
    	$('.courtDetailTimeBtn').each(function() {
    		$(this).prop('disabled', false);
        });        
        callDetail();
    });
    $(document).ready(function() {
        // courtDetailDate input 요소에 datepicker 연결
        $('#courtDetailDate').datepicker({
            format: 'yyyy-mm-dd', // 날짜 형식 설정
            autoclose: true, // 날짜 선택 후 자동으로 닫힘
            todayHighlight: true, // 오늘 날짜 강조 표시
            startDate: 'today', // 오늘 이후의 날짜만 선택 가능
        }).on('click', function(){
            $(this).datepicker('show');
        });
        callDetail();
        

    });

   
   
    function callDetail(){
        $.ajax({
            type:'post'
            , url:'./detail.ajax'
            , data:{
                "courtIdx":courtIdx
                ,"selectDate":$('#courtDetailDate').val()
            }
            , dataType:'json'
            , success:function(data){
                disabledButton();
                console.log(data);
                $('#courtDetailName').html(data.detail[0].courtName);
                $('#courtDetailInfo').val(data.detail[0].courtInfo);
                $('#courtDetailPrice').html(data.detail[0].courtPrice);
                $('#courtDetailAddress').html(data.detail[0].courtAddress);
                var content = '';
                if(data.fileName.length > 0 ){
	                for(item of data.fileName){
	                	content += '<div class="swiper-slide"><img src="/court/'+item+'.png" alt="Image"></div>';
	                }
                	
                }else{
                	content += '<div class="swiper-slide"><img src="../resources/img/court/no_image.png" alt="Image"></div>';
                }

                $('#swiperImage').html(content);
                if(data.bookingStartTime.length > 0){
                	for(item of data.bookingStartTime){
			            $('.courtDetailTimeBtn').each(function() {
			                if($(this).attr('id') == item){
			                    $(this).prop('disabled', true);
			                    $(this).css('background-color','gray');
			                }
			            });
                	}
                }

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

                ///////////////////////////////////////////////////////////////////////
                
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
                var courtAddress = $('#courtDetailAddress').html();
                console.log(courtAddress);
                // 주소로 좌표를 검색합니다
                geocoder.addressSearch(courtAddress, function(result, status) {
                    
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
                            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+$('#courtDetailName').html()+'</div>'
                        });
                        infowindow.open(map, marker);
                
                        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                        map.setCenter(coords);
                    } 
                });

                
                ///////////////////////////////////////////////////////////////////////
                

            }
            , error:function(error){

            }
        });
    }

    function disabledButton(){
        var nowHours = currentDate.getHours();
        var nowDate = currentDate.getFullYear() + "-" + (currentDate.getMonth() + 1).toString().padStart(2, '0') + "-" + currentDate.getDate().toString().padStart(2, '0');
    	console.log(nowDate);
        if($('#courtDetailDate').val() == nowDate){
	        if(nowHours > 0){
	            $('.courtDetailTimeBtn').each(function() {
	                if($(this).attr('id') <= nowHours){
	                    $(this).prop('disabled', true);
	                    $(this).css('background-color','gray');
	                }
	            });
	        }
        }
    }
    
</script>
</html>
