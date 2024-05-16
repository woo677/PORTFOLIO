<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리 상세/수정</title>
<link rel="stylesheet" href="../resources/css/common/reset.css">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../resources/css/header/header.css">
<!-- <link rel="stylesheet" href="../resources/css/admin/member_detail.css"> -->
<style type="text/css">

/* 라디오 버튼 간격 조절 */
.radio-wrapper input[type="radio"] {
    margin-right: 10px;
}

/* 제출 버튼 간격 조절 */
.update {
    margin-top: 20px;
}

/* 전체적인 스타일 개선 */
body {
    font-family: Arial, sans-serif;
    margin: 0; /* body의 기본 여백 제거 */
    padding: 20px; /* 컨텐츠와 페이지 가장자리 사이의 여백 */
    background-color: #f5f5f5; /* 페이지 배경색 설정 */
}


h2 {
    background-color: #f5f5f5;
    padding: 10px;
    margin-top: 0; /* h2 요소의 위쪽 여백 제거 */
    border-radius: 5px 5px 0 0; /* h2 요소의 둥근 모서리 설정 */
}

.content-wrapper {
    background-color: white;
    padding: 20px;
    margin-bottom: 20px; /* 컨텐츠 아래 여백 추가 */
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 그림자 효과 추가 */
}

.textarea, .select {
    width: calc(100% - 20px); /* 폭 계산식을 사용하여 패딩 고려 */
    padding: 10px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-sizing: border-box; /* 요소의 전체 크기에 border와 padding을 포함시키기 */
}

