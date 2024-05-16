<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>팀원 모집글 작성</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="../resources/css/common/reset.css"
	type="text/css">
<link rel="stylesheet" href="../resources/css/teammate/teammate_write.css" 
	type="text/css">
<link rel="stylesheet" href="../resources/css/header/header.css"
	type="text/css">
<style>
	/* 수정 - 강대훈 */
	.wrapper{
		padding:20px 220px !important;
		box-sizing: border-box;
	}
	.wrapper .content{
		width:initial !important;
	}
	.content-wrapper{
		margin-bottom: 10px;
	}
	.content .tit{
		display: inline-block;
		width:105px;
	}
	.content .txt{
	}
	.content.requ{
		width:105px !important;
	}
	.textarea{
		width: 100%;
    	max-width: 70%;
		margin-left:0;
	}
	.update{
		text-align: center;
	}
</style>
</head>
<body>
<jsp:include page="../header/header.jsp"/>
	<div class="wrapper">
		<div class="header">
<!-- 			<img src="../resources/img/icon/logo.png" class="img" alt="로고" />  -->
		<span>팀원 모집글 수정</span>
		</div>
		<br />
		<!-- 수정 - 강대훈 - 지역이 안찍히는데 확인바람 -->
		<div class="content-wrapper">
			<div class="content">
				<span class="tit">팀명 :</span> 
				<span class="txt">${modiDto.team_name}</span>
			</div>
		</div>
		<div class="content-wrapper">
			<div class="content" id="address">
				<span class="tit">지역 :</span> 
				<span class="txt">${modiDto.team_address}</span>
			</div>
		</div>
		<div class="content-wrapper">
			<div class="content">
				<span class="tit">팀 설명 :</span> 
				<span class="txt">${modiDto.team_info}</span>
			</div>
		</div>
		<div class="content-wrapper">
			<div class="content requ">모집내용 : </div>
			<textarea name="teammate_info" class="textarea" id="teammateContent" maxlength="300">
            </textarea>
			<div id="char-count"></div>
		</div>
		<div class="content-wrapper">
			<div class="content requ">모집 성별 :</div>
			<div class="radio-wrapper">
				<input type="radio" id="male" name="teammateGender" value="남자"> 
				<label for="male">남자</label> 
				<input type="radio" id="female" name="teammateGender"	value="여자"> 
				<label for="female">여자</label>
			</div>
		</div>
		<div class="content-wrapper">
			<div class="content requ">모집 레벨 : </div>
			<div class="radio-wrapper">
				<input type="radio" id="bronze" name="teammateLevel" value="브론즈">
					<label for="bronze">브론즈</label> 
				<input type="radio" id="silver"name="teammateLevel" value="실버">
				 	<label for="silver">실버</label>
				<input type="radio" id="gold" name="teammateLevel" value="골드">
				 	<label	for="gold">골드</label>
				<input type="radio" id="platinum" name="teammateLevel" value="플래티넘"> 
					<label for="platinum">플래티넘</label>
			</div>
		</div>
		<div class="content-wrapper">
			<div class="content requ">모집 포지션 :</div>
			<select class="select" name="teammatePosition" id="teammatePosition">
				<option value="">포지션 선택</option>
				<option value="센터">센터</option>
				<option value="포워드">포워드</option>
				<option value="가드">가드</option>
			</select>
		</div>
		<!-- 수정 - 강대훈 - 지역이 안찍히는데 확인바람 -->
		<div class="update">
			<input type="submit" value="수정 취소" id="cancel" class="submit">
			<input type="submit" value="수정 완료" id="finish" class="submit">
		</div>
		
	</div>
</body>
<script>
$('.menu').css('display','none');
var join_team_idx = '${idx}';
console.log(join_team_idx);

	// 수정완료 클릭 시
	$('#finish').on('click',function(){
		if(!confirm("수정 하시겠습니까?")){
			return;
		}
		var selectedGender = $("input[name='teammateGender']:checked").val();
		var selectedLevel = $("input[name='teammateLevel']:checked").val();
		console.log(selectedGender,selectedLevel);
		$.ajax({
			type: 'POST'
			, url: './teammateUpdate.ajax'
			, dataType: 'json'
			, data:{
				'teammate_info':$('#teammateContent').val()
				,'teammate_gender':selectedGender
				,'teammate_level':selectedLevel
				,'teammate_position':$('#teammatePosition').val()
				,'join_team_idx':join_team_idx
			}
			, success:function(data){
					alert("수정 완료되었습니다.");
					window.location.href = './join_info.go?join_team_idx='+ join_team_idx;
			}
			, error:function(){
				alert("수정 실패");
			}
		});
		
	});
	
	// 수정 취소 시 컨펌창
	$(document).ready(function() {
	    $('#cancel').click(function(event) {
	        // 취소 여부 확인
	        var confirmed = confirm("수정을 취소하시겠습니까?");
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
    		,url: './teammateModify.ajax'
    		,dataType:'json'
    		,data:{'join_team_idx':join_team_idx
    		}
    		, success:function(data){
    			console.log(data);
    			$("#teammateContent").val(data.modifyInfo.join_team_content);
    			$("input[name='teammateGender'][value='" + data.modifyInfo.join_team_gender + "']").prop("checked", true);
    			$("input[name='teammateLevel'][value='" + data.modifyInfo.join_team_level + "']").prop("checked", true);
    			$("#teammatePosition").val(data.modifyInfo.join_team_position);
    		}
			, error: function(error){
				
			}
    	});
    });

	 	
</script>
</html>