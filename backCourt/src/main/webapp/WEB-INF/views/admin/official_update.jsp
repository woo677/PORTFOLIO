<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>제목 입력</title>
<link rel="stylesheet" href="../resources/css/common/reset.css">
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script src="../resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<link rel="stylesheet" href="../resources/css/common/reset.css">
<link rel="stylesheet" href="../resources/css/header/header.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<style>
	.officialUpdateTable, .officialUpdateTh, .officialUpdateTd {
		border: 1px solid black;
		border-collapse: collapse;
	}
	
	.officialUpdateTh, .officialUpdateTd {
		padding: 5px 10px;
	}

	#datepicker {
		margin-bottom: 20px;
	}
	
	#officialUpdateInfo {
		resize: none;
		width: 500px;
		height: 150px;
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

	.OfficialUpdateTimeBtn{
		background-color : skyblue;
	}
.black_overlay{
	display: none;
	position: absolute;
	top: 0%;
	left: 0%;
	width: 100%;
	height: 100%;
	background-color: black;
	z-index:1001;
	-moz-opacity: 0.8;
	opacity:.80;
	filter: alpha(opacity=80);
}

.white_content {
	display: none;
	position: absolute;
	top: 25%;
	left: 25%;
	width: 50%;
	height: 50%;
	padding: 16px;
	border: 1px solid black;
	background-color: white;
	z-index:1002;
	overflow: auto;
}
	.officialCourtTable{
			width: 100%;
	}
	.officialCourtTable, .officialCourtTh, .officialCourtTd {

		border: 1px solid black;
		border-collapse: collapse;
	}
	
	.officialCourtTh, .officialCourtTd {
		padding: 5px 10px;
	}
</style>
</head>
<body>
<div class="adminBody">
	<jsp:include page="../header/header_admin.jsp"/>
	<div class="adminContainer">
		<h1>공식경기 수정</h1>
		<table class="officialUpdateTable">
			<tr>
				<th class="officialUpdateTh">공식 경기 이름</th>
				<td class="officialUpdateTd">
					<input type="text" id="officialUpdateName" disabled/>
				</td>
			</tr>
			<tr>
				<th class="officialUpdateTh">공식 경기 사진</th>
				<td class="officialUpdateTd">
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
					<a id="officialCourtList" >구장 찾기</a>
				</td>
			</tr>
			<tr>
				<th class="officialUpdateTh">공식 경기 가격</th>
				<td class="officialUpdateTd">
					<input type="text" id="officialUpdatePrice" value="${officialInfo.officialPrice}" />
				</td>
			</tr>
			<tr>
				<th class="officialUpdateTh">공식 경기 날짜</th>
				<td class="officialUpdateTd">
					<input id="officialUpdateDate" type="text" value="${officialInfo.officialDate}"/>
					<br/>
					<input class="officialUpdateTimeBtn" id="0" type="button" value="00~02">
					<input class="officialUpdateTimeBtn" id="2" type="button" value="02~04">
					<input class="officialUpdateTimeBtn" id="4" type="button" value="04~06">
					<input class="officialUpdateTimeBtn" id="6" type="button" value="06~08">
					<input class="officialUpdateTimeBtn" id="8" type="button" value="08~10">
					<input class="officialUpdateTimeBtn" id="10" type="button" value="10~12">
					<input class="officialUpdateTimeBtn" id="12" type="button" value="12~14">
					<input class="officialUpdateTimeBtn" id="14" type="button" value="14~16">
					<input class="officialUpdateTimeBtn" id="16" type="button" value="16~18">
					<input class="officialUpdateTimeBtn" id="18" type="button" value="18~20">
					<input class="officialUpdateTimeBtn" id="20" type="button" value="20~22">
					<input class="officialUpdateTimeBtn" id="22" type="button" value="22~24">
				</td>
			</tr>
			<tr>
				<th class="officialUpdateTh">공식 경기 레벨</th>
				<td class="officialUpdateTd">
					<select id="officialUpdateLevel" >
						<option value="">레벨을 선택해 주세요</option>
						<option value="브론즈">브론즈</option>
						<option value="실버">실버</option>
						<option value="골드">골드</option>
						<option value="플래티넘">플래티넘</option>
					</select>
				</td>
			</tr>
			<tr>
				<th class="officialUpdateTh">공식 경기 성별</th>
				<td class="officialUpdateTd">
					<select id="officialUpdateGender">
						<option value="">성별을 선택해 주세요</option>
						<option value="남자">남자</option>
						<option value="여자">여자</option>
					</select>
				</td>
			</tr>
			<tr>
				<th class="officialUpdateTh">공식 경기 모집인원</th>
				<td class="officialUpdateTd">
					<input type="number" id="officialUpdateTo" value="${officialInfo.officialTO}"/>
				</td>
			</tr>
			<tr>
				<th class="officialUpdateTh">공식 경기 정보</th>
				<td class="officialUpdateTd">
					<textarea id="officialUpdateInfo" maxlength="300">${officialInfo.officialInfo}</textarea>
				</td>
			</tr>
			<tr>
				<th class="officialUpdateTh">공식 경기 위치</th>
				<td class="officialUpdateTd">
					<input type="text" id="officialUpdateAddress" maxlength="300" disabled/>
				</td>
			</tr>
		</table>
		<br/> 
		<input type="checkbox" name="" id="officialIsDisabled"> 
		<label for="officialIsDisabled">공식 경기 비활성</label>
		<br/>
		<input id="officialRegisterCancel" type="button" value="취소 하기" />
		<input id="officialRegisterSubmit" type="button" value="등록 하기" />

		<div id="light" class="white_content">
		<input type="text" id="officialCourtListSearch" placeholder="(검색)주소를 입력"/>
		<br/>
		<br/>
		<table class="officialCourtTable">
			<thead>
				<tr>
					<th class="officialCourtTh">구장 번호</th>
					<th class="officialCourtTh">구장 이름</th>
					<th class="officialCourtTh">구장 지역</th>
				</tr>
			</thead>
			<tbody id="list">
			</tbody>
		</table>
		</div>
	</div>
	<div class="container">                           
		<nav aria-label="Page navigation" style="text-align:center">
			<ul class="pagination" id="pagination"></ul>
		</nav>               
	</div>
	<div id="fade" class="black_overlay"></div>