.submit {
    display: block; /* 블록 수준 요소로 변경하여 여백 적용 */
    width: 100%; /* 폭을 100%로 설정하여 부모 요소의 너비에 맞춤 */
    margin-top: 10px; /* 제출 버튼 위 여백 추가 */
    background-color: #4CAF50;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}
.cancel {
    display: block; /* 블록 수준 요소로 변경하여 여백 적용 */
    width: 100%; /* 폭을 100%로 설정하여 부모 요소의 너비에 맞춤 */
    margin-top: 10px; /* 제출 버튼 위 여백 추가 */
    background-color: red;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

#pointChange {
    display: block; /* 블록 수준 요소로 변경하여 여백 적용 */
    width: 100%; /* 폭을 100%로 설정하여 부모 요소의 너비에 맞춤 */
    margin-top: 10px; /* 제출 버튼 위 여백 추가 */
    background-color: grey;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 35px;
    cursor: pointer;
}


</style>
</head>
<body>
    <div class="adminBody">
    <jsp:include page="../header/header_admin.jsp"/>
           <div>
           <h2>회원 상세 내역</h2>
           
        <div class="content-wrapper">
        <div class="content">아이디 : ${memberId}</div>
        </div>
        <br/>
        <div class="content-wrapper">
			<div class="content">이름 : </div>
			<textarea name="memberName" class="textarea" id="memberName" maxlength="20">${memberDetail.name}</textarea>
			<div id="char-count"></div>
		</div>
        <div class="content-wrapper">
			<div class="content">비밀번호 : </div>
			<textarea name="memberPass" class="textarea" id="memberPass" maxlength="20">${memberDetail.pw}</textarea>
			<div id="char-count"></div>
		</div>
		<div class="content-wrapper">
			<div class="content">레벨 : </div>
			<div class="radio-wrapper">
				<input type="radio" id="bronze" name="memberLevel" value="브론즈">
					<label for="bronze">브론즈</label> 
				<input type="radio" id="silver"name="memberLevel" value="실버">
				 	<label for="silver">실버</label>
				<input type="radio" id="gold" name="memberLevel" value="골드">
				 	<label	for="gold">골드</label>
				<input type="radio" id="platinum" name="memberLevel" value="플래티넘"> 
					<label for="platinum">플래티넘</label>
			</div>
		</div>
			<div class="content-wrapper">
				<div class="content">지역 :</div>
				<select class="select" name="memberAddress" id="memberAddress">
                        <option value="강남구">강남구</option>
                        <option value="강동구">강동구</option>
                        <option value="강북구">강북구</option>
                        <option value="강서구">강서구</option>
                        <option value="관악구">관악구</option>
                        <option value="광진구">광진구</option>
                        <option value="구로구">구로구</option>
                        <option value="금천구">금천구</option>
                        <option value="노원구">노원구</option>
                        <option value="도봉구">도봉구</option>
                        <option value="동대문구">동대문구</option>
                        <option value="동작구">동작구</option>
                        <option value="마포구">마포구</option>
                        <option value="서대문구">서대문구</option>
                        <option value="서초구">서초구</option>
                        <option value="성동구">성동구</option>
                        <option value="성북구">성북구</option>
                        <option value="송파구">송파구</option>
                        <option value="양천구">양천구</option>
                        <option value="영등포구">영등포구</option>
                        <option value="용산구">용산구</option>
                        <option value="은평구">은평구</option>
                        <option value="종로구">종로구</option>
                        <option value="중구">중구</option>
                        <option value="중랑구">중랑구</option>
				</select>
		</div>
		<div class="content-wrapper">
			<div class="content">성별 :</div>
			<div class="radio-wrapper">
				<input type="radio" id="male" name="memberGender" value="남자"> 
				<label for="male">남자</label> 
				<input type="radio" id="female" name="memberGender"	value="여자"> 
				<label for="female">여자</label>
			</div>
		</div>
		<div class="content-wrapper">
			<div class="content">포지션 :</div>
			<select class="select" name="memberPosition" id="memberPosition">
				<option value="센터">센터</option>
				<option value="포워드">포워드</option>
				<option value="가드">가드</option>
			</select>
		</div>
		<div class="content-wrapper">
			<div class="content">상태 :</div>
			<select class="select" name="memberState" id="memberState">
				<option value="일반">일반</option>
				<option value="경고">경고</option>
				<option value="정지">정지</option>
			</select>
		</div>
		<div class="content-wrapper">포인트 : ${memberDetail.point} P</div>
		<div><input type="button" id="pointChange" value="포인트 변경"/></div>
		<br/>
		<div class="update">
			<input type="submit" value="수정 취소" id="cancel" class="cancel"/>
			<input type="submit" value="수정 완료" id="finish" class="submit"/>
		</div>
		</div>
    </div>
</body>
<script>
var memberId = '${memberId}';
console.log(memberId);

$('#pointChange').on('click', function(){
	window.location.href = './memberPoint.go?memberId=' + memberId;
});



// 회원 정보 불러오기 아작스
$(document).ready(function(){
	
	$.ajax({
		type:'POST'
		,url: './memberDetail.ajax'
		,dataType:'json'
		,data:{'memberId':memberId
		}
		, success:function(data){
			console.log(data);
			$("input[name='memberLevel'][value='" + data.m.level + "']").prop("checked", true);
			$("#memberAddress").val(data.m.address);
			$("input[name='memberGender'][value='" + data.m.gender + "']").prop("checked", true);
			$("#memberPosition").val(data.m.position);
			$("#memberState").val(data.m.state);
		}
		, error: function(error){
		console.log(data.m.level);
		}
	});
});

// 수정완료 클릭 시
$('#finish').on('click',function(){
	if(!confirm("수정 하시겠습니까?")){
		return;
	}
	var selectedGender = $("input[name='memberGender']:checked").val();
	var selectedLevel = $("input[name='memberLevel']:checked").val();
	console.log(selectedGender,selectedLevel);
	$.ajax({
		type: 'POST'
		, url: './memberUpdate.ajax'
		, dataType: 'json'
		, data:{
			'memberName':$('#memberName').val()
			,'memberPass':$('#memberPass').val()
			,'memberLevel':selectedLevel
			,'memberAddress':$('#memberAddress').val()
			,'memberGender':selectedGender
			,'memberPosition':$('#memberPosition').val()
			,'memberState':$('#memberState').val()
			,'memberId':memberId
		}
		, success:function(data){
				alert("수정 완료되었습니다.");
				window.location.href = './memberDetail.go?memberId=' + memberId;
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

</script>
</html>