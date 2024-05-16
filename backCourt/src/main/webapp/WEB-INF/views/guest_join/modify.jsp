<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>게스트 모집글 수정</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="../resources/css/common/reset.css"
	type="text/css">
<link rel="stylesheet" href="../resources/css/guest_join/write.css" 
	type="text/css">
<link rel="stylesheet" href="../resources/css/header/header.css"
	type="text/css">
</head>
<body>
<jsp:include page="../header/header.jsp"/>
	<div class="wrapper">
		<div class="header">
			<img src="../resources/img/icon/logo.png" class="img" alt="로고" /> <span>게스트
				모집글 수정</span>
		</div>
		<br />
		<div class="content-wrapper">
			<div class="content">지역 :</div>
			<input type="text" id="address" disabled/>
		</div>
		<div class="content-wrapper">
			<div class="content">날짜 :</div>
			<input type="text" id="date" disabled>
		</div>
		<div class="content-wrapper">
			<div class="content">구장명 :</div>
			<input type="text" id="courtname" disabled/>
		</div>
		<div class="content-wrapper">
			<div class="content">경기정보 :</div>
			<textarea name="guest_info" class="textarea" id="game-content" maxlength="500"
				placeholder=" 매치설명(구장 특이사항, 경기 룰, 참가비를 받을 개인계좌, 연락처 등)을 자유롭게 입력해 주세요.(글자수 제한: 500자)">
                    </textarea>
			<div id="char-count"></div>
		</div>
		<div class="content-wrapper">
			<div class="content">모집 레벨 :</div>
			<div class="radio-wrapper" id="level">
				<input type="radio" id="bronze" name="guest_level" value="브론즈">
					<label for="bronze">브론즈</label> 
				<input type="radio" id="silver"name="guest_level" value="실버">
				 	<label for="silver">실버</label>
				<input type="radio" id="gold" name="guest_level" value="골드">
				 	<label	for="gold">골드</label>
				<input type="radio" id="platinum" name="guest_level" value="플래티넘"> 
					<label for="platinum">플래티넘</label>
			</div>
		</div>
		<div class="content-wrapper">
			<div class="content">모집 포지션 :</div>
			<select class="select" name="guest_position" id="position">
				<option value="">포지션 선택</option>
				<option value="센터">센터</option>
				<option value="포워드">포워드</option>
				<option value="가드">가드</option>
			</select>
		</div>
		<div class="content-wrapper">
			<div class="content">모집 성별 :</div>
			<div class="radio-wrapper" id="">
				<input type="radio" id="male" name="guest_gender" value="남자"> 
				<label for="male">남자</label> 
				<input type="radio" id="female" name="guest_gender"	value="여자"> 
				<label for="female">여자</label>
			</div>
		</div>
		<div class="content-wrapper">
			<div class="content">모집 인원 :</div>
			<div class="aa">
				<input type="text" name="guest_to" maxlength="1"
					oninput="this.value = this.value.replace(/[^1-9]|10/g, '')"
					placeholder="1~9까지의 숫자 중 입력해 주세요" class="text" id="to"/>
			</div>
		</div>
		<div class="content-wrapper">
			<div class="content">참가비 :</div>
			<div class="aa">
				<input type="text" class="text" name="guest_fee" id="feeInput"
				 maxlength="7" placeholder="참가비를 입력해 주세요" />
			</div>
		</div>
		<div class="update">
			<input type="submit" value="수정 취소" id="cancel" class="submit">
			<input type="submit" value="수정 완료" id="update" class="submit">
		</div>
	</div>
</body>
<script>
	$('.menu').css('display','none');
	
	var guest_idx = ${idx};
	console.log(guest_idx + 'ddd');
	
	
	$('#update').on('click',function(){
		if(!confirm("수정 하시겠습니까?")){
			return;
		}
		var selectedGender = $("input[name='guest_gender']:checked").val();
		var selectedLevel = $("input[name='guest_level']:checked").val();
		console.log(selectedGender,selectedLevel);
		$.ajax({
			type: 'POST'
			, url: './guestUpdate.ajax'
			, dataType: 'json'
			, data:{
				'guest_info':$('#game-content').val()
				,'guest_level':selectedLevel
				,'guest_position':$('#position').val()
				,'guest_gender':selectedGender
				,'guest_to':$('#to').val()
				,'guest_fee':$('#feeInput').val()
				,'guest_idx':guest_idx
			}
			, success:function(data){
					alert("수정 완료되었습니다.");
					window.location.href = '../guest_join/list.go'
			}
			, error:function(){
				alert("수정 실패");
			}
		});
		
	});
	
	// 작성 취소	
	$(document).ready(function() {
	    $('#cancel').click(function(event) {
	        // 취소 여부 확인
	        var confirmed = confirm("수정 취소하시겠습니까?");
	        if (confirmed) {
	            // 확인을 누를 경우 이전 페이지로 이동
	            window.history.back();
	        } else {
	            // 취소를 누르면 폼 제출을 중지
	            event.preventDefault();
	        }
	    });
	});
	
	// 작성 취소 시 컨펌창
	$(document).ready(function() {
		$('#cancel').click(function(event) {
			// 취소 여부 확인
			var confirmed = confirm("작성을 취소하시겠습니까?");
			if (confirmed) {
				// 확인을 누를 경우 이전 페이지로 이동
				window.history.back();
			} else {
				// 취소를 누르면 폼 제출을 중지
				event.preventDefault();
			}
		});
	});
	
	$(document).ready(function(){
    	
    	$.ajax({
    		type:'POST'
    		,url: './modify.ajax'
    		,dataType:'json'
    		,data:{'guest_idx':guest_idx
    		}
    		, success:function(data){
    			console.log(data);
    			$("#address").val(data.guestInfo.court_address);
    			$("#date").val(data.guestInfo.bookingDate);
    			$("#courtname").val(data.guestInfo.court_name);
    			$("#game-content").val(data.guestInfo.guest_info);
    			$("input[name='guest_level'][value='" + data.guestInfo.guest_level + "']").prop("checked", true);
    			$("#position").val(data.guestInfo.guest_position);
    			$("input[name='guest_gender'][value='" + data.guestInfo.guest_gender + "']").prop("checked", true);
    			$("#to").val(data.guestInfo.guest_to);
    			$("#feeInput").val(data.guestInfo.guest_fee);
    		}
			, error: function(error){
				
			}
    	});
    });


    

</script>
</html>