</div>
</body>
<script>
	var courtIdx = '${officialInfo.courtIdx}';
	var currentPage = 1;
	var currentDate = new Date();
	var formattedDate = currentDate.getFullYear() + "-" + (currentDate.getMonth() + 1).toString().padStart(2, '0') + "-" + currentDate.getDate().toString().padStart(2, '0');
	var selectDate = '';
	var selectTime = '';
	var originalCourtIdx = '${officialInfo.courtIdx}';
	var originalSelectTime = '${officialInfo.officialStartTime}';
	
	$('#officialUpdateDate').val('${officialInfo.officialDate}');
	selectDate = $('#officialUpdateDate').val();
	selectTime = '${officialInfo.officialStartTime}';

	$('#officialUpdateLevel').val('${officialInfo.officialLevel}');
	$('#officialUpdateGender').val('${officialInfo.officialGender}');
	
	callCourtInfo(courtIdx);
	disabledButton();
	
	
	$('#officialUpdateDate').datepicker({
		format: 'yyyy-mm-dd', // 날짜 형식 설정
		autoclose: true, // 날짜 선택 후 자동으로 닫힘
		todayHighlight: true, // 오늘 날짜 강조 표시
		startDate: 'today', // 오늘 이후의 날짜만 선택 가능
	});
	
	$('#officialRegisterSubmit').on('click', function(){
		var officialCourtName = $('#officialUpdateName').val();
		var officialCourtPrice = $('#officialUpdatePrice').val();
		var officialLevel = $('#officialUpdateLevel').val();
		var officialGender = $('#officialUpdateGender').val();
		var officialTO = $('#officialUpdateTo').val();
		var officialInfo = $('#officialUpdateInfo').val();
		var officialIsDisabled = !$('#officialIsDisabled').is(':checked');

		console.log('officialCourtName = '+officialCourtName);
		console.log('officialCourtPrice = '+officialCourtPrice);
		console.log('officialLevel = '+officialLevel);
		console.log('officialGender = '+officialGender);
		console.log('officialTO = '+officialTO);
		console.log('officialInfo = '+officialInfo);
		console.log('selectTime = '+selectTime);
		
		
		if(officialCourtName == ''
		    || officialCourtPrice == ''
		    || officialLevel == ''
		    || officialGender == ''
		    || officialTO == ''
		    || officialInfo == ''
		    || selectTime == ''
		){
		    alert('모든 정보를 입력 해 주세요.');
		    return;
		}
		if(confirm('정말로 수정 하시겠습니까?')){
			$.ajax({
				url:'./officialUpdate.ajax'
				,type:'post'
				,dataType:'json'
				,data:{
					'officialState':officialIsDisabled
					,'officialPrice':officialCourtPrice
					,'officialLevel':officialLevel
					,'officialGender':officialGender
					,'officialTO':officialTO
					,'officialInfo':officialInfo
					,'officialStartTime':selectTime
					,'officialEndTime':parseInt(selectTime)+2
					,'officialDate':selectDate
					,'courtIdx':courtIdx
					,'officialIdx':'${officialIdx}'
				}
				,success:function(data){
					console.log(data);
					if(data.result){
						window.location.href = './officialList.go';
					}else{
						alert('경기 수정에 실패 했습니다.');
					}
				}
				,error:function(error){
					
				}
			});
		}

	});
	$('#officialCourtListSearch').on('keydown', function(event){
		if(event.keyCode == 13){

			$('#pagination').twbsPagination('destroy');
			currentPage=1;
			callCourtList(currentPage);
		}
	});
	$('#officialCourtList').on('click', function(){
		$('#light').css('display', 'block');
		$('#fade').css('display', 'block');
		callCourtList(currentPage);
	});
	$('#fade').on('click', function(){
		$('#light').css('display', 'none');
		$('#fade').css('display', 'none');
		$('officialCourtListSearch').val('');
	});
	
	function callCourtList(currentPage) {

		$.ajax({
			url:'./callCourtList.ajax'
			,type:'POST'
			,dataType:'json'
			,data:{
				"currentPage":currentPage
				,"searchWord":$('#officialCourtListSearch').val()
			}
			,success:function(data){
				
				showList(data.list);
				
				var totalPage = data.totalPage ==  0 ? 1:data.totalPage;
				
				$('#pagination').twbsPagination({
					startPage:1
					,totalPages:totalPage
					,visiblePages:5	
					,onPageClick:function(evt,pg){
						currentPage = pg;
						callCourtList(currentPage);
					}
					
				});
			}
			,error: function(xhr, status, error) {
				console.error("AJAX request failed:", status, error);
			}
		})

	}
	function callCourtInfo(idx){
		
		$('.officialWriteTimeBtn').css('background-color', 'skyblue');
		
		$('.officialWriteTimeBtn').each(function() {
			$(this).prop('disabled', false);
		});
		
		disabledButton();
		
		$.ajax({
			url:'./callCourtInfo.ajax'
			,type:'POST'
			,dataType:'json'
			,data:{
				"courtIdx":idx
				,"selectDate":selectDate
			}
			,success:function(data){

				$('#officialUpdateName').val(data.courtInfo.courtName);
				$('#officialUpdateAddress').val(data.courtInfo.courtAddress);
				
				courtIdx = data.courtInfo.courtIdx;
				
				var content = '';
				
				if(data.fileName.length > 0 ){
					for(item of data.fileName){
						content += '<div class="swiper-slide"><img src="/court/'+item+'.png" alt="Image"></div>';
					}
				}else{
					content += '<div class="swiper-slide"><img src="../resources/img/court/no_image.png" alt="Image"></div>';
				}
				
				$('#swiperImage').html(content);
				console.log(data.bookingStartTime);
				
				if(data.bookingStartTime.length > 0){
					for(item of data.bookingStartTime){
						$('.officialUpdateTimeBtn').each(function() {
							if(courtIdx == originalCourtIdx && item == originalSelectTime && $(this).attr('id') == item){
								$(this).css('background-color', 'black');
								$(this).prop('disabled', false);
							}else if($(this).attr('id') == item){
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
			}
			,error:function(error){

			}
		});
	}


		

	$('#officialRegisterCancel').on('click',function(){
		if(confirm('정말 취소 하시겠습니까?')){
			alert('취소되었습니다.');
			window.location.href = "./officialList.go";
		}
	});

	$('.officialUpdateTimeBtn:not([disabled])').click(function() {
		selectTime = $(this).attr('id');
		// 모든 버튼의 배경색을 하늘색으로 초기화
		$('.officialUpdateTimeBtn:not([disabled])').not(this).css('background-color', 'skyblue');

		// 클릭된 버튼의 배경색을 검정색으로 변경
		$(this).css('background-color', 'black');
		officialUpdateTime = $(this).attr('id');
		// console.log(officialUpdateTime);
	});
		
	function disabledButton(){
		var nowHours = currentDate.getHours();
		var nowDate = currentDate.getFullYear() + "-" + (currentDate.getMonth() + 1).toString().padStart(2, '0') + "-" + currentDate.getDate().toString().padStart(2, '0');
		console.log(nowDate);
		if($('#officialUpdateDate').val() == nowDate){
			if(nowHours > 0){
				$('.officialUpdateTimeBtn').each(function() {
					if($(this).attr('id') <= nowHours){
						$(this).prop('disabled', true);
						$(this).css('background-color','gray');
					}
				});
			}
		}
	}
	
	function showList(list){

		var content = '';
		
		for(item of list){
			content +=
				'<tr class="officialCourtListTr">'
				+'<td class="officialCourtListTd">'+item.courtIdx+'</td>'
				+'<td class="officialCourtListTd">'+item.courtName+'</td>'
				+'<td class="officialCourtListTd">'+item.courtAddress.split(' ')[1]+'</td>'
				+'</tr>';
		}
		
		$('#list').html(content);
		
	    $('.officialCourtListTr').hover(function() {
	        $(this).css('background-color', 'lightgray');
	    }, function() {
	        $(this).css('background-color', '');
	    });
	    
	    $('.officialCourtListTr').click(function() {
	        courtIdx = $(this).find('.officialCourtListTd:first').text();
			$('#light').css('display', 'none');
			$('#fade').css('display', 'none');
	        callCourtInfo(courtIdx);
	        console.log('선택한 행의 idx:', courtIdx);
	    });
		
	}
		
			
	$('#officialUpdateDate').change(function() {
		$('.officialUpdateTimeBtn').css('background-color', 'skyblue');	
		$('.officialUpdateTimeBtn').each(function() {
			$(this).prop('disabled', false);
		});
		disabledButton();
		selectDate = $('#officialUpdateDate').val();
		selectTime = '';
		callCourtInfo(courtIdx);
	});
	
</script>
</html>
