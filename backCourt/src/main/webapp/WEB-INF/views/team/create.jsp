<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/common/reset.css">
<link rel="stylesheet" href="../resources/css/header/header.css">
<link rel="stylesheet" href="../resources/css/team/team.css">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<style>

</style>
</head>
<body>
	<jsp:include page="../header/header.jsp"/>
    <!-- 팀 만들기 -->
    <div class="createTeamContainer">
        <form action="./create.do" method="post" enctype="multipart/form-data">
            <div class="leftCont">
                <div class="imgBox" id="imgBox">
                    <img id="img" src="/logo/default_logo.png" alt="">
                </div>
                <button type="button" class="siteLogo">로고 선택</button>
                <!-- 최종 로고 저장 장소 -->
                <input type="hidden" name="sitePhotos" id="sitePhotos">
                <!-- 최종 로고 저장 장소 -->
                <label class="inputFileButton" for="inputFile">내 PC 에서 찾기</label>
                <input id="inputFile" class="pcLogo" type="file" name="photo"/>
            </div>
            <div class="rightCont">
                <p>
                    <span>팀명 : </span>
                    <input class="teamName" type="text" name="teamNikName">
                </p>
                <p>
                    <span>지역 : </span>
                    <select id="address" class="selectBox" name="address">
                        <option value="서울시 금천구">서울시 금천구</option>
                        <option value="서울시 구로구">서울시 구로구</option>
                        <option value="서울시 도봉구">서울시 도봉구</option>
                        <option value="서울시 노원구">서울시 노원구</option>
                        <option value="서울시 성북구">서울시 성북구</option>
                        <option value="서울시 마포구">서울시 마포구</option>
                        <option value="서울시 강서구">서울시 강서구</option>
                        <option value="서울시 종로구">서울시 종로구</option>
                        <option value="서울시 동대문구">서울시 동대문구</option>
                        <option value="서울시 용산구">서울시 용산구</option>
                        <option value="서울시 관악구">서울시 관악구</option>
                        <option value="서울시 중랑구">서울시 중랑구</option>
                        <option value="서울시 영등포구">서울시 영등포구</option>
                    </select>
                </p>
                <p>
                    <span>팀 레벨 : </span>
                    <label for="bronz">브론즈</label>
                    <input class="radio" type="radio" name="level" id="bronz" value="브론즈">
                    <label for="silver">실버</label>
                    <input class="radio"  type="radio" name="level" id="silver" value="실버">
                    <label for="gold">골드</label>
                    <input class="radio"  type="radio" name="level" id="gold" value="골드">
                    <label for="platinum">플래티넘</label>
                    <input class="radio"  type="radio" name="level" id="platinum" value="플래티넘">
                </p>
                <p>
                    <span>팀 설명 : </span>
                    <textarea name="teamDescription" id="description" maxlength="300"></textarea>
                </p>
                <div class="btnWrap">
                    <button id="cancle" type="button">취소</button>
                    <button id="complete" type="button">완료</button>
                </div>
            </div>
        </form>
    </div>

    <!-- 유저 상세 팝업 -->
    <div class="logoPop">
        <a href="#" class="close"><img src="../resources/img/icon/close.png" alt=""></a>
        <div class="popWrap">
            <div class="logoCont">
                <ul>
                    <li><img src="/logo/team_siteLogo01.png" alt=""></li>
                    <li><img src="/logo/team_siteLogo02.png" alt=""></li>
                    <li><img src="/logo/team_siteLogo03.png" alt=""></li>
                    <li><img src="/logo/team_siteLogo04.png" alt=""></li>
                    <li><img src="/logo/team_siteLogo05.png" alt=""></li>
                    <li><img src="/logo/team_siteLogo05.png" alt=""></li>
                    <li><img src="/logo/team_siteLogo05.png" alt=""></li>
                    <li><img src="/logo/team_siteLogo05.png" alt=""></li>
                    <li><img src="/logo/team_siteLogo05.png" alt=""></li>
                    <li><img src="/logo/team_siteLogo05.png" alt=""></li>
                    <li><img src="/logo/team_siteLogo05.png" alt=""></li>
                    <li><img src="/logo/team_siteLogo05.png" alt=""></li>
                    <li><img src="/logo/team_siteLogo05.png" alt=""></li>
                    <li><img src="/logo/team_siteLogo05.png" alt=""></li>
                    <li><img src="/logo/team_siteLogo05.png" alt=""></li>
                    <li><img src="/logo/team_siteLogo05.png" alt=""></li>
                    <li><img src="/logo/team_siteLogo05.png" alt=""></li>
                    <li><img src="/logo/team_siteLogo05.png" alt=""></li>
                    <li><img src="/logo/team_siteLogo05.png" alt=""></li>
                </ul>
            </div>
            <button class="selectBtn">선택완료</button>
        </div>
    </div>
