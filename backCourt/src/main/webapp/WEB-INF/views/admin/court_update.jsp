<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>제목 입력</title>
<link rel="stylesheet" href="../resources/css/common/reset.css">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../resources/css/common/reset.css">
<link rel="stylesheet" href="../resources/css/header/header.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>

<style>
    .courtWriteTable,.courtWriteTh,.courtWriteTd {
        border: 1px solid black;
        border-collapse: collapse;
    }
    .courtWriteTh,.courtWriteTd {
        padding: 5px 10px;
    }
    #courtUpdateInfo {
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
</style>
</head>
<body>
<div class="adminBody">
	<jsp:include page="../header/header_admin.jsp"/>
	<div class="adminContainer">
		<h1>구장 수정</h1>
		<table class="courtWriteTable">
			<tr>
				<th class="courtWriteTh">구장 이름</th>
				<td class="courtWriteTd">
					<input type="text" id="courtUpdateName" value="${courtDetail.courtName}"/>
				</td>
			</tr>
			<tr>
				<th class="courtWriteTh">구장 사진</th>
				<td class="courtWriteTd">
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
					<br/>
					<input type="file" id="courtImageUpload" multiple>
				</td> 
			</tr>
			<tr>
				<th class="courtWriteTh">구장 정보</th>
				<td class="courtWriteTd">
					<textarea id="courtUpdateInfo" maxlength="300">${courtDetail.courtInfo}</textarea>
				</td>
			</tr>
			<tr>
				<th class="courtWriteTh">구장 가격</th>
				<td class="courtWriteTd">
					<input type="number" id="courtUpdatePrice" value="${courtDetail.courtPrice}"/>
				</td>
			</tr>
			<tr>
				<th class="courtWriteTh">구장 위치</th>
				<td class="courtWriteTd">
					<input type="text" id="courtUpdateAddress" maxlength="300" value="${courtDetail.courtAddress}"/>
				</td>
			</tr>
		</table>
		<br/>

		<input type="checkbox" id="courtIsOfficial"/>
			<label for="courtIsOfficial">공식 경기 구장</label>
		<input type="checkbox" name="" id="courtIsDisabled">
			<label for="courtIsDisabled">구장 비활성</label>
		<br/>
		<input id="courtRegisterCancel" type="button" value="취소 하기"/>
		<input id="courtRegisterSubmit" type="button" value="등록 하기"/>
	</div>
</div>
    
<script>
	var courtState = ${courtDetail.courtState};
	var courtOfficial = ${courtDetail.courtOfficial};
	var courtFileNameList = [];
	var courtIdx = ${courtIdx};
	
	// 파일이름 하나씩 배열에 넣기
    <c:forEach var="fileName" items="${fileName}">
        courtFileNameList.push("${fileName}");
    </c:forEach>

    console.log("Loaded file names:", courtFileNameList);
	console.log("courtFileName");
	if(courtState == false){
		$('#courtIsDisabled').prop('checked', true);
	}
	if(courtOfficial == true){
		$('#courtIsOfficial').prop('checked', true)
	}
	var content = '';
    if(courtFileNameList.length > 0 ){
        for(item of courtFileNameList){
        	content += '<div class="swiper-slide"><img src="/court/'+item+'.png" alt="Image"></div>';
        }
    	
    }else{
    	content += '<div class="swiper-slide"><img src="../resources/img/court/no_image.png" alt="Image"></div>';
    }

    $('#swiperImage').html(content);
    
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

    $('#courtRegisterSubmit').on('click',function(){
        var formData = new FormData();
        var files = $('#courtImageUpload')[0].files;

        // 파일이 선택되었는지 확인 후 FormData에 추가
        if (files.length > 0) {
            for (var i = 0; i < files.length; i++) {
                formData.append('file', files[i]);
            }
        } else {
            // 파일이 선택되지 않았을 때의 처리
            alert('파일이 선택되지 않았습니다.');
            return;
        }

    	var courtUpdateName = $('#courtUpdateName').val();
    	var courtUpdateInfo = $('#courtUpdateInfo').val();
    	var courtUpdatePrice = $('#courtUpdatePrice').val();
    	var courtUpdateAddress = $('#courtUpdateAddress').val();
    	var courtIsOfficial = $('#courtIsOfficial').is(':checked');
    	var courtIsDisabled = !$('#courtIsDisabled').is(':checked');
    	
//     	console.log(courtUpdateName);
//     	console.log(courtUpdateInfo);
//     	console.log(courtUpdatePrice);
//     	console.log(courtUpdateAddress);
//     	console.log(courtIsOfficial);
//     	console.log(courtIsDisabled);

    	formData.append('courtUpdateName', courtUpdateName);
        formData.append('courtUpdateInfo', courtUpdateInfo);
        formData.append('courtUpdatePrice', courtUpdatePrice);
        formData.append('courtUpdateAddress', courtUpdateAddress);
        formData.append('courtIsOfficial', courtIsOfficial);
        formData.append('courtIsDisabled', courtIsDisabled);
		formData.append('courtIdx', courtIdx);
        //키 벨류 formdata 에서는 entries써야됨
        for (pair of formData.entries()) {
            console.log(pair[0] + ': ', pair[1]);
        }

    	
    	if(courtUpdateName == ''
    		|| courtUpdateInfo == ''
        	|| courtUpdatePrice == ''
        	|| courtUpdateAddress == ''
    	){
	        alert('모든 정보를 입력해 주세요');
	        return;
    	}
    	if(confirm('정말 등록 하시겠습니까?')){
        	$.ajax({
        		url:'./courtUpdate.ajax'
        		,type:'post'
        		,data:formData
                ,contentType:false
                ,processData:false
                ,success:function(data){
                	if(data.result == true){
						window.location.href = './courtList.go';                		
                	}
                }
                ,error:function(error){

                }
        	});
    	}
    });

    $('#courtRegisterCancel').on('click',function(){
        if(confirm('정말 취소 하시겠습니까?')){
        	alert('취소되었습니다.');
        	window.location.href = "./courtList.go";
        }
    });
    
	$('#courtImageUpload').on('change',function(){
		var files = $(this)[0].files;
		
		if(files.length > 0){
			for(file of files){
// 				console.log(file);
				var fileName = file.name;
				var fileSize = file.size;
				if(fileName.endsWith('.png') == false){
					alert('png 확장자만 업로드 가능합니다.');
					$('#courtImageUpload').val('');
					return;
				}
				if(fileSize > 5242880){// 5mb제한
					alert('5mb가 넘습니다.');
					$('#courtImageUpload').val('');
					return;
				}
				
			}
		}
		
	});    
    
</script>
</body>
</html>