</body>
<script>

    var imgSrc = '';
    var logoName = '';
    var newLogoName = '';    
    var val = '';
    var fileName = '';
    var newFileName = '';

    // logo 팝업
    $('.siteLogo').on('click',function(){
        $('.logoPop').addClass('on');
        $('.curtain').addClass('on');
        $('html').addClass('on');
    });
    $('.close').on('click',function(){
        $('.logoPop').removeClass('on');
        $('.curtain').removeClass('on');
        $('html').removeClass('on');
    });
    $('.logoCont li').on('click',function(){
        $(this).addClass('on').siblings().removeClass('on');

        imgSrc = $(this).children('img').attr('src');
        logoName = imgSrc.substring(imgSrc.lastIndexOf('\/') + 1);
        newLogoName = logoName.substring(0, logoName.lastIndexOf('.'));
        console.log(newLogoName);
    });

    // 이미지 선택완료
    $('.selectBtn').on('click',function(){
    	var imgContent = '';
    	
        $('.logoPop').removeClass('on');
        $('.curtain').removeClass('on');
        $('html').removeClass('on');

        $('#sitePhotos').val(newLogoName);
        console.log($('#sitePhotos').val());
        
        imgContent +=
        	'<img id="img" src="/logo/' + newLogoName + '.png" alt="">';
        
        $('#imgBox').html(imgContent);
        
        $('.pcLogo').val('');
    });

    // 내 pc 에서 이미지 선택
    $('.pcLogo').on('change',function(){
    	var imgContent = '';
    	
        val = $('.pcLogo').val();
        console.log(val);
        fileName = val.substring(val.lastIndexOf('\\') + 1);
        newFileName = fileName.substring(0, fileName.lastIndexOf('.'));
        console.log(newFileName);

        $('#sitePhotos').val(newFileName);
        console.log($('#sitePhotos').val());
        
        previewFile();
        // 내 pc 이미지 저장 ajax 실행
        /* logoStorage(); */
    });
 	
 	// 내 pc 에서 사진 선택하기 미리보기
    function previewFile() {
    	  var preview = document.querySelector("#img");
    	  var file = document.querySelector("input[type=file]").files[0];
    	  var reader = new FileReader();

    	  reader.addEventListener(
    	    "load",
    	    function () {
    	      preview.src = reader.result;
    	    },
    	    false,
    	  );

    	  if (file) {
    	    reader.readAsDataURL(file);
    	  }
    }
 	
 	// 취소 버튼
 	$('#cancle').on('click',function(){
 		cancle();
 	});
 	
 	// 완료 버튼 유효성 검사
 	$('#complete').on('click',function(){
 		validChk();
 	});
 	
 	function validChk(){
 		
 		var testNikName = $('.teamName');
 		var address = $('#address');
 		var level = $('input[name="level"]:checked');
 		var description = $('#description');
 		var sitePhotos = $('#sitePhotos');
 		var inputFile = $('#inputFile');
 		
 		
 		console.log('--------------------------------');
 		console.log(testNikName);
 		console.log(address);
 		console.log(level);
 		console.log(description);
 		console.log(sitePhotos);
 		console.log(inputFile);
 		
 		if(testNikName.val() == ''){
 			alert('팀 이름을 입력해주세요');
 			testNikName.focus();
 		}else if(address.val() == ''){
 			alert('주소를 선택해주세요');
 			address.focus();
 		}else if(level.val() == null){
 			alert('레벨을 선택해주세요');
 			level.focus();
 		}else if(description.val() == ''){
 			alert('팀정보를 입력해주세요');
 			description.focus();
 		}else if(sitePhotos.val() == '' && inputFile.val() == ''){
 			alert('로고를 선택해주세요');
 		}else{
 			console.log('서버로 요청');
 			
 			var cf = '';
 			cf = confirm('팀을 만드시겠습니까?');
 			if(cf){
	 			$('form').submit();
 			}
 			
 		}
 		
 	}
 	
 	function cancle(){
 		var cf = '';
 		cf = confirm('취소하시겠습니까?');
 		if(cf){
 			window.history.back();
 		}
 		
 	}

</script>
</html>































